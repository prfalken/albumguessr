"""
Populate the mystery_random_album table with top-rated albums per genre.

This module uses Algolia's indexed data to efficiently find top-rated albums
for each genre, avoiding slow MusicBrainz queries.
"""

import re
import warnings
import random
from datetime import datetime, timedelta
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


def search_albums(algolia_client: SearchClientSync, index_name: str) -> List[Dict[str, Any]]:
    try:
        response = algolia_client.search_single_index(
            index_name=index_name,
            search_params={
                "query": "",  # Empty query to get all results
                "hitsPerPage": 1000,
                "attributesToRetrieve": [
                    "objectID",
                    "primary_genre",
                    "title",
                    "main_artist",
                    "lastfm_playcount",
                    "lastfm_listeners",
                    "quality_score",
                ],
            },
        )

        albums = []
        for hit in response.hits:
            hit_dict = hit.to_dict()
            albums.append(
                {
                    "object_id": hit_dict.get("objectID"),
                    "primary_genre": hit_dict.get("primary_genre"),
                    "title": hit_dict.get("title"),
                    "main_artist": hit_dict.get("main_artist"),
                    "lastfm_playcount": hit_dict.get("lastfm_playcount"),
                    "lastfm_listeners": hit_dict.get("lastfm_listeners"),
                    "quality_score": hit_dict.get("quality_score"),
                }
            )

        return albums
    except Exception as e:
        logger.error(f"Error searching Algolia: {e}")
        return []


def list_top_albums(
    algolia_client: SearchClientSync,
    index_name: str,
    sort_by: str,
) -> List[Dict[str, Any]]:
    """
    List top albums from Algolia by Last.fm plays and listeners with optional formatting.

    Args:
        algolia_client: Algolia search client
        index_name: Name of the Algolia index
        limit: Maximum number of albums to retrieve
        format: Output format - "csv" or "pretty" (default: "csv")
        sort_by: Sort by "playcount", "listeners", "engagement_score", or "both" (default: "both")
    """

    albums = search_albums(algolia_client, index_name + "_sort_" + sort_by)

    if not albums:
        logger.info("No albums found")
        return albums

    print("=" * 120)

    header = f"{'#':<5} {'Title':<20} {'Artist':<25}" f"{'Listeners':<10} {'Playcount':<15} {'Quality':<10}"
    print(header)
    print("-" * 120)

    for idx, album in enumerate(albums, 1):
        title = (album.get("title") or "N/A")[:20]
        artist = (album.get("main_artist") or "N/A")[:25]
        playcount = album.get("lastfm_playcount") or 0
        listeners = album.get("lastfm_listeners") or 0
        quality = album.get("quality_score") or 0
        print(f"{idx:<5} {title:<20} {artist:<25}" f"{listeners:<10,} {playcount:<15,} {quality:<10,.2f}")

    print("=" * 120)
    print(f"Total albums: {len(albums)}\n")

    return albums


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
        List of albums with objectID, primary_genre, composite_score, and rating_score
    """
    try:
        response = algolia_client.search_single_index(
            index_name=index_name,
            search_params={
                "query": "",  # Empty query to get all results
                "filters": f'primary_genre:"{genre_name}"',
                "hitsPerPage": limit,
                "attributesToRetrieve": [
                    "objectID",
                    "primary_genre",
                    "rating_score",
                    "composite_score",
                    "title",
                ],
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
                    "composite_score": hit_dict.get("composite_score", 0),
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

    # For each Neon genre, take top 1000 by composite_score (or rating_score) and insert
    total_inserted = 0

    for neon_genre in neon_genres:
        albums = genre_albums[neon_genre]

        if not albums:
            logger.warning(f"No albums found for Neon genre '{neon_genre}'")
            continue

        # Sort by composite_score descending (fallback to rating_score) and take top 1000
        albums.sort(key=lambda x: x.get("composite_score") or x.get("rating_score", 0), reverse=True)
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


def populate_album_of_the_day_schedule(
    neon_conn: psycopg2.extensions.connection,
    algolia_client: SearchClientSync,
    index_name: str,
) -> None:
    """
    Populate the mystery_album_schedule table with 365 albums for daily challenges.
    
    Fetches top albums by quality_score from Algolia, shuffles them, and inserts
    them into the schedule starting from tomorrow. Uses smart shuffling to avoid
    placing albums from the same artist in the same month.
    
    Args:
        neon_conn: PostgreSQL connection to Neon database
        algolia_client: Algolia search client
        index_name: Name of the Algolia index
    """
    logger.info("Starting album of the day schedule population")
    
    # Fetch albums sorted by quality_score
    albums = search_albums(algolia_client, index_name + "_sort_quality_score")
    
    if not albums:
        logger.error("No albums found in Algolia")
        return
    
    logger.info(f"Found {len(albums)} albums total")
    
    # Take first 365 albums (best quality scores)
    albums_to_schedule = albums[:365]
    
    # Smart shuffle: group by artist and distribute across months
    # to avoid same artist appearing in the same month
    from collections import defaultdict
    
    # Group albums by artist
    artist_albums = defaultdict(list)
    for album in albums_to_schedule:
        artist = album.get("main_artist", "Unknown")
        artist_albums[artist].append(album)
    
    logger.info(f"Found {len(artist_albums)} unique artists in top 365 albums")
    
    # Shuffle albums within each artist group
    for artist in artist_albums:
        random.shuffle(artist_albums[artist])
    
    # Create a list of artist keys and shuffle them
    artists = list(artist_albums.keys())
    random.shuffle(artists)
    
    # Distribute albums across months (roughly 30-31 albums per month)
    # by round-robin through artists
    shuffled_albums = []
    while len(shuffled_albums) < 365:
        for artist in artists:
            if artist_albums[artist]:
                shuffled_albums.append(artist_albums[artist].pop(0))
                if len(shuffled_albums) >= 365:
                    break
    
    albums_to_schedule = shuffled_albums
    
    logger.info(f"Intelligently shuffled {len(albums_to_schedule)} albums to avoid same artist in same month")
    
    # Calculate start date (tomorrow)
    start_date = datetime.now().date() + timedelta(days=1)
    
    # Validate artist distribution per month
    from collections import defaultdict
    month_artists = defaultdict(set)
    month_albums = defaultdict(list)
    
    for idx, album in enumerate(albums_to_schedule):
        schedule_date = start_date + timedelta(days=idx)
        month_key = schedule_date.strftime("%Y-%m")
        artist = album.get("main_artist", "Unknown")
        month_artists[month_key].add(artist)
        month_albums[month_key].append(album)
    
    # Log validation results
    logger.info("Artist distribution validation:")
    for month_key in sorted(month_artists.keys())[:3]:  # Show first 3 months
        albums_count = len(month_albums[month_key])
        artists_count = len(month_artists[month_key])
        logger.info(f"  {month_key}: {albums_count} albums, {artists_count} unique artists (no duplicates: {albums_count == artists_count})")
    
    # Insert albums into schedule
    inserted_count = 0
    with neon_conn.cursor() as cursor:
        for idx, album in enumerate(albums_to_schedule):
            schedule_date = start_date + timedelta(days=idx)
            object_id = album.get("object_id")
            primary_genre = album.get("primary_genre")
            
            if not object_id:
                logger.warning(f"Skipping album at index {idx}: missing object_id")
                continue
            
            try:
                cursor.execute(
                    """
                    INSERT INTO mystery_album_schedule (schedule_date, object_id, primary_genre)
                    VALUES (%s, %s, %s)
                    ON CONFLICT (schedule_date) DO UPDATE 
                    SET object_id = EXCLUDED.object_id,
                        primary_genre = EXCLUDED.primary_genre
                    """,
                    (schedule_date, object_id, primary_genre),
                )
                
                if cursor.rowcount > 0:
                    inserted_count += 1
                    if inserted_count <= 5 or inserted_count % 50 == 0:
                        logger.info(
                            f"Scheduled for {schedule_date}: {album.get('title', 'N/A')} "
                            f"by {album.get('main_artist', 'N/A')} (quality: {album.get('quality_score', 0):.2f})"
                        )
                
                neon_conn.commit()
            except Exception as e:
                neon_conn.rollback()
                logger.error(f"Error inserting schedule for date {schedule_date}: {e}")
                continue
    
    logger.info(
        f"Completed album of the day schedule population. "
        f"Inserted/updated {inserted_count} dates from {start_date} to {start_date + timedelta(days=inserted_count-1)}"
    )
