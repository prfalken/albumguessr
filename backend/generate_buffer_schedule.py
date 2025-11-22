
import csv
import io
import random
from datetime import date, timedelta
from typing import Any, Dict, List, Optional

import psycopg2
from algoliasearch.search.client import SearchClientSync
from loguru import logger
from psycopg2.extras import RealDictCursor

from config import Config


# Message templates for yesterday's album (morning post)
YESTERDAY_TEMPLATES = [
    (
        "Last album of the day was {album_title} by {artist}, "
        "did you find it? How many guesses did it take?"
    ),
    "Yesterday's mystery album was {album_title} by {artist}! Did you guess it? Share your score!",
    "Did you crack yesterday's album? It was {album_title} by {artist}! How many tries?",
    "{album_title} by {artist} was yesterday's challenge. Did you solve it? How many guesses?",
    "Yesterday's album: {album_title} by {artist}. Did you find it? Tell us your guess count!",
    "The mystery album yesterday was {album_title} by {artist}. How did you do?",
    "Could you guess yesterday's album? It was {album_title} by {artist}! Share your result!",
    "{album_title} by {artist} - that was yesterday's album! How many guesses did it take you?",
]

# Message templates for today's album (afternoon/evening post)
TODAY_TEMPLATES = [
    "In how many guesses will you find the Album of the day?",
    "Today's mystery album is waiting for you! How many guesses will it take?",
    "Can you guess today's album? Test your skills now!",
    "A new album challenge awaits! How many tries will you need?",
    "Ready for today's album mystery? Let's see your guessing skills!",
    "Today's album is ready. Can you find it in fewer guesses?",
    "New day, new album challenge! How fast can you guess it?",
    "The daily album mystery is live! How many guesses will you need?",
    "Think you know your albums? Prove it with today's challenge!",
    "Today's mystery album is here. How sharp is your music knowledge?",
]

SITE_URL = "https://albumguessr.com"


def fetch_mystery_schedule(
    neon_conn: psycopg2.extensions.connection,
) -> List[Dict[str, Any]]:
    with neon_conn.cursor(cursor_factory=RealDictCursor) as cursor:
        cursor.execute(
            """
            SELECT schedule_date, object_id, primary_genre
            FROM mystery_album_schedule
            WHERE schedule_date BETWEEN CURRENT_DATE 
                                    AND CURRENT_DATE + INTERVAL '4 days'
            ORDER BY schedule_date ASC
            """
        )
        results = cursor.fetchall()
        return [dict(row) for row in results]


def get_album_details(
    algolia_client: SearchClientSync,
    index_name: str,
    object_id: str,
) -> Optional[Dict[str, Any]]:
    try:
        result = algolia_client.get_object(
            index_name=index_name,
            object_id=object_id,
            attributes_to_retrieve=["title", "main_artist", "cover_art_url"],
        )

        if result:
            return {
                "title": result.get("title", "Unknown Album"),
                "main_artist": result.get("main_artist", "Unknown Artist"),
                "cover_art_url": result.get("cover_art_url", ""),
            }
        return None
    except Exception as e:
        logger.error(f"Error retrieving album with objectID '{object_id}': {e}")
        return None


def generate_buffer_csv(
    schedule: List[Dict[str, Any]],
    album_details: Dict[str, Dict[str, Any]],
) -> str:
    output = io.StringIO()
    writer = csv.writer(output, quoting=csv.QUOTE_ALL)

    # Write header
    writer.writerow(["Text", "Image URL", "Tags", "Posting Time"])

    filtered_schedule = []
    skipped_missing = 0

    # Filter schedule to only include albums with complete details
    for record in schedule:
        schedule_date = record["schedule_date"]
        object_id = record["object_id"]

        # Skip albums without complete details
        if object_id not in album_details:
            skipped_missing += 1
            logger.debug(
                f"Skipping {schedule_date}: no album details found for {object_id}"
            )
            continue

        filtered_schedule.append(record)

    if skipped_missing > 0:
        logger.warning(
            f"Skipped {skipped_missing} albums due to missing details in Algolia"
        )

    logger.info(
        f"Generating posts for {len(filtered_schedule)} albums "
        f"within the next 365 days"
    )

    for i, record in enumerate(filtered_schedule):
        schedule_date = record["schedule_date"]
        planned_post_date = schedule_date + timedelta(days=1)

        # Generate morning post revealing the album from schedule_date
        object_id = record["object_id"]
        current_album = album_details[object_id]

        # Random morning time between 9:00 and 9:59
        morning_hour = 9
        morning_minute = random.randint(0, 59)
        morning_time = f"{planned_post_date} {morning_hour:02d}:{morning_minute:02d}"

        # Format reveal message with cover art
        template = random.choice(YESTERDAY_TEMPLATES)
        message = template.format(
            album_title=current_album["title"],
            artist=current_album["main_artist"],
        )
        message += f" {SITE_URL}"

        # Write morning post with album's cover art
        writer.writerow(
            [
                message,
                current_album.get("cover_art_url", ""),
                "",
                morning_time,
            ]
        )

        # Generate afternoon post teasing the NEXT album
        if i < len(filtered_schedule) - 1:

            # Random afternoon time between 16:00 and 17:00
            afternoon_hour = 18
            afternoon_minute = random.randint(0, 59)
            afternoon_time = f"{planned_post_date} {afternoon_hour:02d}:{afternoon_minute:02d}"

            template = random.choice(TODAY_TEMPLATES)
            message = template + f" {SITE_URL}"

            # Write afternoon post
            writer.writerow(
                [
                    message,
                    "",
                    "",
                    afternoon_time,
                ]
            )

    return output.getvalue()


def main(output_file: Optional[str] = None) -> None:
    """
    Main function to generate Buffer.com posting schedule.

    Args:
        output_file: Optional path to save CSV file. If None, prints to stdout.
    """
    logger.info("Starting Buffer.com schedule generation")

    # Load configuration
    config = Config()
    config.validate()

    # Check for Neon database URL
    if not config.neon_database_url:
        logger.error("NETLIFY_DATABASE_URL environment variable not set")
        return

    # Connect to Neon database
    logger.info("Connecting to Neon database...")
    try:
        neon_conn = psycopg2.connect(config.neon_database_url)
    except Exception as e:
        logger.error(f"Failed to connect to Neon database: {e}")
        return

    # Initialize Algolia client
    logger.info("Initializing Algolia client...")
    algolia_client = SearchClientSync(
        config.algolia_application_id,
        config.algolia_api_key,
    )

    try:
        # Fetch mystery album schedule
        logger.info("Fetching mystery album schedule...")
        schedule = fetch_mystery_schedule(neon_conn)

        if not schedule:
            logger.warning("No mystery albums found in schedule")
            return

        logger.info(f"Found {len(schedule)} scheduled albums")

        # Fetch album details from Algolia for all scheduled albums
        logger.info("Fetching album details from Algolia...")
        album_details = {}

        for record in schedule:
            object_id = record["object_id"]
            details = get_album_details(
                algolia_client,
                config.algolia_index_name,
                object_id,
            )
            if details:
                album_details[object_id] = details

        logger.info(f"Retrieved details for {len(album_details)} albums")

        # Generate CSV
        logger.info("Generating Buffer.com CSV...")
        csv_content = generate_buffer_csv(schedule, album_details)

        # Output or save CSV
        if output_file:
            with open(output_file, "w", encoding="utf-8") as f:
                f.write(csv_content)
            logger.info(f"CSV saved to {output_file}")
        else:
            print(csv_content)

        logger.info("Buffer.com schedule generation complete")

    finally:
        neon_conn.close()
        logger.info("Database connection closed")


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(
        description="Generate Buffer.com posting schedule for mystery albums",
        epilog="""
Examples:
  # Print CSV to stdout
  python generate_buffer_schedule.py

  # Save CSV to file
  python generate_buffer_schedule.py --output buffer_schedule.csv
        """,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )

    parser.add_argument(
        "--output",
        "-o",
        type=str,
        help="Output file path for CSV (default: print to stdout)",
    )

    args = parser.parse_args()

    main(output_file=args.output)
