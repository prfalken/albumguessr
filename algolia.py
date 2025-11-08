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
        """Configure Algolia index settings for optimal album search with rating support."""
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
                        "desc(rating_score)",
                        "desc(release_year)",
                    ],
                },
            )
            logger.info("Algolia settings updated")
        except Exception as e:
            logger.error(f"Failed to update Algolia settings: {e}")
