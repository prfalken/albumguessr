import unittest
from unittest.mock import patch, MagicMock

from data_processor import AlbumDataProcessor


class TestAlbumDataProcessor(unittest.TestCase):
    def setUp(self):
        self.db = MagicMock()
        self.processor = AlbumDataProcessor(self.db)
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
        # Cover art URLs
        base = "https://coverartarchive.org/release/rel-1/front"
        self.assertEqual(out["cover_art_url"], base)

    def test_row_to_album_missing_required_returns_none(self):
        row_missing_id = {"title": "X"}
        self.assertIsNone(self.processor._row_to_album(row_missing_id))

        row_missing_title = {"object_uuid": "abc"}
        self.assertIsNone(self.processor._row_to_album(row_missing_title))


if __name__ == "__main__":
    unittest.main(verbosity=2)
