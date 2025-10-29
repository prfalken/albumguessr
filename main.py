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
    config = Config()
    data_processor = AlbumDataProcessor()

    algolia_client = SearchClientSync(config.ALGOLIA_APPLICATION_ID, config.ALGOLIA_API_KEY)
    algolia_app = AlgoliaApp(config, algolia_client)
    algolia_indexer = AlgoliaIndexer(config, algolia_client)
    algolia_searcher = AlgoliaSearcher(config, algolia_client)

    # Validate environment
    try:
        config.validate()
    except ValueError as e:
        logger.error(f"Environment validation failed: {e}")
        sys.exit(1)

    # Handle different command modes
    if args.stats:
        algolia_app.get_index_stats()
    elif args.clear_index:
        algolia_app.clear_index()
    elif args.configure:
        algolia_app.configure_index_settings()
    elif args.search:
        results = algolia_searcher.search_albums(args.search)
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
        for batch in data_processor.stream_albums_from_db(
            batch_size=args.batch_size, max_records=args.max_records
        ):
            if not batch:
                continue
            algolia_indexer.batch_index_records(batch)
            total_indexed += len(batch)
            logger.info(f"Indexed so far: {total_indexed}")
        logger.info(f"Completed DB sync. Total indexed: {total_indexed}")


if __name__ == "__main__":
    main()
