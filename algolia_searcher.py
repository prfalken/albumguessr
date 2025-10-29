from algolia import AlgoliaApp

from loguru import logger


class AlgoliaSearcher(AlgoliaApp):
    """Handles indexing album data to Algolia with full implementation."""

    def search_albums(self, query: str, params: dict = None) -> list[dict]:
        """Search albums in the Algolia index."""
        response = self.client.search_single_index(
            index_name=self.index_name,
            search_params={
                "query": query,
                **(params or {}),
                "attributesToRetrieve": [
                    "title",
                    "main_artist",
                ],
            },
        )
        hits = response.hits
        results = []
        if hits:
            for hit in hits:
                results.append(
                    {
                        "title": hit.to_dict().get("title"),
                    }
                )
        return results
