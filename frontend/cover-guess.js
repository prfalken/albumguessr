import { AuthManager } from './js/shared/auth-manager.js';
import { ApiClient } from './js/shared/api-client.js';
import { i18n } from './js/shared/i18n.js';
// ALGOLIA_CONFIG is loaded globally via script tag in HTML

class CoverGuessGame {
    constructor() {
        this.algoliaClient = null;
        this.algoliaIndex = null;
        this.authManager = new AuthManager();
        this.apiClient = new ApiClient(this.authManager);
        this.mysteryAlbum = null;
        this.revealedZones = new Set(); // Set of revealed zone indices (0-15)
        this.zoneOrder = []; // Random order of zones to reveal
        
        this.initializeAlgolia();
        this.authManager.initializeAuth0();
        this.initializeDOM();
        this.postDomAuthSetup();
        this.bindEvents();
        this.initializeGame();

        // Re-wire auth controls after header injection
        const setupAuthAfterHeaderReady = async () => {
            this.refreshAuthElements();
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
            } catch (err) {
                console.warn('Auth setup failed:', err);
            }
        };

        // Check if header is already ready (event might have fired before we registered listener)
        if (document.getElementById('btn-login')) {
            // Header already injected, setup auth immediately
            setupAuthAfterHeaderReady();
        } else {
            // Wait for header injection event
            document.addEventListener('albumguessr:header-ready', setupAuthAfterHeaderReady);
        }
    }

    initializeAlgolia() {
        try {
            this.algoliaClient = window.algoliasearch(
                ALGOLIA_CONFIG.applicationId,
                ALGOLIA_CONFIG.apiKey
            );
            this.algoliaIndex = this.algoliaClient.initIndex(ALGOLIA_CONFIG.indexName);
            console.log('Algolia initialized successfully');
        } catch (error) {
            console.error('Failed to initialize Algolia:', error);
        }
    }

    refreshAuthElements() {
        this.elements.btnLogin = document.getElementById('btn-login');
        this.elements.btnLogout = document.getElementById('btn-logout');
        this.elements.userProfile = document.getElementById('user-profile');
        this.elements.userAvatar = document.getElementById('user-avatar');
        this.elements.userName = document.getElementById('user-name');
        this.elements.navStatistics = document.getElementById('nav-statistics');
        this.elements.navReportBug = document.getElementById('nav-report-bug');
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
        } catch (err) {
            console.warn('Auth0 post-DOM setup skipped or failed (cover-guess):', err);
        }
    }

    initializeDOM() {
        this.elements = {
            btnLogin: null,
            btnLogout: null,
            userProfile: null,
            userAvatar: null,
            userName: null,
            navStatistics: null,
            navReportBug: null,
            loading: document.getElementById('loading'),
            coverMask: document.getElementById('cover-mask'),
            mysteryCover: document.getElementById('mystery-cover'),
            albumSearch: document.getElementById('album-search'),
            searchResults: document.getElementById('search-results'),
            nextHintBtn: document.getElementById('next-hint-btn'),
            guessesHistory: document.getElementById('guesses-history'),
            guessesContainer: document.getElementById('guesses-container')
        };
        this.templates = {
            guessItem: document.getElementById('tpl-guess-item'),
            mysteryAlbum: document.getElementById('tpl-mystery-album')
        };
        this.searchResults = [];
        this.selectedResult = null;
        this.guessCount = 0;
        this.guesses = [];
        this.gameWon = false;
        this.gameOver = false;
        this.initialPoints = 16; // 1 point per square
        this.finalPoints = null; // Points at the moment of victory
    }

    bindEvents() {
        // Listen for language changes to update victory/defeat messages
        document.addEventListener('albumguessr:language-changed', () => {
            // Re-render victory/defeat messages if game is over
            if (this.gameWon || this.gameOver) {
                setTimeout(() => {
                    if (this.gameWon) {
                        this.updateGuessesHistory();
                    } else {
                        this.showDefeatMessage();
                    }
                }, 100);
            }
        });
        // Search input events
        if (this.elements.albumSearch) {
            this.elements.albumSearch.addEventListener('input', 
                this.debounce(this.handleSearchInput.bind(this), 300)
            );
            
            this.elements.albumSearch.addEventListener('keydown', (e) => {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    if (this.selectedResult) {
                        this.submitGuess();
                    }
                }
            });
        }

        // Next hint button
        if (this.elements.nextHintBtn) {
            this.elements.nextHintBtn.addEventListener('click', () => {
                this.revealNextZone();
            });
        }
    }

    async initializeGame() {
        this.showLoading(true);
        try {
            await this.selectRandomAlbum();
            this.setupCoverReveal();
            this.showLoading(false);
        } catch (error) {
            console.error('Failed to initialize game:', error);
            this.showLoading(false);
        }
    }

    async selectRandomAlbum() {
        try {
            const res = await fetch('/.netlify/functions/randomAlbum', { cache: 'no-store' });
            if (!res.ok) {
                throw new Error('Failed to load album');
            }
            const data = await res.json();
            const objectID = data && data.objectID;
            if (!objectID) throw new Error('Invalid album payload');

            if (!this.algoliaIndex) throw new Error('Algolia index not initialized');

            this.mysteryAlbum = await this.algoliaIndex.getObject(objectID, { 
                attributesToRetrieve: ['objectID', 'title', 'artists', 'cover_art_url']
            });
            
            console.log('Selected album:', this.mysteryAlbum);
        } catch (error) {
            console.error('Failed to select album:', error);
            throw error;
        }
    }

    setupCoverReveal() {
        if (!this.mysteryAlbum || !this.mysteryAlbum.cover_art_url) {
            throw new Error('No cover art available');
        }

        // Create random order for zone revelation (0-15 for 4x4 grid = 16 zones)
        this.zoneOrder = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15].sort(() => Math.random() - 0.5);
        
        // Initially all zones are hidden
        this.revealedZones.clear();
        this.finalPoints = null; // Reset points for new game

        // Set the cover image
        this.elements.mysteryCover.src = this.mysteryAlbum.cover_art_url;
        
        // Reveal first zone immediately
        requestAnimationFrame(() => {
            this.revealFirstZone();
        });
    }

    revealFirstZone() {
        if (this.zoneOrder.length > 0) {
            const firstZone = this.zoneOrder[0];
            this.revealZone(firstZone);
        }
    }

    revealZone(zoneIndex) {
        if (this.revealedZones.has(zoneIndex)) {
            return; // Zone already revealed
        }

        this.revealedZones.add(zoneIndex);
        const zoneElement = this.elements.coverMask.querySelector(`[data-zone="${zoneIndex}"]`);
        if (zoneElement) {
            zoneElement.classList.add('revealed');
        }
    }

    revealNextZone() {
        const nextZoneIndex = this.revealedZones.size;
        if (nextZoneIndex < this.zoneOrder.length) {
            const nextZone = this.zoneOrder[nextZoneIndex];
            this.revealZone(nextZone);
            
            // Check if all zones are revealed and game is not won
            if (this.revealedZones.size === 16 && !this.gameWon) {
                // Calculate points before marking game as over (should be 0 at this point)
                this.finalPoints = this.calculatePoints();
                this.gameOver = true;
                this.updateGuessesHistory();
                this.showDefeatMessage();
            }
        } else {
            // All zones revealed
            if (this.elements.nextHintBtn) {
                this.elements.nextHintBtn.disabled = true;
                this.elements.nextHintBtn.textContent = 'Tous les carrés sont révélés !';
            }
            if (!this.gameWon) {
                // Calculate points before marking game as over (should be 0 at this point)
                this.finalPoints = this.calculatePoints();
                this.gameOver = true;
                this.updateGuessesHistory();
                this.showDefeatMessage();
            }
        }
    }

    showLoading(show) {
        if (this.elements.loading) {
            this.elements.loading.style.display = show ? 'flex' : 'none';
        }
    }

    async handleSearchInput(e) {
        const query = e.target.value.trim();
        if (!query || query.length < 2) {
            this.hideSearchResults();
            this.selectedResult = null;
            return;
        }

        try {
            const results = await this.algoliaIndex.search(query, {
                hitsPerPage: 8,
                attributesToRetrieve: ['objectID', 'title', 'artists', 'cover_art_url']
            });

            this.searchResults = results.hits || [];
            this.displaySearchResults();
        } catch (error) {
            console.error('Search error:', error);
            this.hideSearchResults();
        }
    }

    displaySearchResults() {
        const container = this.elements.searchResults;
        container.replaceChildren();

        if (this.searchResults.length === 0) {
            container.classList.remove('show');
            return;
        }

        // Filtrer les albums déjà proposés
        const proposedObjectIDs = new Set(this.guesses.map(guess => guess.album.objectID));
        const filteredResults = this.searchResults.filter(result => !proposedObjectIDs.has(result.objectID));

        if (filteredResults.length === 0) {
            container.classList.remove('show');
            return;
        }

        filteredResults.forEach((result, index) => {
            const el = document.createElement('div');
            el.className = 'search-result';
            if (index === 0) {
                el.classList.add('selected');
                this.selectedResult = result;
            }

            el.innerHTML = `
                <div class="search-result-text">
                    <div class="search-result-title">${result.title || ''}</div>
                    <div class="search-result-artist">${(result.artists || []).join(', ') || 'Unknown'}</div>
                </div>
            `;

            el.addEventListener('click', () => {
                container.querySelectorAll('.search-result').forEach(r => r.classList.remove('selected'));
                el.classList.add('selected');
                this.selectedResult = result;
                this.submitGuess();
            });

            container.appendChild(el);
        });

        container.classList.add('show');
    }

    hideSearchResults() {
        this.elements.searchResults.classList.remove('show');
    }

    submitGuess() {
        if (!this.selectedResult || this.gameWon || this.gameOver) return;

        this.guessCount++;
        const isCorrect = this.selectedResult.objectID === this.mysteryAlbum.objectID;

        // Add guess to history
        const guess = {
            album: this.selectedResult,
            correct: isCorrect,
            guessNumber: this.guessCount
        };
        this.guesses.push(guess);

        if (isCorrect) {
            // Game won - calculate points BEFORE revealing all zones
            const finalPoints = this.calculatePoints();
            
            // Reveal all zones for visual effect
            this.gameWon = true;
            for (let i = 0; i < 16; i++) {
                this.revealZone(i);
            }
            
            // Store the points at the moment of victory
            this.finalPoints = finalPoints;
            
            // Wait for DOM to update before showing victory
            setTimeout(() => {
                this.celebrateVictory();
                this.updateGuessesHistory();
                this.saveWinToHistory();
            }, 100);
        } else {
            // Wrong answer - reveal next zone (don't show guess in history)
            this.revealNextZone();
            // Don't call updateGuessesHistory() here - guesses should only be shown at the end
        }

        this.elements.albumSearch.value = '';
        this.hideSearchResults();
        this.selectedResult = null;
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

    updateGuessesHistory() {
        if (!this.elements.guessesContainer) return;

        // Hide search, hint button, cover image and title when game is won or over
        if (this.gameWon || this.gameOver) {
            if (this.elements.albumSearch && this.elements.albumSearch.parentElement) {
                this.elements.albumSearch.parentElement.parentElement.style.display = 'none';
            }
            if (this.elements.nextHintBtn) {
                this.elements.nextHintBtn.style.display = 'none';
            }
            // Hide the cover reveal container
            const coverRevealContainer = document.querySelector('.cover-reveal-container');
            if (coverRevealContainer) {
                coverRevealContainer.style.display = 'none';
            }
            // Hide the game title
            const gameTitle = document.querySelector('.cover-guess-wrapper h2');
            if (gameTitle) {
                gameTitle.style.display = 'none';
            }
        }

        this.elements.guessesContainer.replaceChildren();

        // Only show victory message if game is won, no guess-item history
        if (this.gameWon && this.mysteryAlbum) {
            // Create wrapper div with victory class for styling
            const victoryWrapper = document.createElement('div');
            victoryWrapper.className = 'guess-item victory';

            const mysteryAlbumTpl = this.templates.mysteryAlbum;
            if (mysteryAlbumTpl) {
                const mysteryAlbumBlock = mysteryAlbumTpl.content.firstElementChild.cloneNode(true);
                // Remove margin-bottom on mystery-album for victory/defeat boxes
                mysteryAlbumBlock.style.marginBottom = '0';
                const titleEl = mysteryAlbumBlock.querySelector('.mystery-album-title');
                const artistEl = mysteryAlbumBlock.querySelector('.mystery-album-artist');
                const coverEl = mysteryAlbumBlock.querySelector('.mystery-album-cover');
                const metaEl = mysteryAlbumBlock.querySelector('.mystery-album-meta');

                // Add congratulations message (no title)
                const congratulationsMessage = document.createElement('div');
                congratulationsMessage.className = 'victory-congratulations-message';
                const victoryText = i18n.t('game.coverGuess.victoryMessage');
                congratulationsMessage.innerHTML = `<strong>${victoryText}</strong>`;

                mysteryAlbumBlock.insertBefore(congratulationsMessage, mysteryAlbumBlock.firstChild);

                // Set cover image
                if (coverEl) {
                    coverEl.src = this.mysteryAlbum.cover_art_url || '';
                    if (this.mysteryAlbum.cover_art_url) {
                        coverEl.style.display = '';
                    } else {
                        coverEl.style.display = 'none';
                    }
                }

                // Set title and artist
                if (titleEl) titleEl.textContent = this.mysteryAlbum.title || '';
                if (artistEl) {
                    artistEl.textContent = (this.mysteryAlbum.artists && this.mysteryAlbum.artists.length > 0) ? this.mysteryAlbum.artists.join(', ') : i18n.t('game.unknownArtist');
                    // Reduce margin-bottom to reduce space between album and stats
                    artistEl.style.marginBottom = '0.25rem';
                }

                // Hide meta in victory guess
                if (metaEl) {
                    metaEl.style.display = 'none';
                }

                // Add stats
                const statsContainer = document.createElement('div');
                statsContainer.className = 'victory-stats';
                statsContainer.style.display = 'flex';
                statsContainer.style.flexDirection = 'column';
                statsContainer.style.gap = '1rem';
                statsContainer.style.marginTop = '0.25rem';

                // Add points stat (inline: label and value on same line, bigger font)
                const pointsStat = document.createElement('div');
                pointsStat.style.display = 'flex';
                pointsStat.style.flexDirection = 'row'; // Label and value on same line
                pointsStat.style.alignItems = 'center';
                pointsStat.style.justifyContent = 'center';
                pointsStat.style.gap = '0.5rem';
                const pointsLabelText = document.createElement('span');
                pointsLabelText.style.fontSize = '1.2rem';
                pointsLabelText.style.color = 'rgba(0, 0, 0, 0.7)';
                pointsLabelText.textContent = i18n.t('game.coverGuess.points');
                const pointsValueText = document.createElement('span');
                pointsValueText.style.fontSize = '2rem';
                pointsValueText.style.fontWeight = '700';
                pointsValueText.style.color = '#000';
                const points = this.calculatePoints();
                pointsValueText.textContent = points;
                pointsStat.appendChild(pointsLabelText);
                pointsStat.appendChild(pointsValueText);

                statsContainer.appendChild(pointsStat);

                // Add ranking message (two lines)
                const rankingContainer = document.createElement('div');
                rankingContainer.style.display = 'flex';
                rankingContainer.style.flexDirection = 'column';
                rankingContainer.style.alignItems = 'center';
                rankingContainer.style.justifyContent = 'center';
                rankingContainer.style.gap = '0.1rem';
                rankingContainer.style.fontSize = '1.2rem';
                rankingContainer.style.textAlign = 'center';

                const rankingLine1 = document.createElement('div');
                rankingLine1.innerHTML = i18n.t('game.coverGuess.rankingLine1Loading');
                const rankingLine2 = document.createElement('div');
                rankingLine2.innerHTML = i18n.t('game.coverGuess.rankingLine2Loading');

                rankingContainer.appendChild(rankingLine1);
                rankingContainer.appendChild(rankingLine2);
                statsContainer.appendChild(rankingContainer);

                // Fetch ranking position and total points asynchronously
                this.fetchRankingPositionAndPoints(rankingLine1, rankingLine2);

                // Add share section
                const shareSection = document.createElement('div');
                shareSection.className = 'victory-share-section';

                const playAgainBtn = document.createElement('button');
                playAgainBtn.className = 'share-button';
                playAgainBtn.innerHTML = `<i class="bi bi-arrow-repeat"></i> ${i18n.t('game.coverGuess.playAgain')}`;
                playAgainBtn.addEventListener('click', () => {
                    window.location.reload();
                });
                shareSection.appendChild(playAgainBtn);

                const rankingBtn = document.createElement('button');
                rankingBtn.className = 'share-button';
                rankingBtn.innerHTML = `<i class="bi bi-trophy-fill"></i> ${i18n.t('game.coverGuess.viewRanking')}`;
                rankingBtn.addEventListener('click', () => {
                    window.location.href = '/cover-guess-ranking.html';
                });
                shareSection.appendChild(rankingBtn);

                victoryWrapper.appendChild(mysteryAlbumBlock);
                victoryWrapper.appendChild(statsContainer);
                victoryWrapper.appendChild(shareSection);
                this.elements.guessesContainer.appendChild(victoryWrapper);
            }
        }
    }

    showDefeatMessage() {
        if (!this.elements.guessesContainer || !this.mysteryAlbum) return;

        // Hide search, hint button and cover image when game is over
        if (this.elements.albumSearch && this.elements.albumSearch.parentElement) {
            this.elements.albumSearch.parentElement.parentElement.style.display = 'none';
        }
        if (this.elements.nextHintBtn) {
            this.elements.nextHintBtn.style.display = 'none';
        }
        // Hide the cover reveal container
        const coverRevealContainer = document.querySelector('.cover-reveal-container');
        if (coverRevealContainer) {
            coverRevealContainer.style.display = 'none';
        }
        // Hide the game title
        const gameTitle = document.querySelector('.cover-guess-wrapper h2');
        if (gameTitle) {
            gameTitle.style.display = 'none';
        }

        // Clear container first to remove any guess-items
        this.elements.guessesContainer.replaceChildren();

        // Create wrapper div with victory class for styling (same style for defeat)
        const defeatWrapper = document.createElement('div');
        defeatWrapper.className = 'guess-item victory';

        const mysteryAlbumTpl = this.templates.mysteryAlbum;
        if (mysteryAlbumTpl) {
            const mysteryAlbumBlock = mysteryAlbumTpl.content.firstElementChild.cloneNode(true);
            // Remove margin-bottom on mystery-album for victory/defeat boxes
            mysteryAlbumBlock.style.marginBottom = '0';
            const titleEl = mysteryAlbumBlock.querySelector('.mystery-album-title');
            const artistEl = mysteryAlbumBlock.querySelector('.mystery-album-artist');
            const coverEl = mysteryAlbumBlock.querySelector('.mystery-album-cover');
            const metaEl = mysteryAlbumBlock.querySelector('.mystery-album-meta');

            // Add defeat message (no title)
            const defeatMessage = document.createElement('div');
            defeatMessage.className = 'victory-congratulations-message';
            const defeatText = i18n.t('game.coverGuess.defeatMessage');
            defeatMessage.innerHTML = `<strong>${defeatText}</strong>`;

            mysteryAlbumBlock.insertBefore(defeatMessage, mysteryAlbumBlock.firstChild);

            // Set cover image
            if (coverEl) {
                coverEl.src = this.mysteryAlbum.cover_art_url || '';
                if (this.mysteryAlbum.cover_art_url) {
                    coverEl.style.display = '';
                } else {
                    coverEl.style.display = 'none';
                }
            }

            // Set title and artist
            if (titleEl) titleEl.textContent = this.mysteryAlbum.title || '';
            if (artistEl) {
                artistEl.textContent = (this.mysteryAlbum.artists && this.mysteryAlbum.artists.length > 0) ? this.mysteryAlbum.artists.join(', ') : i18n.t('game.unknownArtist');
                // Reduce margin-bottom to reduce space between album and stats
                artistEl.style.marginBottom = '0.25rem';
            }

            // Hide meta in defeat message
            if (metaEl) {
                metaEl.style.display = 'none';
            }

            // Add stats (points)
            const statsContainer = document.createElement('div');
            statsContainer.className = 'victory-stats';
            statsContainer.style.display = 'flex';
            statsContainer.style.flexDirection = 'column';
            statsContainer.style.gap = '1rem';
            statsContainer.style.marginTop = '0.25rem';

            // Add points stat (inline: label and value on same line, bigger font)
            const pointsStat = document.createElement('div');
            pointsStat.style.display = 'flex';
            pointsStat.style.flexDirection = 'row'; // Label and value on same line
            pointsStat.style.alignItems = 'center';
            pointsStat.style.justifyContent = 'center';
            pointsStat.style.gap = '0.5rem';
            const pointsLabelText = document.createElement('span');
            pointsLabelText.style.fontSize = '1.2rem';
            pointsLabelText.style.color = 'rgba(0, 0, 0, 0.7)';
            pointsLabelText.textContent = i18n.t('game.coverGuess.points');
            const pointsValueText = document.createElement('span');
            pointsValueText.style.fontSize = '2rem';
            pointsValueText.style.fontWeight = '700';
            pointsValueText.style.color = '#000';
            const points = this.calculatePoints();
            pointsValueText.textContent = points;
            pointsStat.appendChild(pointsLabelText);
            pointsStat.appendChild(pointsValueText);

            statsContainer.appendChild(pointsStat);

            // Add ranking message (two lines)
            const rankingContainer = document.createElement('div');
            rankingContainer.style.display = 'flex';
            rankingContainer.style.flexDirection = 'column';
            rankingContainer.style.alignItems = 'center';
            rankingContainer.style.justifyContent = 'center';
            rankingContainer.style.gap = '0.1rem';
            rankingContainer.style.fontSize = '1.2rem';
            rankingContainer.style.textAlign = 'center';

            const rankingLine1 = document.createElement('div');
            rankingLine1.innerHTML = i18n.t('game.coverGuess.rankingLine1Loading');
            const rankingLine2 = document.createElement('div');
            rankingLine2.innerHTML = i18n.t('game.coverGuess.rankingLine2Loading');

            rankingContainer.appendChild(rankingLine1);
            rankingContainer.appendChild(rankingLine2);
            statsContainer.appendChild(rankingContainer);

            // Fetch ranking position and total points asynchronously
            this.fetchRankingPositionAndPoints(rankingLine1, rankingLine2);

            // Add share section
            const shareSection = document.createElement('div');
            shareSection.className = 'victory-share-section';

            const playAgainBtn = document.createElement('button');
            playAgainBtn.className = 'share-button';
            playAgainBtn.innerHTML = `<i class="bi bi-arrow-repeat"></i> ${i18n.t('game.coverGuess.playAgain')}`;
            playAgainBtn.addEventListener('click', () => {
                window.location.reload();
            });
            shareSection.appendChild(playAgainBtn);

            const rankingBtn = document.createElement('button');
            rankingBtn.className = 'share-button';
            rankingBtn.innerHTML = `<i class="bi bi-trophy-fill"></i> ${i18n.t('game.coverGuess.viewRanking')}`;
            rankingBtn.addEventListener('click', () => {
                window.location.href = '/cover-guess-ranking.html';
            });
            shareSection.appendChild(rankingBtn);

            defeatWrapper.appendChild(mysteryAlbumBlock);
            defeatWrapper.appendChild(statsContainer);
            defeatWrapper.appendChild(shareSection);
            this.elements.guessesContainer.appendChild(defeatWrapper);
        }
    }

    calculatePoints() {
        // If we already calculated final points at victory, use that
        if (this.finalPoints !== null) {
            return this.finalPoints;
        }
        // Start with 16 points, minus 1 point per revealed square
        const revealedCount = this.revealedZones.size;
        const points = Math.max(0, this.initialPoints - revealedCount);
        return points;
    }

    async fetchRankingPositionAndPoints(rankingLine1Element, rankingLine2Element) {
        try {
            const userId = this.authManager.authenticatedUser?.sub;
            if (!userId) {
                rankingLine1Element.innerHTML = i18n.t('game.coverGuess.rankingLine1Loading');
                rankingLine2Element.innerHTML = i18n.t('game.coverGuess.rankingLine2Loading');
                return;
            }

            const response = await fetch('/.netlify/functions/coverGuessRanking');
            if (!response.ok) {
                rankingLine1Element.innerHTML = i18n.t('game.coverGuess.rankingLine1Loading');
                rankingLine2Element.innerHTML = i18n.t('game.coverGuess.rankingLine2Loading');
                return;
            }

            const data = await response.json();
            if (data.ranking && Array.isArray(data.ranking)) {
                // Find current user's position in ranking
                const userIndex = data.ranking.findIndex(r => r.user_id === userId);
                if (userIndex !== -1) {
                    const userRanking = data.ranking[userIndex];
                    const position = userIndex + 1; // Position is index + 1 (1-based ranking)
                    const totalPoints = userRanking.total_points || 0;
                    // Replace {position} and {points} in the translated templates
                    const line1Template = i18n.t('game.coverGuess.rankingLine1');
                    const line2Template = i18n.t('game.coverGuess.rankingLine2');
                    rankingLine1Element.innerHTML = line1Template.replace('{position}', position);
                    rankingLine2Element.innerHTML = line2Template.replace('{points}', totalPoints);
                } else {
                    rankingLine1Element.innerHTML = i18n.t('game.coverGuess.rankingLine1Loading');
                    rankingLine2Element.innerHTML = i18n.t('game.coverGuess.rankingLine2Loading');
                }
            } else {
                rankingLine1Element.innerHTML = i18n.t('game.coverGuess.rankingLine1Loading');
                rankingLine2Element.innerHTML = i18n.t('game.coverGuess.rankingLine2Loading');
            }
        } catch (error) {
            console.warn('Failed to fetch ranking position and points:', error);
            rankingLine1Element.innerHTML = i18n.t('game.coverGuess.rankingLine1Loading');
            rankingLine2Element.innerHTML = i18n.t('game.coverGuess.rankingLine2Loading');
        }
    }

    async saveWinToHistory() {
        if (!this.gameWon || !this.mysteryAlbum) return;
        if (!this.authManager || !this.authManager.authenticatedUser) return;
        if (!this.apiClient) return;

        const points = this.calculatePoints();

        const entry = {
            objectID: this.mysteryAlbum.objectID,
            title: this.mysteryAlbum.title,
            artists: Array.isArray(this.mysteryAlbum.artists) ? this.mysteryAlbum.artists : [],
            release_year: this.mysteryAlbum.release_year || null,
            coverUrl: this.mysteryAlbum.cover_art_url || null,
            guesses: this.guessCount,
            gameMode: 'cover-guess',
            points: points,
            userProfile: {
                custom_username: this.authManager.customUsername || null,
                email: this.authManager.authenticatedUser.email || null,
                picture: this.authManager.authenticatedUser.picture || null
            }
        };

        try {
            await this.apiClient.saveHistoryEntry(entry);
            console.log('Win saved to history with points:', points);
        } catch (error) {
            console.error('Failed to save win to history:', error);
        }
    }

    celebrateVictory() {
        // Play victory sound
        this.playVictorySound();
        
        // Create confetti animation
        this.createConfetti();
    }

    playVictorySound() {
        try {
            const audio = new Audio('sounds/pow-pow-pow.mp3');
            audio.volume = 0.6;
            audio.play().catch(error => {
                console.warn('Could not play victory sound:', error);
            });
        } catch (error) {
            console.warn('Could not play victory sound:', error);
        }
    }

    createConfetti() {
        // Find the mystery album cover
        let centerX = window.innerWidth / 2;
        let centerY = window.innerHeight / 2;
        
        const coverImage = this.elements.mysteryCover;
        if (coverImage) {
            const rect = coverImage.getBoundingClientRect();
            centerX = rect.left + rect.width / 2;
            centerY = rect.top + rect.height / 2;
        }
        
        const colors = ['#ffd41d', '#ff6b6b', '#4ecdc4', '#45b7d1', '#ffa07a', '#98d8c8', '#f7dc6f', '#bb8fce'];
        const confettiCount = 100;
        const duration = 2400;
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
            
            confettiContainer.appendChild(confetti);
            
            // Add keyframes for this confetti piece
            keyframesCSS += `
                @keyframes confettiExplode${i} {
                    0% {
                        transform: translate(-50%, -50%) translate(0, 0) rotate(0deg);
                        opacity: 1;
                    }
                    100% {
                        transform: translate(-50%, -50%) translate(${endX}px, ${endY}px) rotate(${endRotation}deg);
                        opacity: 0;
                    }
                }
            `;
        }
        
        // Add all keyframes to the style element
        styleEl.textContent = keyframesCSS;
        document.head.appendChild(styleEl);
        
        // Clean up confetti after animation
        setTimeout(() => {
            confettiContainer.innerHTML = '';
            if (oldStyle) oldStyle.remove();
        }, duration + 500);
    }

    shareResult() {
        if (!this.mysteryAlbum) return;
        // Note: This function is kept for potential future use, but share button was removed
        const albumInfo = `"${this.mysteryAlbum.title}" ${i18n.getCurrentLanguage() === 'fr' ? 'par' : i18n.getCurrentLanguage() === 'es' ? 'por' : 'by'} ${this.mysteryAlbum.artists ? this.mysteryAlbum.artists.join(', ') : i18n.t('game.unknownArtist')}`;
        const guessWord = this.guessCount === 1 ? i18n.t('game.guessCounterSingle') : i18n.t('game.guessCounter');
        const stats = `${this.guessCount} ${guessWord}`;
        const foundText = i18n.getCurrentLanguage() === 'fr' ? 'J\'ai trouvé l\'album mystère !' : i18n.getCurrentLanguage() === 'es' ? '¡Encontré el álbum misterioso!' : 'I found the mystery album!';
        const shareText = `🎵 ${foundText}\n\n${albumInfo}\n${stats}\n\n🎵 AlbumGuessr 🎵`;

        if (navigator.share) {
            navigator.share({
                title: 'AlbumGuessr',
                text: shareText
            });
        } else {
            // Fallback: copy to clipboard
            navigator.clipboard.writeText(shareText).then(() => {
                alert('Résultat copié dans le presse-papiers !');
            }).catch(() => {
                alert('Impossible de copier le résultat. Vous pouvez le partager manuellement :\n\n' + shareText);
            });
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new CoverGuessGame();
});
