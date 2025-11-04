import { AuthManager } from './js/shared/auth-manager.js';
import { ApiClient } from './js/shared/api-client.js';
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
        this.bindEvents();
        this.initializeGame();
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

    initializeDOM() {
        this.elements = {
            loading: document.getElementById('loading'),
            coverMask: document.getElementById('cover-mask'),
            mysteryCover: document.getElementById('mystery-cover'),
            nextHintBtn: document.getElementById('next-hint-btn'),
            albumSearch: document.getElementById('album-search'),
            searchResults: document.getElementById('search-results')
        };
        this.searchResults = [];
        this.selectedResult = null;
    }

    bindEvents() {
        if (this.elements.nextHintBtn) {
            this.elements.nextHintBtn.addEventListener('click', () => {
                this.revealNextZone();
            });
        }

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
        } else {
            // All zones revealed
            if (this.elements.nextHintBtn) {
                this.elements.nextHintBtn.disabled = true;
                this.elements.nextHintBtn.textContent = 'Tous les carrés sont révélés !';
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

        this.searchResults.forEach((result, index) => {
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
        if (!this.selectedResult) return;

        const isCorrect = this.selectedResult.objectID === this.mysteryAlbum.objectID;

        if (isCorrect) {
            // Game won - reveal all zones
            for (let i = 0; i < 16; i++) {
                this.revealZone(i);
            }
            alert('Félicitations ! Vous avez trouvé l\'album !');
        } else {
            // Wrong answer - reveal next zone
            this.revealNextZone();
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
}

document.addEventListener('DOMContentLoaded', () => {
    new CoverGuessGame();
});
