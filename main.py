#!/usr/bin/env python3
"""
 Music Album Database Sync to Algolia

This script fetches the latest Music Album database from Kaggle,
processes the data, and indexes it to Algolia for search functionality.
"""

import argparse
import sys
from loguru import logger

from config import Config

from algoliasearch.search.client import SearchClientSync
from algolia import AlgoliaApp
from algolia_indexer import AlgoliaIndexer
from algolia_searcher import AlgoliaSearcher
from data_processor import AlbumDataProcessor


class MusicAlbumSyncApp:
    """Main application class for Music Album sync."""

    def __init__(self):
        self.config = Config()
        self.data_processor = AlbumDataProcessor()

        self.algolia_client = SearchClientSync(self.config.ALGOLIA_APPLICATION_ID, self.config.ALGOLIA_API_KEY)
        self.algolia_app = AlgoliaApp(self.config, self.algolia_client)
        self.algolia_indexer = AlgoliaIndexer(self.config, self.algolia_client)
        self.algolia_searcher = AlgoliaSearcher(self.config, self.algolia_client)

    def validate_environment(self) -> bool:
        """Validate that all required environment variables are set."""
        try:
            self.config.validate()
            return True
        except ValueError as e:
            logger.error(f"Environment validation failed: {e}")
            logger.error("Please create a .env file with the following variables:")
            logger.error("   - ALGOLIA_APPLICATION_ID: Your Algolia application ID")
            logger.error("   - ALGOLIA_API_KEY: Your Algolia admin API key")
            logger.error("   - ALGOLIA_INDEX_NAME: Name for your albums index (optional, defaults to 'albums')")
            logger.error("\n💡 You can copy .env.example to .env and fill in your credentials.")
            return False

    def show_index_stats(self):
        """Show current index statistics."""
        logger.info("Getting index statistics...")
        try:
            stats = self.algolia_app.get_index_stats()
            logger.info(stats)

        except Exception as e:
            logger.error(f"Failed to get index stats: {e}")


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(
        description="Sync Music Album database to Algolia",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )

    parser.add_argument(
        "--max-records",
        type=int,
        help="Maximum number of records to process (useful for testing)",
    )

    parser.add_argument(
        "--batch-size",
        type=int,
        default=1000,
        help="Batch size for processing large files (default: 1000)",
    )

    parser.add_argument(
        "--clear-index",
        action="store_true",
        help="Clear existing Algolia index before indexing new data",
    )
    parser.add_argument("--configure", action="store_true", help="Configure Algolia index settings")
    parser.add_argument("--search", type=str, help="Search for a album in Algolia")
    parser.add_argument("--stats", action="store_true", help="Show Algolia index statistics")

    # Build epilog dynamically from declared options
    def _build_examples_from_parser(p: argparse.ArgumentParser) -> str:
        examples: list[str] = [
            "Examples:",
            "  python main.py                                  # Run full sync",
        ]

        sample_values = {
            "max_records": "1000",
            "batch_size": "500",
            "data_file": "data/ridethelightning.json",
            "search": '"appetite for destruction"',
        }

        for action in p._actions:  # type: ignore[attr-defined]
            # consider only long-form options and skip help
            long_opts = [opt for opt in action.option_strings if opt.startswith("--")]
            if not long_opts or action.dest in {"help"}:
                continue

            opt = long_opts[0]
            help_text = (action.help or "").strip()

            # If action.type is None, it's likely a flag (store_true)
            if getattr(action, "type", None) is None:
                examples.append(f"  python main.py {opt}            # {help_text}")
            else:
                value = sample_values.get(action.dest, "VALUE")
                examples.append(f"  python main.py {opt} {value}       # {help_text}")

        return "\n".join(examples)

    parser.epilog = _build_examples_from_parser(parser)
    args = parser.parse_args()

    # Create app instance
    app = MusicAlbumSyncApp()

    # Validate environment
    if not app.validate_environment():
        sys.exit(1)

    # Handle different command modes
    if args.stats:
        app.show_index_stats()
    elif args.clear_index:
        app.algolia_app.clear_index()
    elif args.configure:
        app.algolia_app.configure_index_settings()
    elif args.search:
        results = app.algolia_searcher.search_albums(args.search)
        logger.info("Search results:")
        for result in results:
            logger.info(
                result["title"],
                result.get("main_artist", "N/A"),
                result.get("release_year", "N/A"),
            )
    else:
        logger.info("Starting DB-driven sync (MusicBrainz → Algolia)")
        total_indexed = 0
        for batch in app.data_processor.stream_albums_from_db(
            batch_size=args.batch_size, max_records=args.max_records
        ):
            if not batch:
                continue
            app.algolia_indexer.batch_index_records(batch)
            total_indexed += len(batch)
            logger.info(f"Indexed so far: {total_indexed}")
        logger.info(f"Completed DB sync. Total indexed: {total_indexed}")


if __name__ == "__main__":
    main()
