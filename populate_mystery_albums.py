"""
Populate the mystery_random_album table with top-rated albums per genre.

This module uses Algolia's indexed data to efficiently find top-rated albums
for each genre, avoiding slow MusicBrainz queries.
"""

import re
import warnings
from typing import Any, Dict, List, Optional
import psycopg2
import psycopg2.extensions
from psycopg2.extras import RealDictCursor
from algoliasearch.search.client import SearchClientSync
from loguru import logger

# Suppress Pydantic serialization warnings from Algolia SDK
warnings.filterwarnings("ignore", category=UserWarning, module="pydantic.main")


def get_available_genres(neon_conn: psycopg2.extensions.connection) -> List[str]:
    """
    Query the available_genres table from Neon DB and return enabled genres.

    Args:
        neon_conn: PostgreSQL connection to Neon database

    Returns:
        List of genre names that are enabled
    """
    genres = []
    with neon_conn.cursor(cursor_factory=RealDictCursor) as cursor:
        cursor.execute(
            """
            SELECT name 
            FROM available_genres 
            WHERE enabled = true
            ORDER BY name
        """
        )
        rows = cursor.fetchall()
        genres = [row["name"] for row in rows]

    logger.info(f"Found {len(genres)} enabled genres in Neon DB")
    return genres


def get_all_musicbrainz_genres(musicbrainz_conn: psycopg2.extensions.connection) -> List[str]:
    """
    Query all genre names from MusicBrainz genre table.

    Args:
        musicbrainz_conn: PostgreSQL connection to MusicBrainz database

    Returns:
        List of all genre names from MusicBrainz
    """
    genres = []
    with musicbrainz_conn.cursor(cursor_factory=RealDictCursor) as cursor:
        cursor.execute("SELECT name FROM musicbrainz.genre ORDER BY name")
        rows = cursor.fetchall()
        genres = [row["name"] for row in rows]

    logger.info(f"Found {len(genres)} genres in MusicBrainz database")
    return genres


def match_genre_to_neon(mb_genre: str, neon_genres: List[str]) -> Optional[str]:
    """
    Check if a MusicBrainz genre matches any Neon genre using word boundaries.

    Example: "classic rock" matches "rock", "pop rock" matches both "pop" and "rock"

    Args:
        mb_genre: Genre name from MusicBrainz
        neon_genres: List of enabled genre names from Neon DB

    Returns:
        First matching Neon genre name, or None if no match
    """
    for neon_genre in neon_genres:
        # Use word boundary regex for matching
        pattern = rf"\b{re.escape(neon_genre)}\b"
        if re.search(pattern, mb_genre, re.IGNORECASE):
            return neon_genre
    return None


def search_albums_by_genre(
    algolia_client: SearchClientSync, index_name: str, genre_name: str, limit: int = 1000
) -> List[Dict[str, Any]]:
    """
    Search Algolia for albums with exact primary_genre match.

    Args:
        algolia_client: Algolia search client
        index_name: Name of the Algolia index
        genre_name: Exact genre name to filter by
        limit: Maximum number of results to return (default: 1000)

    Returns:
        List of albums with objectID, primary_genre, and rating_score
    """
    try:
        response = algolia_client.search_single_index(
            index_name=index_name,
            search_params={
                "query": "",  # Empty query to get all results
                "filters": f'primary_genre:"{genre_name}"',
                "hitsPerPage": limit,
                "attributesToRetrieve": ["objectID", "primary_genre", "rating_score", "title"],
            },
        )

        albums = []
        for hit in response.hits:
            hit_dict = hit.to_dict()
            albums.append(
                {
                    "object_id": hit_dict.get("objectID"),
                    "primary_genre": hit_dict.get("primary_genre"),
                    "rating_score": hit_dict.get("rating_score", 0),
                    "title": hit_dict.get("title"),
                }
            )

        return albums
    except Exception as e:
        logger.error(f"Error searching Algolia for genre '{genre_name}': {e}")
        return []


def insert_mystery_albums(neon_conn: psycopg2.extensions.connection, albums: List[Dict[str, Any]]) -> int:
    """
    Insert albums into the mystery_random_album table.

    Uses INSERT ... ON CONFLICT DO NOTHING to handle duplicates gracefully.

    Args:
        neon_conn: PostgreSQL connection to Neon database
        albums: List of album dictionaries with object_id and primary_genre

    Returns:
        Number of albums inserted
    """
    if not albums:
        return 0

    inserted_count = 0
    with neon_conn.cursor() as cursor:
        for album in albums:
            try:
                cursor.execute(
                    """
                    INSERT INTO mystery_random_album (object_id, primary_genre)
                    VALUES (%s, %s)
                    ON CONFLICT (object_id, primary_genre) DO NOTHING
                """,
                    (album["object_id"], album["primary_genre"]),
                )

                if cursor.rowcount > 0:
                    inserted_count += 1

                # Commit after each successful insert to avoid transaction abort issues
                neon_conn.commit()
            except Exception as e:
                # Rollback the failed transaction and continue with next album
                neon_conn.rollback()
                logger.error(f"Error inserting album {album.get('object_id', 'unknown')}: {e}")
                continue

    return inserted_count


def clear_mystery_albums(neon_conn: psycopg2.extensions.connection) -> None:
    """
    Clear all existing records from the mystery_random_album table.

    Args:
        neon_conn: PostgreSQL connection to Neon database
    """
    with neon_conn.cursor() as cursor:
        cursor.execute("DELETE FROM mystery_random_album")
        neon_conn.commit()
        logger.info("Cleared all existing mystery albums")


def populate_mystery_albums(
    musicbrainz_conn: psycopg2.extensions.connection,
    neon_conn: psycopg2.extensions.connection,
    algolia_client: SearchClientSync,
    index_name: str,
    clear_existing: bool = False,
) -> None:
    """
    Main function to populate the mystery_random_album table using Algolia.

    1. Gets all enabled genres from Neon DB
    2. Gets all genres from MusicBrainz
    3. For each MusicBrainz genre:
       - Searches Algolia with exact primary_genre filter
       - Checks if it matches any Neon genre (word boundary)
       - If match, accumulates albums for that Neon genre
    4. For each Neon genre, takes top 1000 by rating_score
    5. Inserts into mystery_random_album table

    Args:
        musicbrainz_conn: PostgreSQL connection to MusicBrainz database
        neon_conn: PostgreSQL connection to Neon database
        algolia_client: Algolia search client
        index_name: Name of the Algolia index
        clear_existing: If True, clear existing records before populating
    """
    logger.info("Starting mystery album population using Algolia")

    # Optionally clear existing records
    if clear_existing:
        clear_mystery_albums(neon_conn)

    # Get enabled genres from Neon
    neon_genres = get_available_genres(neon_conn)

    if not neon_genres:
        logger.warning("No enabled genres found in Neon DB")
        return

    # Get all MusicBrainz genres
    mb_genres = get_all_musicbrainz_genres(musicbrainz_conn)

    if not mb_genres:
        logger.warning("No genres found in MusicBrainz database")
        return

    # Accumulate albums per Neon genre
    # Key: Neon genre name, Value: List of albums
    genre_albums: Dict[str, List[Dict[str, Any]]] = {genre: [] for genre in neon_genres}

    logger.info(f"Processing {len(mb_genres)} MusicBrainz genres...")

    # Process each MusicBrainz genre
    for idx, mb_genre in enumerate(mb_genres, 1):
        if idx % 100 == 0:
            logger.info(f"Processed {idx}/{len(mb_genres)} MusicBrainz genres...")

        # Check if this MusicBrainz genre matches any Neon genre
        matched_neon_genre = match_genre_to_neon(mb_genre, neon_genres)

        if not matched_neon_genre:
            continue

        # Search Algolia for albums with this exact primary_genre
        albums = search_albums_by_genre(algolia_client, index_name, mb_genre, limit=1000)

        if albums:
            # Add these albums to the matched Neon genre's collection
            for album in albums:
                # Store with the Neon genre name for insertion
                album["neon_genre"] = matched_neon_genre
                genre_albums[matched_neon_genre].append(album)

            logger.debug(
                f"MusicBrainz genre '{mb_genre}' → Neon genre '{matched_neon_genre}': "
                f"found {len(albums)} albums"
            )

    # For each Neon genre, take top 1000 by rating_score and insert
    total_inserted = 0

    for neon_genre in neon_genres:
        albums = genre_albums[neon_genre]

        if not albums:
            logger.warning(f"No albums found for Neon genre '{neon_genre}'")
            continue

        # Sort by rating_score descending and take top 1000
        albums.sort(key=lambda x: x.get("rating_score", 0), reverse=True)
        top_albums = albums[:1000]

        # Prepare albums for insertion with the Neon genre name
        albums_to_insert = [
            {
                "object_id": album["object_id"],
                "primary_genre": neon_genre,  # Use Neon genre name, not MusicBrainz genre
            }
            for album in top_albums
            if album.get("object_id")
        ]

        # Insert into Neon DB
        inserted = insert_mystery_albums(neon_conn, albums_to_insert)
        total_inserted += inserted

        logger.info(
            f"Neon genre '{neon_genre}': processed {len(albums)} albums, "
            f"inserted top {inserted} (total so far: {total_inserted})"
        )

    logger.info(f"Completed mystery album population. Total inserted: {total_inserted}")
