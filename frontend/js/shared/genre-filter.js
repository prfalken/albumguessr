import { i18n } from './i18n.js';

export class GenreFilter {
    constructor(containerId) {
        this.container = document.querySelector(containerId);
        if (!this.container) {
            console.error('Genre filter container not found:', containerId);
            return;
        }
        
        this.genres = [];
        this.selectedGenre = null; // null means "All genres"
        this.collapsed = false;
        
        this.init();
    }
    
    async init() {
        await this.loadGenres();
        this.render();
        this.bindEvents();
        this.loadSavedSelection();
    }
    
    async loadGenres() {
        try {
            const response = await fetch('/.netlify/functions/getAvailableGenres');
            if (!response.ok) {
                throw new Error('Failed to load genres');
            }
            const data = await response.json();
            this.genres = data.genres || [];
        } catch (error) {
            console.error('Failed to load genres:', error);
            this.genres = [];
        }
    }
    
    render() {
        if (this.genres.length === 0) {
            this.container.style.display = 'none';
            return;
        }
        
        const html = `
            <aside class="genre-filter ${this.collapsed ? 'collapsed' : ''}" role="complementary" aria-label="Genre filter">
                <div class="genre-filter-header">
                    <h3 class="genre-filter-title">
                        <i class="bi bi-music-note-list"></i>
                        <span>${this.getTranslation('genreFilter.title', 'Filter by Genre')}</span>
                    </h3>
                    <button 
                        class="genre-filter-toggle" 
                        aria-label="${this.collapsed ? 'Expand' : 'Collapse'} genre filter"
                        data-action="toggle"
                    >
                        <i class="bi bi-chevron-${this.collapsed ? 'right' : 'left'}"></i>
                    </button>
                </div>
                <div class="genre-filter-content">
                    <div class="genre-filter-list" role="list">
                        <button 
                            class="genre-filter-item ${this.selectedGenre === null ? 'active' : ''}" 
                            data-genre=""
                            role="listitem"
                        >
                            <i class="bi bi-collection"></i>
                            <span>${this.getTranslation('genreFilter.allGenres', 'All Genres')}</span>
                        </button>
                        ${this.genres.map(genre => `
                            <button 
                                class="genre-filter-item ${this.selectedGenre === genre.name ? 'active' : ''}" 
                                data-genre="${genre.name}"
                                role="listitem"
                            >
                                <i class="bi bi-vinyl"></i>
                                <span>${this.escapeHtml(genre.displayName)}</span>
                            </button>
                        `).join('')}
                    </div>
                </div>
            </aside>
            ${this.collapsed ? `
                <button 
                    class="genre-filter-expand-btn" 
                    data-action="toggle"
                    aria-label="Expand genre filter"
                    title="Filter by Genre"
                >
                    <i class="bi bi-music-note-list"></i>
                </button>
            ` : ''}
        `;
        
        this.container.innerHTML = html;
        
        // Apply i18n translations if available
        if (i18n && i18n.translatePage) {
            i18n.translatePage();
        }
    }
    
    bindEvents() {
        // Toggle collapse/expand - bind to all toggle buttons
        const toggleBtns = this.container.querySelectorAll('[data-action="toggle"]');
        toggleBtns.forEach(toggleBtn => {
            toggleBtn.addEventListener('click', () => {
                this.collapsed = !this.collapsed;
                localStorage.setItem('genreFilterCollapsed', this.collapsed);
                this.render();
                this.bindEvents();
            });
        });
        
        // Genre selection
        const genreButtons = this.container.querySelectorAll('.genre-filter-item');
        genreButtons.forEach(btn => {
            btn.addEventListener('click', () => {
                const genre = btn.getAttribute('data-genre') || null;
                this.selectGenre(genre);
            });
        });
    }
    
    selectGenre(genre) {
        const previousGenre = this.selectedGenre;
        
        // If selecting the same genre, do nothing
        if (genre === previousGenre) {
            return;
        }
        
        this.selectedGenre = genre;
        
        // Save to localStorage
        if (genre) {
            localStorage.setItem('selectedGenre', genre);
        } else {
            localStorage.removeItem('selectedGenre');
        }
        
        // Update UI
        this.render();
        this.bindEvents();
        
        // Dispatch custom event (games will listen to this and reload)
        const event = new CustomEvent('albumguessr:genre-changed', {
            detail: { genre, previousGenre }
        });
        document.dispatchEvent(event);
    }
    
    getSelectedGenre() {
        return this.selectedGenre;
    }
    
    loadSavedSelection() {
        const saved = localStorage.getItem('selectedGenre');
        if (saved) {
            this.selectedGenre = saved;
            this.render();
            this.bindEvents();
        }
        
        const collapsed = localStorage.getItem('genreFilterCollapsed');
        if (collapsed === 'true') {
            this.collapsed = true;
            this.render();
            this.bindEvents();
        }
    }
    
    getTranslation(key, fallback) {
        // Try to get translation from i18n, with fallback
        try {
            if (i18n && typeof i18n.t === 'function') {
                const translation = i18n.t(key);
                // If translation returns the key itself, use fallback
                if (translation && translation !== key) {
                    return translation;
                }
            }
        } catch (e) {
            // i18n not ready or error, use fallback
        }
        return fallback;
    }
    
    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
}

