class AlbumGuessrDailyGame extends AlbumGuessrGame {
    initializeDOM() {
        super.initializeDOM();
        try {
            const today = new Date();
            const label = today.toLocaleDateString(undefined, { year: 'numeric', month: 'long', day: 'numeric' });
            this.elements.gameDate.textContent = `Album of the day • ${label}`;
        } catch (e) {
            this.elements.gameDate.textContent = 'Album of the day';
        }
    }

    async selectDailyAlbum() {
        try {
            const res = await fetch('/.netlify/functions/albumOfTheDay', { cache: 'no-store' });
            if (!res.ok) throw new Error('Failed to load today\'s album');
            const data = await res.json();
            const objectID = data && data.objectID;
            if (!objectID) throw new Error('Invalid album payload');

            if (!this.algoliaIndex) throw new Error('Algolia index not initialized');

            const attrs = [
                'objectID', 'title', 'artists', 'genres', 'release_year', 'countries', 'tags',
                'contributors', 'rating_value', 'rating_count', 'rating',
                'cover_art_url', 'label', 'total_length_seconds'
            ];

            this.mysteryAlbum = await this.algoliaIndex.getObject(objectID, { attributesToRetrieve: attrs });
            this.normalizeAlbumContributors(this.mysteryAlbum);
            if (Array.isArray(this.mysteryAlbum.countries)) {
                this.mysteryAlbum.continents = this.getContinentsForCountryCodes(this.mysteryAlbum.countries);
            }
            return this.mysteryAlbum;
        } catch (error) {
            console.error('Failed to load album of the day:', error);
            throw error;
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    // Ensure base game is loaded
    if (typeof AlbumGuessrGame === 'undefined') {
        console.error('Base game.js must be loaded before daily.js');
        return;
    }
    new AlbumGuessrDailyGame();
});


