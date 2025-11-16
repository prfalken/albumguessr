from config import Config
from algoliasearch.search.client import SearchClientSync

from loguru import logger


class AlgoliaApp:
    def __init__(self, config: Config, client: SearchClientSync):
        self.config = config
        self.client = client
        self.index_name = config.ALGOLIA_INDEX_NAME
        self.batch_size = 1000  # Algolia recommended batch size

    def clear_index(self) -> None:
        """Clear all records from the Algolia index."""
        try:
            logger.info(f"Clearing index '{self.index_name}'...")
            self.client.clear_objects(index_name=self.index_name)
            logger.info(f"Index '{self.index_name}' cleared successfully.")
        except Exception as e:
            logger.error(f"Error clearing index '{self.index_name}': {e}")

    def get_index_stats(self):
        """Retrieve statistics for the Algolia index."""
        try:
            stats = self.client.list_indices()
            logger.info(f"Index stats for '{self.index_name}': {stats}")
            print(stats)
        except Exception as e:
            logger.error(f"Error retrieving index stats: {e}")
            return {}

    def configure_index_settings(self) -> None:
        """Configure Algolia index settings for optimal album search with composite scoring."""
        logger.info("Configuring index settings for optimal album search...")
        try:
            self.client.set_settings(
                index_name=self.index_name,
                index_settings={
                    "searchableAttributes": ["unordered(main_artist , title )", "primary_genre"],
                    "attributesForFaceting": [
                        "filterOnly(release_year)",
                        "searchable(primary_genre)",
                        "filterOnly(countries)",
                    ],
                    "customRanking": [
                        "desc(composite_score)",  # Primary: composite score (quality + engagement)
                        "desc(rating_score)",  # Secondary: MusicBrainz rating score
                        "desc(lastfm_playcount)",  # Tertiary: Last.fm playcount
                        "desc(release_year)",  # Quaternary: recency
                    ],
                },
            )
            logger.info("Algolia settings updated with composite scoring")
        except Exception as e:
            logger.error(f"Failed to update Algolia settings: {e}")

    def count_records_with_quality_score(self) -> None:
        """Display the number of records that have the quality_score attribute set."""
        try:
            logger.info("Counting records with quality_score attribute...")

            total_records = 0
            records_with_quality = 0
            cursor = None

            # Use browse to iterate through all records efficiently
            while True:
                if cursor:
                    response = self.client.browse(
                        index_name=self.index_name,
                        browse_params={
                            "attributesToRetrieve": ["quality_score"],
                            "cursor": cursor,
                        },
                    )
                else:
                    response = self.client.browse(
                        index_name=self.index_name,
                        browse_params={
                            "attributesToRetrieve": ["quality_score"],
                        },
                    )

                hits = response.hits if hasattr(response, "hits") else []

                for hit in hits:
                    total_records += 1
                    # Convert hit object to dictionary
                    hit_dict = hit.to_dict() if hasattr(hit, "to_dict") else hit

                    if "quality_score" in hit_dict:
                        records_with_quality += 1

                # Log progress every 10,000 records
                if total_records % 10000 == 0:
                    logger.info(f"Processed {total_records:,} records...")

                cursor = response.cursor if hasattr(response, "cursor") else None
                if not cursor:
                    break

            percentage = (records_with_quality / total_records * 100) if total_records > 0 else 0

            logger.info(f"Records with quality_score: {records_with_quality:,}")
            logger.info(f"Total records in index: {total_records:,}")
            logger.info(f"Percentage with quality_score: {percentage:.2f}%")

            print(f"\n{'='*60}")
            print(f"Records with quality_score: {records_with_quality:,}")
            print(f"Total records in index:       {total_records:,}")
            print(f"Coverage:                     {percentage:.2f}%")
            print(f"{'='*60}\n")

        except Exception as e:
            logger.error(f"Error counting records with quality_score: {e}")
