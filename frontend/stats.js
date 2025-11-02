import { AuthManager } from './js/shared/auth-manager.js';
import { ApiClient } from './js/shared/api-client.js';
import { HistoryRenderer } from './js/shared/history-renderer.js';
import { StatsRenderer } from './js/shared/stats-renderer.js';
import { i18n } from './js/shared/i18n.js';

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
                this.updateAuthUI(authed);
                this.renderUserHistory();
                this.renderUserStats();
            } catch (err) {
                console.warn('Auth setup failed:', err);
            }
        });

        // Listen for language changes to update translations
        document.addEventListener('albumguessr:language-changed', () => {
            const isAuthenticated = !!this.authManager.authenticatedUser;
            this.updateAuthUI(isAuthenticated);
            // Re-render stats and history with new translations
            this.renderUserStats();
            this.renderUserHistory();
        });

        // Update auth UI after all translations are applied
        document.addEventListener('albumguessr:footer-ready', () => {
            // Small delay to ensure translations are fully applied
            setTimeout(() => {
                const isAuthenticated = !!this.authManager.authenticatedUser;
                this.updateAuthUI(isAuthenticated);
            }, 100);
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
            navReportBug: document.getElementById('nav-report-bug'),
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
            if (isAuthenticated) {
                try {
                    const profileData = await this.apiClient.fetchProfile();
                    const dbUsername = profileData && profileData.custom_username;
                    this.authManager.setCustomUsername(dbUsername);
                } catch (profileErr) {
                    console.warn('Failed to fetch profile:', profileErr);
                }
            }
            this.updateAuthUI(isAuthenticated);
            this.renderUserHistory();
            this.renderUserStats();
        } catch (err) {
            console.warn('Auth0 post-DOM setup skipped or failed (stats):', err);
        }
    }

    updateAuthUI(isAuthenticated) {
        this.authManager.updateAuthUI(this.elements, isAuthenticated);
        // Update subtitles with translations
        const statsSubtitle = this.elements.userStatsSubtitle;
        const histSubtitle = this.elements.userHistorySubtitle;
        if (statsSubtitle) {
            statsSubtitle.textContent = isAuthenticated 
                ? i18n.t('profile.statsSubtitleAuthed') 
                : i18n.t('profile.statsSubtitle');
        }
        if (histSubtitle) {
            histSubtitle.textContent = isAuthenticated 
                ? i18n.t('profile.historySubtitleAuthed') 
                : i18n.t('profile.historySubtitle');
        }
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


