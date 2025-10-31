import { AuthManager } from './js/shared/auth-manager.js';
import { ApiClient } from './js/shared/api-client.js';
import { HistoryRenderer } from './js/shared/history-renderer.js';
import { StatsRenderer } from './js/shared/stats-renderer.js';

class AlbumGuessrStats {
    constructor() {
        this.authManager = new AuthManager();
        this.apiClient = new ApiClient(this.authManager);
        this.historyRenderer = null; // Will be initialized after DOM
        this.statsRenderer = new StatsRenderer();

        this.initializeDOM();
        this.authManager.initializeAuth0();
        this.bindEvents();
        this.postDomAuthSetup();

        // Re-wire auth controls after header injection
        document.addEventListener('albumguessr:header-ready', async () => {
            this.elements.btnLogin = document.getElementById('btn-login');
            this.elements.btnLogout = document.getElementById('btn-logout');
            this.elements.userProfile = document.getElementById('user-profile');
            this.elements.userAvatar = document.getElementById('user-avatar');
            this.elements.userName = document.getElementById('user-name');
            this.elements.navStatistics = document.getElementById('nav-statistics');
            this.authManager.bindAuthButtons(this.elements);
            try {
                const authed = await this.authManager.isAuthenticated();
                this.authManager.updateAuthUI(this.elements, authed);
                this.renderUserHistory();
                this.renderUserStats();
            } catch (_) {}
        });
    }

    initializeDOM() {
        this.elements = {
            // Auth controls
            btnLogin: document.getElementById('btn-login'),
            btnLogout: document.getElementById('btn-logout'),
            userProfile: document.getElementById('user-profile'),
            userAvatar: document.getElementById('user-avatar'),
            userName: document.getElementById('user-name'),
            navStatistics: document.getElementById('nav-statistics'),
            // History elements
            userHistorySubtitle: document.getElementById('user-history-subtitle'),
            userHistoryList: document.getElementById('user-history-list'),
            // Stats elements
            userStatsSubtitle: document.getElementById('user-stats-subtitle'),
            statsCards: document.getElementById('stats-cards')
        };

        this.templates = {
            historyItem: document.getElementById('tpl-history-item'),
            historyEmpty: document.getElementById('tpl-history-empty'),
            historyError: document.getElementById('tpl-history-error')
        };
        
        // Initialize history renderer now that templates are available
        this.historyRenderer = new HistoryRenderer(this.elements, this.templates);
    }

    bindEvents() {
        this.authManager.bindAuthButtons(this.elements);
    }

    async postDomAuthSetup() {
        try {
            const isAuthenticated = await this.authManager.postDomAuthSetup();
            this.updateAuthUI(isAuthenticated);
            this.renderUserHistory();
            this.renderUserStats();
        } catch (err) {
            console.warn('Auth0 post-DOM setup skipped or failed (stats):', err);
        }
    }

    updateAuthUI(isAuthenticated) {
        this.authManager.updateAuthUI(this.elements, isAuthenticated);
        // Update subtitles visibility
        const statsSubtitle = this.elements.userStatsSubtitle;
        const histSubtitle = this.elements.userHistorySubtitle;
        if (statsSubtitle) statsSubtitle.textContent = isAuthenticated ? 'Your personal game stats' : 'Log in to see your stats';
        if (histSubtitle) histSubtitle.textContent = isAuthenticated ? 'Recent wins saved to your account' : 'Log in to save and see your history';
    }

    async renderUserHistory() {
        const isAuthenticated = !!this.authManager.authenticatedUser;
        const history = isAuthenticated ? await this.apiClient.fetchUserHistory() : [];
        this.historyRenderer.render(history, isAuthenticated);
    }

    // ---------- Stats rendering ----------
    async renderUserStats() {
        const listEl = this.elements.statsCards;
        if (!listEl) return;

        if (!this.authManager.authenticatedUser) {
            listEl.replaceChildren();
            return;
        }

        try {
            const history = await this.apiClient.fetchUserHistory();
            this.statsRenderer.render(listEl, history);
        } catch (e) {
            console.warn('stats render failed:', e);
            listEl.replaceChildren();
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new AlbumGuessrStats();
});


