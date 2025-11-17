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
import math
import time


def calculate_quality_score(
    lastfm_playcount: int,
    lastfm_listeners: int,
) -> float:
    """
    Calculate a quality score combining Last.fm playcount and listeners.

    Args:
        lastfm_playcount: Total plays on Last.fm
        lastfm_listeners: Total unique listeners on Last.fm

    Returns:
        Quality score combining both metrics
    """
    # Normalize using log scale to handle large differences
    normalized_listeners = math.log10(lastfm_listeners + 1)
    normalized_playcount = math.log10(lastfm_playcount + 1)

    # Combine with equal or custom weights
    combined_score = (0.5 * normalized_listeners) + (0.5 * normalized_playcount)
    return round(combined_score, 2)


def update_quality_scores(
    algolia_client: SearchClientSync,
    index_name: str,
    playcount_weight: float = 0.5,
    listeners_weight: float = 0.5,
    batch_size: int = 100,
) -> None:
    """
    Update quality_score for all albums that already have Last.fm data.

    This is a fast operation that doesn't make API calls - it only recalculates
    scores for albums that already have lastfm_playcount and lastfm_listeners.

    Args:
        algolia_client: Algolia search client
        index_name: Name of the Algolia index
        playcount_weight: Weight for playcount component (default: 0.5)
        listeners_weight: Weight for listeners component (default: 0.5)
        batch_size: Number of records to update in each batch (default: 100)
    """
    logger.info(f"Starting quality_score update for index: {index_name}")
    logger.info(f"Weights: playcount={playcount_weight}, listeners={listeners_weight}")

    total_processed = 0
    total_with_data = 0
    total_without_data = 0
    total_updated = 0

    start_time = time.time()
    last_milestone_time = start_time
    last_milestone_count = 0

    # Batch updates for efficiency
    update_batch = []

    try:
        cursor = None

        while True:
            # Fetch albums from Algolia using browse for efficient iteration
            if cursor:
                response = algolia_client.browse(
                    index_name=index_name,
                    browse_params={
                        "cursor": cursor,
                        "attributesToRetrieve": [
                            "objectID",
                            "title",
                            "main_artist",
                            "lastfm_playcount",
                            "lastfm_listeners",
                        ],
                    },
                )
            else:
                response = algolia_client.browse(
                    index_name=index_name,
                    browse_params={
                        "attributesToRetrieve": [
                            "objectID",
                            "title",
                            "main_artist",
                            "lastfm_playcount",
                            "lastfm_listeners",
                        ],
                    },
                )

            hits = response.hits
            if not hits:
                break

            # Process each album in the batch
            for hit in hits:
                total_processed += 1
                hit_dict = hit.to_dict()

                object_id = hit_dict.get("objectID")
                playcount = hit_dict.get("lastfm_playcount", 0)
                listeners = hit_dict.get("lastfm_listeners", 0)

                # Skip if no Last.fm data
                if not playcount and not listeners:
                    total_without_data += 1
                    continue

                total_with_data += 1

                # Calculate quality score using the normalized weighted average
                quality_score = calculate_quality_score(
                    lastfm_playcount=playcount or 0,
                    lastfm_listeners=listeners or 0,
                )

                # Add to update batch
                update_batch.append(
                    {
                        "objectID": object_id,
                        "quality_score": quality_score,
                    }
                )

                # Update in batches for efficiency
                if len(update_batch) >= batch_size:
                    algolia_client.partial_update_objects(
                        index_name=index_name,
                        objects=update_batch,
                    )
                    total_updated += len(update_batch)
                    logger.debug(f"Updated batch of {len(update_batch)} records")
                    update_batch = []

                # Progress reporting every 1000 records
                if total_processed % 1000 == 0:
                    current_time = time.time()
                    elapsed = current_time - last_milestone_time
                    records_since_milestone = total_processed - last_milestone_count
                    rate = records_since_milestone / elapsed if elapsed > 0 else 0

                    logger.info(
                        f"Processed: {total_processed:,} albums | "
                        f"With data: {total_with_data:,} | "
                        f"Updated: {total_updated:,} | "
                        f"Rate: {rate:.1f} records/sec"
                    )

                    last_milestone_time = current_time
                    last_milestone_count = total_processed

            # Get next cursor
            cursor = response.cursor if hasattr(response, "cursor") else None
            if not cursor:
                break

        # Update remaining records in batch
        if update_batch:
            algolia_client.partial_update_objects(
                index_name=index_name,
                objects=update_batch,
            )
            total_updated += len(update_batch)
            logger.debug(f"Updated final batch of {len(update_batch)} records")

        # Final statistics
        elapsed_total = time.time() - start_time
        logger.info("=" * 80)
        logger.info("Quality Score Update Complete!")
        logger.info("=" * 80)
        logger.info(f"Total processed:           {total_processed:,}")
        logger.info(f"With Last.fm data:         {total_with_data:,}")
        logger.info(f"Without Last.fm data:      {total_without_data:,}")
        logger.info(f"Total updated:             {total_updated:,}")
        logger.info(f"Time elapsed:              {elapsed_total:.2f} seconds")
        if total_processed > 0:
            logger.info(f"Average rate:              {total_processed/elapsed_total:.1f} records/sec")
        logger.info("=" * 80)

    except Exception as e:
        logger.error(f"Error during quality score update: {e}")
        # Try to update any remaining batch
        if update_batch:
            try:
                algolia_client.partial_update_objects(
                    index_name=index_name,
                    objects=update_batch,
                )
                total_updated += len(update_batch)
                logger.info(f"Updated final batch of {len(update_batch)} records before error")
            except Exception as batch_error:
                logger.error(f"Failed to update final batch: {batch_error}")
        raise


def enrich_albums_with_lastfm(
    algolia_client: SearchClientSync,
    index_name: str,
    lastfm_client: LastFmClient,
    limit: int = None,
) -> None:
    """
    Enrich albums in Algolia with Last.fm engagement data.

    Args:
        algolia_client: Algolia search client
        index_name: Name of the Algolia index
        lastfm_client: Last.fm API client
        limit: Optional limit on number of albums to process
    """
    logger.info("Starting Last.fm enrichment process")

    total_processed = 0
    total_enriched = 0
    total_updated = 0

    # Timing tracking
    start_time = time.time()
    last_milestone_time = start_time
    last_milestone_count = 0

    try:
        cursor = None

        while True:
            if limit and total_processed >= limit:
                logger.info(f"Reached limit of {limit} albums")
                break

            # Fetch albums from Algolia using browse for efficient iteration
            if cursor:
                response = algolia_client.browse(
                    index_name=index_name,
                    browse_params={
                        "cursor": cursor,
                        "attributesToRetrieve": [
                            "objectID",
                            "title",
                            "main_artist",
                        ],
                    },
                )
            else:
                response = algolia_client.browse(
                    index_name=index_name,
                    browse_params={
                        "attributesToRetrieve": [
                            "objectID",
                            "title",
                            "main_artist",
                        ],
                    },
                )

            hits = response.hits
            if not hits:
                break

            # Prepare batch of albums for parallel enrichment
            albums_to_enrich = []
            album_metadata = {}  # Store album info keyed by objectID

            for hit in hits:
                hit_dict = hit.to_dict()
                object_id = hit_dict.get("objectID")
                title = hit_dict.get("title")
                main_artist = hit_dict.get("main_artist")

                total_processed += 1

                if not object_id or not title or not main_artist:
                    logger.debug(f"Skipping album with missing data: {object_id}")
                    continue

                albums_to_enrich.append((object_id, main_artist, title))
                album_metadata[object_id] = {
                    "title": title,
                    "main_artist": main_artist,
                }

            # Enrich all albums in parallel
            enrichment_results = lastfm_client.enrich_albums_batch(albums_to_enrich, max_workers=10)

            # Process results and prepare Algolia updates
            batch_updates = []
            for object_id, lastfm_data in enrichment_results:
                if lastfm_data:
                    total_enriched += 1

                    playcount = lastfm_data.get("playcount", 0)
                    listeners = lastfm_data.get("listeners", 0)

                    # Calculate quality score
                    quality_score = calculate_quality_score(playcount, listeners)

                    # Prepare update
                    update_obj = {
                        "objectID": object_id,
                        "lastfm_playcount": playcount,
                        "lastfm_listeners": listeners,
                        "quality_score": round(quality_score, 2),
                    }

                    batch_updates.append(update_obj)

                    metadata = album_metadata.get(object_id, {})
                    logger.debug(
                        f"Enriched: {metadata.get('main_artist')} - {metadata.get('title')} | "
                        f"Plays: {playcount}, Listeners: {listeners}, "
                        f"Quality: {quality_score}"
                    )

            # Update Algolia in batch
            if batch_updates:
                try:
                    algolia_client.partial_update_objects(
                        index_name=index_name,
                        objects=batch_updates,
                    )
                    total_updated += len(batch_updates)
                    logger.info(
                        f"Updated batch of {len(batch_updates)} albums "
                        f"(Total: {total_updated}/{total_processed})"
                    )
                except Exception as e:
                    logger.error(f"Failed to update Algolia batch: {e}")

            # Update cursor for next iteration
            cursor = response.cursor if hasattr(response, "cursor") else None
            if not cursor:
                break

            # Log progress with timing every 1000 albums
            if total_processed % 1000 == 0:
                current_time = time.time()
                batch_elapsed = current_time - last_milestone_time
                total_elapsed = current_time - start_time
                albums_in_batch = total_processed - last_milestone_count

                logger.info(
                    f"Progress: {total_processed} processed, "
                    f"{total_enriched} enriched, {total_updated} updated | "
                    f"Last {albums_in_batch} albums: {batch_elapsed:.1f}s "
                    f"({albums_in_batch/batch_elapsed:.1f} albums/sec) | "
                    f"Total time: {total_elapsed:.1f}s"
                )

                last_milestone_time = current_time
                last_milestone_count = total_processed

    finally:
        lastfm_client.close()

    logger.info(
        f"Enrichment complete. Processed: {total_processed}, "
        f"Enriched: {total_enriched}, Updated: {total_updated}"
    )


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

    # Handle different command modes
    if args.stats:
        algolia_app.get_index_stats()
    elif args.clear_index:
        algolia_app.clear_index()
    elif args.configure:
        algolia_app.configure_index_settings()
    elif args.count_quality_score:
        algolia_app.count_records_with_quality_score()
    elif args.get_by_id:
        result = algolia_searcher.get_album_by_id(args.get_by_id)
        if result:
            logger.info(f"Album found:")
            logger.info(f"  Title: {result.get('title', 'N/A')}")
            logger.info(f"  Artist: {result.get('main_artist', 'N/A')}")
        else:
            logger.warning(f"No album found with objectID: {args.get_by_id}")
    elif args.search:
        results = algolia_searcher.search_albums(args.search)
        logger.info("Search results:")
        for result in results:
            logger.info(
                result["title"],
                result.get("main_artist", "N/A"),
                result.get("release_year", "N/A"),
            )
    elif args.list_top_albums:
        list_top_albums(
            algolia_client,
            config.ALGOLIA_INDEX_NAME,
            sort_by=args.sort_by,
        )
    elif args.update_quality_scores:
        logger.info("Updating quality scores for existing albums with Last.fm data")
        update_quality_scores(
            algolia_client,
            config.ALGOLIA_INDEX_NAME,
            playcount_weight=args.playcount_weight,
            listeners_weight=args.listeners_weight,
        )
    elif args.enrich_lastfm:
        if not config.LASTFM_API_KEY:
            logger.error("LASTFM_API_KEY not configured. Please set it in your environment.")
            sys.exit(1)
        lastfm_client = LastFmClient(config.LASTFM_API_KEY, config.LASTFM_CACHE_FILE, config.LASTFM_CACHE_TTL_DAYS)
        enrich_albums_with_lastfm(
            algolia_client, config.ALGOLIA_INDEX_NAME, lastfm_client, limit=args.enrich_limit
        )
    elif args.populate_mystery_albums:
        if not config.NEON_DATABASE_URL:
            logger.error("NEON_DATABASE_URL (NETLIFY_DATABASE_URL) not configured")
            sys.exit(1)
        if not neon_db:
            logger.error("Failed to connect to Neon database")
            sys.exit(1)
        logger.info("Starting mystery album population using Algolia")
        populate_mystery_albums(
            db, neon_db, algolia_client, config.ALGOLIA_INDEX_NAME, clear_existing=args.clear_mystery_albums
        )
        neon_db.close()
    else:
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


if __name__ == "__main__":
    main()
