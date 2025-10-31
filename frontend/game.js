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

        // Re-wire auth controls after header injection
        document.addEventListener('albumguessr:header-ready', async () => {
            this.elements.btnLogin = document.getElementById('btn-login');
            this.elements.btnLogout = document.getElementById('btn-logout');
            this.elements.userProfile = document.getElementById('user-profile');
            this.elements.userAvatar = document.getElementById('user-avatar');
            this.elements.userName = document.getElementById('user-name');
            this.elements.navStatistics = document.getElementById('nav-statistics');
            this.bindAuthButtons();
            try {
                await this.ensureAuth0Client();
                const authed = this.auth0Client ? await this.auth0Client.isAuthenticated() : false;
                this.updateAuthUI(!!authed);
                await this.refreshHeaderUsernameFromDb();
            } catch (_) {}
        });
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
                    const result = await this.auth0Client.handleRedirectCallback();
                    // Redirect to the page the user was on before login
                    const returnTo = (result.appState && result.appState.returnTo) ? result.appState.returnTo : '/';
                    window.history.replaceState({}, document.title, returnTo);
                } catch (e) {
                    console.warn('Auth0 redirect callback failed:', e);
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
            await this.refreshHeaderUsernameFromDb();
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
        const maxAttempts = 5;
        let lastError = null;
        for (let attempt = 1; attempt <= maxAttempts; attempt++) {
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

        

        // Modal events
        this.elements.closeVictory.addEventListener('click', () => this.hideVictoryModal());
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

        // Close modals on background click
        if (this.elements.victoryModal) {
            this.elements.victoryModal.addEventListener('click', (e) => {
                if (e.target === this.elements.victoryModal) {
                    this.hideVictoryModal();
                }
            });
        }

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
        this.bindAuthButtons();
    }

    bindAuthButtons() {
        if (this.elements && this.elements.btnLogin) {
            this.elements.btnLogin.addEventListener('click', () => this.login());
        }
        if (this.elements && this.elements.btnLogout) {
            this.elements.btnLogout.addEventListener('click', () => this.logout());
        }
    }

    async ensureAuth0Client() {
        if (this.auth0Client) return this.auth0Client;
        try {
            if (typeof AUTH0_CONFIG === 'object' && AUTH0_CONFIG) {
                if (typeof auth0 === 'undefined') {
                    await this.loadAuth0Library();
                }
                if (typeof auth0 === 'undefined') {
                    return null;
                }
                this.auth0Client = await auth0.createAuth0Client(AUTH0_CONFIG);
                return this.auth0Client;
            }
        } catch (e) {
            console.warn('Unable to create Auth0 client:', e);
        }
        return null;
    }

    async loadAuth0Library() {
        // Dynamically load Auth0 SPA SDK if the CDN script failed to load
        return new Promise((resolve) => {
            try {
                if (typeof auth0 !== 'undefined') return resolve();
                const existing = document.querySelector('script[data-auth0-spa]');
                if (existing) {
                    existing.addEventListener('load', () => resolve());
                    existing.addEventListener('error', () => resolve());
                    return;
                }
                const script = document.createElement('script');
                script.src = 'https://cdn.auth0.com/js/auth0-spa-js/2.1/auth0-spa-js.production.js';
                script.async = true;
                script.defer = true;
                script.setAttribute('data-auth0-spa', 'true');
                script.onload = () => resolve();
                script.onerror = () => resolve();
                document.head.appendChild(script);
            } catch (_) {
                resolve();
            }
        });
    }

    async login() {
        const client = await this.ensureAuth0Client();
        if (!client) {
            alert('Login is currently unavailable. Please try again later.');
            return;
        }
        await client.loginWithRedirect({
            authorizationParams: { redirect_uri: window.location.origin },
            appState: { returnTo: window.location.pathname }
        });
    }

    async logout() {
        const client = await this.ensureAuth0Client();
        if (!client) {
            alert('Logout is currently unavailable. Please try again later.');
            return;
        }
        client.logout({ logoutParams: { returnTo: window.location.origin } });
    }

    updateAuthUI(isAuthenticated) {
        const show = (el, visible) => { if (el) el.style.display = visible ? '' : 'none'; };
        show(this.elements.btnLogin, !isAuthenticated);
        show(this.elements.btnLogout, !!isAuthenticated);
        show(this.elements.navStatistics, !!isAuthenticated);
        if (isAuthenticated && this.authenticatedUser) {
            if (this.elements.userAvatar) {
                this.elements.userAvatar.src = this.authenticatedUser.picture || '';
                // Add error handler to prevent repeated failed loads
                this.elements.userAvatar.onerror = () => {
                    this.elements.userAvatar.style.display = 'none';
                    this.elements.userAvatar.onerror = null; // Prevent infinite loop
                };
                // Reset display in case it was hidden before
                this.elements.userAvatar.style.display = '';
            }
            if (this.elements.userName) {
                // Show custom username if set, otherwise fall back to name or email
                const displayName = this.authenticatedUser.user_metadata?.custom_username || 
                                   this.authenticatedUser.name || 
                                   this.authenticatedUser.email || '';
                this.elements.userName.textContent = displayName;
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

    async refreshHeaderUsernameFromDb() {
        try {
            if (!this.authenticatedUser || !this.elements || !this.elements.userName) return;
            const token = await this.getApiAccessToken();
            if (!token) return;
            const response = await fetch('/.netlify/functions/updateProfile', {
                method: 'GET',
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (!response.ok) return;
            const profileData = await response.json();
            const dbUsername = profileData && profileData.custom_username;
            if (dbUsername) {
                this.elements.userName.textContent = String(dbUsername);
            }
        } catch (_) {}
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
                    'cover_art_url', 'label', 'total_length_seconds'
                ]
            });

            this.searchResults = searchResponse.hits.map(hit => {
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
        if (this.elements.searchSubmit) this.elements.searchSubmit.disabled = true;

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
            const valuesEl = catEl.querySelector('.clue-values');
            if (valuesEl) {
                // Single icon before all values
                const iconEl = document.createElement('i');
                iconEl.className = `bi ${catConf.icon}`;
                valuesEl.appendChild(iconEl);

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
        console.log('getApiAccessToken: client=', !!client, 'audience=', audience);
        if (!client) {
            console.warn('getApiAccessToken: No Auth0 client available');
            return null;
        }
        if (!audience) {
            console.warn('getApiAccessToken: No audience configured in AUTH0_CONFIG.authorizationParams.audience');
            return null;
        }
        try {
            const token = await client.getTokenSilently({ authorizationParams: { audience } });
            console.log('getApiAccessToken: Successfully obtained token');
            return token;
        } catch (e) {
            console.error('getApiAccessToken: Failed to obtain API token:', e);
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
        if (!token) {
            console.warn('saveHistoryToApi: No token available, cannot save history');
            return false;
        }
        console.log('saveHistoryToApi: Sending entry to API:', entry);
        const res = await fetch('/.netlify/functions/history', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                Authorization: `Bearer ${token}`
            },
            body: JSON.stringify(entry)
        });
        if (!res.ok) {
            const text = await res.text();
            console.error('saveHistoryToApi: Failed to save history:', res.status, text);
        } else {
            console.log('saveHistoryToApi: Successfully saved to history');
        }
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
            guesses: this.guessCount,
            userProfile: {
                custom_username: this.authenticatedUser.user_metadata?.custom_username || null,
                email: this.authenticatedUser.email || null,
                picture: this.authenticatedUser.picture || null
            }
        };

        this.saveHistoryToApi(entry)
            .then(ok => {
                if (ok) {
                    this.winSaved = true;
                    this.renderUserHistory();
                    
                    // Show toast suggesting username setup if user doesn't have a custom username
                    const hasCustomUsername = this.authenticatedUser.user_metadata?.custom_username;
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
}
