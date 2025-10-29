from config import Config
from data_processor import AlbumDataProcessor
from algolia import AlgoliaApp
from algolia_indexer import AlgoliaIndexer
from algolia_searcher import AlgoliaSearcher
from loguru import logger


class MusicAlbumSyncApp:
    """Main application class for Music Album sync."""

    def __init__(
        self,
        config: Config,
        data_processor: AlbumDataProcessor,
        algolia_app: AlgoliaApp,
        algolia_indexer: AlgoliaIndexer,
        algolia_searcher: AlgoliaSearcher,
    ):
        self.config = config
        self.data_processor = data_processor
        self.algolia_app = algolia_app
        self.algolia_indexer = algolia_indexer
        self.algolia_searcher = algolia_searcher

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
