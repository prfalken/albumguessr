"""
Data processor for cleaning and transforming music album data for Algolia indexing.
"""

import json
import re
from datetime import datetime
from typing import Any, Dict, List, Optional
from pathlib import Path
from loguru import logger
from psycopg2.extras import RealDictCursor
import psycopg2.extensions


class AlbumDataProcessor:
    """Processes and cleans music album data for Algolia indexing."""

    def __init__(self, db: psycopg2.extensions.connection):
        self.db: psycopg2.extensions.connection = db
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
        with self.db as conn:
            with conn.cursor(cursor_factory=RealDictCursor) as cursor:
                cursor.execute("SELECT id, name FROM musicbrainz.genre")
                for row in cursor.fetchall():
                    all_genres[row["name"]] = row["id"]
        return all_genres

    def _build_album_batch_sql(self) -> str:
        """SQL selecting release groups of primary type 'Album' with metadata, tags, artists, and countries."""
        sql_path = Path(__file__).parent / "sql" / "album_batch.sql"
        return sql_path.read_text(encoding="utf-8")

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
            logger.warning(f"Album is too big: {json.dumps(album, ensure_ascii=False)}")
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

        with self.db.cursor(cursor_factory=RealDictCursor) as cursor:
            while True:
                cursor.execute(sql, (last_id, batch_size))
                rows = cursor.fetchall()
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
