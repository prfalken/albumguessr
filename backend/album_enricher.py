"""
Album enrichment module for Last.fm engagement data and quality score calculations.
"""

import math
import time
from typing import Optional
from algoliasearch.search.client import SearchClientSync
from lastfm_enricher import LastFmClient
from loguru import logger


class AlbumEnricher:
    """Handles Last.fm enrichment and quality score calculations for albums."""

    def __init__(self, algolia_client: SearchClientSync, index_name: str):
        """
        Initialize the album enricher.

        Args:
            algolia_client: Algolia search client
            index_name: Name of the Algolia index
        """
        self.algolia_client = algolia_client
        self.index_name = index_name

    def calculate_quality_score(
        self,
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
        self,
        playcount_weight: float = 0.5,
        listeners_weight: float = 0.5,
        batch_size: int = 100,
    ) -> None:
        """
        Update quality_score for all albums that already have Last.fm data.

        This is a fast operation that doesn't make API calls - it only recalculates
        scores for albums that already have lastfm_playcount and lastfm_listeners.

        Args:
            playcount_weight: Weight for playcount component (default: 0.5)
            listeners_weight: Weight for listeners component (default: 0.5)
            batch_size: Number of records to update in each batch (default: 100)
        """
        logger.info(f"Starting quality_score update for index: {self.index_name}")
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
                    response = self.algolia_client.browse(
                        index_name=self.index_name,
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
                    response = self.algolia_client.browse(
                        index_name=self.index_name,
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
                    quality_score = self.calculate_quality_score(
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
                        self.algolia_client.partial_update_objects(
                            index_name=self.index_name,
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
                self.algolia_client.partial_update_objects(
                    index_name=self.index_name,
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
                    self.algolia_client.partial_update_objects(
                        index_name=self.index_name,
                        objects=update_batch,
                    )
                    total_updated += len(update_batch)
                    logger.info(f"Updated final batch of {len(update_batch)} records before error")
                except Exception as batch_error:
                    logger.error(f"Failed to update final batch: {batch_error}")
            raise

    def enrich_albums_with_lastfm(
        self,
        lastfm_client: LastFmClient,
        limit: Optional[int] = None,
    ) -> None:
        """
        Enrich albums in Algolia with Last.fm engagement data.

        Args:
            lastfm_client: Last.fm API client
            limit: Optional limit on number of albums to process
        """
        logger.info("Starting Last.fm enrichment process")

        total_processed = 0
        total_enriched = 0
        total_updated = 0
        total_skipped = 0

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
                    response = self.algolia_client.browse(
                        index_name=self.index_name,
                        browse_params={
                            "cursor": cursor,
                            "attributesToRetrieve": [
                                "objectID",
                                "title",
                                "main_artist",
                                "quality_score",
                            ],
                        },
                    )
                else:
                    response = self.algolia_client.browse(
                        index_name=self.index_name,
                        browse_params={
                            "attributesToRetrieve": [
                                "objectID",
                                "title",
                                "main_artist",
                                "quality_score",
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
                    quality_score = hit_dict.get("quality_score")

                    total_processed += 1

                    if not object_id or not title or not main_artist:
                        logger.debug(f"Skipping album with missing data: {object_id}")
                        continue

                    # Skip albums that already have a quality_score
                    if quality_score is not None:
                        total_skipped += 1
                        logger.debug(f"Skipping album with existing quality_score: {main_artist} - {title}")
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
                        quality_score = self.calculate_quality_score(playcount, listeners)

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
                        self.algolia_client.partial_update_objects(
                            index_name=self.index_name,
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
                        f"{total_skipped} skipped (already enriched), "
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
            f"Skipped: {total_skipped}, "
            f"Enriched: {total_enriched}, Updated: {total_updated}"
        )

