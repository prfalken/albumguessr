"""
Configuration settings for the Music Album Sync application.
"""

import os
from typing import Optional
from dotenv import load_dotenv

# Load environment variables
load_dotenv()


class Config:
    """Configuration class for the application."""

    def __init__(self):
        """Initialize configuration from environment variables."""
        # Algolia configuration
        self.algolia_application_id: Optional[str] = os.getenv("ALGOLIA_APPLICATION_ID")
        self.algolia_api_key: Optional[str] = os.getenv("ALGOLIA_API_KEY")
        self.algolia_index_name: str = os.getenv("ALGOLIA_INDEX_NAME", "albumguessr")

        # Processing configuration
        self.batch_size: int = int(os.getenv("BATCH_SIZE", "1000"))
        self.max_records: Optional[int] = None  # Set to limit records for testing

        # Database configuration (MusicBrainz)
        self.db_host: str = os.getenv("DB_HOST", "localhost")
        self.db_port: int = int(os.getenv("DB_PORT", "5432"))
        self.db_name: str = os.getenv("DB_NAME", "musicbrainz_db")
        self.db_user: str = os.getenv("DB_USER", "musicbrainz")
        self.db_password: str = os.getenv("DB_PASSWORD", "musicbrainz")

        # Neon database configuration (serverless Postgres for app data)
        self.neon_database_url: Optional[str] = os.getenv("NETLIFY_DATABASE_URL")

        # Last.fm API configuration
        self.lastfm_api_key: Optional[str] = os.getenv("LASTFM_API_KEY")
        self.lastfm_cache_file: str = os.getenv("LASTFM_CACHE_FILE", ".lastfm_cache.json")
        self.lastfm_cache_ttl_days: int = int(os.getenv("LASTFM_CACHE_TTL_DAYS", "30"))

    def validate(self) -> None:
        """Validate that all required configuration is present."""
        required_vars = [
            ("ALGOLIA_APPLICATION_ID", self.algolia_application_id),
            ("ALGOLIA_API_KEY", self.algolia_api_key),
        ]

        missing_vars = [var_name for var_name, var_value in required_vars if not var_value]

        if missing_vars:
            raise ValueError(
                f"Missing required environment variables: {', '.join(missing_vars)}. "
                f"Please check your .env file or environment variables."
            )
