import { AlbumGuessrGame } from './game.js';

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

    async initializeGame() {
        this.showLoading(true);
        try {
            await this.selectDailyAlbum();
            
            // Wait for auth to be ready before checking previous wins
            try {
                await this.authManager.isAuthenticated();
            } catch (authError) {
                console.warn('Auth check skipped:', authError);
            }
            
            // Try to restore game state from localStorage
            this.restoreGameState();
            
            // Check if user has already completed this album (must be before updateUI)
            await this.checkAndRestorePreviousWin();
            
            // If game is won but not saved yet, try to save it (wait a bit for auth to be fully ready)
            if (this.gameWon && !this.winSaved) {
                // Wait a bit for auth to be ready, then try to save
                setTimeout(() => {
                    if (this.authManager.authenticatedUser && !this.winSaved) {
                        this.saveWinToHistory();
                    }
                }, 500);
            }
            
            // Now update UI with correct game state
            this.updateUI();
            this.showLoading(false);
        } catch (error) {
            console.error('Failed to initialize game:', error);
            this.showError('Error while loading the game. Please refresh the page.');
            this.showLoading(false);
        }
    }
    
    getStorageKey() {
        if (!this.mysteryAlbum) return null;
        return `albumguessr_daily_game_${this.mysteryAlbum.objectID}`;
    }
    
    saveGameState() {
        if (!this.mysteryAlbum) return;
        
        const storageKey = this.getStorageKey();
        if (!storageKey) return;
        
        try {
            const gameState = {
                objectID: this.mysteryAlbum.objectID,
                guessCount: this.guessCount,
                gameOver: this.gameOver,
                gameWon: this.gameWon,
                winSaved: this.winSaved,
                guesses: this.guesses.map(guess => ({
                    album: {
                        objectID: guess.album.objectID,
                        title: guess.album.title,
                        artists: guess.album.artists,
                        cover_art_url: guess.album.cover_art_url,
                        release_year: guess.album.release_year,
                        genres: guess.album.genres,
                        countries: guess.album.countries,
                        contributors: guess.album.contributors,
                        total_length_seconds: guess.album.total_length_seconds,
                        label: guess.album.label
                    },
                    correct: guess.correct,
                    guessNumber: guess.guessNumber,
                    cluesRevealed: guess.cluesRevealed
                })),
                discoveredClues: Array.from(this.discoveredClues.entries()).map(([key, values]) => [
                    key,
                    Array.from(values)
                ]),
                timestamp: Date.now()
            };
            
            localStorage.setItem(storageKey, JSON.stringify(gameState));
        } catch (error) {
            console.warn('Failed to save game state:', error);
        }
    }
    
    restoreGameState() {
        if (!this.mysteryAlbum) return false;
        
        const storageKey = this.getStorageKey();
        if (!storageKey) return false;
        
        try {
            const saved = localStorage.getItem(storageKey);
            if (!saved) return false;
            
            const gameState = JSON.parse(saved);
            
            // Verify it's for the same album
            if (gameState.objectID !== this.mysteryAlbum.objectID) {
                localStorage.removeItem(storageKey);
                return false;
            }
            
            // Check if state is too old (more than 24 hours)
            const stateAge = Date.now() - (gameState.timestamp || 0);
            if (stateAge > 24 * 60 * 60 * 1000) {
                localStorage.removeItem(storageKey);
                return false;
            }
            
            // Restore game state
            this.guessCount = gameState.guessCount || 0;
            this.gameOver = gameState.gameOver || false;
            this.gameWon = gameState.gameWon || false;
            this.winSaved = gameState.winSaved || false;
            this.guesses = (gameState.guesses || []).map(guess => {
                // Restore full album data from Algolia if needed
                return {
                    ...guess,
                    album: {
                        ...guess.album,
                        continents: Array.isArray(guess.album.countries) 
                            ? this.getContinentsForCountryCodes(guess.album.countries) 
                            : []
                    }
                };
            });
            
            // Restore discovered clues
            this.discoveredClues = new Map();
            if (gameState.discoveredClues) {
                gameState.discoveredClues.forEach(([key, values]) => {
                    this.discoveredClues.set(key, new Set(values));
                });
            }
            
            // Recalculate year and length hints from restored guesses
            if (this.guesses.length > 0 && !this.gameOver) {
                this.updateYearHint();
                this.updateLengthHint();
            }
            
            // Don't show victory modal - user already won, just restoring state from localStorage
            
            console.log('Game state restored:', {
                guesses: this.guessCount,
                clues: this.discoveredClues.size
            });
            
            return true;
        } catch (error) {
            console.warn('Failed to restore game state:', error);
            return false;
        }
    }

    async checkAndRestorePreviousWin() {
        // Only check if user is authenticated
        if (!this.authManager.authenticatedUser || !this.mysteryAlbum) return;

        try {
            // Fetch user's history
            const history = await this.apiClient.fetchUserHistory();
            if (!history || history.length === 0) return;

            // Check if current album is in history as a DAILY game win
            // (ignore wins from random game mode)
            const previousWin = history.find(entry => 
                entry.objectID === this.mysteryAlbum.objectID && 
                entry.gameMode === 'daily'
            );
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

            // Note: UI update happens in initializeGame after this function returns
            // Don't show victory modal - user already won, just restoring state
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

    submitGuess() {
        // Call parent method
        super.submitGuess();
        
        // Save game state after each guess
        this.saveGameState();
        
        // Save win to history if game is won (after state is saved)
        if (this.gameWon && !this.winSaved) {
            this.saveWinToHistory();
        }
    }
    
    updateUI() {
        // Call parent method
        super.updateUI();
        
        // Save game state after UI update (for clues updates)
        if (!this.gameOver) {
            this.saveGameState();
        }
    }
    
    saveWinToHistory() {
        if (this.winSaved) return;
        if (!this.gameWon || !this.mysteryAlbum) return;
        if (!this.authManager.authenticatedUser) return; // only for logged-in users

        const entry = {
            objectID: this.mysteryAlbum.objectID,
            title: this.mysteryAlbum.title,
            artists: Array.isArray(this.mysteryAlbum.artists) ? this.mysteryAlbum.artists : [],
            release_year: this.mysteryAlbum.release_year || null,
            coverUrl: this.getCoverUrl(this.mysteryAlbum, 250),
            guesses: this.guessCount,
            gameMode: 'daily', // Daily game uses 'daily' mode
            userProfile: {
                custom_username: this.authManager.customUsername || null,
                email: this.authManager.authenticatedUser.email || null,
                picture: this.authManager.authenticatedUser.picture || null
            }
        };

        this.apiClient.saveHistoryEntry(entry)
            .then(ok => {
                if (ok) {
                    this.winSaved = true;
                    this.renderUserHistory();
                    
                    // Clear saved game state since game is over
                    const storageKey = this.getStorageKey();
                    if (storageKey) {
                        localStorage.removeItem(storageKey);
                    }
                    
                    // Show toast suggesting username setup if user doesn't have a custom username
                    const hasCustomUsername = this.authManager.customUsername;
                    if (!hasCustomUsername) {
                        this.showToast({
                            title: 'Customize Your Profile',
                            message: 'Set a custom username in your profile to appear on the leaderboard!',
                            duration: 6000,
                            type: 'info'
                        });
                    }
                } else {
                    console.warn('saveWinToHistory: Save failed');
                }
            })
            .catch(err => {
                console.error('saveWinToHistory: Error:', err);
            });
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


