#!/usr/bin/env python3
"""
 Music Album Database Sync to Algolia

This script fetches the latest Music Album database from Kaggle,
processes the data, and indexes it to Algolia for search functionality.
"""

import argparse
import sys
from loguru import logger
import psycopg2
from config import Config

from algoliasearch.search.client import SearchClientSync
from algolia import AlgoliaApp
from algolia_indexer import AlgoliaIndexer
from algolia_searcher import AlgoliaSearcher
from data_processor import AlbumDataProcessor
from populate_mystery_albums import list_top_albums, populate_mystery_albums
from lastfm_enricher import LastFmClient
from album_enricher import AlbumEnricher


# Command handlers
def handle_stats(args, algolia_app, **kwargs):
    """Show Algolia index statistics."""
    algolia_app.get_index_stats()


def handle_clear_index(args, algolia_app, **kwargs):
    """Clear existing Algolia index."""
    algolia_app.clear_index()


def handle_configure(args, algolia_app, **kwargs):
    """Configure Algolia index settings."""
    algolia_app.configure_index_settings()


def handle_count_quality_score(args, algolia_app, **kwargs):
    """Count records with quality_score attribute."""
    algolia_app.count_records_with_quality_score()


def handle_get_by_id(args, algolia_searcher, **kwargs):
    """Get an album by its objectID."""
    result = algolia_searcher.get_album_by_id(args.get_by_id)
    if result:
        logger.info(f"Album found:")
        logger.info(f"  Title: {result.get('title', 'N/A')}")
        logger.info(f"  Artist: {result.get('main_artist', 'N/A')}")
    else:
        logger.warning(f"No album found with objectID: {args.get_by_id}")


def handle_search(args, algolia_searcher, **kwargs):
    """Search for albums in Algolia."""
    results = algolia_searcher.search_albums(args.search)
    logger.info("Search results:")
    for result in results:
        logger.info(
            result["title"],
            result.get("main_artist", "N/A"),
            result.get("release_year", "N/A"),
        )


def handle_list_top_albums(args, algolia_client, config, **kwargs):
    """List top albums from Algolia."""
    list_top_albums(
        algolia_client,
        config.ALGOLIA_INDEX_NAME,
        sort_by=args.sort_by,
    )


def handle_update_quality_scores(args, algolia_client, config, **kwargs):
    """Update quality scores for albums with existing Last.fm data."""
    logger.info("Updating quality scores for existing albums with Last.fm data")
    enricher = AlbumEnricher(algolia_client, config.ALGOLIA_INDEX_NAME)
    enricher.update_quality_scores(
        playcount_weight=args.playcount_weight,
        listeners_weight=args.listeners_weight,
    )


def handle_enrich_lastfm(args, algolia_client, config, **kwargs):
    """Enrich existing Algolia records with Last.fm engagement data."""
    if not config.LASTFM_API_KEY:
        logger.error("LASTFM_API_KEY not configured. Please set it in your environment.")
        sys.exit(1)
    lastfm_client = LastFmClient(
        config.LASTFM_API_KEY, config.LASTFM_CACHE_FILE, config.LASTFM_CACHE_TTL_DAYS
    )
    enricher = AlbumEnricher(algolia_client, config.ALGOLIA_INDEX_NAME)
    enricher.enrich_albums_with_lastfm(lastfm_client, limit=args.enrich_limit)


def handle_populate_mystery_albums(args, algolia_client, config, neon_db, **kwargs):
    """Populate mystery_random_album table with top albums per genre."""
    if not config.NEON_DATABASE_URL:
        logger.error("NEON_DATABASE_URL (NETLIFY_DATABASE_URL) not configured")
        sys.exit(1)
    if not neon_db:
        logger.error("Failed to connect to Neon database")
        sys.exit(1)
    logger.info("Starting mystery album population using Algolia")
    db = psycopg2.connect(
        host=config.DB_HOST,
        port=config.DB_PORT,
        dbname=config.DB_NAME,
        user=config.DB_USER,
        password=config.DB_PASSWORD,
    )
    populate_mystery_albums(
        db, neon_db, algolia_client, config.ALGOLIA_INDEX_NAME, clear_existing=args.clear_mystery_albums
    )
    neon_db.close()
    db.close()


def handle_default_sync(args, config, algolia_indexer, **kwargs):
    """Run the default DB-driven sync from MusicBrainz to Algolia."""
    logger.info("Starting DB-driven sync (MusicBrainz → Algolia)")
    db = psycopg2.connect(
        host=config.DB_HOST,
        port=config.DB_PORT,
        dbname=config.DB_NAME,
        user=config.DB_USER,
        password=config.DB_PASSWORD,
    )
    data_processor = AlbumDataProcessor(db)

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
    db.close()


# Command routing table: (arg_name, handler_function)
COMMANDS = [
    ("stats", handle_stats),
    ("clear_index", handle_clear_index),
    ("configure", handle_configure),
    ("count_quality_score", handle_count_quality_score),
    ("get_by_id", handle_get_by_id),
    ("search", handle_search),
    ("list_top_albums", handle_list_top_albums),
    ("update_quality_scores", handle_update_quality_scores),
    ("enrich_lastfm", handle_enrich_lastfm),
    ("populate_mystery_albums", handle_populate_mystery_albums),
]


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
    parser.add_argument("--get-by-id", type=str, help="Get an album by its objectID")
    parser.add_argument("--stats", action="store_true", help="Show Algolia index statistics")
    parser.add_argument(
        "--count-quality-score",
        action="store_true",
        help="Count records with quality_score attribute (Last.fm enriched)",
    )
    parser.add_argument(
        "--populate-mystery-albums",
        action="store_true",
        help="Populate mystery_random_album table with top albums per genre",
    )
    parser.add_argument("--list-top-albums", action="store_true", help="List top albums from Algolia")
    parser.add_argument(
        "--sort-by",
        type=str,
        help="Sort albums by lastfm_listeners, quality_score",
    )
    parser.add_argument(
        "--clear-mystery-albums",
        action="store_true",
        help="Clear existing mystery albums before populating",
    )
    parser.add_argument(
        "--enrich-lastfm",
        action="store_true",
        help="Enrich existing Algolia records with Last.fm engagement data",
    )
    parser.add_argument(
        "--enrich-limit",
        type=int,
        help="Limit number of albums to enrich (useful for testing)",
    )
    parser.add_argument(
        "--update-quality-scores",
        action="store_true",
        help="Update quality_score for albums with existing Last.fm data (fast, no API calls)",
    )
    parser.add_argument(
        "--playcount-weight",
        type=float,
        default=0.5,
        help="Weight for playcount in quality score calculation (default: 0.5)",
    )
    parser.add_argument(
        "--listeners-weight",
        type=float,
        default=0.5,
        help="Weight for listeners in quality score calculation (default: 0.5)",
    )

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

    # Neon DB connection (only if needed)
    neon_db = None
    if args.populate_mystery_albums and config.NEON_DATABASE_URL:
        neon_db = psycopg2.connect(config.NEON_DATABASE_URL)

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

    # Build context for command handlers
    context = {
        "config": config,
        "algolia_app": algolia_app,
        "algolia_indexer": algolia_indexer,
        "algolia_searcher": algolia_searcher,
        "algolia_client": algolia_client,
        "neon_db": neon_db,
    }

    # Execute first matching command
    for arg_name, handler in COMMANDS:
        if getattr(args, arg_name, None):
            handler(args, **context)
            return

    # No command matched, run default sync
    handle_default_sync(args, **context)


if __name__ == "__main__":
    main()
