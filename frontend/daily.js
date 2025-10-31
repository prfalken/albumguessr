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

    initializeGame() {
        this.showLoading(true);
        this.selectDailyAlbum()
            .then(async () => {
                this.updateUI();
                this.showLoading(false);
                // Check if user has already completed this album
                await this.checkAndRestorePreviousWin();
            })
            .catch(error => {
                console.error('Failed to initialize game:', error);
                this.showError('Error while loading the game. Please refresh the page.');
                this.showLoading(false);
            });
    }

    async checkAndRestorePreviousWin() {
        // Only check if user is authenticated
        if (!this.authenticatedUser || !this.mysteryAlbum) return;

        try {
            // Fetch user's history
            const history = await this.fetchUserHistoryFromApi();
            if (!history || history.length === 0) return;

            // Check if current album is in history
            const previousWin = history.find(entry => entry.objectID === this.mysteryAlbum.objectID);
            if (!previousWin) return;

            // User has already completed this album - restore the win state
            console.log('User has already completed this album today');
            
            // Set game state to won
            this.gameWon = true;
            this.gameOver = true;
            this.winSaved = true; // Prevent re-saving
            this.guessCount = previousWin.guesses || 1;

            // Restore guesses array with the winning guess so the UI can display the result
            // Create a guess entry showing the correct answer was found
            const winningGuess = {
                album: this.mysteryAlbum,
                correct: true,
                guessNumber: this.guessCount,
                cluesRevealed: []
            };
            this.guesses = [winningGuess];

            // Update UI to reflect the win
            this.updateUI();

            // Show victory modal after a brief delay
            setTimeout(() => this.showVictoryModal(), 500);
        } catch (error) {
            console.warn('Failed to check previous win:', error);
            // Silently fail - user can still play normally
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
            console.log('Daily mystery album:', this.mysteryAlbum);
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


