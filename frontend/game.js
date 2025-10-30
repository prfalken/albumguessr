class AlbumGuessrGame {
    constructor() {
        this.algoliaClient = null;
        this.algoliaIndex = null;
        this.auth0Client = null;
        this.authenticatedUser = null;
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
        
        this.initializeAlgolia();
        this.initializeAuth0();
        this.initializeDOM();
        // Kick off auth flow wiring after DOM is available
        this.postDomAuthSetup();
        // Ensure label is part of the clue categories
        this.ensureLabelClueCategory();
        this.initializeGame();
        this.bindEvents();
    }

    initializeAlgolia() {
        try {
            this.algoliaClient = algoliasearch(
                ALGOLIA_CONFIG.applicationId,
                ALGOLIA_CONFIG.apiKey
            );
            this.algoliaIndex = this.algoliaClient.initIndex(ALGOLIA_CONFIG.indexName);
            console.log('Algolia initialized successfully');
        } catch (error) {
            console.error('Failed to initialize Algolia:', error);
            this.showError('Failed to connect to the search index. Please refresh the page.');
        }
    }

    async initializeAuth0() {
        // Only initialize if config and library are available
        try {
            if (typeof AUTH0_CONFIG === 'object' && AUTH0_CONFIG && typeof auth0 !== 'undefined') {
                this.auth0Client = await auth0.createAuth0Client(AUTH0_CONFIG);
                console.log('Auth0 initialized');
            }
        } catch (error) {
            console.warn('Auth0 initialization failed or skipped:', error);
        }
    }

    initializeDOM() {
        // Get DOM elements
        this.elements = {
            gameDate: document.getElementById('game-date'),
            guessCount: document.getElementById('guess-count'),
            albumSearch: document.getElementById('album-search'),
            searchSubmit: document.getElementById('search-submit'),
            searchResults: document.getElementById('search-results'),
            cluesContainer: document.getElementById('clues-container'),
            guessesContainer: document.getElementById('guesses-container'),
            victoryModal: document.getElementById('victory-modal'),
            mysteryAlbumDisplay: document.getElementById('mystery-album-display'),
            finalGuesses: document.getElementById('final-guesses'),
            finalClues: document.getElementById('final-clues'),
            shareButton: document.getElementById('share-button'),
            playAgainButton: document.getElementById('play-again-button'),
            closeVictory: document.getElementById('close-victory'),
            instructionsModal: document.getElementById('instructions-modal'),
            instructionsButton: document.getElementById('instructions-button'),
            closeInstructions: document.getElementById('close-instructions'),
            loading: document.getElementById('loading'),
            // Auth controls
            btnLogin: document.getElementById('btn-login'),
            btnLogout: document.getElementById('btn-logout'),
            userProfile: document.getElementById('user-profile'),
            userAvatar: document.getElementById('user-avatar'),
            userName: document.getElementById('user-name'),
            // User history (right panel)
            userHistorySubtitle: document.getElementById('user-history-subtitle'),
            userHistoryList: document.getElementById('user-history-list')
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
            historyError: document.getElementById('tpl-history-error')
        };

        // Show refresh-based info
        this.elements.gameDate.textContent = 'New mystery on each refresh';
    }

    async postDomAuthSetup() {
        try {
            await this.ensureAuth0Client();
            if (!this.auth0Client) return;

            // Handle redirect callback if returning from Auth0
            const hasAuthParams = window.location.search.includes('code=') && window.location.search.includes('state=');
            if (hasAuthParams) {
                try {
                    await this.auth0Client.handleRedirectCallback();
                } finally {
                    window.history.replaceState({}, document.title, window.location.pathname);
                }
            }

            const isAuthenticated = await this.auth0Client.isAuthenticated();
            if (isAuthenticated) {
                this.authenticatedUser = await this.auth0Client.getUser();
            } else {
                this.authenticatedUser = null;
            }
            this.updateAuthUI(isAuthenticated);
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

    async selectDailyAlbum() {
        // Fetch a random scheduled album from the database via Netlify Function
        try {
            const res = await fetch('/.netlify/functions/randomAlbum', { cache: 'no-store' });
            if (!res.ok) throw new Error('Failed to load random album');
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
            console.log('Random mystery album:', this.mysteryAlbum);
            return this.mysteryAlbum;
        } catch (error) {
            console.error('Failed to select random album:', error);
            throw error;
        }
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

        // Submit button
        this.elements.searchSubmit.addEventListener('click', this.submitGuess.bind(this));

        // Modal events
        this.elements.closeVictory.addEventListener('click', () => window.location.reload());
        this.elements.shareButton.addEventListener('click', this.shareResult.bind(this));
        if (this.elements.playAgainButton) {
            this.elements.playAgainButton.addEventListener('click', () => window.location.reload());
        }
        
        // Instructions modal
        this.elements.instructionsButton.addEventListener('click', this.showInstructionsModal.bind(this));
        this.elements.closeInstructions.addEventListener('click', this.hideInstructionsModal.bind(this));

        // Close modals on background click
        this.elements.victoryModal.addEventListener('click', (e) => {
            if (e.target === this.elements.victoryModal) {
                this.hideVictoryModal();
            }
        });

        this.elements.instructionsModal.addEventListener('click', (e) => {
            if (e.target === this.elements.instructionsModal) {
                this.hideInstructionsModal();
            }
        });

        // Close search results when clicking outside
        document.addEventListener('click', (e) => {
            if (!e.target.closest('.search-container')) {
                this.hideSearchResults();
            }
        });

        // Auth buttons
        if (this.elements.btnLogin) {
            this.elements.btnLogin.addEventListener('click', () => this.login());
        }
        if (this.elements.btnLogout) {
            this.elements.btnLogout.addEventListener('click', () => this.logout());
        }
    }

    async ensureAuth0Client() {
        if (this.auth0Client) return this.auth0Client;
        try {
            if (typeof AUTH0_CONFIG === 'object' && AUTH0_CONFIG && typeof auth0 !== 'undefined') {
                this.auth0Client = await auth0.createAuth0Client(AUTH0_CONFIG);
                return this.auth0Client;
            }
        } catch (e) {
            console.warn('Unable to create Auth0 client:', e);
        }
        return null;
    }

    async login() {
        const client = await this.ensureAuth0Client();
        if (!client) return;
        await client.loginWithRedirect({
            authorizationParams: { redirect_uri: window.location.origin }
        });
    }

    async logout() {
        const client = await this.ensureAuth0Client();
        if (!client) return;
        client.logout({ logoutParams: { returnTo: window.location.origin } });
    }

    updateAuthUI(isAuthenticated) {
        const show = (el, visible) => { if (el) el.style.display = visible ? '' : 'none'; };
        show(this.elements.btnLogin, !isAuthenticated);
        show(this.elements.btnLogout, !!isAuthenticated);
        if (isAuthenticated && this.authenticatedUser) {
            if (this.elements.userAvatar) {
                this.elements.userAvatar.src = this.authenticatedUser.picture || '';
            }
            if (this.elements.userName) {
                this.elements.userName.textContent = this.authenticatedUser.name || this.authenticatedUser.email || '';
            }
            show(this.elements.userProfile, true);
        } else {
            show(this.elements.userProfile, false);
        }
        this.renderUserHistory();
        // If the user logs in after already winning, persist the win once
        if (isAuthenticated && this.gameWon && !this.winSaved) {
            this.saveWinToHistory();
        }
    }

    async handleSearchInput(event) {
        const query = event.target.value.trim();
        
        if (query.length < 2) {
            this.hideSearchResults();
            this.selectedResult = null;
            this.elements.searchSubmit.disabled = true;
            return;
        }

        try {
            const searchResponse = await this.algoliaIndex.search(query, {
                hitsPerPage: 20,
                attributesToRetrieve: [
                    'objectID', 'title', 'artists', 'genres', 'release_year', 'countries', 'contributors',
                    'cover_art_url', 'label', 'total_length_seconds'
                ]
            });

            this.searchResults = searchResponse.hits.map(hit => {
                this.normalizeAlbumContributors(hit);
                return hit;
            });
            this.displaySearchResults();
            this.elements.searchSubmit.disabled = this.searchResults.length === 0;
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
            if (artistEl) artistEl.textContent = (album.artists && album.artists.length > 0) ? album.artists.join(', ') : 'Unknown artist';
            if (metaEl) {
                metaEl.replaceChildren();
                const parts = [];
                if (album.release_year) parts.push(String(album.release_year));
                if (album.genres && album.genres.length > 0) parts.push(String(album.genres[0]));
                if (album.countries && album.countries.length > 0) parts.push(this.getCountryName(album.countries[0]));
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

        this.updateUI();
        this.elements.albumSearch.value = '';
        this.hideSearchResults();
        this.selectedResult = null;
        this.elements.searchSubmit.disabled = true;

        if (this.gameOver) {
            setTimeout(() => this.showVictoryModal(), 1000);
        }
    }

    analyzeSharedAttributes(guess, mystery) {
        const sharedClues = [];

        GAME_CONFIG.clueCategories.forEach(category => {
            // Skip release_year as it's handled separately
            if (category.key === 'release_year') return;
            // Skip total_length_seconds as it's handled separately (longer/shorter)
            if (category.key === 'total_length_seconds') return;
            
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
            yearHint = `between ${latestBefore} and ${earliestAfter}`;
        } else if (yearsBefore.length > 0) {
            // We only have years before - show "after X"
            const latestBefore = Math.max(...yearsBefore);
            yearHint = `after ${latestBefore}`;
        } else if (yearsAfter.length > 0) {
            // We only have years after - show "before X"
            const earliestAfter = Math.min(...yearsAfter);
            yearHint = `before ${earliestAfter}`;
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
            lenHint = `between ${this.formatSeconds(maxShorter)} and ${this.formatSeconds(minLonger)}`;
        } else if (shorter.length > 0) {
            const maxShorter = Math.max(...shorter);
            lenHint = `longer than ${this.formatSeconds(maxShorter)}`;
        } else if (longer.length > 0) {
            const minLonger = Math.min(...longer);
            lenHint = `shorter than ${this.formatSeconds(minLonger)}`;
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
        // Update guess counter
        this.elements.guessCount.textContent = this.guessCount;
        
        // Update clues board
        this.updateCluesBoard();

        // Update guesses history
        this.updateGuessesHistory();
    }

    updateCluesBoard() {
        const container = this.elements.cluesContainer;
        container.replaceChildren();

        if (this.discoveredClues.size === 0) {
            const tpl = this.templates.noClues;
            if (tpl) container.appendChild(tpl.content.firstElementChild.cloneNode(true));
            return;
        }

        GAME_CONFIG.clueCategories.forEach(catConf => {
            // Skip standalone continents panel; continents merge under countries
            if (catConf.key === 'continents') return;

            if (catConf.key === 'countries') {
                const countriesSet = this.discoveredClues.get('countries') || new Set();
                const continentsSet = this.discoveredClues.get('continents') || new Set();
                if (countriesSet.size === 0 && continentsSet.size === 0) return;

                const catEl = this.templates.clueCategory.content.firstElementChild.cloneNode(true);
                const titleIcon = catEl.querySelector('.clue-category-title i');
                const titleLabel = catEl.querySelector('.clue-category-label');
                if (titleIcon) titleIcon.className = `bi ${catConf.icon}`;
                if (titleLabel) titleLabel.textContent = catConf.label;
                const valuesEl = catEl.querySelector('.clue-values');
                if (valuesEl) {
                    Array.from(countriesSet).forEach(code => {
                        const chip = this.templates.clueValue.content.firstElementChild.cloneNode(true);
                        chip.textContent = this.getCountryName(String(code));
                        valuesEl.appendChild(chip);
                    });
                    Array.from(continentsSet).forEach(name => {
                        const chip = this.templates.clueValue.content.firstElementChild.cloneNode(true);
                        chip.textContent = String(name);
                        valuesEl.appendChild(chip);
                    });
                }
                container.appendChild(catEl);
                return;
            }

            const values = this.discoveredClues.get(catConf.key);
            if (!values || values.size === 0) return;

            const catEl = this.templates.clueCategory.content.firstElementChild.cloneNode(true);
            const titleIcon = catEl.querySelector('.clue-category-title i');
            const titleLabel = catEl.querySelector('.clue-category-label');
            if (titleIcon) titleIcon.className = `bi ${catConf.icon}`;
            if (titleLabel) titleLabel.textContent = catConf.label;
            const valuesEl = catEl.querySelector('.clue-values');
            if (valuesEl) {
                Array.from(values).forEach(value => {
                    const chip = this.templates.clueValue.content.firstElementChild.cloneNode(true);
                    if (catConf.key === 'contributors') chip.classList.add('clue-musician');
                    chip.textContent = String(value);
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
        this.guesses.slice().reverse().forEach(guess => {
            const itemEl = this.templates.guessItem.content.firstElementChild.cloneNode(true);
            if (guess.correct) itemEl.classList.add('victory');

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

            const titleEl = itemEl.querySelector('.guess-title');
            const artistEl = itemEl.querySelector('.guess-artist');
            if (titleEl) titleEl.textContent = guess.album.title || '';
            if (artistEl) artistEl.textContent = (guess.album.artists && guess.album.artists.length > 0) ? guess.album.artists.join(', ') : 'Unknown artist';

            const cluesEl = itemEl.querySelector('.guess-clues');
            if (cluesEl) {
                cluesEl.replaceChildren();
                if (guess.correct) {
                    cluesEl.classList.add('victory');
                    const icon = document.createElement('i');
                    icon.className = 'bi bi-trophy-fill';
                    const text = document.createTextNode(' Victory!');
                    cluesEl.appendChild(icon);
                    cluesEl.appendChild(text);
                } else {
                    const icon = document.createElement('i');
                    icon.className = 'bi bi-lightbulb';
                    const text = document.createTextNode(` ${guess.cluesRevealed.length} clue(s)`);
                    cluesEl.appendChild(icon);
                    cluesEl.appendChild(text);
                }
            }

            if (!guess.correct) {
                const categories = GAME_CONFIG.clueCategories.map(c => c.key);
                const revealedByCategory = new Map();
                (guess.cluesRevealed || []).forEach(c => revealedByCategory.set(c.category, new Set(c.values)));

                const detailsEl = itemEl.querySelector('.guess-details');
                if (detailsEl) {
                    categories.forEach(catKey => {
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
                                    } else if (gyi < myi) {
                                        label = `${gyi} (before)`;
                                    } else if (gyi > myi) {
                                        label = `${gyi} (after)`;
                                    }
                                }
                            }
                            const catConf = GAME_CONFIG.clueCategories.find(c => c.key === 'release_year');
                            const attrEl = this.templates.guessAttr.content.firstElementChild.cloneNode(true);
                            const icon = attrEl.querySelector('.guess-attr-title i');
                            const lab = attrEl.querySelector('.guess-attr-label');
                            if (icon) icon.className = `bi ${catConf.icon}`;
                            if (lab) lab.textContent = catConf.label;
                            const valuesEl = attrEl.querySelector('.guess-attr-values');
                            const chip = this.templates.guessChip.content.firstElementChild.cloneNode(true);
                            chip.classList.add(cls);
                            chip.textContent = label;
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
                                    } else if (gli < mli) {
                                        label = `${this.formatSeconds(gl)} (shorter)`;
                                    } else if (gli > mli) {
                                        label = `${this.formatSeconds(gl)} (longer)`;
                                    }
                                }
                            }
                            const catConf = GAME_CONFIG.clueCategories.find(c => c.key === 'total_length_seconds');
                            const attrEl = this.templates.guessAttr.content.firstElementChild.cloneNode(true);
                            const icon = attrEl.querySelector('.guess-attr-title i');
                            const lab = attrEl.querySelector('.guess-attr-label');
                            if (icon) icon.className = `bi ${catConf.icon}`;
                            if (lab) lab.textContent = catConf.label;
                            const valuesEl = attrEl.querySelector('.guess-attr-values');
                            const chip = this.templates.guessChip.content.firstElementChild.cloneNode(true);
                            chip.classList.add(cls);
                            chip.textContent = label;
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
                        guessValues.forEach(v => {
                            const vStr = String(v);
                            const display = catKey === 'countries' ? this.getCountryName(vStr) : vStr;
                            const isCommon = revealed.has(vStr);
                            const chip = this.templates.guessChip.content.firstElementChild.cloneNode(true);
                            chip.classList.add(isCommon ? 'guess-chip-hit' : 'guess-chip-miss');
                            chip.textContent = display;
                            chips.push(chip);
                        });

                        if (catKey === 'countries') {
                            const continents = this.getContinentsForCountryCodes(guessValues);
                            const continentsRevealed = revealedByCategory.get('continents') || new Set();
                            continents.forEach(name => {
                                const chip = this.templates.guessChip.content.firstElementChild.cloneNode(true);
                                chip.classList.add(continentsRevealed.has(String(name)) ? 'guess-chip-hit' : 'guess-chip-miss');
                                chip.textContent = String(name);
                                chips.push(chip);
                            });
                        }

                        if (chips.length > 0) {
                            const attrEl = this.templates.guessAttr.content.firstElementChild.cloneNode(true);
                            const icon = attrEl.querySelector('.guess-attr-title i');
                            const lab = attrEl.querySelector('.guess-attr-label');
                            if (icon) icon.className = `bi ${catConf.icon}`;
                            if (lab) lab.textContent = catConf.label;
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
        this.elements.mysteryAlbumDisplay.replaceChildren(block);

        // Update stats
        this.elements.finalGuesses.textContent = this.guessCount;
        this.elements.finalClues.textContent = this.discoveredClues.size;

        this.elements.victoryModal.classList.add('show');

        // Persist win to user history if logged in
        this.saveWinToHistory();
    }

    hideVictoryModal() {
        this.elements.victoryModal.classList.remove('show');
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
                if (inst) instrumentsSet.add(String(inst));
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
            const locale = (typeof navigator !== 'undefined' && navigator.language) ? navigator.language : this.countryDisplayNamesLocale || 'en';
            if (!this.countryDisplayNames || this.countryDisplayNamesLocale !== locale) {
                if (typeof Intl !== 'undefined' && typeof Intl.DisplayNames === 'function') {
                    this.countryDisplayNames = new Intl.DisplayNames([locale], { type: 'region' });
                    this.countryDisplayNamesLocale = locale;
                } else {
                    this.countryDisplayNames = null;
                }
            }
            if (this.countryDisplayNames) {
                const name = this.countryDisplayNames.of(regionCode);
                if (name) return name;
            }
        } catch (e) {
            // ignore and fallback
        }
        return regionCode;
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
    async getApiAccessToken() {
        const client = await this.ensureAuth0Client();
        const audience = AUTH0_CONFIG && AUTH0_CONFIG.authorizationParams && AUTH0_CONFIG.authorizationParams.audience;
        if (!client || !audience) return null;
        try {
            return await client.getTokenSilently({ authorizationParams: { audience } });
        } catch (e) {
            console.warn('Failed to obtain API token:', e);
            return null;
        }
    }

    async fetchUserHistoryFromApi() {
        const token = await this.getApiAccessToken();
        if (!token) return [];
        const res = await fetch('/.netlify/functions/history', {
            method: 'GET',
            headers: { Authorization: `Bearer ${token}` }
        });
        if (!res.ok) {
            let details = '';
            try { details = await res.text(); } catch {}
            console.warn('history_get_failed_response:', res.status, details);
            throw new Error('history_get_failed');
        }
        return await res.json();
    }

    async saveHistoryToApi(entry) {
        const token = await this.getApiAccessToken();
        if (!token) return false;
        const res = await fetch('/.netlify/functions/history', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                Authorization: `Bearer ${token}`
            },
            body: JSON.stringify(entry)
        });
        return res.ok;
    }

    saveWinToHistory() {
        if (this.winSaved) return;
        if (!this.gameWon || !this.mysteryAlbum) return;
        if (!this.authenticatedUser) return; // only for logged-in users

        const entry = {
            objectID: this.mysteryAlbum.objectID,
            title: this.mysteryAlbum.title,
            artists: Array.isArray(this.mysteryAlbum.artists) ? this.mysteryAlbum.artists : [],
            release_year: this.mysteryAlbum.release_year || null,
            coverUrl: this.getCoverUrl(this.mysteryAlbum, 250),
            guesses: this.guessCount
        };

        this.saveHistoryToApi(entry)
            .then(ok => {
                if (ok) {
                    this.winSaved = true;
                    this.renderUserHistory();
                }
            })
            .catch(err => console.warn('save history error:', err));
    }

    async renderUserHistory() {
        const subtitleEl = this.elements.userHistorySubtitle;
        const listEl = this.elements.userHistoryList;
        if (!subtitleEl || !listEl) return;

        if (!this.authenticatedUser) {
            subtitleEl.textContent = 'Log in to save and see your history';
            listEl.replaceChildren();
            return;
        }

        subtitleEl.textContent = 'Recent wins saved to your account';
        try {
            const history = await this.fetchUserHistoryFromApi();
            if (!history || history.length === 0) {
                listEl.replaceChildren();
                const tpl = this.templates.historyEmpty;
                if (tpl) listEl.appendChild(tpl.content.firstElementChild.cloneNode(true));
                return;
            }
            listEl.replaceChildren();
            history.forEach(item => {
                const el = this.templates.historyItem.content.firstElementChild.cloneNode(true);
                const cover = el.querySelector('.history-cover');
                if (cover) {
                    if (item.coverUrl) {
                        cover.src = item.coverUrl;
                        cover.style.display = '';
                    } else {
                        cover.style.display = 'none';
                    }
                }
                const date = item.timestamp ? new Date(item.timestamp) : null;
                const meta = [
                    item.release_year ? String(item.release_year) : null,
                    `${item.guesses} guess${item.guesses === 1 ? '' : 'es'}`,
                    date && !isNaN(date.getTime()) ? date.toLocaleDateString() : null
                ].filter(Boolean).join(' • ');
                const artist = (item.artists && item.artists.length > 0) ? item.artists.join(', ') : 'Unknown artist';

                const titleEl = el.querySelector('.history-title');
                const artistEl = el.querySelector('.history-artist');
                const metaEl = el.querySelector('.history-meta');
                if (titleEl) titleEl.textContent = item.title || '';
                if (artistEl) artistEl.textContent = artist;
                if (metaEl) metaEl.textContent = meta;
                listEl.appendChild(el);
            });
        } catch (e) {
            console.warn('history render failed:', e);
            listEl.replaceChildren();
            const tplErr = this.templates.historyError;
            if (tplErr) listEl.appendChild(tplErr.content.firstElementChild.cloneNode(true));
        }
    }
}

// Initialize the game when the page loads
document.addEventListener('DOMContentLoaded', () => {
    new AlbumGuessrGame();
});
