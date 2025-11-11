import { AlbumGuessrGame } from './game.js';
import { i18n } from './js/shared/i18n.js';

class AlbumGuessrDailyGame extends AlbumGuessrGame {
    constructor() {
        super();
        
        // Listen for language changes to update status subtitle
        document.addEventListener('albumguessr:language-changed', () => {
            setTimeout(() => {
                this.updateStatusSubtitle();
            }, 100);
        });
        
        // Re-check previous win when user logs in (after header is ready)
        document.addEventListener('albumguessr:header-ready', async () => {
            // If game is already initialized and user just logged in, check for previous win
            if (this.mysteryAlbum) {
                await this.recheckPreviousWinIfNeeded();
            }
        });
        
        // Also re-check when auth state changes (user logs in)
        // Store previous auth state to detect changes
        this.previousAuthState = false;
        setInterval(async () => {
            const currentAuthState = !!this.authManager.authenticatedUser;
            if (currentAuthState && !this.previousAuthState && this.mysteryAlbum) {
                // User just logged in
                await this.recheckPreviousWinIfNeeded();
            }
            this.previousAuthState = currentAuthState;
        }, 1000);
    }
    
    updateStatusSubtitle() {
        // Re-query the element in case it was recreated
        const gameDate = document.getElementById('game-date');
        if (!gameDate) {
            console.warn('updateStatusSubtitle: gameDate element not found');
            return;
        }
        
        // Make sure we don't have the random game class
        if (gameDate.classList.contains('daily-instruction')) {
            gameDate.classList.remove('daily-instruction');
        }
        
        try {
            // Check if there's a date parameter in the URL (for past dailies)
            const urlParams = new URLSearchParams(window.location.search);
            const requestedDate = urlParams.get('date');
            
            let dateToDisplay;
            if (requestedDate) {
                // Validate date format and use it
                const dateRegex = /^\d{4}-\d{2}-\d{2}$/;
                if (dateRegex.test(requestedDate)) {
                    dateToDisplay = new Date(requestedDate + 'T00:00:00');
                } else {
                    dateToDisplay = new Date();
                }
            } else {
                dateToDisplay = new Date();
            }
            
            let currentLang = 'en';
            try {
                if (i18n && typeof i18n.getCurrentLanguage === 'function') {
                    currentLang = i18n.getCurrentLanguage();
                }
            } catch (e) {
                console.warn('i18n not ready in updateStatusSubtitle, using default language:', e);
            }
            
            const localeMap = { 'en': 'en-US', 'fr': 'fr-FR', 'es': 'es-ES' };
            const locale = localeMap[currentLang] || 'en-US';
            
            const label = dateToDisplay.toLocaleDateString(locale, { year: 'numeric', month: 'long', day: 'numeric' });
            
            // Check if i18n is ready
            if (!i18n || typeof i18n.t !== 'function') {
                console.warn('i18n not ready, using default text');
                if (requestedDate) {
                    gameDate.textContent = `Album du ${label}`;
                } else {
                    gameDate.textContent = `Album of the day - ${label}`;
                }
                return;
            }
            
            // Different format for past dailies vs current day
            let fullText;
            if (requestedDate) {
                // For past dailies: "Album du [date]"
                if (currentLang === 'fr') {
                    fullText = `Album du ${label}`;
                } else if (currentLang === 'es') {
                    fullText = `Álbum del ${label}`;
                } else {
                    fullText = `Album of ${label}`;
                }
            } else {
                // For current day: "Album of the day - [date]"
                const albumLabel = i18n.t('game.albumOfDayLabel');
                fullText = `${albumLabel} - ${label}`;
            }
            
            console.log('updateStatusSubtitle: Setting date to:', fullText);
            gameDate.textContent = fullText;
        } catch (e) {
            console.error('Error updating status subtitle:', e);
            try {
                const albumLabel = i18n.t('game.albumOfDayLabel');
                gameDate.textContent = albumLabel;
            } catch (e2) {
                console.error('Error in fallback:', e2);
                gameDate.textContent = 'Album of the day';
            }
        }
    }
    
    initializeDOM() {
        super.initializeDOM();
        // Remove the random game class that parent adds and set the date immediately
        if (this.elements.gameDate) {
            this.elements.gameDate.classList.remove('daily-instruction');
            // Set the date immediately, don't wait
            this.updateStatusSubtitle();
        }
        // Also call it again after a brief delay to ensure it sticks
        setTimeout(() => {
            if (this.elements && this.elements.gameDate) {
                this.updateStatusSubtitle();
            }
        }, 100);
        
        // Hide navigation buttons if playing a past daily
        this.hideNavButtonsIfPastDaily();
    }
    
    setupSearchFieldClickHandler() {
        const searchInput = document.getElementById('album-search');
        
        if (!searchInput) {
            console.error('Search input not found');
            return;
        }
        
        // Check if we're playing a past daily
        const urlParams = new URLSearchParams(window.location.search);
        const isPastDaily = urlParams.has('date');
        
        // Check if game has already started (guesses were made)
        const gameStarted = this.hasGameStarted();
        
        // If it's a past daily, only hide the instruction text, keep the date
        if (isPastDaily) {
            // If game has started, hide instruction permanently
            if (gameStarted) {
                this.hideInstructionText();
            }
            
            const hideInstruction = () => {
                this.hideInstructionText();
            };
            
            searchInput.addEventListener('focus', hideInstruction);
            searchInput.addEventListener('click', hideInstruction);
            searchInput.addEventListener('input', hideInstruction);
            
            return;
        }
        
        // Normal daily behavior: change the entire title
        if (gameStarted) {
            this.showGameQuestionTitle();
        }
        
        const showQuestion = () => {
            this.showGameQuestionTitle();
        };
        
        searchInput.addEventListener('focus', showQuestion);
        searchInput.addEventListener('click', showQuestion);
        searchInput.addEventListener('input', showQuestion);
    }
    
    hasGameStarted() {
        // Game has started only if user has already made guesses
        return this.guessCount > 0;
    }
    
    showGameQuestionTitle() {
        const subtitleContainer = document.querySelector('.subtitle');
        if (subtitleContainer) {
            // Clear the subtitle container and replace with new title
            subtitleContainer.innerHTML = '';
            
            const titleElement = document.createElement('p');
            titleElement.className = 'subtitle album-title-question';
            titleElement.setAttribute('data-i18n', 'game.albumQuestion');
            titleElement.textContent = i18n.t('game.albumQuestion');
            
            subtitleContainer.appendChild(titleElement);
        }
    }
    
    showOriginalTitle() {
        const subtitleContainer = document.querySelector('.subtitle');
        if (subtitleContainer) {
            // Clear and restore original content
            subtitleContainer.innerHTML = '';
            
            // Add game date
            const dateElement = document.createElement('p');
            dateElement.id = 'game-date';
            dateElement.className = 'subtitle';
            
            // Add instruction text
            const instructionElement = document.createElement('p');
            instructionElement.className = 'daily-instruction';
            instructionElement.setAttribute('data-i18n', 'game.makeGuess');
            instructionElement.innerHTML = i18n.t('game.makeGuess');
            
            subtitleContainer.appendChild(dateElement);
            subtitleContainer.appendChild(instructionElement);
            
            // Update the date text
            this.updateStatusSubtitle();
        }
    }
    
    hideNavButtonsIfPastDaily() {
        const urlParams = new URLSearchParams(window.location.search);
        const isPastDaily = urlParams.has('date');
        
        if (isPastDaily) {
            // Add class to body to hide nav buttons via CSS
            document.body.classList.add('past-daily-mode');
        }
    }

    async initializeGame() {
        this.showLoading(true);
        try {
            await this.selectDailyAlbum();
            
            // Wait for auth to be ready before checking previous wins
            // Try multiple times with delays to ensure auth is fully ready
            let authReady = false;
            for (let i = 0; i < 3; i++) {
                try {
                    const isAuth = await this.authManager.isAuthenticated();
                    if (isAuth && this.authManager.authenticatedUser) {
                        authReady = true;
                        break;
                    }
                } catch (authError) {
                    console.warn('Auth check attempt', i + 1, 'failed:', authError);
                }
                if (i < 2) {
                    await new Promise(resolve => setTimeout(resolve, 300));
                }
            }
            
            // Try to restore game state from localStorage
            this.restoreGameState();
            
            // Check if user has already completed this album (must be before updateUI)
            // Only check if auth is ready and user is authenticated
            if (authReady && this.authManager.authenticatedUser) {
                await this.checkAndRestorePreviousWin();
            }
            
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
            
            // If game is already won (restored from localStorage or API), show victory modal
            if (this.gameWon) {
                this.showVictoryModal();
                // Hide game-box after a small delay to ensure DOM is ready
                setTimeout(() => {
                    this.hideGameBox();
                }, 100);
            }
            
            // Ensure status subtitle is updated after everything is loaded
            this.updateStatusSubtitle();
            
            // Setup search field click handler after game is initialized
            this.setupSearchFieldClickHandler();
            
            // Hide instruction if game has already started (after page refresh)
            if (this.hasGameStarted()) {
                this.hideInstructionText();
            }
            
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
        // Don't save progress if user is not authenticated
        if (!this.authManager.authenticatedUser) {
            return;
        }
        
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
                        label: guess.album.label,
                        is_solo_artist: guess.album.is_solo_artist,
                        is_group: guess.album.is_group
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
        // Don't restore progress if user is not authenticated
        if (!this.authManager.authenticatedUser) {
            return false;
        }
        
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

    async recheckPreviousWinIfNeeded() {
        try {
            const authed = await this.authManager.isAuthenticated();
            if (authed && this.authManager.authenticatedUser && this.mysteryAlbum) {
                // Re-check if user has already won this album
                await this.checkAndRestorePreviousWin();
                // Update UI to reflect the restored state
                this.updateUI();
                // Show victory modal if game was won
                if (this.gameWon && !this.elements.victoryModal.classList.contains('show')) {
                    this.showVictoryModal();
                }
            }
        } catch (err) {
            console.warn('Failed to re-check previous win after login:', err);
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
            console.log('User has already completed this album');
            
            // Set game state to won
            this.gameWon = true;
            this.gameOver = true;
            this.winSaved = true; // Prevent re-saving
            this.guessCount = previousWin.guesses || 1;

            // Only create a minimal winning guess if we don't already have guesses from localStorage
            // This preserves the full history if it was restored by restoreGameState()
            if (this.guesses.length === 0) {
                // Restore guesses array with the winning guess so the UI can display the result
                // Create a guess entry showing the correct answer was found
                const winningGuess = {
                    album: this.mysteryAlbum,
                    correct: true,
                    guessNumber: this.guessCount,
                    cluesRevealed: []
                };
                this.guesses = [winningGuess];
            }

            // Note: UI update happens in initializeGame after this function returns
            // Don't show victory modal - user already won, just restoring state
        } catch (error) {
            console.warn('Failed to check previous win:', error);
            // Silently fail - user can still play normally
        }
    }

    async selectDailyAlbum() {
        try {
            // Check if date parameter is in URL
            const urlParams = new URLSearchParams(window.location.search);
            const requestedDate = urlParams.get('date');
            
            // Build URL with optional date parameter
            let apiUrl = '/.netlify/functions/albumOfTheDay';
            if (requestedDate) {
                // Validate date format
                const dateRegex = /^\d{4}-\d{2}-\d{2}$/;
                if (!dateRegex.test(requestedDate)) {
                    throw new Error('Invalid date format');
                }
                // Check if date is in the future
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                const reqDate = new Date(requestedDate + 'T00:00:00');
                if (reqDate > today) {
                    throw new Error('Cannot play future albums');
                }
                apiUrl += `?date=${requestedDate}`;
            }
            
            const res = await fetch(apiUrl, { cache: 'no-store' });
            if (!res.ok) {
                const errorText = await res.text();
                throw new Error(`Failed to load album: ${errorText}`);
            }
            const data = await res.json();
            const objectID = data && data.objectID;
            if (!objectID) throw new Error('Invalid album payload');

            if (!this.algoliaIndex) throw new Error('Algolia index not initialized');

            const attrs = [
                'objectID', 'title', 'artists', 'genres', 'release_year', 'countries', 'tags',
                'contributors', 'rating_value', 'rating_count', 'rating',
                'cover_art_url', 'label', 'total_length_seconds', 'is_solo_artist', 'is_group'
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
        
        // Hide the instruction text permanently after first guess
        this.hideInstructionText();
        
        // Save game state after each guess
        this.saveGameState();
        
        // Save win to history if game is won (after state is saved)
        if (this.gameWon && !this.winSaved) {
            this.saveWinToHistory();
        }
    }
    
    hideInstructionText() {
        const dailyInstruction = document.querySelector('.daily-instruction');
        console.log('hideInstructionText called, element found:', dailyInstruction);
        if (dailyInstruction) {
            dailyInstruction.style.setProperty('display', 'none', 'important');
            console.log('Instruction hidden, current display:', dailyInstruction.style.display);
        }
    }
    
    updateUI() {
        // Call parent method
        super.updateUI();
        
        // Update status subtitle to ensure it displays correctly
        this.updateStatusSubtitle();
        
        // Hide instruction text if game has started
        if (this.hasGameStarted()) {
            this.hideInstructionText();
        }
        
        // Save game state after UI update (for clues updates)
        if (!this.gameOver) {
            this.saveGameState();
        }
    }
    
    generateChallengeUrl() {
        // For daily game, just point to the homepage (everyone plays the same album)
        const baseUrl = window.location.origin;
        return `${baseUrl}/index.html`;
    }

    copyChallengeLinkToClipboard(button) {
        const challengeUrl = this.generateChallengeUrl();
        if (!challengeUrl) {
            alert('Unable to generate challenge link');
            return;
        }

        navigator.clipboard.writeText(challengeUrl).then(() => {
            // Store original button content and style
            const originalHTML = button.innerHTML;
            const originalBackground = button.style.backgroundColor;
            
            // Change button to success state
            button.innerHTML = '<i class="bi bi-check-circle-fill"></i> Challenge link copied to clipboard!';
            button.style.backgroundColor = '#22c55e';
            button.style.transition = 'background-color 0.3s ease';
            button.disabled = true;
            
            // Revert after 2 seconds
            setTimeout(() => {
                button.innerHTML = originalHTML;
                button.style.backgroundColor = originalBackground;
                button.disabled = false;
            }, 2000);
        }).catch(() => {
            alert('Unable to copy link to clipboard');
        });
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
                    
                    // Keep game state in localStorage to preserve full history on refresh
                    // Don't remove it so that all guesses can be restored when page is refreshed
                    
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


