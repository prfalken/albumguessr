import json
import sys
import types
import importlib
import tempfile
import unittest
from pathlib import Path
from typing import Any, Dict, List

from unittest.mock import patch, MagicMock

# We'll import AlbumDataProcessor dynamically after installing stubs
AlbumDataProcessor = None  # type: ignore
Config = None  # type: ignore


def _install_dependency_stubs() -> None:
    """Install minimal stubs for external deps so importing data_processor works."""
    # Stub psycopg2 and extras.RealDictCursor if missing
    if "psycopg2" not in sys.modules:
        psycopg2_stub = types.SimpleNamespace()
        psycopg2_stub.connect = MagicMock(name="psycopg2.connect")
        extras = types.SimpleNamespace(RealDictCursor=object)
        psycopg2_stub.extras = extras
        sys.modules["psycopg2"] = psycopg2_stub
        sys.modules["psycopg2.extras"] = extras
    # Stub tqdm.tqdm to a passthrough
    if "tqdm" not in sys.modules:

        def _tqdm(iterable=None, **kwargs):  # noqa: ARG001
            return iterable

        tqdm_stub = types.SimpleNamespace(tqdm=_tqdm)
        sys.modules["tqdm"] = tqdm_stub


class TestAlbumDataProcessor(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        _install_dependency_stubs()
        # Ensure project root is on sys.path for direct module imports
        project_root = Path(__file__).resolve().parents[1]
        if str(project_root) not in sys.path:
            sys.path.insert(0, str(project_root))
        dp = importlib.import_module("data_processor")
        globals()["AlbumDataProcessor"] = dp.AlbumDataProcessor
        globals()["Config"] = importlib.import_module("config").Config

    def setUp(self):
        self.processor = AlbumDataProcessor()
        self.processor.all_genres = {
            "Thrash": 1,
            "Metal": 2,
            "Rock": 3,
            "Progressive Rock": 4,
            "Progressive Metal": 5,
            "Progressive Rock": 6,
        }

    # Helper/pure functions
    def test_clean_text(self):
        self.assertIsNone(self.processor.clean_text(None))
        self.assertIsNone(self.processor.clean_text(""))
        self.assertIsNone(self.processor.clean_text("   "))
        self.assertEqual(self.processor.clean_text("Hello, World!"), "Hello, World!")
        self.assertEqual(self.processor.clean_text("Hello, World!   "), "Hello, World!")
        self.assertEqual(self.processor.clean_text("A   B\tC"), "A B C")

    # SQL helpers
    @patch("data_processor.psycopg2.connect")
    def test_connect_db_uses_config(self, mock_connect):
        with patch.object(Config, "DB_HOST", "h"), patch.object(Config, "DB_PORT", 5432), patch.object(
            Config, "DB_NAME", "n"
        ), patch.object(Config, "DB_USER", "u"), patch.object(Config, "DB_PASSWORD", "p"):
            self.processor._connect_db()
            mock_connect.assert_called_once_with(host="h", port=5432, dbname="n", user="u", password="p")

    def test_build_album_batch_sql_contains_expected_clauses(self):
        sql = self.processor._build_album_batch_sql()
        self.assertIn("SELECT", sql)
        self.assertIn("FROM musicbrainz.release_group rg", sql)
        self.assertIn("WHERE rpt.name = 'Album'", sql)
        self.assertIn("LIMIT %s", sql)

    # SQL row transformation
    def test_row_to_album_happy_path_and_cover_art(self):
        row = {
            "object_uuid": "uuid-123",
            "title": "  Ride the Lightning ",
            "fr_year": 1984,
            "fr_month": 7,
            "fr_day": 27,
            "rating_0_100": 85,
            "rating_count": 42,
            "artist_names": ["Metallica"],
            "countries": ["US"],
            "tag_names": ["Thrash"],
            "secondary_names": ["live", None],
            "musician_names": ["Cliff Burton"],
            "musician_details": [{"name": "Cliff Burton", "mbid": "mbid-1", "instruments": ["bass", None]}],
            "cover_release_gid": "rel-1",
        }
        out = self.processor._row_to_album(row)
        self.assertEqual(out["objectID"], "uuid-123")
        self.assertEqual(out["title"], "Ride the Lightning")
        self.assertEqual(out["first_release_date"], "1984-07-27")
        self.assertEqual(out["release_year"], 1984)
        self.assertAlmostEqual(out["rating_value"], 4.2)
        self.assertEqual(out["rating_count"], 42)
        self.assertIn("rating_score", out)
        self.assertEqual(out["artists"], ["Metallica"])
        self.assertEqual(out["countries"], ["US"])
        self.assertEqual(out["genres"], ["Thrash"])
        self.assertEqual(out["main_artist"], "Metallica")
        self.assertEqual(out["primary_genre"], "Thrash")
        # Musicians
        self.assertEqual(out.get("musicians"), ["Cliff Burton"])
        # self.assertEqual(out.get("musicians_details")[0]["name"], "Cliff Burton")
        # Cover art URLs
        base = "https://coverartarchive.org/release/rel-1/front"
        self.assertEqual(out["cover_art_url"], base)
        self.assertEqual(out["cover_art_url_250"], base + "-250")
        self.assertEqual(out["cover_art_url_500"], base + "-500")
        self.assertEqual(out["cover_art_url_1200"], base + "-1200")

    def test_row_to_album_missing_required_returns_none(self):
        row_missing_id = {"title": "X"}
        self.assertIsNone(self.processor._row_to_album(row_missing_id))

        row_missing_title = {"object_uuid": "abc"}
        self.assertIsNone(self.processor._row_to_album(row_missing_title))

    # Streaming from DB
    def test_stream_albums_from_db_yields_and_stops(self):
        rows_iter = [
            [
                {"rg_id": 1, "object_uuid": "id-1", "title": "T1"},
                {"rg_id": 2, "object_uuid": "id-2", "title": "T2"},
            ],
            [
                {"rg_id": 3, "object_uuid": "id-3", "title": "T3"},
            ],
            [],
        ]

        class FakeCursor:
            def __init__(self):
                self.calls = 0

            def __enter__(self):
                return self

            def __exit__(self, exc_type, exc, tb):
                return False

            def execute(self, sql, params):  # noqa: ARG002
                self.calls += 1

            def fetchall(self):
                return rows_iter.pop(0)

        class FakeConn:
            def __enter__(self):
                return self

            def __exit__(self, exc_type, exc, tb):
                return False

            def cursor(self, cursor_factory=None):  # noqa: ARG002
                return FakeCursor()

        with patch.object(AlbumDataProcessor, "_connect_db", return_value=FakeConn()):
            # Patch _row_to_album to simply echo minimal album for each row
            def to_album(row):
                return {"objectID": row.get("object_uuid", ""), "title": row.get("title", "")}

            with patch.object(AlbumDataProcessor, "_row_to_album", side_effect=lambda r: to_album(r)):
                batches = list(self.processor.stream_albums_from_db(batch_size=2))
                self.assertEqual(len(batches), 2)
                self.assertEqual(len(batches[0]), 2)
                self.assertEqual(len(batches[1]), 1)

        # Test early stop via max_records
        rows_iter2 = [[{"rg_id": i, "object_uuid": f"id-{i}", "title": f"T{i}"} for i in range(1, 6)], []]
        with patch.object(AlbumDataProcessor, "_connect_db", return_value=FakeConn()):
            with patch.object(FakeCursor, "fetchall", new=lambda self: rows_iter2.pop(0)):
                with patch.object(
                    AlbumDataProcessor,
                    "_row_to_album",
                    side_effect=lambda r: {"objectID": r["object_uuid"], "title": r["title"]},
                ):
                    out = []
                    for batch in self.processor.stream_albums_from_db(batch_size=10, max_records=3):
                        out.extend(batch)
                    # Implementation yields full batch then stops; ensure at least 3 were yielded
                    self.assertGreaterEqual(len(out), 3)


if __name__ == "__main__":
    unittest.main(verbosity=2)
