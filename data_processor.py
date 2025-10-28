"""
Data processor for cleaning and transforming music album data for Algolia indexing.
"""

import json
import re
from datetime import datetime
from typing import Any, Dict, List, Optional, Union
from pathlib import Path

from tqdm import tqdm
import psycopg2
from psycopg2.extras import RealDictCursor
from config import Config

from loguru import logger


class AlbumDataProcessor:
    """Processes and cleans music album data for Algolia indexing."""

    def __init__(self):
        self.processed_count = 0
        self.error_count = 0
        self.all_genres = self.get_all_genres()

    def clean_text(self, text: Any) -> Optional[str]:
        """Clean and normalize text data."""
        if text is None or text == "":
            return None

        text = str(text).strip()
        if not text or text.lower() in ["", "null", "none", "nan"]:
            return None

        # Remove excessive whitespace
        text = re.sub(r"\s+", " ", text)
        return text

    def get_all_genres(self) -> List[str]:
        """Get all genres from the database."""
        all_genres = {}
        with self._connect_db() as conn:
            with conn.cursor(cursor_factory=RealDictCursor) as cursor:
                cursor.execute("SELECT id, name FROM musicbrainz.genre")
                for row in cursor.fetchall():
                    all_genres[row["name"]] = row["id"]
        return all_genres

    def _connect_db(self):
        """Create a PostgreSQL connection using Config settings."""
        return psycopg2.connect(
            host=Config.DB_HOST,
            port=Config.DB_PORT,
            dbname=Config.DB_NAME,
            user=Config.DB_USER,
            password=Config.DB_PASSWORD,
        )

    def _build_album_batch_sql(self) -> str:
        """SQL selecting release groups of primary type 'Album' with metadata, tags, artists, and countries."""
        # Note: We keyset paginate by rg.id using a parameter :last_id and limit :batch_size
        # We rely on joins to build arrays for artists, countries, genres (tags), and secondary types
        return """
            SELECT
                rg.id AS rg_id,
                rg.gid::text AS object_uuid,
                rg.name AS title,
                rgm.first_release_date_year AS fr_year,
                rgm.first_release_date_month AS fr_month,
                rgm.first_release_date_day AS fr_day,
                rgm.rating AS rating_0_100,
                rgm.rating_count AS rating_count,
                ac_info.artist_names,
                ac_info.countries,
                tags.tag_names,
                sec_types.secondary_names,
                mus.musician_names,
                mus.musician_details,
                caa.cover_release_gid
            FROM musicbrainz.release_group rg
            JOIN musicbrainz.release_group_primary_type rpt ON rpt.id = rg.type
            LEFT JOIN musicbrainz.release_group_meta rgm ON rgm.id = rg.id
            LEFT JOIN LATERAL (
                SELECT
                    ARRAY_AGG(acn.name ORDER BY acn."position") AS artist_names,
                    ARRAY_REMOVE(ARRAY_AGG(DISTINCT i1.code), NULL) AS countries
                FROM musicbrainz.artist_credit_name acn
                JOIN musicbrainz.artist a ON a.id = acn.artist
                LEFT JOIN musicbrainz.area ar ON ar.id = a.area
                LEFT JOIN musicbrainz.iso_3166_1 i1 ON i1.area = ar.id
                WHERE acn.artist_credit = rg.artist_credit
            ) ac_info ON TRUE
            LEFT JOIN LATERAL (
                SELECT ARRAY_AGG(t.name ORDER BY rgt.count DESC) AS tag_names
                FROM musicbrainz.release_group_tag rgt
                JOIN musicbrainz.tag t ON t.id = rgt.tag
                WHERE rgt.release_group = rg.id
            ) tags ON TRUE
            LEFT JOIN LATERAL (
                SELECT ARRAY_AGG(rgst.name ORDER BY rgst.name) AS secondary_names
                FROM musicbrainz.release_group_secondary_type_join rgstj
                JOIN musicbrainz.release_group_secondary_type rgst ON rgst.id = rgstj.secondary_type
                WHERE rgstj.release_group = rg.id
            ) sec_types ON TRUE
            LEFT JOIN LATERAL (
                WITH recs AS (
                    SELECT DISTINCT rec.id AS recording_id
                    FROM musicbrainz.release r2
                    JOIN musicbrainz.medium m ON m.release = r2.id
                    JOIN musicbrainz.track t ON t.medium = m.id
                    JOIN musicbrainz.recording rec ON rec.id = t.recording
                    WHERE r2.release_group = rg.id
                ),
                per_artist AS (
                    SELECT
                        lar.entity0 AS artist_id,
                        ARRAY_AGG(DISTINCT lat.name) FILTER (WHERE lat.name IS NOT NULL AND lat.name <> '') AS instrument_names
                    FROM recs
                    JOIN musicbrainz.l_artist_recording lar ON lar.entity1 = recs.recording_id
                    JOIN musicbrainz.link lk ON lk.id = lar.link
                    LEFT JOIN musicbrainz.link_attribute la ON la.link = lk.id
                    LEFT JOIN musicbrainz.link_attribute_type lat ON lat.id = la.attribute_type
                    GROUP BY lar.entity0
                )
                SELECT
                    ARRAY_AGG(DISTINCT a2.name) AS musician_names,
                    JSONB_AGG(
                        DISTINCT JSONB_BUILD_OBJECT(
                            'name', a2.name,
                            'mbid', a2.gid::text,
                            'instruments', COALESCE(per_artist.instrument_names, ARRAY[]::text[])
                        )
                    ) AS musician_details
                FROM per_artist
                JOIN musicbrainz.artist a2 ON a2.id = per_artist.artist_id
            ) mus ON TRUE
            LEFT JOIN LATERAL (
                SELECT rel_choice.rel_gid AS cover_release_gid
                FROM (
                    SELECT
                        r.gid::text AS rel_gid,
                        MAX(CASE WHEN at.name = 'Front' THEN 1 ELSE 0 END) AS has_front,
                        MIN(ca.ordering) AS min_ordering
                    FROM musicbrainz.release r
                    JOIN cover_art_archive.cover_art ca ON ca.release = r.id
                    LEFT JOIN cover_art_archive.cover_art_type cat ON cat.id = ca.id
                    LEFT JOIN cover_art_archive.art_type at ON at.id = cat.type_id
                    WHERE r.release_group = rg.id
                    GROUP BY r.gid
                    ORDER BY has_front DESC, min_ordering ASC
                    LIMIT 1
                ) rel_choice
            ) caa ON TRUE
            WHERE rpt.name = 'Album' AND rg.id > %s AND sec_types.secondary_names IS NULL
            ORDER BY rg.id
            LIMIT %s
            """

    def _row_to_album(self, row: Dict[str, Any]) -> Optional[Dict[str, Any]]:
        """Convert a SQL row to the normalized album object used for indexing."""
        first_release_date: Optional[str] = None
        y = row.get("fr_year")
        m = row.get("fr_month")
        d = row.get("fr_day")
        # Build a normalized YYYY-MM-DD with fallbacks
        if y:
            mm = int(m) if m else 1
            dd = int(d) if d else 1
            try:
                first_release_date = datetime(int(y), mm, dd).strftime("%Y-%m-%d")
            except ValueError:
                # Fallback to year only
                first_release_date = f"{int(y):04d}-01-01"

        rating_value: Optional[float] = None
        rating_0_100 = row.get("rating_0_100")
        if rating_0_100 is not None:
            try:
                rating_value = round(float(rating_0_100) / 20.0, 1)
            except Exception:
                rating_value = None

        album: Dict[str, Any] = {
            "objectID": str(row.get("object_uuid") or ""),
            "title": self.clean_text(row.get("title")),
            "first_release_date": first_release_date,
        }

        # Artists and countries
        artist_names = row.get("artist_names") or []
        countries = row.get("countries") or []
        album["artists"] = [self.clean_text(a) for a in artist_names if a]
        album["countries"] = [self.clean_text(c) for c in countries if c]

        # Genres mapped from tags (should map a genre from the DB)
        tag_names = row.get("tag_names") or []
        album["genres"] = [self.clean_text(t) for t in tag_names if self.all_genres.get(t)]

        # Secondary types
        secondary_names = row.get("secondary_names") or []
        if secondary_names:
            album["secondary_types"] = [self.clean_text(s) for s in secondary_names if s]

        # Musicians (contributors across recordings of the album)
        musician_names = row.get("musician_names") or []
        if musician_names:
            album["musicians"] = [self.clean_text(n) for n in musician_names if n]

        # Detailed musicians info - removed for now, not used in the index
        # musician_details = row.get("musician_details") or []
        # if musician_details:
        #     normalized_details = []
        #     for md in musician_details:
        #         if not isinstance(md, dict):
        #             continue
        #         name = self.clean_text(md.get("name"))
        #         instruments = md.get("instruments") or []
        #         instruments = [self.clean_text(i) for i in instruments if i]
        #         detail_obj = {
        #             k: v
        #             for k, v in {
        #                 "name": name,
        #                 "instruments": instruments,
        #             }.items()
        #             if v not in (None, "") and v != []
        #         }
        #         if detail_obj:
        #             normalized_details.append(detail_obj)
        #     if normalized_details:
        #         album["musicians_details"] = normalized_details

        # Ratings
        if rating_value is not None:
            album["rating_value"] = rating_value
        rating_count = row.get("rating_count")
        if rating_count is not None:
            album["rating_count"] = int(rating_count)

        # Composite score for ranking: rating_value * rating_count
        if album.get("rating_value") is not None and album.get("rating_count") is not None:
            try:
                album["rating_score"] = float(album["rating_value"]) * int(album["rating_count"])
            except Exception:
                pass

        # Derived fields
        if first_release_date:
            try:
                album["release_year"] = int(first_release_date[:4])
            except Exception:
                pass

        if album.get("artists"):
            album["main_artist"] = album["artists"][0]
        if album.get("genres"):
            album["primary_genre"] = album["genres"][0]

        # Remove null/empty
        album = {k: v for k, v in album.items() if v not in (None, "") and v != []}
        # Cover art URLs (Cover Art Archive) using a representative release gid when available
        cover_release_gid = row.get("cover_release_gid")
        if cover_release_gid:
            base = f"https://coverartarchive.org/release/{cover_release_gid}/front"
            album["cover_art_url"] = base
            album["cover_art_url_250"] = f"{base}-250"
            album["cover_art_url_500"] = f"{base}-500"
            album["cover_art_url_1200"] = f"{base}-1200"
        if not album.get("title") or not album.get("objectID"):
            return None
        self.processed_count += 1
        if len(json.dumps(album)) > 10000:
            print(f"This album is too big: {json.dumps(album, ensure_ascii=False)}")
        return album

    def stream_albums_from_db(
        self,
        batch_size: int = 1000,
        max_records: Optional[int] = None,
    ):
        """Generator yielding processed album batches directly from PostgreSQL."""
        sql = self._build_album_batch_sql()
        total_yielded = 0
        last_id = 0

        with self._connect_db() as conn:
            with conn.cursor(cursor_factory=RealDictCursor) as cur:
                while True:
                    cur.execute(sql, (last_id, batch_size))
                    rows = cur.fetchall()
                    if not rows:
                        break

                    processed_batch: List[Dict[str, Any]] = []
                    for row in rows:
                        album = self._row_to_album(row)
                        if album:
                            processed_batch.append(album)

                    if not processed_batch:
                        # Advance last_id even if nothing processed to avoid infinite loop
                        last_id = rows[-1]["rg_id"]
                        continue

                    total_yielded += len(processed_batch)
                    yield processed_batch

                    last_id = rows[-1]["rg_id"]

                    if max_records is not None and total_yielded >= max_records:
                        break
