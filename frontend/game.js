import { AuthManager } from './js/shared/auth-manager.js';
import { ApiClient } from './js/shared/api-client.js';
import { HistoryRenderer } from './js/shared/history-renderer.js';
import { i18n } from './js/shared/i18n.js';
import { GenreFilter } from './js/shared/genre-filter.js';

export class AlbumGuessrGame {
    constructor() {
        this.algoliaClient = null;
        this.algoliaIndex = null;
        this.authManager = new AuthManager();
        this.apiClient = new ApiClient(this.authManager);
        this.guessCount = 0;
        this.gameOver = false;
        this.gameWon = false;
        this.mysteryAlbum = null;
        this.guesses = [];
        this.searchResults = [];
        this.selectedResult = null;
        this.discoveredClues = new Map(); // Map of clue category -> Set of values
        this.winSaved = false;
        this.countryDisplayNames = null;
        this.countryDisplayNamesLocale = 'en';
        this.historyRenderer = null; // Will be initialized after DOM
        this.genreFilter = null; // Will be initialized after DOM (only for random game)
        
        this.initializeAlgolia();
        this.authManager.initializeAuth0();
        this.initializeDOM();
        // Initialize genre filter for random game only
        this.initializeGenreFilter();
        // Kick off auth flow wiring after DOM is available
        this.postDomAuthSetup();
        // Ensure label is part of the clue categories
        this.ensureLabelClueCategory();
        // Ensure artist_type is part of the clue categories
        this.ensureArtistTypeClueCategory();
        this.initializeGame();
        this.bindEvents();

        // Re-wire auth controls after header injection
        document.addEventListener('albumguessr:header-ready', async () => {
            this.elements.btnLogin = document.getElementById('btn-login');
            this.elements.btnLogout = document.getElementById('btn-logout');
            this.elements.userProfile = document.getElementById('user-profile');
            this.elements.userAvatar = document.getElementById('user-avatar');
            this.elements.userName = document.getElementById('user-name');
            this.elements.navStatistics = document.getElementById('nav-statistics');
            this.elements.navReportBug = document.getElementById('nav-report-bug');
            this.authManager.bindAuthButtons(this.elements);
            try {
                const authed = await this.authManager.isAuthenticated();
                if (authed) {
                    try {
                        const profileData = await this.apiClient.fetchProfile();
                        const dbUsername = profileData && profileData.custom_username;
                        this.authManager.setCustomUsername(dbUsername);
                    } catch (profileErr) {
                        console.warn('Failed to fetch profile:', profileErr);
                    }
                }
                this.authManager.updateAuthUI(this.elements, authed);
                this.renderUserHistory();
            } catch (err) {
                console.warn('Auth setup failed:', err);
            }
        });
        
        // Listen for language changes
        document.addEventListener('albumguessr:language-changed', () => {
            // Reset country display names cache to force refresh with new language
            // Use a marker value to ensure cache is invalidated
            this.countryDisplayNames = null;
            this.countryDisplayNamesLocale = 'INVALID'; // Use invalid marker instead of null
            
            // Small delay to ensure i18n has fully updated before regenerating UI
            // This ensures translations are available when updateGuessesHistory is called
            setTimeout(() => {
                // Update search placeholder and other dynamic text
                if (this.elements.albumSearch) {
                    this.elements.albumSearch.placeholder = i18n.t('game.searchPlaceholder');
                }
                if (this.elements.gameDate && !this.elements.gameDate.classList.contains('daily-instruction')) {
                    // For daily game, date is set by daily.js
                } else if (this.elements.gameDate) {
                    this.updateGameDateText();
                }
                // Regenerate year and length hints with new language
                if (this.mysteryAlbum) {
                    this.updateYearHint();
                    this.updateLengthHint();
                }
                // Refresh other dynamic content - this will call updateCluesBoard which uses getCountryName
                // and updateGuessesHistory which regenerates all labels with current translations
                this.updateUI();
            }, 0);
        });
    }

    updateGameDateText() {
        if (this.elements && this.elements.gameDate && this.elements.gameDate.classList.contains('daily-instruction')) {
            try {
                this.elements.gameDate.innerHTML = i18n.t('game.newMystery');
            } catch (e) {
                // i18n might not be ready yet, will be updated later
                console.warn('i18n not ready for gameDate:', e);
            }
        }
    }

    updateSearchPlaceholder() {
        if (this.elements && this.elements.albumSearch) {
            try {
                this.elements.albumSearch.placeholder = i18n.t('game.searchPlaceholder');
            } catch (e) {
                console.warn('i18n not ready for searchPlaceholder:', e);
            }
        }
    }

    initializeAlgolia() {
        try {
            this.algoliaClient = algoliasearch(
                ALGOLIA_CONFIG.applicationId,
                ALGOLIA_CONFIG.apiKey
            );
            this.algoliaIndex = this.algoliaClient.initIndex(ALGOLIA_CONFIG.indexName);
        } catch (error) {
            console.error('Failed to initialize Algolia:', error);
            this.showError('Failed to connect to the search index. Please refresh the page.');
        }
    }


    initializeDOM() {
        // Get DOM elements
        this.elements = {
            gameDate: document.getElementById('game-date'),
            guessCount: document.getElementById('guess-count'),
            gameStatus: document.getElementById('game-status'),
            guessesHistory: document.getElementById('guesses-history'),
            albumSearch: document.getElementById('album-search'),
            searchSubmit: document.getElementById('search-submit'),
            searchResults: document.getElementById('search-results'),
            searchContainer: document.querySelector('.search-container'),
            cluesBoard: document.querySelector('.clues-board'),
            cluesContainer: document.getElementById('clues-container'),
            guessesContainer: document.getElementById('guesses-container'),
            victoryModal: document.getElementById('victory-modal'),
            mysteryAlbumDisplay: document.getElementById('mystery-album-display'),
            finalGuesses: document.getElementById('final-guesses'),
            finalClues: document.getElementById('final-clues'),
            shareButton: document.getElementById('share-button'),
            playAgainButton: document.getElementById('play-again-button'),
            showRankingsButton: document.getElementById('show-rankings-button'),
            closeVictory: document.getElementById('close-victory'),
            instructionsModal: document.getElementById('instructions-modal'),
            instructionsButton: document.getElementById('instructions-button'),
            closeInstructions: document.getElementById('close-instructions'),
            loading: document.getElementById('loading'),
            toastContainer: document.getElementById('toast-container'),
            // Auth controls
            btnLogin: document.getElementById('btn-login'),
            btnLogout: document.getElementById('btn-logout'),
            userProfile: document.getElementById('user-profile'),
            userAvatar: document.getElementById('user-avatar'),
            userName: document.getElementById('user-name'),
            navStatistics: document.getElementById('nav-statistics'),
            navReportBug: document.getElementById('nav-report-bug'),
            // User history (right panel)
            userHistorySubtitle: document.getElementById('user-history-subtitle'),
            userHistoryList: document.getElementById('user-history-list'),
            // Inspiration box
            inspirationBox: document.getElementById('inspiration-box'),
            inspirationToggle: document.getElementById('inspiration-toggle'),
            inspirationContent: document.getElementById('inspiration-content'),
            inspirationMessage: document.getElementById('inspiration-message'),
            inspirationResults: document.getElementById('inspiration-results')
        };

        // HTML templates: UI structure is defined in HTML, JS only clones and fills
        this.templates = {
            searchResult: document.getElementById('tpl-search-result'),
            clueCategory: document.getElementById('tpl-clue-category'),
            clueValue: document.getElementById('tpl-clue-value'),
            guessItem: document.getElementById('tpl-guess-item'),
            guessAttr: document.getElementById('tpl-guess-attr'),
            guessChip: document.getElementById('tpl-guess-chip'),
            mysteryAlbum: document.getElementById('tpl-mystery-album'),
            historyItem: document.getElementById('tpl-history-item'),
            noClues: document.getElementById('tpl-no-clues'),
            historyEmpty: document.getElementById('tpl-history-empty'),
            historyError: document.getElementById('tpl-history-error'),
            inspirationItem: document.getElementById('tpl-inspiration-item')
        };

        // Show refresh-based info
        // Use a function to update the text after i18n is initialized
        this.updateGameDateText();
        this.elements.gameDate.classList.add('daily-instruction');
        
        // Set placeholder for search input
        if (this.elements.albumSearch) {
            this.updateSearchPlaceholder();
        }
        
        // Listen for i18n initialization to update text
        // The includes.js file calls i18n.init() and then i18n.applyTranslations()
        // We'll update the text when translations are applied
        document.addEventListener('albumguessr:header-ready', () => {
            // Header ready means i18n.init() has been called
            setTimeout(() => {
                this.updateGameDateText();
                this.updateSearchPlaceholder();
            }, 0);
        });
        
        // Initialize history renderer now that templates are available
        this.historyRenderer = new HistoryRenderer(this.elements, this.templates);
    }

    async postDomAuthSetup() {
        try {
            const isAuthenticated = await this.authManager.postDomAuthSetup();
            if (isAuthenticated) {
                try {
                    const profileData = await this.apiClient.fetchProfile();
                    const dbUsername = profileData && profileData.custom_username;
                    this.authManager.setCustomUsername(dbUsername);
                } catch (profileErr) {
                    console.warn('Failed to fetch profile:', profileErr);
                }
            }
            this.authManager.updateAuthUI(this.elements, isAuthenticated);
            this.renderUserHistory();
        } catch (err) {
            console.warn('Auth0 post-DOM setup skipped or failed:', err);
        }
    }

    initializeGame() {
        this.showLoading(true);
        this.selectDailyAlbum()
            .then(() => {
                this.updateUI();
                
                // Hide instruction if game has already started
                if (this.guessCount > 0) {
                    this.hideInstructionText();
                }
                
                // Hide game-box if game has already been won
                if (this.gameWon) {
                    this.hideGameBox();
                }
                
                this.showLoading(false);
            })
            .catch(error => {
                console.error('Failed to initialize game:', error);
                this.showError('Error while loading the game. Please refresh the page.');
                this.showLoading(false);
            });
    }

    ensureLabelClueCategory() {
        try {
            if (typeof GAME_CONFIG === 'object' && GAME_CONFIG && Array.isArray(GAME_CONFIG.clueCategories)) {
                const exists = GAME_CONFIG.clueCategories.some(c => c && c.key === 'label');
                if (!exists) {
                    GAME_CONFIG.clueCategories.push({ key: 'label', label: 'Label', icon: 'bi-vinyl' });
                }
            }
        } catch (e) {
            // no-op if GAME_CONFIG is not defined or malformed
        }
    }

    ensureArtistTypeClueCategory() {
        try {
            if (typeof GAME_CONFIG === 'object' && GAME_CONFIG && Array.isArray(GAME_CONFIG.clueCategories)) {
                const exists = GAME_CONFIG.clueCategories.some(c => c && c.key === 'artist_type');
                if (!exists) {
                    GAME_CONFIG.clueCategories.push({ key: 'artist_type', label: 'Artist Type', icon: 'bi-person-badge' });
                }
            }
        } catch (e) {
            // no-op if GAME_CONFIG is not defined or malformed
        }
    }

    initializeGenreFilter() {
        // Only initialize genre filter for game.html (random game), not for daily game
        const container = document.querySelector('#genre-filter-container');
        if (!container) {
            return; // No container means this is daily game or another page
        }
        
        this.genreFilter = new GenreFilter('#genre-filter-container');
        
        // Listen for genre changes
        document.addEventListener('albumguessr:genre-changed', (event) => {
            this.handleGenreChange(event.detail);
        });
    }

    handleGenreChange(detail) {
        const { genre, previousGenre } = detail;
        
        // If game is in progress, prompt user about resetting
        if (this.guessCount > 0 && !this.gameOver) {
            const confirmReset = confirm(i18n.t('genreFilter.confirmReset') || 'Changing the genre filter will start a new game. Continue?');
            if (confirmReset) {
                window.location.reload();
            } else {
                // Revert the selection
                if (this.genreFilter) {
                    this.genreFilter.selectGenre(previousGenre);
                }
            }
        } else {
            // Game hasn't started or is over, reload immediately to get new album
            window.location.reload();
        }
    }

    async selectDailyAlbum() {
        // Check if there's a challenge parameter in the URL
        const urlParams = new URLSearchParams(window.location.search);
        const challengeObjectID = urlParams.get('challenge');
        
        if (challengeObjectID) {
            try {
                
                if (!this.algoliaIndex) throw new Error('Algolia index not initialized');

                const attrs = [
                    'objectID', 'title', 'artists', 'genres', 'release_year', 'countries', 'tags',
                    'contributors', 'rating_value', 'rating_count', 'rating',
                    'cover_art_url', 'label', 'total_length_seconds', 'is_solo_artist', 'is_group'
                ];

                this.mysteryAlbum = await this.algoliaIndex.getObject(challengeObjectID, { attributesToRetrieve: attrs });
                this.normalizeAlbumContributors(this.mysteryAlbum);
                if (Array.isArray(this.mysteryAlbum.countries)) {
                    this.mysteryAlbum.continents = this.getContinentsForCountryCodes(this.mysteryAlbum.countries);
                }
                
                // Clean up URL (remove challenge parameter for cleaner appearance)
                const cleanUrl = window.location.pathname;
                window.history.replaceState({}, '', cleanUrl);
                
                return this.mysteryAlbum;
            } catch (error) {
                console.warn('Failed to load challenge album, falling back to random:', error);
                // Fall through to random album selection below
            }
        }
        
        // Fetch a random scheduled album from the database via Netlify Function
        // Get selected genre filter (if any) - read directly from localStorage to ensure we have it
        const selectedGenre = localStorage.getItem('selectedGenre') || null;
        const genreParam = selectedGenre ? `?genre=${encodeURIComponent(selectedGenre)}` : '';
                
        const maxAttempts = 5;
        let lastError = null;
        for (let attempt = 1; attempt <= maxAttempts; attempt++) {
            try {
                const res = await fetch(`/.netlify/functions/randomAlbum${genreParam}`, { cache: 'no-store' });
                if (!res.ok) throw new Error('Failed to load random album');
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
                return this.mysteryAlbum;
            } catch (error) {
                lastError = error;
                const isAlgolia404 = error && (error.status === 404 || error.code === 404) && String(error.message || '').includes('ObjectID does not exist');
                if (isAlgolia404) {
                    // Try picking another random album
                    console.warn(`Random pick ${attempt}/${maxAttempts} failed (missing in index), retrying...`);
                    continue;
                }
                console.error('Failed to select random album:', error);
                throw error;
            }
        }
        console.error('Failed to select random album after retries:', lastError);
        throw lastError || new Error('Failed to select random album');
    }
    
    hashCode(str) {
        let hash = 0;
        for (let i = 0; i < str.length; i++) {
            const char = str.charCodeAt(i);
            hash = ((hash << 5) - hash) + char;
            hash = hash & hash; // Convert to 32-bit integer
        }
        return hash;
    }

    bindEvents() {
        // Search input events
        this.elements.albumSearch.addEventListener('input', 
            this.debounce(this.handleSearchInput.bind(this), 300)
        );
        
        this.elements.albumSearch.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                this.submitGuess();
            } else if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
                e.preventDefault();
                this.navigateSearchResults(e.key === 'ArrowDown' ? 1 : -1);
            }
        });
        
        // Hide instruction text when user starts interacting with search
        const hideInstruction = () => {
            this.hideInstructionText();
        };
        
        this.elements.albumSearch.addEventListener('focus', hideInstruction);
        this.elements.albumSearch.addEventListener('click', hideInstruction);
        this.elements.albumSearch.addEventListener('input', hideInstruction);

        // Search submit button
        if (this.elements.searchSubmit) {
            this.elements.searchSubmit.addEventListener('click', () => {
                if (!this.elements.searchSubmit.disabled) {
                    this.submitGuess();
                }
            });
        }

        // Modal events
        if (this.elements.closeVictory) {
            this.elements.closeVictory.addEventListener('click', () => this.hideVictoryModal());
        }
        this.elements.shareButton.addEventListener('click', this.shareResult.bind(this));
        if (this.elements.playAgainButton) {
            this.elements.playAgainButton.addEventListener('click', () => window.location.reload());
        }
        if (this.elements.showRankingsButton) {
            this.elements.showRankingsButton.addEventListener('click', () => window.location.href = '/ranking.html');
        }
        
        // Instructions modal
        if (this.elements.instructionsButton) {
            this.elements.instructionsButton.addEventListener('click', this.showInstructionsModal.bind(this));
        }
        if (this.elements.closeInstructions) {
            this.elements.closeInstructions.addEventListener('click', this.hideInstructionsModal.bind(this));
        }

        // Close modals on background click - Not applicable for victory modal (inline display)

        if (this.elements.instructionsModal) {
            this.elements.instructionsModal.addEventListener('click', (e) => {
                if (e.target === this.elements.instructionsModal) {
                    this.hideInstructionsModal();
                }
            });
        }

        // Close search results when clicking outside
        document.addEventListener('click', (e) => {
            if (!e.target.closest('.search-container')) {
                this.hideSearchResults();
            }
        });

        // Auth buttons
        this.authManager.bindAuthButtons(this.elements);
        
        // Inspiration box toggle
        if (this.elements.inspirationToggle) {
            this.elements.inspirationToggle.addEventListener('click', () => {
                this.toggleInspirationBox();
            });
        }
    }

    async handleSearchInput(event) {
        const query = event.target.value.trim();
        
        if (query.length < 2) {
            this.hideSearchResults();
            this.selectedResult = null;
            if (this.elements.searchSubmit) this.elements.searchSubmit.disabled = true;
            return;
        }

        try {
            const searchResponse = await this.algoliaIndex.search(query, {
                hitsPerPage: 20,
                attributesToRetrieve: [
                    'objectID', 'title', 'artists', 'genres', 'release_year', 'countries', 'contributors',
                    'cover_art_url', 'label', 'total_length_seconds', 'is_solo_artist', 'is_group'
                ],
                optionalFilters: [
                    'rating_score > 100'
                ]
            });

            // Build set of already guessed album IDs
            const guessedIds = new Set(this.guesses.map(g => g.album.objectID));

            // Filter and normalize results
            this.searchResults = searchResponse.hits
                .filter(hit => !guessedIds.has(hit.objectID))
                .map(hit => {
                    this.normalizeAlbumContributors(hit);
                    return hit;
                });
            this.displaySearchResults();
            if (this.elements.searchSubmit) this.elements.searchSubmit.disabled = this.searchResults.length === 0;
        } catch (error) {
            console.error('Search error:', error);
        }
    }

    displaySearchResults() {
        if (this.searchResults.length === 0) {
            this.hideSearchResults();
            return;
        }

        const container = this.elements.searchResults;
        container.replaceChildren();
        this.searchResults.forEach((album, index) => {
            const tpl = this.templates.searchResult;
            if (!tpl) return;
            const el = tpl.content.firstElementChild.cloneNode(true);
            el.dataset.albumId = album.objectID;
            el.dataset.index = String(index);
            if (index === 0) el.classList.add('selected');

            const coverUrl = this.getCoverUrl(album, 250);
            const img = el.querySelector('img.search-result-thumb');
            const placeholder = el.querySelector('.search-result-thumb.placeholder');
            if (coverUrl && img) {
                img.src = coverUrl;
                img.style.display = '';
                if (placeholder) placeholder.style.display = 'none';
            } else {
                if (img) img.style.display = 'none';
                if (placeholder) placeholder.style.display = 'inline-block';
            }

            const titleEl = el.querySelector('.search-result-title');
            const artistEl = el.querySelector('.search-result-artist');
            const metaEl = el.querySelector('.search-result-meta');
            if (titleEl) titleEl.textContent = album.title || '';
            if (artistEl) artistEl.textContent = (album.artists && album.artists.length > 0) ? album.artists.join(', ') : i18n.t('game.unknownArtist');
            if (metaEl) {
                metaEl.replaceChildren();
                const parts = [];
                if (album.release_year) parts.push(String(album.release_year));
                if (album.genres && album.genres.length > 0) parts.push(String(album.genres[0]));
                if (album.countries && album.countries.length > 0) parts.push(this.getCountryName(album.countries[0]));
                
                // Ajouter le type d'artiste (artiste solo ou groupe)
                // Priorité: is_group > is_solo_artist > fallback sur nombre d'artistes
                let isSolo = false;
                if (album.is_group === true) {
                    isSolo = false;
                } else if (album.is_solo_artist === true) {
                    isSolo = true;
                } else if (album.artists && album.artists.length === 1) {
                    // Fallback: compter les artistes
                    isSolo = true;
                } else {
                    // Sinon, c'est un groupe (par défaut)
                    isSolo = false;
                }
                const artistTypeKey = isSolo ? 'solo' : 'group';
                const artistType = i18n.t(`game.artistTypes.${artistTypeKey}`);
                parts.push(artistType);
                
                parts.forEach(text => {
                    const span = document.createElement('span');
                    span.textContent = text;
                    metaEl.appendChild(span);
                });
            }

            el.addEventListener('click', () => {
                const albumId = el.dataset.albumId;
                const albumObj = this.searchResults.find(a => a.objectID === albumId);
                this.selectedResult = albumObj || null;
                this.updateSelectedResult(index);
                this.submitGuess();
            });

            container.appendChild(el);
        });
        container.classList.add('show');

        // Set first result as selected by default
        this.selectedResult = this.searchResults[0];
    }

    navigateSearchResults(direction) {
        if (this.searchResults.length === 0) return;

        const currentIndex = this.selectedResult ? 
            this.searchResults.findIndex(r => r.objectID === this.selectedResult.objectID) : 0;
        
        let newIndex = currentIndex + direction;
        if (newIndex < 0) newIndex = this.searchResults.length - 1;
        if (newIndex >= this.searchResults.length) newIndex = 0;

        this.selectedResult = this.searchResults[newIndex];
        this.updateSelectedResult(newIndex);
    }

    updateSelectedResult(selectedIndex) {
        const results = this.elements.searchResults.querySelectorAll('.search-result');
        results.forEach((result, index) => {
            if (index === selectedIndex) {
                result.classList.add('selected');
            } else {
                result.classList.remove('selected');
            }
        });
    }

    hideSearchResults() {
        this.elements.searchResults.classList.remove('show');
    }

    submitGuess() {
        if (this.gameOver || !this.selectedResult) return;

        this.guessCount++;
        const isCorrect = this.selectedResult.objectID === this.mysteryAlbum.objectID;
        
        // Derive continents for the selected result so UI can render that section
        if (Array.isArray(this.selectedResult.countries)) {
            this.selectedResult.continents = this.getContinentsForCountryCodes(this.selectedResult.countries);
        }

        const guess = {
            album: this.selectedResult,
            correct: isCorrect,
            guessNumber: this.guessCount,
            cluesRevealed: []
        };

        // Analyze shared attributes and reveal clues
        if (!isCorrect) {
            guess.cluesRevealed = this.analyzeSharedAttributes(this.selectedResult, this.mysteryAlbum);
            this.updateDiscoveredClues(guess.cluesRevealed);
        }

        this.guesses.push(guess);
        
        if (isCorrect) {
            this.gameWon = true;
            this.gameOver = true;
        }

        // Update year hint if we have any year information
        this.updateYearHint();
        // Update length hint if we have any length information
        this.updateLengthHint();
        
        // Hide instruction text permanently after first guess
        this.hideInstructionText();

        this.updateUI();
        
        // Trigger victory celebration and hide game-box after UI is updated
        if (isCorrect) {
            // Wait for DOM to update
            setTimeout(() => {
                this.celebrateVictory();
                this.hideGameBox();
            }, 100);
        }
        this.elements.albumSearch.value = '';
        this.hideSearchResults();
        this.selectedResult = null;
        if (this.elements.searchSubmit) this.elements.searchSubmit.disabled = true;

        if (this.gameOver && this.gameWon) {
            // First, ensure UI is updated with clues and guesses visible
            this.updateUI();
            
            // Show victory modal
            setTimeout(() => {
                this.showVictoryModal();
            }, 200);
        }
    }

    celebrateVictory() {
        // Play victory sound
        this.playVictorySound();
        
        // Create confetti animation
        this.createConfetti();
    }
    
    hideInstructionText() {
        // Target only the instruction paragraph, not the title
        const dailyInstruction = document.querySelector('.subtitle .daily-instruction:not(#game-date)');
        if (dailyInstruction) {
            dailyInstruction.style.setProperty('display', 'none', 'important');
        }
    }
    
    hideGameBox() {
        const gameBox = document.querySelector('.game-box');
        if (gameBox) {
            gameBox.style.setProperty('display', 'none', 'important');
        } else {
            console.warn('hideGameBox - Game box not found in DOM');
        }
    }

    playVictorySound() {
        try {
            const audio = new Audio('sounds/pow-pow-pow.mp3');
            audio.volume = 0.6; // Set volume (0.0 to 1.0)
            audio.play().catch(error => {
                console.warn('Could not play victory sound:', error);
            });
        } catch (error) {
            console.warn('Could not play victory sound:', error);
        }
    }

    createConfetti() {
        // Find the victory image - look for the mystery-album-cover in the victory guess item
        const victoryGuessItem = document.querySelector('.guess-item.victory');
        let centerX = window.innerWidth / 2;
        let centerY = window.innerHeight / 2;
        
        if (victoryGuessItem) {
            const coverImage = victoryGuessItem.querySelector('.mystery-album-cover');
            if (coverImage) {
                const rect = coverImage.getBoundingClientRect();
                centerX = rect.left + rect.width / 2;
                centerY = rect.top + rect.height / 2;
            }
        }
        
        const colors = ['#ffd41d', '#ff6b6b', '#4ecdc4', '#45b7d1', '#ffa07a', '#98d8c8', '#f7dc6f', '#bb8fce'];
        const confettiCount = 100;
        const duration = 2400; // 2.4 seconds
        const maxDistance = Math.max(window.innerWidth, window.innerHeight) * 0.8;
        
        // Create confetti container if it doesn't exist
        let confettiContainer = document.getElementById('confetti-container');
        if (!confettiContainer) {
            confettiContainer = document.createElement('div');
            confettiContainer.id = 'confetti-container';
            confettiContainer.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 10000;
            `;
            document.body.appendChild(confettiContainer);
        }
        
        // Clear any existing confetti and remove old style tag
        confettiContainer.innerHTML = '';
        const oldStyle = document.getElementById('confetti-dynamic-styles');
        if (oldStyle) oldStyle.remove();
        
        // Create a single style element for all keyframes
        const styleEl = document.createElement('style');
        styleEl.id = 'confetti-dynamic-styles';
        let keyframesCSS = '';
        
        // Create confetti pieces exploding from center
        for (let i = 0; i < confettiCount; i++) {
            const confetti = document.createElement('div');
            const color = colors[Math.floor(Math.random() * colors.length)];
            const size = Math.random() * 10 + 5;
            const isRect = Math.random() > 0.5;
            
            // Random angle in all directions (360 degrees)
            const angle = Math.random() * Math.PI * 2;
            // Random distance with some variation
            const distance = maxDistance * (0.7 + Math.random() * 0.3);
            // Random delay for a more natural explosion
            const delay = Math.random() * 0.1;
            
            // Calculate end position
            const endX = Math.cos(angle) * distance;
            const endY = Math.sin(angle) * distance;
            const rotation = Math.random() * 360;
            const endRotation = rotation + 360 * (2 + Math.random() * 2);
            
            // Make confetti pieces more varied (squares or circles)
            if (isRect) {
                confetti.style.borderRadius = '2px';
            } else {
                confetti.style.borderRadius = '50%';
            }
            
            // Position at center
            confetti.style.cssText += `
                position: fixed;
                left: ${centerX}px;
                top: ${centerY}px;
                width: ${size}px;
                height: ${size}px;
                background-color: ${color};
                opacity: 0.95;
                transform: translate(-50%, -50%) rotate(0deg);
                animation: confettiExplode${i} ${duration}ms ease-out forwards;
                animation-delay: ${delay * 1000}ms;
            `;
            
            // Add keyframe for this confetti piece with explosion effect
            keyframesCSS += `
                @keyframes confettiExplode${i} {
                    0% {
                        transform: translate(-50%, -50%) rotate(0deg) scale(1);
                        opacity: 1;
                    }
                    100% {
                        transform: translate(calc(-50% + ${endX}px), calc(-50% + ${endY}px)) rotate(${endRotation}deg) scale(0.8);
                        opacity: 0;
                    }
                }
            `;
            
            confettiContainer.appendChild(confetti);
        }
        
        // Add all keyframes to the style element
        styleEl.textContent = keyframesCSS;
        document.head.appendChild(styleEl);
        
        // Clean up after animation
        setTimeout(() => {
            if (confettiContainer && confettiContainer.parentNode) {
                confettiContainer.remove();
            }
            const styleToRemove = document.getElementById('confetti-dynamic-styles');
            if (styleToRemove) styleToRemove.remove();
        }, duration + 200);
    }

    analyzeSharedAttributes(guess, mystery) {
        const sharedClues = [];

        GAME_CONFIG.clueCategories.forEach(category => {
            // Skip release_year as it's handled separately
            if (category.key === 'release_year') return;
            // Skip total_length_seconds as it's handled separately (longer/shorter)
            if (category.key === 'total_length_seconds') return;
            // Handle artist_type separately
            if (category.key === 'artist_type') {
                // Déterminer le type du guess et de l'album mystère
                // Priorité: is_group > is_solo_artist > fallback sur nombre d'artistes
                let guessIsSolo = false; // Par défaut, c'est un groupe
                if (guess.is_group === true) {
                    guessIsSolo = false;
                } else if (guess.is_solo_artist === true) {
                    guessIsSolo = true;
                } else if (guess.artists && guess.artists.length === 1) {
                    // Fallback: compter les artistes
                    guessIsSolo = true;
                } else {
                    // Sinon, c'est un groupe (par défaut)
                    guessIsSolo = false;
                }
                
                let mysteryIsSolo = false; // Par défaut, c'est un groupe
                if (mystery.is_group === true) {
                    mysteryIsSolo = false;
                } else if (mystery.is_solo_artist === true) {
                    mysteryIsSolo = true;
                } else if (mystery.artists && mystery.artists.length === 1) {
                    // Fallback: compter les artistes
                    mysteryIsSolo = true;
                } else {
                    // Sinon, c'est un groupe (par défaut)
                    mysteryIsSolo = false;
                }
                
                // Si les types correspondent, ajouter le clue
                if (guessIsSolo === mysteryIsSolo) {
                    const artistTypeKey = mysteryIsSolo ? 'solo' : 'group';
                    const artistType = i18n.t(`game.artistTypes.${artistTypeKey}`);
                    sharedClues.push({
                        category: 'artist_type',
                        label: category.label,
                        icon: category.icon,
                        values: [artistType]
                    });
                }
                return;
            }
            
            const guessValue = guess[category.key];
            const mysteryValue = mystery[category.key];

            if (guessValue && mysteryValue) {
                let matches = [];

                if (Array.isArray(guessValue) && Array.isArray(mysteryValue)) {
                    // Find intersection for arrays
                    if (category.key === 'contributors' || category.key === 'instruments') {
                        matches = this.caseInsensitiveArrayIntersection(guessValue, mysteryValue);
                    } else {
                        matches = guessValue.filter(value => mysteryValue.includes(value));
                    }
                } else if (guessValue === mysteryValue) {
                    // Direct match for non-arrays
                    matches = [guessValue];
                }

                if (matches.length > 0) {
                    sharedClues.push({
                        category: category.key,
                        label: category.label,
                        icon: category.icon,
                        values: matches
                    });
                }
            }
        });

        // Additional derived clue: continents overlap (from countries)
        try {
            const guessCountries = Array.isArray(guess.countries) ? guess.countries : [];
            const mysteryCountries = Array.isArray(mystery.countries) ? mystery.countries : [];
            if (guessCountries.length > 0 && mysteryCountries.length > 0) {
                const guessContinents = this.getContinentsForCountryCodes(guessCountries);
                const mysteryContinents = this.getContinentsForCountryCodes(mysteryCountries);
                const setMystery = new Set(mysteryContinents);
                const overlap = guessContinents.filter(c => setMystery.has(c));
                if (overlap.length > 0) {
                    const cat = GAME_CONFIG.clueCategories.find(c => c.key === 'continents');
                    sharedClues.push({
                        category: 'continents',
                        label: cat ? cat.label : 'Continents',
                        icon: cat ? cat.icon : 'bi-globe-europe-africa',
                        values: Array.from(new Set(overlap))
                    });
                }
            }
        } catch (e) {
            // ignore continent errors
        }

        return sharedClues;
    }

    updateYearHint() {
        // Check if mystery album has a release year
        if (!this.mysteryAlbum.release_year) return;
        
        const mysteryYear = parseInt(this.mysteryAlbum.release_year);
        
        // Collect all year guesses that have release_year data
        const allYearGuesses = this.guesses
            .map(g => g.album.release_year)
            .filter(year => year && !isNaN(parseInt(year)))
            .map(year => parseInt(year));
        
        if (allYearGuesses.length === 0) return;
        
        // Check if any guess has the exact year
        const exactMatch = allYearGuesses.includes(mysteryYear);
        if (exactMatch) {
            // Show the exact year
            if (!this.discoveredClues.has('release_year')) {
                this.discoveredClues.set('release_year', new Set());
            }
            this.discoveredClues.set('release_year', new Set([mysteryYear.toString()]));
            return;
        }
        
        // Sort years to find the range
        allYearGuesses.sort((a, b) => a - b);
        
        // Find years that are before and after the mystery year
        const yearsBefore = allYearGuesses.filter(year => year < mysteryYear);
        const yearsAfter = allYearGuesses.filter(year => year > mysteryYear);
        
        let yearHint = null;
        
        // Determine the hint based on the range
        if (yearsBefore.length > 0 && yearsAfter.length > 0) {
            // We have years both before and after - show range
            const latestBefore = Math.max(...yearsBefore);
            const earliestAfter = Math.min(...yearsAfter);
            yearHint = `${i18n.t('game.guessLabels.between')} ${latestBefore} ${i18n.t('game.guessLabels.and')} ${earliestAfter}`;
        } else if (yearsBefore.length > 0) {
            // We only have years before - show "after X"
            const latestBefore = Math.max(...yearsBefore);
            yearHint = `${i18n.t('game.guessLabels.afterYear')} ${latestBefore}`;
        } else if (yearsAfter.length > 0) {
            // We only have years after - show "before X"
            const earliestAfter = Math.min(...yearsAfter);
            yearHint = `${i18n.t('game.guessLabels.beforeYear')} ${earliestAfter}`;
        }
        
        // Update the discovered clues with the new year hint
        if (yearHint) {
            if (!this.discoveredClues.has('release_year')) {
                this.discoveredClues.set('release_year', new Set());
            }
            this.discoveredClues.set('release_year', new Set([yearHint]));
        }
    }

    formatSeconds(totalSeconds) {
        if (totalSeconds == null || isNaN(Number(totalSeconds))) return '';
        const s = Math.max(0, parseInt(totalSeconds, 10));
        const hours = Math.floor(s / 3600);
        const minutes = Math.floor((s % 3600) / 60);
        const seconds = s % 60;
        if (hours > 0) {
            return `${hours}:${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;
        }
        return `${minutes}:${String(seconds).padStart(2, '0')}`;
    }

    updateLengthHint() {
        // Check if mystery album has a total length
        if (!this.mysteryAlbum.total_length_seconds) return;

        const mysteryLen = parseInt(this.mysteryAlbum.total_length_seconds);
        if (isNaN(mysteryLen) || mysteryLen <= 0) return;

        // Collect all guesses that have length data
        const allLenGuesses = this.guesses
            .map(g => g.album.total_length_seconds)
            .filter(v => v && !isNaN(parseInt(v)))
            .map(v => parseInt(v));

        if (allLenGuesses.length === 0) return;

        // Exact match
        const exactMatch = allLenGuesses.includes(mysteryLen);
        if (exactMatch) {
            if (!this.discoveredClues.has('total_length_seconds')) {
                this.discoveredClues.set('total_length_seconds', new Set());
            }
            this.discoveredClues.set('total_length_seconds', new Set([this.formatSeconds(mysteryLen)]));
            return;
        }

        allLenGuesses.sort((a, b) => a - b);

        const shorter = allLenGuesses.filter(v => v < mysteryLen);
        const longer = allLenGuesses.filter(v => v > mysteryLen);

        let lenHint = null;
        if (shorter.length > 0 && longer.length > 0) {
            const maxShorter = Math.max(...shorter);
            const minLonger = Math.min(...longer);
            lenHint = `${i18n.t('game.guessLabels.between')} ${this.formatSeconds(maxShorter)} ${i18n.t('game.guessLabels.and')} ${this.formatSeconds(minLonger)}`;
        } else if (shorter.length > 0) {
            const maxShorter = Math.max(...shorter);
            lenHint = `${i18n.t('game.guessLabels.longerThan')} ${this.formatSeconds(maxShorter)}`;
        } else if (longer.length > 0) {
            const minLonger = Math.min(...longer);
            lenHint = `${i18n.t('game.guessLabels.shorterThan')} ${this.formatSeconds(minLonger)}`;
        }

        if (lenHint) {
            if (!this.discoveredClues.has('total_length_seconds')) {
                this.discoveredClues.set('total_length_seconds', new Set());
            }
            this.discoveredClues.set('total_length_seconds', new Set([lenHint]));
        }
    }

    updateDiscoveredClues(newClues) {
        newClues.forEach(clue => {
            if (!this.discoveredClues.has(clue.category)) {
                this.discoveredClues.set(clue.category, new Set());
            }
            
            clue.values.forEach(value => {
                this.discoveredClues.get(clue.category).add(value);
            });
        });
    }

    updateUI() {
        // Hide navigation buttons when game starts (when there are guesses)
        const navButtonsContainer = document.getElementById('nav-buttons-container');
        if (navButtonsContainer) {
            navButtonsContainer.style.display = this.guesses.length === 0 ? '' : 'none';
        }
        
        // Refresh inspiration box if it's expanded
        if (this.elements.inspirationBox && this.elements.inspirationBox.classList.contains('expanded')) {
            this.loadInspirationResults();
        }
        
        // Update guess counter
        this.elements.guessCount.textContent = this.guessCount;
        // Update guess/guesses text
        const guessCounterEl = this.elements.guessCount.parentElement;
        if (guessCounterEl) {
            const guessText = this.guessCount === 1 ? i18n.t('game.guessCounterSingle') : i18n.t('game.guessCounter');
            // Find any text node after the span and update it, or create a new one
            let textNode = null;
            let foundSpan = false;
            for (let node of guessCounterEl.childNodes) {
                if (node === this.elements.guessCount) {
                    foundSpan = true;
                    continue;
                }
                if (foundSpan && node.nodeType === Node.TEXT_NODE) {
                    textNode = node;
                    break;
                }
            }
            if (textNode) {
                textNode.textContent = ` ${guessText}`;
            } else {
                // Remove any existing text nodes after the span and create a new one
                let foundSpan = false;
                const nodesToRemove = [];
                for (let node of guessCounterEl.childNodes) {
                    if (node === this.elements.guessCount) {
                        foundSpan = true;
                        continue;
                    }
                    if (foundSpan && node.nodeType === Node.TEXT_NODE) {
                        nodesToRemove.push(node);
                    }
                }
                nodesToRemove.forEach(node => node.remove());
                // Append new text node
                guessCounterEl.appendChild(document.createTextNode(` ${guessText}`));
            }
        }
        
        // Hide search interface if game is already won/over
        if (this.elements.searchContainer) {
            this.elements.searchContainer.style.display = this.gameWon || this.gameOver ? 'none' : '';
        }
        
        // Hide clues board and game status after victory
        if (this.elements.cluesBoard) {
            this.elements.cluesBoard.style.display = (this.gameWon || this.gameOver) ? 'none' : '';
        }
        if (this.elements.gameStatus) {
            // Show game status when we have guesses, even after victory
            this.elements.gameStatus.style.display = (this.guessCount === 0) ? 'none' : '';
        }
        
        // Always show guesses history if we have guesses, even after victory
        if (this.elements.guessesHistory) {
            if (this.guesses.length > 0 || this.guessCount > 0) {
                this.elements.guessesHistory.style.display = '';
                this.elements.guessesHistory.style.visibility = 'visible';
            } else {
                this.elements.guessesHistory.style.display = 'none';
            }
        }
        
        // Update clues board (always update to ensure translations are current)
        // Even if game is over, we might need to update translations
        this.updateCluesBoard();

        // Update guesses history (this will render all guesses even after victory)
        this.updateGuessesHistory();
    }

    updateCluesBoard() {
        const container = this.elements.cluesContainer;
        if (!container) return;
        
        container.replaceChildren();

        // If no clues and game is not won/over, show "no clues" message
        if (this.discoveredClues.size === 0) {
            if (!this.gameWon && !this.gameOver) {
                const tpl = this.templates.noClues;
                if (tpl) {
                    const cloned = tpl.content.firstElementChild.cloneNode(true);
                    container.appendChild(cloned);
                    // Apply translation to the cloned element
                    const i18nElement = cloned.querySelector('[data-i18n]');
                    if (i18nElement) {
                        const key = i18nElement.getAttribute('data-i18n');
                        if (key) {
                            i18nElement.textContent = i18n.t(key);
                        }
                    }
                }
            }
            // If game is won/over, leave container empty but visible (clues may have been discovered)
            return;
        }

        // Render artists first on a separate line
        const artistsSet = this.discoveredClues.get('artists');
        if (artistsSet && artistsSet.size > 0) {
            const artistsCat = GAME_CONFIG.clueCategories.find(c => c.key === 'artists');
            if (artistsCat) {
                const catEl = this.templates.clueCategory.content.firstElementChild.cloneNode(true);
                catEl.classList.add('clue-artists-container');
                
                // Ajouter le titre avec l'indication solo/groupe
                const titleEl = catEl.querySelector('.clue-category-title');
                if (titleEl) {
                    const iconEl = titleEl.querySelector('i');
                    const labelEl = titleEl.querySelector('.clue-category-label');
                    // Supprimer l'icône et le label du titre
                    if (iconEl) iconEl.remove();
                    if (labelEl) labelEl.remove();
                }
                
                const valuesEl = catEl.querySelector('.clue-values');
                if (valuesEl) {
                    valuesEl.classList.add('clue-artists-values');
                    // Single icon before all values
                    const iconEl = document.createElement('i');
                    iconEl.className = `bi ${artistsCat.icon}`;
                    valuesEl.appendChild(iconEl);

                    Array.from(artistsSet).forEach(value => {
                        const chip = this.templates.clueValue.content.firstElementChild.cloneNode(true);
                        chip.classList.add('clue-artist');
                        chip.textContent = String(value);
                        valuesEl.appendChild(chip);
                    });
                }
                container.appendChild(catEl);
            }
        }

        // Render artist type (Type) if discovered
        const artistTypeSet = this.discoveredClues.get('artist_type');
        if (artistTypeSet && artistTypeSet.size > 0) {
            const artistTypeCat = GAME_CONFIG.clueCategories.find(c => c.key === 'artist_type');
            if (artistTypeCat) {
                // Déterminer le type d'artiste de l'album mystère pour afficher la bonne valeur
                // Priorité: is_group > is_solo_artist > fallback sur nombre d'artistes
                let mysteryIsSolo = false; // Par défaut, c'est un groupe
                if (this.mysteryAlbum) {
                    if (this.mysteryAlbum.is_group === true) {
                        mysteryIsSolo = false;
                    } else if (this.mysteryAlbum.is_solo_artist === true) {
                        mysteryIsSolo = true;
                    } else if (this.mysteryAlbum.artists && this.mysteryAlbum.artists.length === 1) {
                        // Fallback: compter les artistes
                        mysteryIsSolo = true;
                    } else {
                        // Sinon, c'est un groupe (par défaut)
                        mysteryIsSolo = false;
                    }
                }
                const artistTypeKey = mysteryIsSolo ? 'solo' : 'group';
                const artistType = i18n.t(`game.artistTypes.${artistTypeKey}`);
                
                const catEl = this.templates.clueCategory.content.firstElementChild.cloneNode(true);
                const titleEl = catEl.querySelector('.clue-category-title');
                if (titleEl) {
                    const iconEl = titleEl.querySelector('i');
                    const labelEl = titleEl.querySelector('.clue-category-label');
                    // Supprimer l'icône et le label du titre
                    if (iconEl) iconEl.remove();
                    if (labelEl) labelEl.remove();
                }
                
                const valuesEl = catEl.querySelector('.clue-values');
                if (valuesEl) {
                    // Single icon before all values
                    const iconEl = document.createElement('i');
                    iconEl.className = `bi ${artistTypeCat.icon}`;
                    valuesEl.appendChild(iconEl);
                    
                    // Afficher le type correct basé sur l'album mystère
                    const chip = this.templates.clueValue.content.firstElementChild.cloneNode(true);
                    chip.textContent = artistType;
                    valuesEl.appendChild(chip);
                }
                container.appendChild(catEl);
            }
        }

        GAME_CONFIG.clueCategories.forEach(catConf => {
            // Skip standalone continents panel; continents merge under countries
            if (catConf.key === 'continents') return;
            
            // Skip artists as they're already rendered above
            if (catConf.key === 'artists') return;
            
            // Skip artist_type as it's already rendered above
            if (catConf.key === 'artist_type') return;

            if (catConf.key === 'countries') {
                const countriesSet = this.discoveredClues.get('countries') || new Set();
                const continentsSet = this.discoveredClues.get('continents') || new Set();
                if (countriesSet.size === 0 && continentsSet.size === 0) return;

                const catEl = this.templates.clueCategory.content.firstElementChild.cloneNode(true);
                const valuesEl = catEl.querySelector('.clue-values');
                if (valuesEl) {
                    // Single icon before all values
                    const iconEl = document.createElement('i');
                    iconEl.className = `bi ${catConf.icon}`;
                    valuesEl.appendChild(iconEl);

                    Array.from(countriesSet).forEach(code => {
                        const chip = this.templates.clueValue.content.firstElementChild.cloneNode(true);
                        chip.textContent = this.getCountryName(String(code));
                        valuesEl.appendChild(chip);
                    });
                    Array.from(continentsSet).forEach(name => {
                        const chip = this.templates.clueValue.content.firstElementChild.cloneNode(true);
                        const continentName = String(name);
                        // Get continent translation directly from the translations object
                        const lang = i18n.getCurrentLanguage();
                        const continentTranslations = i18n.translations[lang]?.game?.continents;
                        const translatedName = continentTranslations?.[continentName] || continentName;
                        chip.textContent = translatedName;
                        valuesEl.appendChild(chip);
                    });
                }
                container.appendChild(catEl);
                return;
            }

            const values = this.discoveredClues.get(catConf.key);
            if (!values || values.size === 0) return;

            const catEl = this.templates.clueCategory.content.firstElementChild.cloneNode(true);
            const valuesEl = catEl.querySelector('.clue-values');
            if (valuesEl) {
                // Single icon before all values
                const iconEl = document.createElement('i');
                iconEl.className = `bi ${catConf.icon}`;
                valuesEl.appendChild(iconEl);

                // For instruments, translate and de-duplicate before displaying
                let displayValues = Array.from(values);
                if (catConf.key === 'instruments') {
                    const translatedSet = new Set();
                    displayValues.forEach(value => {
                        const translated = this.getInstrumentName(String(value));
                        if (translated) translatedSet.add(translated);
                    });
                    displayValues = Array.from(translatedSet);
                }

                displayValues.forEach(value => {
                    const chip = this.templates.clueValue.content.firstElementChild.cloneNode(true);
                    if (catConf.key === 'contributors') chip.classList.add('clue-musician');
                    if (catConf.key === 'artists') chip.classList.add('clue-artist');
                    // For non-instrument categories, use the value directly
                    let displayText = String(value);
                    chip.textContent = displayText;
                    valuesEl.appendChild(chip);
                });
            }
            container.appendChild(catEl);
        });
    }

    updateGuessesHistory() {
        const container = this.elements.guessesContainer;
        
        if (this.guesses.length === 0) {
            container.replaceChildren();
            return;
        }

        container.replaceChildren();
        this.guesses.slice().reverse().forEach((guess, index) => {
            const itemEl = this.templates.guessItem.content.firstElementChild.cloneNode(true);
            // Don't add victory class - display winning guess like others

            const coverUrl = this.getCoverUrl(guess.album, 250);
            const img = itemEl.querySelector('img.guess-cover');
            const placeholder = itemEl.querySelector('.guess-cover.placeholder');
            if (coverUrl && img) {
                img.src = coverUrl;
                img.style.display = '';
                if (placeholder) placeholder.style.display = 'none';
            } else {
                if (img) img.style.display = 'none';
                if (placeholder) placeholder.style.display = 'inline-block';
            }

            // Display title and artist for all guesses
            const titleEl = itemEl.querySelector('.guess-title');
            const artistEl = itemEl.querySelector('.guess-artist');
            if (titleEl) titleEl.textContent = guess.album.title || '';
            if (artistEl) artistEl.textContent = (guess.album.artists && guess.album.artists.length > 0) ? guess.album.artists.join(', ') : 'Unknown artist';

            const cluesEl = itemEl.querySelector('.guess-clues');
            if (cluesEl) {
                const icon = document.createElement('i');
                icon.className = 'bi bi-lightbulb';
                const clueCount = guess.cluesRevealed ? guess.cluesRevealed.length : 0;
                const text = document.createTextNode(` ${clueCount} clue(s)`);
                cluesEl.appendChild(icon);
                cluesEl.appendChild(text);
            }

            // Display attributes for all guesses (correct or not)
            {
                const categories = GAME_CONFIG.clueCategories.map(c => c.key);
                const revealedByCategory = new Map();
                
                // For winning guess, all attributes are hits
                if (guess.correct) {
                    // Mark all album attributes as hits
                    categories.forEach(catKey => {
                        const albumVal = guess.album[catKey];
                        if (albumVal) {
                            const values = Array.isArray(albumVal) ? albumVal : [albumVal];
                            revealedByCategory.set(catKey, new Set(values));
                        }
                    });
                    // Also add continents if countries are present
                    if (guess.album.continents) {
                        revealedByCategory.set('continents', new Set(guess.album.continents));
                    }
                } else {
                    (guess.cluesRevealed || []).forEach(c => revealedByCategory.set(c.category, new Set(c.values)));
                }

                const detailsEl = itemEl.querySelector('.guess-details');
                if (detailsEl) {
                    categories.forEach(catKey => {
                        // Skip continents as separate clue-attr (they're shown within countries)
                        if (catKey === 'continents') return;
                        
                        if (catKey === 'artist_type') {
                            // Déterminer le type d'artiste du guess et de l'album mystère
                            // Priorité: is_group > is_solo_artist > fallback sur nombre d'artistes
                            const guessAlbum = guess.album;
                            let guessIsSolo = false; // Par défaut, c'est un groupe
                            
                            if (guessAlbum) {
                                if (guessAlbum.is_group === true) {
                                    guessIsSolo = false;
                                } else if (guessAlbum.is_solo_artist === true) {
                                    guessIsSolo = true;
                                } else if (guessAlbum.artists && guessAlbum.artists.length === 1) {
                                    // Fallback: compter les artistes
                                    guessIsSolo = true;
                                } else {
                                    // Sinon, c'est un groupe (par défaut)
                                    guessIsSolo = false;
                                }
                            }
                            
                            let mysteryIsSolo = false; // Par défaut, c'est un groupe
                            if (this.mysteryAlbum) {
                                if (this.mysteryAlbum.is_group === true) {
                                    mysteryIsSolo = false;
                                } else if (this.mysteryAlbum.is_solo_artist === true) {
                                    mysteryIsSolo = true;
                                } else if (this.mysteryAlbum.artists && this.mysteryAlbum.artists.length === 1) {
                                    // Fallback: compter les artistes
                                    mysteryIsSolo = true;
                                } else {
                                    // Sinon, c'est un groupe (par défaut)
                                    mysteryIsSolo = false;
                                }
                            }
                            
                            const isMatch = guessIsSolo === mysteryIsSolo;
                            // Afficher le type du guess (pas celui de l'album mystère)
                            const guessArtistTypeKey = guessIsSolo ? 'solo' : 'group';
                            const guessArtistType = i18n.t(`game.artistTypes.${guessArtistTypeKey}`);
                            
                            const catConf = GAME_CONFIG.clueCategories.find(c => c.key === 'artist_type');
                            const attrEl = this.templates.guessAttr.content.firstElementChild.cloneNode(true);
                            const icon = attrEl.querySelector('.guess-attr-title i');
                            const lab = attrEl.querySelector('.guess-attr-label');
                            if (icon) icon.className = `bi ${catConf.icon}`;
                            if (lab) lab.textContent = i18n.t(`game.clueCategories.${catConf.key}`);
                            
                            const valuesEl = attrEl.querySelector('.guess-attr-values');
                            const chip = this.templates.guessChip.content.firstElementChild.cloneNode(true);
                            chip.classList.add(isMatch ? 'guess-chip-hit' : 'guess-chip-miss');
                            chip.textContent = guessArtistType;
                            chip.setAttribute('aria-label', `${guessArtistType}: ${i18n.t(isMatch ? 'game.chipLabels.hit' : 'game.chipLabels.miss')}`);
                            chip.setAttribute('title', i18n.t(isMatch ? 'game.chipLabels.hit' : 'game.chipLabels.miss'));
                            valuesEl.appendChild(chip);
                            detailsEl.appendChild(attrEl);
                            return;
                        }
                        
                        if (catKey === 'release_year') {
                            const gy = guess.album.release_year;
                            const my = this.mysteryAlbum && this.mysteryAlbum.release_year;
                            if (!gy) return;
                            let cls = 'guess-chip-miss';
                            let label = String(gy);
                            if (my) {
                                const gyi = parseInt(gy);
                                const myi = parseInt(my);
                                if (!isNaN(gyi) && !isNaN(myi)) {
                                    if (gyi === myi) {
                                        cls = 'guess-chip-hit';
                                    } else {
                                        label = `${gyi}`;
                                    }
                                }
                            }
                            const catConf = GAME_CONFIG.clueCategories.find(c => c.key === 'release_year');
                            const attrEl = this.templates.guessAttr.content.firstElementChild.cloneNode(true);
                            const icon = attrEl.querySelector('.guess-attr-title i');
                            const lab = attrEl.querySelector('.guess-attr-label');
                            if (icon) icon.className = `bi ${catConf.icon}`;
                            if (lab) lab.textContent = i18n.t(`game.clueCategories.${catConf.key}`);
                            const valuesEl = attrEl.querySelector('.guess-attr-values');
                            const chip = this.templates.guessChip.content.firstElementChild.cloneNode(true);
                            chip.classList.add(cls);
                            chip.textContent = label;
                            const isHit = cls === 'guess-chip-hit';
                            chip.setAttribute('aria-label', `${label}: ${i18n.t(isHit ? 'game.chipLabels.hit' : 'game.chipLabels.miss')}`);
                            chip.setAttribute('title', i18n.t(isHit ? 'game.chipLabels.hit' : 'game.chipLabels.miss'));
                            valuesEl.appendChild(chip);
                            detailsEl.appendChild(attrEl);
                            return;
                        }

                        if (catKey === 'total_length_seconds') {
                            const gl = guess.album.total_length_seconds;
                            const ml = this.mysteryAlbum && this.mysteryAlbum.total_length_seconds;
                            if (!gl) return;
                            let cls = 'guess-chip-miss';
                            let label = this.formatSeconds(gl);
                            if (ml) {
                                const gli = parseInt(gl);
                                const mli = parseInt(ml);
                                if (!isNaN(gli) && !isNaN(mli)) {
                                    if (gli === mli) {
                                        cls = 'guess-chip-hit';
                                    } else {
                                        label = this.formatSeconds(gl);
                                    }
                                }
                            }
                            const catConf = GAME_CONFIG.clueCategories.find(c => c.key === 'total_length_seconds');
                            const attrEl = this.templates.guessAttr.content.firstElementChild.cloneNode(true);
                            const icon = attrEl.querySelector('.guess-attr-title i');
                            const lab = attrEl.querySelector('.guess-attr-label');
                            if (icon) icon.className = `bi ${catConf.icon}`;
                            if (lab) lab.textContent = i18n.t(`game.clueCategories.${catConf.key}`);
                            const valuesEl = attrEl.querySelector('.guess-attr-values');
                            const chip = this.templates.guessChip.content.firstElementChild.cloneNode(true);
                            chip.classList.add(cls);
                            chip.textContent = label;
                            const isHit = cls === 'guess-chip-hit';
                            chip.setAttribute('aria-label', `${label}: ${i18n.t(isHit ? 'game.chipLabels.hit' : 'game.chipLabels.miss')}`);
                            chip.setAttribute('title', i18n.t(isHit ? 'game.chipLabels.hit' : 'game.chipLabels.miss'));
                            valuesEl.appendChild(chip);
                            detailsEl.appendChild(attrEl);
                            return;
                        }

                        const guessVal = guess.album[catKey];
                        if (!guessVal) return;
                        const catConf = GAME_CONFIG.clueCategories.find(c => c.key === catKey);
                        const revealed = revealedByCategory.get(catKey) || new Set();

                        const guessValues = Array.isArray(guessVal) ? guessVal : [guessVal];
                        const chips = [];
                        
                        // For instruments, de-duplicate by translated display text
                        if (catKey === 'instruments') {
                            const displayMap = new Map(); // Map<displayText, {isHit: boolean}>
                            guessValues.forEach(v => {
                                const vStr = String(v);
                                const display = this.getInstrumentName(vStr);
                                const isCommon = revealed.has(vStr);
                                // If any variant is a hit, mark the display text as a hit
                                if (!displayMap.has(display) || isCommon) {
                                    displayMap.set(display, { isHit: isCommon || (displayMap.get(display)?.isHit || false) });
                                }
                            });
                            displayMap.forEach((data, display) => {
                                const chip = this.templates.guessChip.content.firstElementChild.cloneNode(true);
                                chip.classList.add(data.isHit ? 'guess-chip-hit' : 'guess-chip-miss');
                                chip.textContent = display;
                                chip.setAttribute('aria-label', `${display}: ${i18n.t(data.isHit ? 'game.chipLabels.hit' : 'game.chipLabels.miss')}`);
                                chip.setAttribute('title', i18n.t(data.isHit ? 'game.chipLabels.hit' : 'game.chipLabels.miss'));
                                chips.push(chip);
                            });
                        } else {
                            guessValues.forEach(v => {
                                const vStr = String(v);
                                // Translate countries
                                let display = vStr;
                                if (catKey === 'countries') {
                                    display = this.getCountryName(vStr);
                                }
                                const isCommon = revealed.has(vStr);
                                const chip = this.templates.guessChip.content.firstElementChild.cloneNode(true);
                                chip.classList.add(isCommon ? 'guess-chip-hit' : 'guess-chip-miss');
                                chip.textContent = display;
                                chip.setAttribute('aria-label', `${display}: ${i18n.t(isCommon ? 'game.chipLabels.hit' : 'game.chipLabels.miss')}`);
                                chip.setAttribute('title', i18n.t(isCommon ? 'game.chipLabels.hit' : 'game.chipLabels.miss'));
                                chips.push(chip);
                            });
                        }

                        if (catKey === 'countries') {
                            const continents = this.getContinentsForCountryCodes(guessValues);
                            const continentsRevealed = revealedByCategory.get('continents') || new Set();
                            continents.forEach(name => {
                                const chip = this.templates.guessChip.content.firstElementChild.cloneNode(true);
                                const continentName = String(name);
                                // Get continent translation directly from the translations object
                                const continentTranslations = i18n.translations[i18n.currentLanguage]?.game?.continents;
                                const translatedName = continentTranslations?.[continentName] || continentName;
                                const isCommon = continentsRevealed.has(continentName);
                                chip.classList.add(isCommon ? 'guess-chip-hit' : 'guess-chip-miss');
                                chip.textContent = translatedName;
                                chip.setAttribute('aria-label', `${translatedName}: ${i18n.t(isCommon ? 'game.chipLabels.hit' : 'game.chipLabels.miss')}`);
                                chip.setAttribute('title', i18n.t(isCommon ? 'game.chipLabels.hit' : 'game.chipLabels.miss'));
                                chips.push(chip);
                            });
                        }

                        if (chips.length > 0) {
                            const attrEl = this.templates.guessAttr.content.firstElementChild.cloneNode(true);
                            const icon = attrEl.querySelector('.guess-attr-title i');
                            const lab = attrEl.querySelector('.guess-attr-label');
                            if (icon) icon.className = `bi ${catConf.icon}`;
                            if (lab) lab.textContent = i18n.t(`game.clueCategories.${catConf.key}`);
                            const valuesEl = attrEl.querySelector('.guess-attr-values');
                            chips.forEach(ch => valuesEl.appendChild(ch));
                            detailsEl.appendChild(attrEl);
                        }
                    });
                }
            }

            container.appendChild(itemEl);
        });
    }

    showVictoryModal() {
        // Display mystery album using template
        const block = this.templates.mysteryAlbum.content.firstElementChild.cloneNode(true);
        const titleEl = block.querySelector('.mystery-album-title');
        const artistEl = block.querySelector('.mystery-album-artist');
        const coverEl = block.querySelector('.mystery-album-cover');
        const metaEl = block.querySelector('.mystery-album-meta');

        if (titleEl) titleEl.textContent = this.mysteryAlbum.title || '';
        if (artistEl) artistEl.textContent = (this.mysteryAlbum.artists && this.mysteryAlbum.artists.length > 0) ? this.mysteryAlbum.artists.join(', ') : 'Unknown artist';
        if (coverEl) {
            const coverUrl = this.getCoverUrl(this.mysteryAlbum, 250);
            if (coverUrl) {
                coverEl.src = coverUrl;
                coverEl.style.display = '';
            } else {
                coverEl.style.display = 'none';
            }
        }
        if (metaEl) {
            metaEl.replaceChildren();
            const parts = [];
            if (this.mysteryAlbum.release_year) parts.push(`📅 ${this.mysteryAlbum.release_year}`);
            if (this.mysteryAlbum.genres && this.mysteryAlbum.genres.length > 0) parts.push(`🎵 ${this.mysteryAlbum.genres[0]}`);
            if (this.mysteryAlbum.countries && this.mysteryAlbum.countries.length > 0) parts.push(`🌍 ${this.getCountryName(this.mysteryAlbum.countries[0])}`);
            parts.forEach(text => {
                const span = document.createElement('span');
                span.textContent = text;
                metaEl.appendChild(span);
            });
        }
        
        // Reorder elements: cover, title, artist, meta
        if (coverEl && titleEl) {
            coverEl.parentNode.insertBefore(coverEl, titleEl);
        }
        
        this.elements.mysteryAlbumDisplay.replaceChildren(block);

        // Update stats
        this.elements.finalGuesses.textContent = this.guessCount;
        if (this.elements.finalClues) {
            this.elements.finalClues.textContent = this.discoveredClues.size;
        }

        // Hide show rankings button in random mode
        const isRandomAlbum = this.constructor.name === 'AlbumGuessrGame' && 
                             (window.location.pathname.includes('game.html') || 
                              (this.elements.gameDate && this.elements.gameDate.classList.contains('daily-instruction')));
        
        // Check if we're playing a past daily (URL has date parameter)
        const urlParams = new URLSearchParams(window.location.search);
        const isPastDaily = urlParams.has('date');
        
        if (this.elements.showRankingsButton) {
            this.elements.showRankingsButton.style.display = (isRandomAlbum || isPastDaily) ? 'none' : '';
        }
        
        // Get share section container
        const shareSection = document.querySelector('#victory-modal .share-section');
        
        if (isPastDaily) {
            // Hide share button in past daily mode
            const shareButton = document.getElementById('share-button');
            if (shareButton) {
                shareButton.style.display = 'none';
            }
            
            // Create or show "Play more past dailies" button
            let pastDailiesButton = document.getElementById('past-dailies-button');
            if (!pastDailiesButton && shareSection) {
                pastDailiesButton = document.createElement('button');
                pastDailiesButton.id = 'past-dailies-button';
                pastDailiesButton.className = 'share-button';
                const buttonText = i18n.t('game.victory.playPastDailies');
                pastDailiesButton.innerHTML = `<i class="bi bi-disc"></i><span data-i18n="game.victory.playPastDailies">${buttonText}</span>`;
                pastDailiesButton.addEventListener('click', () => {
                    window.location.href = 'past-dailies.html';
                });
                shareSection.appendChild(pastDailiesButton);
            } else if (pastDailiesButton) {
                pastDailiesButton.style.display = '';
            }
        } else {
            // Show share button in current daily mode
            const shareButton = document.getElementById('share-button');
            if (shareButton) {
                shareButton.style.display = '';
            }
            
            // Hide past dailies button if it exists
            const pastDailiesButton = document.getElementById('past-dailies-button');
            if (pastDailiesButton) {
                pastDailiesButton.style.display = 'none';
            }
        }

        this.elements.victoryModal.classList.add('show');

        // Ensure game status (guess counter) is visible
        if (this.elements.gameStatus) {
            this.elements.gameStatus.style.display = '';
        }

        // Ensure guesses history is visible
        if (this.elements.guessesHistory) {
            this.elements.guessesHistory.style.display = '';
            this.elements.guessesHistory.style.visibility = 'visible';
        }

        // Update guesses history to show all searches including the winning one
        this.updateGuessesHistory();

        // Persist win to user history if logged in
        this.saveWinToHistory();
    }

    hideVictoryModal() {
        this.elements.victoryModal.classList.remove('show');
        // Ensure clues and guesses are visible after closing modal
        this.updateUI();
    }

    showInstructionsModal() {
        this.elements.instructionsModal.classList.add('show');
    }

    hideInstructionsModal() {
        this.elements.instructionsModal.classList.remove('show');
    }

    shareResult() {
        const albumInfo = `"${this.mysteryAlbum.title}" by ${this.mysteryAlbum.artists ? this.mysteryAlbum.artists.join(', ') : 'Unknown artist'}`;
        const stats = `${this.guessCount} guess(es) • ${this.discoveredClues.size} clue(s) discovered`;

        const shareText = `🎵 I found the mystery album!\n\n${albumInfo}\n${stats}\n\n🎵 AlbumGuessr 🎵`;

        if (navigator.share) {
            navigator.share({
                title: 'AlbumGuessr',
                text: shareText
            });
        } else {
            // Fallback: copy to clipboard
            navigator.clipboard.writeText(shareText).then(() => {
                alert('Result copied to clipboard!');
            }).catch(() => {
                alert('Unable to copy the result. You can share it manually:\n\n' + shareText);
            });
        }
    }

    generateChallengeUrl() {
        if (!this.mysteryAlbum) return null;
        const baseUrl = window.location.origin;
        const path = '/game.html';
        const objectID = this.mysteryAlbum.objectID;
        return `${baseUrl}${path}?challenge=${objectID}`;
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
            button.innerHTML = `<i class="bi bi-check-circle-fill"></i> ${i18n.t('game.challengeLink')}`;
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

    showLoading(show) {
        if (show) {
            this.elements.loading.classList.add('show');
        } else {
            this.elements.loading.classList.remove('show');
        }
    }

    showError(message) {
        alert(message); // Simple error handling - could be improved with custom modal
    }

    getCoverUrl(album, size = 250) {
        if (!album || !album.cover_art_url) return null;
        const base = album.cover_art_url;
        if (!size) return base;
        // Avoid double-appending if a sized URL is already provided
        if (/-\d{3,4}$/.test(base)) return base;
        return `${base}-${size}`;
    }

    buildContributorDetailMap() {
        const map = new Map();
        const details = (this.mysteryAlbum && this.mysteryAlbum.contributors_details) ? this.mysteryAlbum.contributors_details : [];
        if (Array.isArray(details)) {
            details.forEach(d => {
                if (d && d.name) {
                    map.set(d.name, d);
                }
            });
        }
        return map;
    }

    normalizeAlbumContributors(album) {
        if (!album || !Array.isArray(album.contributors)) return;
        const validDetails = album.contributors.filter(c => c && (typeof c.name === 'string' || Array.isArray(c.instruments)));
        const names = validDetails.map(c => c.name).filter(Boolean);
        const instrumentsSet = new Set();
        validDetails.forEach(c => {
            const list = Array.isArray(c.instruments) ? c.instruments : [];
            list.forEach(inst => {
                if (inst) {
                    const normalized = String(inst).trim();
                    if (normalized) instrumentsSet.add(normalized);
                }
            });
        });
        album.contributors_details = validDetails;
        album.contributors = names;
        album.instruments = Array.from(instrumentsSet);
    }

    escapeHtml(text) {
        if (!text) return '';
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    getCountryName(code) {
        if (!code) return '';
        const regionCode = String(code).toUpperCase();
        try {
            // Use the current language from i18n instead of browser language
            let currentLang = 'en'; // Default fallback
            try {
                if (i18n && typeof i18n.getCurrentLanguage === 'function') {
                    currentLang = i18n.getCurrentLanguage();
                }
            } catch (e) {
                // i18n might not be initialized yet
                console.warn('i18n not ready, using default language:', e);
            }
            
            // Map app language codes to locale codes for Intl.DisplayNames
            const localeMap = {
                'en': 'en',
                'fr': 'fr',
                'es': 'es'
            };
            const locale = localeMap[currentLang] || currentLang || 'en';
            
            // Always check if we need to recreate the formatter if locale changed
            // Check for null, undefined, or the 'INVALID' marker we use when resetting
            const needsUpdate = !this.countryDisplayNames || 
                               !this.countryDisplayNamesLocale || 
                               this.countryDisplayNamesLocale === 'INVALID' ||
                               this.countryDisplayNamesLocale !== locale;
            
            if (needsUpdate) {
                if (typeof Intl !== 'undefined' && typeof Intl.DisplayNames === 'function') {
                    try {
                        this.countryDisplayNames = new Intl.DisplayNames([locale], { type: 'region' });
                        this.countryDisplayNamesLocale = locale;
                    } catch (e) {
                        console.warn('Failed to create Intl.DisplayNames:', e);
                        this.countryDisplayNames = null;
                        this.countryDisplayNamesLocale = null;
                    }
                } else {
                    this.countryDisplayNames = null;
                    this.countryDisplayNamesLocale = null;
                }
            }
            if (this.countryDisplayNames) {
                const name = this.countryDisplayNames.of(regionCode);
                if (name) return name;
            }
        } catch (e) {
            // ignore and fallback
            console.warn('Error in getCountryName:', e);
        }
        return regionCode;
    }

    getInstrumentName(instrument) {
        if (!instrument) return '';
        const instrumentName = String(instrument);
        try {
            // Get current language - use same method as getCountryName
            let lang = 'en'; // Default fallback
            try {
                if (i18n && typeof i18n.getCurrentLanguage === 'function') {
                    lang = i18n.getCurrentLanguage();
                }
            } catch (e) {
                // i18n might not be initialized yet
                console.warn('i18n not ready in getInstrumentName, using default language:', e);
                return instrumentName;
            }
            
            // Get instrument translations directly from the translations object
            // Use same pattern as continents translation
            const langTranslations = i18n.translations?.[lang];
            if (!langTranslations || !langTranslations.game || !langTranslations.game.instruments) {
                console.warn('Instrument translations not available for lang:', lang, 'instrument:', instrumentName);
                return instrumentName;
            }
            
            const instrumentTranslations = langTranslations.game.instruments;
            
            // Try exact match first
            let translatedName = instrumentTranslations[instrumentName];
            
            // If no exact match, try case-insensitive match
            if (!translatedName) {
                const lowerName = instrumentName.toLowerCase();
                for (const [key, value] of Object.entries(instrumentTranslations)) {
                    if (key.toLowerCase() === lowerName) {
                        translatedName = value;
                        break;
                    }
                }
            }
            
            // If still no match, try matching with first letter capitalized
            if (!translatedName) {
                const capitalized = instrumentName.charAt(0).toUpperCase() + instrumentName.slice(1).toLowerCase();
                translatedName = instrumentTranslations[capitalized];
            }
            
            // If still no match, try partial matching for compound names
            // (e.g., "guitar" matches "Electric Guitar" or "Acoustic Guitar")
            if (!translatedName) {
                const lowerName = instrumentName.toLowerCase().trim();
                // Only try partial matching if the instrument name is a single word or common instrument base
                const commonBases = ['guitar', 'bass', 'saxophone', 'violin', 'piano', 'drums', 'percussion'];
                const isCommonBase = commonBases.some(base => lowerName.includes(base) || base.includes(lowerName));
                
                if (isCommonBase || lowerName.split(/\s+/).length <= 2) {
                    for (const [key, value] of Object.entries(instrumentTranslations)) {
                        const lowerKey = key.toLowerCase();
                        // Prefer matches where the instrument name is at the end of the key
                        // (e.g., "guitar" matches "Electric Guitar" but not "Bass Guitar")
                        if (lowerKey.endsWith(' ' + lowerName) || lowerKey === lowerName + 's' || lowerKey === lowerName) {
                            translatedName = value;
                            break;
                        }
                        // Also check if key is contained in instrument name (for compound instruments)
                        if (lowerName.includes(lowerKey) && lowerKey.length > 3) {
                            translatedName = value;
                            break;
                        }
                    }
                }
            }
            
            // Return translated name if available, otherwise return original
            return translatedName || instrumentName;
        } catch (e) {
            // ignore and fallback
            console.warn('Error in getInstrumentName:', e, 'instrument:', instrument);
            return instrumentName;
        }
    }

    // --- Continents mapping utilities ---
    getContinentsForCountryCodes(codes) {
        if (!Array.isArray(codes)) return [];
        const map = this.getContinentCountryMap();
        const continents = new Set();
        codes.forEach(code => {
            const cc = String(code || '').toUpperCase();
            for (const [continent, set] of map.entries()) {
                if (set.has(cc)) {
                    continents.add(continent);
                }
            }
        });
        return Array.from(continents);
    }

    getContinentCountryMap() {
        if (this._continentCountryMap) return this._continentCountryMap;

        // Define ISO 3166-1 alpha-2 country codes by continent (not exhaustive comments; data-driven)
        const AF = [
            'DZ','AO','BJ','BW','BF','BI','CM','CV','CF','TD','KM','CG','CD','CI','DJ','EG','GQ','ER','ET','GA','GM','GH','GN','GW','KE','LS','LR','LY','MG','MW','ML','MR','MU','MA','MZ','NA','NE','NG','RE','RW','ST','SN','SC','SL','SO','ZA','SS','SD','SZ','TZ','TG','TN','UG','EH','YT','ZM','ZW'
        ];
        const EU = [
            'AL','AD','AT','BY','BE','BA','BG','HR','CY','CZ','DK','EE','FO','FI','FR','DE','GI','GR','GG','HU','IS','IE','IM','IT','JE','LV','LI','LT','LU','MT','MD','MC','ME','NL','MK','NO','PL','PT','RO','RU','SM','RS','SK','SI','ES','SE','CH','TR','UA','GB','VA','AX','XK'
        ];
        const AS = [
            'AF','AM','AZ','BH','BD','BT','BN','KH','CN','GE','HK','IN','ID','IR','IQ','IL','JP','JO','KZ','KW','KG','LA','LB','MO','MY','MV','MN','MM','NP','KP','OM','PK','PS','PH','QA','SA','SG','KR','LK','SY','TW','TJ','TH','TL','TM','AE','UZ','VN','YE'
        ];
        const NA = [
            'US','CA','MX','GL','BM','PM','AG','AI','AW','BS','BB','BQ','KY','CU','CW','DM','DO','GD','GP','HT','JM','MQ','MS','PR','BL','KN','MF','SX','TT','VC','VG','VI','LC','BZ','CR','SV','GT','HN','NI','PA','TC'
        ];
        const SA = [
            'AR','BO','BR','CL','CO','EC','FK','GF','GY','PE','PY','SR','UY','VE'
        ];
        const OC = [
            'AS','AU','CK','FJ','PF','GU','KI','MH','FM','NR','NC','NZ','NU','NF','MP','PW','PG','PN','WS','SB','TK','TO','TV','UM','VU','WF'
        ];
        const AN = [
            'AQ','BV','GS','HM','TF'
        ];

        const map = new Map();
        map.set('Africa', new Set(AF));
        map.set('Europe', new Set(EU));
        map.set('Asia', new Set(AS));
        map.set('North America', new Set(NA));
        map.set('South America', new Set(SA));
        map.set('Oceania', new Set(OC));
        map.set('Antarctica', new Set(AN));
        this._continentCountryMap = map;
        return map;
    }

    caseInsensitiveArrayIntersection(arrA, arrB) {
        // Returns values from arrA that case-insensitively exist in arrB, preserving arrA's original casing
        if (!Array.isArray(arrA) || !Array.isArray(arrB)) return [];
        const setB = new Set(arrB.map(v => String(v).toLowerCase()));
        return arrA.filter(v => setB.has(String(v).toLowerCase()));
    }

    debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }

    // ---------- User history via API (Netlify Functions + Neon) ----------

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
            gameMode: 'random', // Base game uses 'random' mode
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
                    
                    // Show toast suggesting username setup if user doesn't have a custom username
                    const hasCustomUsername = this.authManager.authenticatedUser.user_metadata?.custom_username;
                    if (!hasCustomUsername) {
                        this.showToast({
                            title: 'Customize Your Profile',
                            message: 'Set a custom username to personalize your appearance on the leaderboard!',
                            type: 'info',
                            duration: 8000,
                            action: {
                                text: 'Set Username',
                                href: '/profile.html'
                            }
                        });
                    }
                }
            })
            .catch(err => console.warn('save history error:', err));
    }

    async renderUserHistory() {
        const isAuthenticated = !!this.authManager.authenticatedUser;
        const history = isAuthenticated ? await this.apiClient.fetchUserHistory() : [];
        this.historyRenderer.render(history, isAuthenticated);
    }

    /**
     * Show a toast notification
     * @param {Object} options - Toast options
     * @param {string} options.title - Toast title
     * @param {string} options.message - Toast message
     * @param {string} options.type - Toast type: 'info', 'success', 'warning' (default: 'info')
     * @param {number} options.duration - Duration in ms (default: 6000, 0 for persistent)
     * @param {Object} options.action - Optional action link { text, href }
     */
    showToast({ title, message, type = 'info', duration = 6000, action = null }) {
        if (!this.elements.toastContainer) return;

        const toast = document.createElement('div');
        toast.className = `toast toast-${type}`;

        // Icon based on type
        const iconMap = {
            info: 'bi-info-circle-fill',
            success: 'bi-check-circle-fill',
            warning: 'bi-exclamation-circle-fill'
        };
        const iconClass = iconMap[type] || iconMap.info;

        toast.innerHTML = `
            <i class="bi ${iconClass} toast-icon"></i>
            <div class="toast-content">
                <div class="toast-title">${this.escapeHtml(title)}</div>
                <div class="toast-message">${this.escapeHtml(message)}</div>
                ${action ? `<div class="toast-action"><a href="${this.escapeHtml(action.href)}">${this.escapeHtml(action.text)} <i class="bi bi-arrow-right"></i></a></div>` : ''}
            </div>
            <button class="toast-close" aria-label="Close notification">×</button>
        `;

        // Close button handler
        const closeBtn = toast.querySelector('.toast-close');
        closeBtn.addEventListener('click', () => this.removeToast(toast));

        // Action link handler (if present)
        if (action) {
            const actionLink = toast.querySelector('.toast-action a');
            actionLink.addEventListener('click', (e) => {
                e.preventDefault();
                window.location.href = action.href;
            });
        }

        // Add to container
        this.elements.toastContainer.appendChild(toast);

        // Auto-remove after duration (if not persistent)
        if (duration > 0) {
            setTimeout(() => this.removeToast(toast), duration);
        }
    }

    /**
     * Remove a toast notification
     * @param {HTMLElement} toast - Toast element to remove
     */
    removeToast(toast) {
        if (!toast || !toast.parentElement) return;
        
        toast.classList.add('toast-exit');
        setTimeout(() => {
            if (toast.parentElement) {
                toast.parentElement.removeChild(toast);
            }
        }, 300); // Match animation duration
    }

    /**
     * Escape HTML to prevent XSS
     * @param {string} text - Text to escape
     * @returns {string} Escaped text
     */
    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // Inspiration box functionality
    toggleInspirationBox() {
        if (!this.elements.inspirationBox) return;
        
        const isExpanded = this.elements.inspirationBox.classList.contains('expanded');
        
        if (isExpanded) {
            this.elements.inspirationBox.classList.remove('expanded');
        } else {
            this.elements.inspirationBox.classList.add('expanded');
            // Load inspiration results when expanding
            this.loadInspirationResults();
        }
    }

    async loadInspirationResults() {
        if (!this.elements.inspirationResults || !this.elements.inspirationMessage) return;
        
        // Check if there are any discovered clues
        if (this.discoveredClues.size === 0 || this.gameOver) {
            this.elements.inspirationMessage.style.display = 'block';
            this.elements.inspirationResults.style.display = 'none';
            return;
        }
        
        try {
            // Build Algolia search query based on discovered clues
            const { numericFilters, requiredFilters, optionalFilterGroups } = this.buildInspirationFilters();
            
            if (requiredFilters.length === 0 && numericFilters.length === 0) {
                this.elements.inspirationMessage.style.display = 'block';
                this.elements.inspirationResults.style.display = 'none';
                return;
            }
            
            // Build filter to exclude already guessed albums
            const guessedObjectIDs = this.guesses.map(guess => guess.album.objectID);
            const excludeGuessedFilter = guessedObjectIDs.length > 0 
                ? guessedObjectIDs.map(id => `NOT objectID:"${id}"`).join(' AND ')
                : '';
            
            // Search with required filters + optional filters for better ranking
            // Required: genres, artists, countries (must match)
            // Optional: instruments, label, contributors (boost score if match)
            let searchResponse = await this.algoliaIndex.search('', {
                filters: excludeGuessedFilter,
                facetFilters: requiredFilters, // Must match genres/artists/countries
                optionalFilters: optionalFilterGroups, // Boost score for matching instruments/label
                numericFilters: numericFilters,
                sumOrFiltersScores: true, // Score based on optional filter matches
                hitsPerPage: 5,
                attributesToRetrieve: [
                    'objectID', 'title', 'artists', 'release_year', 
                    'cover_art_url', 'rating_score', 'rating_count', 'genres'
                ]
                // customRanking is already configured in the index
            });
            
            // If no results with required filters, make everything optional
            if (searchResponse.hits.length === 0 && requiredFilters.length > 0) {
                
                const allFilters = [...requiredFilters, ...optionalFilterGroups];
                searchResponse = await this.algoliaIndex.search('', {
                    filters: excludeGuessedFilter,
                    optionalFilters: allFilters, // All filters optional - rank by best matches
                    numericFilters: numericFilters,
                    sumOrFiltersScores: true,
                    hitsPerPage: 5,
                    attributesToRetrieve: [
                        'objectID', 'title', 'artists', 'release_year', 
                        'cover_art_url', 'rating_score', 'rating_count', 'genres'
                    ]
                });
            }
            
            // If still no results, try with only numeric filters (year only)
            if (searchResponse.hits.length === 0 && numericFilters.length > 0) {
                searchResponse = await this.algoliaIndex.search('', {
                    filters: excludeGuessedFilter,
                    numericFilters: numericFilters,
                    hitsPerPage: 5,
                    attributesToRetrieve: [
                        'objectID', 'title', 'artists', 'release_year', 
                        'cover_art_url', 'rating_score', 'rating_count'
                    ]
                });
            }
            
            if (searchResponse.hits.length === 0) {
                this.elements.inspirationMessage.innerHTML = '<p>No albums found matching your clues. Try making more guesses!</p>';
                this.elements.inspirationMessage.style.display = 'block';
                this.elements.inspirationResults.style.display = 'none';
                return;
            }
            
            // Hide message and show results
            this.elements.inspirationMessage.style.display = 'none';
            this.elements.inspirationResults.style.display = 'block';
            
            // Render results
            this.renderInspirationResults(searchResponse.hits);
            
        } catch (error) {
            console.error('Failed to load inspiration results:', error);
            this.elements.inspirationMessage.innerHTML = '<p>Error loading suggestions. Please try again.</p>';
            this.elements.inspirationMessage.style.display = 'block';
            this.elements.inspirationResults.style.display = 'none';
        }
    }

    buildInspirationFilters() {
        const numericFilters = [];
        const requiredFilters = [];  // Critical filters (must match)
        const optionalFilterGroups = [];  // Less critical filters (nice to have)
        
        // Add filters for each discovered clue type
        this.discoveredClues.forEach((values, category) => {
            // Skip certain categories that need special handling
            if (category === 'continents' || category === 'artist_type') return;
            
            const valuesArray = Array.from(values);
            if (valuesArray.length === 0) return;
            
            // Handle year ranges with numeric filters
            if (category === 'release_year') {
                const yearHint = valuesArray[0]; // e.g., "between 1995 and 2000" or "2000"
                
                // Check if it's a plain year number
                const yearNum = parseInt(yearHint);
                if (!isNaN(yearNum) && yearHint.trim() === yearNum.toString()) {
                    // Exact year
                    numericFilters.push(`release_year=${yearNum}`);
                } else {
                    // Extract all 4-digit years from the hint
                    const yearMatches = yearHint.match(/\d{4}/g);
                    
                    if (yearMatches && yearMatches.length === 2) {
                        // Two years found: it's a "between X and Y" range
                        const year1 = parseInt(yearMatches[0]);
                        const year2 = parseInt(yearMatches[1]);
                        numericFilters.push(`release_year>=${Math.min(year1, year2)}`);
                        numericFilters.push(`release_year<=${Math.max(year1, year2)}`);
                    } else if (yearMatches && yearMatches.length === 1) {
                        // One year found: check if it's "after" or "before"
                        const year = parseInt(yearMatches[0]);
                        const lowerHint = yearHint.toLowerCase();
                        
                        // Check for "after" keywords in all languages (after, après, después)
                        if (lowerHint.includes('after') || lowerHint.includes('après') || lowerHint.includes('después')) {
                            numericFilters.push(`release_year>=${year}`);
                        }
                        // Check for "before" keywords in all languages (before, avant, antes)
                        else if (lowerHint.includes('before') || lowerHint.includes('avant') || lowerHint.includes('antes')) {
                            numericFilters.push(`release_year<=${year}`);
                        }
                    }
                }
                return;
            }
            
            // Skip length hints for now (would need to parse formatted strings)
            if (category === 'total_length_seconds') return;
            
            // Build facet filters for this category
            // Each value in the array becomes an OR within the category
            // Note: Algolia facet values are case-sensitive and must match exactly
            const categoryFacets = valuesArray.map(value => {
                // Ensure proper escaping for facet filter format
                const escapedValue = String(value).replace(/"/g, '\\"');
                return `${category}:"${escapedValue}"`;
            });
            
            if (categoryFacets.length === 0) return;
            
            // Prioritize filters: genres, artists, countries are REQUIRED
            // instruments, contributors, label are OPTIONAL (nice to have but not critical)
            if (category === 'genres' || category === 'artists' || category === 'countries') {
                requiredFilters.push(categoryFacets);
            } else {
                // Instruments, label, contributors are optional
                optionalFilterGroups.push(categoryFacets);
            }
        });
        
        return { numericFilters, requiredFilters, optionalFilterGroups };
    }

    renderInspirationResults(hits) {
        if (!this.elements.inspirationResults || !this.templates.inspirationItem) return;
        
        this.elements.inspirationResults.replaceChildren();
        
        hits.forEach(album => {
            const item = this.templates.inspirationItem.content.firstElementChild.cloneNode(true);
            
            // Set cover image
            const cover = item.querySelector('.inspiration-cover');
            if (cover) {
                const coverUrl = this.getCoverUrl(album, 120);
                if (coverUrl) {
                    cover.src = coverUrl;
                    cover.alt = `${album.title} cover`;
                } else {
                    cover.style.display = 'none';
                }
            }
            
            // Set title
            const title = item.querySelector('.inspiration-title');
            if (title) {
                title.textContent = album.title || 'Unknown Album';
            }
            
            // Set artist
            const artist = item.querySelector('.inspiration-artist');
            if (artist) {
                const artistText = Array.isArray(album.artists) ? album.artists.join(', ') : 'Unknown Artist';
                artist.textContent = artistText;
            }
            
            // Set meta (year)
            const meta = item.querySelector('.inspiration-meta');
            if (meta) {
                const yearText = album.release_year ? album.release_year : '';
                meta.textContent = yearText;
            }
            
            // Add click handler to select this album
            item.addEventListener('click', () => {
                this.selectInspirationAlbum(album);
            });
            
            this.elements.inspirationResults.appendChild(item);
        });
    }

    async selectInspirationAlbum(album) {
        // Fetch full album data from Algolia
        try {
            const fullAlbum = await this.algoliaIndex.getObject(album.objectID, {
                attributesToRetrieve: [
                    'objectID', 'title', 'artists', 'genres', 'release_year', 'countries', 'contributors',
                    'cover_art_url', 'label', 'total_length_seconds', 'is_solo_artist', 'is_group'
                ]
            });
            
            // Normalize album data
            this.normalizeAlbumContributors(fullAlbum);
            if (Array.isArray(fullAlbum.countries)) {
                fullAlbum.continents = this.getContinentsForCountryCodes(fullAlbum.countries);
            }
            
            // Set as selected result
            this.selectedResult = fullAlbum;
            
            // Collapse the inspiration box
            if (this.elements.inspirationBox) {
                this.elements.inspirationBox.classList.remove('expanded');
            }
            
            // Automatically submit the guess
            this.submitGuess();
            
        } catch (error) {
            console.error('Failed to select inspiration album:', error);
            this.showToast({
                title: 'Error',
                message: 'Failed to select album. Please try again.',
                type: 'error'
            });
        }
    }
}
