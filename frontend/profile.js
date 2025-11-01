import { AuthManager } from './js/shared/auth-manager.js';
import { ApiClient } from './js/shared/api-client.js';
import { HistoryRenderer } from './js/shared/history-renderer.js';
import { StatsRenderer } from './js/shared/stats-renderer.js';

class AlbumGuessrProfile {
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
                await this.renderUserProfile();
                this.renderUserHistory();
                this.renderUserStats();
            } catch (err) {
                console.warn('Auth setup failed:', err);
            }
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
            // Profile elements
            profileAvatar: document.getElementById('profile-avatar'),
            profileEmail: document.getElementById('profile-email'),
            currentUsername: document.getElementById('current-username'),
            newUsername: document.getElementById('new-username'),
            usernameForm: document.getElementById('username-form'),
            usernameMessage: document.getElementById('username-message'),
            btnSaveUsername: document.getElementById('btn-save-username'),
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
        if (this.elements.usernameForm) {
            this.elements.usernameForm.addEventListener('submit', (e) => this.handleUsernameChange(e));
        }
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
            await this.renderUserProfile();
            this.renderUserHistory();
            this.renderUserStats();
        } catch (err) {
            console.warn('Auth0 post-DOM setup skipped or failed (profile):', err);
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

    async renderUserProfile() {
        if (!this.authManager.authenticatedUser) {
            // Redirect to home if not authenticated
            window.location.href = 'index.html';
            return;
        }

        const avatarEl = this.elements.profileAvatar;
        const emailEl = this.elements.profileEmail;
        const currentUsernameEl = this.elements.currentUsername;

        if (avatarEl && this.authManager.authenticatedUser.picture) {
            avatarEl.src = this.authManager.authenticatedUser.picture;
            avatarEl.onerror = () => {
                avatarEl.style.display = 'none';
                avatarEl.onerror = null;
            };
        }

        if (emailEl) {
            emailEl.textContent = this.authManager.authenticatedUser.email || '';
        }

        if (currentUsernameEl) {
            // Try to fetch username from database first, fall back to Auth0 metadata
            let customUsername = null;
            try {
                const profileData = await this.apiClient.fetchProfile();
                if (profileData) {
                    customUsername = profileData.custom_username;
                }
            } catch (e) {
                console.warn('Failed to fetch profile from database, using Auth0 data:', e);
            }

            // Fall back to Auth0 user_metadata if database doesn't have it
            if (!customUsername) {
                customUsername = this.authManager.authenticatedUser.user_metadata?.custom_username;
            }

            // Final fallback to name or email
            currentUsernameEl.textContent = customUsername || this.authManager.authenticatedUser.name || this.authManager.authenticatedUser.email || '';
        }
    }

    async handleUsernameChange(e) {
        e.preventDefault();
        
        const newUsername = this.elements.newUsername.value.trim();
        const submitBtn = this.elements.btnSaveUsername;

        if (!newUsername || newUsername.length < 3) {
            this.showMessage('Username must be at least 3 characters long', 'error');
            return;
        }

        // Disable form while processing
        submitBtn.disabled = true;
        this.showMessage('Updating username...', 'info');

        try {
            const result = await this.apiClient.updateProfile(newUsername);
            
            if (!result.success) {
                this.showMessage(result.error || 'Failed to update username. Please try again.', 'error');
                submitBtn.disabled = false;
                return;
            }

            // Update local user object with custom username in metadata
            if (!this.authManager.authenticatedUser.user_metadata) {
                this.authManager.authenticatedUser.user_metadata = {};
            }
            this.authManager.authenticatedUser.user_metadata.custom_username = newUsername;
            
            // Update auth manager custom username and refresh header display
            this.authManager.setCustomUsername(newUsername);
            this.authManager.updateAuthUI(this.elements, true);
            
            // Refresh current username from database to ensure consistency
            await this.renderUserProfile();
            this.elements.newUsername.value = '';

            this.showMessage('Username updated successfully!', 'success');
        } catch (error) {
            console.error('Username update failed:', error);
            this.showMessage('Failed to update username. Please try again.', 'error');
        } finally {
            submitBtn.disabled = false;
        }
    }

    showMessage(text, type) {
        const messageEl = this.elements.usernameMessage;
        if (!messageEl) return;

        messageEl.textContent = text;
        messageEl.className = 'form-message';
        
        if (type === 'success') {
            messageEl.classList.add('success');
        } else if (type === 'error') {
            messageEl.classList.add('error');
        } else {
            messageEl.classList.add('info');
        }

        if (type === 'success') {
            setTimeout(() => {
                messageEl.textContent = '';
                messageEl.className = 'form-message';
            }, 5000);
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
            console.warn('stats render failed (profile):', e);
            listEl.replaceChildren();
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new AlbumGuessrProfile();
});

