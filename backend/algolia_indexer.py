"""
Algolia indexer for album data with rating support.
"""

from typing import Dict, List, Any
from tqdm import tqdm
from algolia import AlgoliaApp

from loguru import logger


class AlgoliaIndexer(AlgoliaApp):
    """Handles indexing album data to Algolia with rating support."""

    def batch_index_records(self, records: List[Dict[str, Any]]) -> None:
        """Index records in batches to Algolia."""
        if not records:
            logger.error("No records to index")
            return

        total_records = len(records)
        logger.info(f"Indexing {total_records} records in batches of {self.batch_size}")

        success_count = 0
        error_count = 0

        for i in tqdm(range(0, total_records, self.batch_size), desc="Indexing batches"):
            batch = records[i : i + self.batch_size]

            try:
                # Ensure all records in the batch have an objectID
                for j, record in enumerate(batch):
                    if "objectID" not in record or not record["objectID"]:
                        record["objectID"] = record.get("id", f"album_{i}_{j}")

                # Perform a single batch HTTP request for this chunk
                self.client.save_objects(index_name=self.index_name, objects=batch)
                success_count += len(batch)

            except Exception as e:
                logger.error(f"Error processing batch: {e}")
                error_count += len(batch)

        logger.info(f"Indexing completed: {success_count} successful, {error_count} errors")
