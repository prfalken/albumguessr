import { AuthManager } from './js/shared/auth-manager.js';
import { ApiClient } from './js/shared/api-client.js';

class AlbumGuessrRanking {
    constructor() {
        this.authManager = new AuthManager();
        this.apiClient = new ApiClient(this.authManager);
        this.rankingData = [];

        this.initializeDOM();
        this.authManager.initializeAuth0();
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
            } catch (err) {
                console.warn('Auth setup failed:', err);
            }
        });

        this.fetchAndRenderRanking();
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
            // Ranking elements
            rankingTbody: document.getElementById('ranking-tbody'),
            rankingEmpty: document.getElementById('ranking-empty'),
            rankingSubtitle: document.getElementById('ranking-subtitle')
        };
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
            console.warn('Auth0 post-DOM setup skipped or failed (ranking):', err);
        }
    }

    async fetchAndRenderRanking() {
        try {
            this.rankingData = await this.apiClient.fetchDailyRanking();
            this.renderRanking();
        } catch (error) {
            console.warn('Failed to fetch ranking:', error);
            this.renderError();
        }
    }

    renderRanking() {
        const tbody = this.elements.rankingTbody;
        const emptyEl = this.elements.rankingEmpty;
        
        if (!tbody) return;

        tbody.innerHTML = '';

        if (!this.rankingData || this.rankingData.length === 0) {
            tbody.closest('.ranking-table-wrapper').style.display = 'none';
            if (emptyEl) emptyEl.style.display = 'flex';
            return;
        }

        tbody.closest('.ranking-table-wrapper').style.display = 'block';
        if (emptyEl) emptyEl.style.display = 'none';

        this.rankingData.forEach((entry, index) => {
            const rank = index + 1;
            const tr = document.createElement('tr');
            tr.className = 'ranking-row';
            
            // Highlight current user's row
            if (this.authManager.authenticatedUser && entry.user_id === this.authManager.authenticatedUser.sub) {
                tr.classList.add('ranking-current-user');
            }

            // Rank column with medal for top 3
            const tdRank = document.createElement('td');
            tdRank.className = 'ranking-rank';
            if (rank <= 3) {
                const medal = document.createElement('div');
                medal.className = 'ranking-medal';
                const medalIcon = document.createElement('div');
                medalIcon.className = `medal-icon medal-${rank}`;
                if (rank === 1) {
                    medalIcon.innerHTML = '<div class="medal-decoration">🥇</div><div class="medal-number">1</div>';
                } else if (rank === 2) {
                    medalIcon.innerHTML = '<div class="medal-decoration">🥈</div><div class="medal-number">2</div>';
                } else if (rank === 3) {
                    medalIcon.innerHTML = '<div class="medal-decoration">🥉</div><div class="medal-number">3</div>';
                }
                medal.appendChild(medalIcon);
                tdRank.appendChild(medal);
            } else {
                tdRank.textContent = rank;
            }

            // Username column with avatar
            const tdUser = document.createElement('td');
            tdUser.className = 'ranking-username';
            const userContainer = document.createElement('div');
            userContainer.className = 'ranking-user-container';
            
            const avatar = document.createElement('img');
            avatar.className = 'ranking-avatar';
            avatar.src = entry.picture || '';
            avatar.alt = entry.username || 'User';
            avatar.onerror = () => {
                // Use initials as fallback
                avatar.style.display = 'none';
                const initials = document.createElement('div');
                initials.className = 'ranking-avatar-initials';
                initials.textContent = (entry.username || 'U').substring(0, 2).toUpperCase();
                userContainer.insertBefore(initials, userContainer.firstChild);
            };
            
            const username = document.createElement('span');
            username.className = 'ranking-username-text';
            username.textContent = entry.username || 'Anonymous';
            
            userContainer.appendChild(avatar);
            userContainer.appendChild(username);
            tdUser.appendChild(userContainer);

            // Attempts column
            const tdAttempts = document.createElement('td');
            tdAttempts.className = 'ranking-attempts';
            tdAttempts.textContent = entry.guesses || '-';

            // Time Valid column (timestamp)
            const tdTimeValid = document.createElement('td');
            tdTimeValid.className = 'ranking-time-valid';
            tdTimeValid.textContent = this.formatTime(entry.timestamp);

            tr.appendChild(tdRank);
            tr.appendChild(tdUser);
            tr.appendChild(tdAttempts);
            tr.appendChild(tdTimeValid);

            tbody.appendChild(tr);
        });
    }

    formatDuration(seconds) {
        if (!seconds || seconds < 0) return '-';
        
        const hours = Math.floor(seconds / 3600);
        const minutes = Math.floor((seconds % 3600) / 60);

        // Format as hh:mm (padding with zero if needed)
        if (hours > 0) {
            return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}`;
        } else {
            return `00:${String(minutes).padStart(2, '0')}`;
        }
    }

    formatTime(timestamp) {
        if (!timestamp) return '-';
        
        try {
            const date = new Date(timestamp);
            return date.toLocaleTimeString('en-US', { 
                hour: '2-digit',
                minute: '2-digit',
                hour12: false 
            });
        } catch (e) {
            return '-';
        }
    }

    renderError() {
        const tbody = this.elements.rankingTbody;
        if (!tbody) return;

        tbody.innerHTML = `
            <tr class="ranking-error">
                <td colspan="4" style="text-align: center; padding: 2rem;">
                    <i class="bi bi-exclamation-triangle" style="font-size: 2rem; color: var(--text-secondary);"></i>
                    <p style="color: var(--text-secondary); margin-top: 1rem;">Unable to load ranking. Please try again later.</p>
                </td>
            </tr>
        `;
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new AlbumGuessrRanking();
});



