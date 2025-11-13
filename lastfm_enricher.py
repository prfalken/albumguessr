"""
Last.fm API client for enriching album data with engagement metrics.

This module provides functionality to fetch playcount and listener data from Last.fm
to supplement MusicBrainz ratings with popularity metrics.
"""

import json
import time
from pathlib import Path
from typing import Any, Dict, Optional
import requests
from loguru import logger


class LastFmClient:
    """Client for interacting with the Last.fm API with exponential backoff on rate limits."""

    BASE_URL = "https://ws.audioscrobbler.com/2.0/"
    
    # Rate limiting parameters
    INITIAL_DELAY = 0.5  # Initial backoff delay when rate limited
    MAX_DELAY = 5.0  # Maximum delay (0.2 req/sec - very conservative)
    
    # Exponential backoff parameters (on rate limit only)
    BACKOFF_MULTIPLIER = 2.0  # Double delay on rate limit

    def __init__(self, api_key: str, cache_file: Optional[str] = None, cache_ttl_days: int = 30):
        """
        Initialize Last.fm client with exponential backoff on rate limits.

        Args:
            api_key: Last.fm API key
            cache_file: Optional path to cache file for API responses
            cache_ttl_days: Cache TTL in days (default: 30)
        """
        self.api_key = api_key
        self.cache_file = Path(cache_file) if cache_file else None
        self.cache: Dict[str, Dict[str, Any]] = {}
        self.cache_ttl_days = cache_ttl_days
        self.last_request_time = 0.0
        
        # Rate limiting state - no delay unless rate limited
        self.current_delay = 0.0
        self.total_requests = 0
        self.rate_limited_count = 0

        # Load cache from file if it exists
        if self.cache_file and self.cache_file.exists():
            try:
                with open(self.cache_file, "r", encoding="utf-8") as f:
                    self.cache = json.load(f)
                # Clean expired entries on load
                self._clean_expired_cache()
                logger.info(f"Loaded {len(self.cache)} cached Last.fm responses")
            except Exception as e:
                logger.warning(f"Failed to load Last.fm cache: {e}")
        
        logger.info(f"Initialized Last.fm client with no throttling (exponential backoff on rate limits only)")

    def _rate_limit(self) -> None:
        """Enforce rate limiting between API requests."""
        elapsed = time.time() - self.last_request_time
        if elapsed < self.current_delay:
            time.sleep(self.current_delay - elapsed)
        self.last_request_time = time.time()
    
    def _handle_rate_limit_error(self) -> None:
        """Adjust rate limiter after hitting rate limit with exponential backoff."""
        self.rate_limited_count += 1
        old_delay = self.current_delay
        
        # If this is the first rate limit, start with initial delay
        if self.current_delay == 0.0:
            self.current_delay = self.INITIAL_DELAY
        else:
            # Otherwise apply exponential backoff
            self.current_delay = min(self.MAX_DELAY, self.current_delay * self.BACKOFF_MULTIPLIER)
        
        if old_delay == 0.0:
            logger.warning(
                f"Rate limited! Starting backoff at {self.current_delay:.1f}s delay "
                f"(total rate limits: {self.rate_limited_count})"
            )
        else:
            logger.warning(
                f"Rate limited! Exponential backoff: {old_delay:.1f}s → {self.current_delay:.1f}s delay "
                f"(total rate limits: {self.rate_limited_count})"
            )
        
        # Sleep extra time to let rate limit window pass
        time.sleep(self.current_delay)

    def _clean_expired_cache(self) -> None:
        """Remove expired entries from cache."""
        current_time = time.time()
        ttl_seconds = self.cache_ttl_days * 24 * 60 * 60

        expired_keys = []
        for key, entry in self.cache.items():
            # Handle old cache format (no timestamp)
            if not isinstance(entry, dict) or "timestamp" not in entry:
                expired_keys.append(key)
                continue

            # Check if expired
            if current_time - entry["timestamp"] > ttl_seconds:
                expired_keys.append(key)

        for key in expired_keys:
            del self.cache[key]

        if expired_keys:
            logger.info(f"Removed {len(expired_keys)} expired cache entries")

    def _save_cache(self) -> None:
        """Save cache to disk."""
        if not self.cache_file:
            return

        try:
            self.cache_file.parent.mkdir(parents=True, exist_ok=True)
            with open(self.cache_file, "w", encoding="utf-8") as f:
                json.dump(self.cache, f, indent=2)
        except Exception as e:
            logger.warning(f"Failed to save Last.fm cache: {e}")

    def _make_request(self, params: Dict[str, str], retry_count: int = 0, max_retries: int = 3) -> Optional[Dict[str, Any]]:
        """
        Make a request to the Last.fm API with exponential backoff on rate limits.

        Args:
            params: Query parameters for the API request
            retry_count: Current retry attempt (used internally)
            max_retries: Maximum number of retries on rate limit

        Returns:
            JSON response or None if request fails
        """
        # Add API key and format
        params["api_key"] = self.api_key
        params["format"] = "json"

        # Create cache key
        cache_key = json.dumps(params, sort_keys=True)

        # Check cache first
        if cache_key in self.cache:
            entry = self.cache[cache_key]
            # Handle new cache format with TTL
            if isinstance(entry, dict) and "data" in entry and "timestamp" in entry:
                # Check if expired
                ttl_seconds = self.cache_ttl_days * 24 * 60 * 60
                if time.time() - entry["timestamp"] < ttl_seconds:
                    logger.debug(f"Cache hit for Last.fm request")
                    return entry["data"]
                else:
                    logger.debug(f"Cache expired for Last.fm request")
                    del self.cache[cache_key]
            # Handle old format - treat as expired
            else:
                logger.debug(f"Old cache format detected, refreshing")
                del self.cache[cache_key]

        # Rate limit
        self._rate_limit()
        self.total_requests += 1

        try:
            response = requests.get(self.BASE_URL, params=params, timeout=10)
            
            # Handle rate limiting specifically
            if response.status_code == 429:
                self._handle_rate_limit_error()
                
                # Retry if we haven't exceeded max retries
                if retry_count < max_retries:
                    logger.info(f"Retrying request (attempt {retry_count + 1}/{max_retries})...")
                    return self._make_request(params, retry_count + 1, max_retries)
                else:
                    logger.error(f"Max retries ({max_retries}) exceeded for rate limiting")
                    return None
            
            response.raise_for_status()
            data = response.json()

            # Cache the response with timestamp
            self.cache[cache_key] = {
                "data": data,
                "timestamp": time.time(),
            }

            # Periodically save cache (every 100 requests)
            if len(self.cache) % 100 == 0:
                self._save_cache()

            # Log progress periodically
            if self.total_requests % 1000 == 0:
                if self.current_delay > 0:
                    logger.info(
                        f"API Stats: {self.total_requests} requests, "
                        f"current delay: {self.current_delay:.2f}s, "
                        f"rate limited: {self.rate_limited_count} times"
                    )
                else:
                    logger.info(
                        f"API Stats: {self.total_requests} requests, "
                        f"no throttling, "
                        f"rate limited: {self.rate_limited_count} times"
                    )

            return data
            
        except requests.exceptions.HTTPError as e:
            # Already handled 429 above, this catches other HTTP errors
            logger.error(f"Last.fm API HTTP error: {e}")
            return None
        except requests.exceptions.RequestException as e:
            logger.error(f"Last.fm API request failed: {e}")
            return None
        except json.JSONDecodeError as e:
            logger.error(f"Failed to parse Last.fm response: {e}")
            return None

    def get_album_info_by_mbid(self, mbid: str) -> Optional[Dict[str, Any]]:
        """
        Get album information by MusicBrainz ID.

        Args:
            mbid: MusicBrainz release group ID

        Returns:
            Album info dict with playcount and listeners, or None if not found
        """
        params = {
            "method": "album.getinfo",
            "mbid": mbid,
        }

        data = self._make_request(params)
        if not data or "album" not in data:
            return None

        album = data["album"]
        return self._extract_album_metrics(album)

    def get_album_info_by_name(self, artist: str, album: str) -> Optional[Dict[str, Any]]:
        """
        Get album information by artist and album name.

        Args:
            artist: Artist name
            album: Album title

        Returns:
            Album info dict with playcount and listeners, or None if not found
        """
        params = {
            "method": "album.getinfo",
            "artist": artist,
            "album": album,
        }

        data = self._make_request(params)
        if not data or "album" not in data:
            return None

        album_data = data["album"]
        return self._extract_album_metrics(album_data)

    def search_album(self, artist: str, album: str) -> Optional[Dict[str, Any]]:
        """
        Search for an album using Last.fm search API.

        Args:
            artist: Artist name
            album: Album title

        Returns:
            Best matching album info, or None if not found
        """
        params = {
            "method": "album.search",
            "album": f"{artist} {album}",
            "limit": "5",
        }

        data = self._make_request(params)
        if not data or "results" not in data:
            return None

        results = data["results"]
        if "albummatches" not in results or "album" not in results["albummatches"]:
            return None

        albums = results["albummatches"]["album"]
        if not albums:
            return None

        # Try to find best match by comparing artist and album names
        best_match = None
        for album_result in albums:
            result_artist = album_result.get("artist", "").lower()
            result_album = album_result.get("name", "").lower()

            # Simple fuzzy matching
            if artist.lower() in result_artist and album.lower() in result_album:
                best_match = album_result
                break

        if not best_match:
            # Just take the first result
            best_match = albums[0]

        # Get full info for the matched album
        return self.get_album_info_by_name(
            best_match.get("artist", ""), best_match.get("name", "")
        )

    def _extract_album_metrics(self, album_data: Dict[str, Any]) -> Optional[Dict[str, Any]]:
        """
        Extract playcount and listener metrics from Last.fm album data.

        Args:
            album_data: Raw album data from Last.fm API

        Returns:
            Dict with playcount and listeners, or None if data is invalid
        """
        try:
            playcount = int(album_data.get("playcount", 0))
            listeners = int(album_data.get("listeners", 0))

            if playcount == 0 and listeners == 0:
                return None

            return {
                "playcount": playcount,
                "listeners": listeners,
                "artist": album_data.get("artist", ""),
                "name": album_data.get("name", ""),
            }
        except (ValueError, TypeError) as e:
            logger.debug(f"Failed to extract metrics from Last.fm data: {e}")
            return None

    def enrich_album(
        self, object_id: str, artist: str, title: str
    ) -> Optional[Dict[str, Any]]:
        """
        Enrich an album with Last.fm engagement data.

        Uses artist+title matching (MBID lookup skipped because we use release group IDs,
        but Last.fm expects release IDs).

        Args:
            object_id: MusicBrainz release group ID (UUID) - not used for Last.fm lookup
            artist: Artist name
            title: Album title

        Returns:
            Dict with Last.fm metrics, or None if no data found
        """
        # Note: We skip MBID lookup because our objectID is a release group ID,
        # but Last.fm expects release IDs. Artist+title matching is more reliable.

        # Try artist + title lookup
        logger.debug(f"Trying Last.fm lookup by artist+title: {artist} - {title}")
        result = self.get_album_info_by_name(artist, title)

        if result:
            logger.debug(
                f"Found Last.fm data by name: {result['playcount']} plays, "
                f"{result['listeners']} listeners"
            )
            return result

        # Fallback: search API for fuzzy matching
        logger.debug(f"Name lookup failed, trying search: {artist} - {title}")
        result = self.search_album(artist, title)

        if result:
            logger.debug(
                f"Found Last.fm data by search: {result['playcount']} plays, "
                f"{result['listeners']} listeners"
            )
            return result

        logger.debug(f"No Last.fm data found for: {artist} - {title}")
        return None

    def close(self) -> None:
        """Save cache and cleanup, displaying final statistics."""
        self._save_cache()
        
        # Log final statistics
        logger.info("=" * 60)
        logger.info("Last.fm Client Session Summary:")
        logger.info(f"  Total API requests:        {self.total_requests}")
        logger.info(f"  Rate limited:              {self.rate_limited_count} times")
        if self.current_delay > 0:
            logger.info(f"  Final delay:               {self.current_delay:.2f}s between requests")
        else:
            logger.info(f"  Final delay:               No throttling (max speed)")
        logger.info(f"  Cached responses:          {len(self.cache)}")
        if self.total_requests > 0:
            logger.info(f"  Rate limit percentage:     {self.rate_limited_count/self.total_requests*100:.2f}%")
        logger.info("=" * 60)

