class AlbumGuessrRanking {
    constructor() {
        this.auth0Client = null;
        this.authenticatedUser = null;
        this.rankingData = [];

        this.initializeDOM();
        this.initializeAuth0();
        this.postDomAuthSetup();

        // Re-wire auth controls after header injection
        document.addEventListener('albumguessr:header-ready', async () => {
            this.elements.btnLogin = document.getElementById('btn-login');
            this.elements.btnLogout = document.getElementById('btn-logout');
            this.elements.userProfile = document.getElementById('user-profile');
            this.elements.userAvatar = document.getElementById('user-avatar');
            this.elements.userName = document.getElementById('user-name');
            this.bindAuthButtons();
            try {
                await this.ensureAuth0Client();
                const authed = this.auth0Client ? await this.auth0Client.isAuthenticated() : false;
                this.updateAuthUI(!!authed);
            } catch (_) {}
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
            // Ranking elements
            rankingTbody: document.getElementById('ranking-tbody'),
            rankingEmpty: document.getElementById('ranking-empty'),
            rankingSubtitle: document.getElementById('ranking-subtitle')
        };
    }

    bindAuthButtons() {
        if (this.elements && this.elements.btnLogin) {
            this.elements.btnLogin.addEventListener('click', () => this.login());
        }
        if (this.elements && this.elements.btnLogout) {
            this.elements.btnLogout.addEventListener('click', () => this.logout());
        }
    }

    async initializeAuth0() {
        try {
            if (typeof AUTH0_CONFIG === 'object' && AUTH0_CONFIG && typeof auth0 !== 'undefined') {
                this.auth0Client = await auth0.createAuth0Client(AUTH0_CONFIG);
                console.log('Auth0 initialized (ranking)');
            }
        } catch (error) {
            console.warn('Auth0 initialization failed or skipped (ranking):', error);
        }
    }

    async ensureAuth0Client() {
        if (this.auth0Client) return this.auth0Client;
        try {
            if (typeof AUTH0_CONFIG === 'object' && AUTH0_CONFIG) {
                if (typeof auth0 === 'undefined') {
                    await this.loadAuth0Library();
                }
                if (typeof auth0 === 'undefined') return null;
                this.auth0Client = await auth0.createAuth0Client(AUTH0_CONFIG);
                return this.auth0Client;
            }
        } catch (e) {
            console.warn('Unable to create Auth0 client (ranking):', e);
        }
        return null;
    }

    async loadAuth0Library() {
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

    async postDomAuthSetup() {
        try {
            await this.ensureAuth0Client();
            if (!this.auth0Client) return;

            const hasAuthParams = window.location.search.includes('code=') && window.location.search.includes('state=');
            if (hasAuthParams) {
                try {
                    const result = await this.auth0Client.handleRedirectCallback();
                    const returnTo = (result.appState && result.appState.returnTo) ? result.appState.returnTo : '/';
                    window.history.replaceState({}, document.title, returnTo);
                } catch (e) {
                    console.warn('Auth0 redirect callback failed (ranking):', e);
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
        } catch (err) {
            console.warn('Auth0 post-DOM setup skipped or failed (ranking):', err);
        }
    }

    updateAuthUI(isAuthenticated) {
        const show = (el, visible) => { if (el) el.style.display = visible ? '' : 'none'; };
        show(this.elements.btnLogin, !isAuthenticated);
        show(this.elements.btnLogout, !!isAuthenticated);
        if (isAuthenticated && this.authenticatedUser) {
            if (this.elements.userAvatar) {
                this.elements.userAvatar.src = this.authenticatedUser.picture || '';
                this.elements.userAvatar.onerror = () => {
                    this.elements.userAvatar.style.display = 'none';
                    this.elements.userAvatar.onerror = null;
                };
                this.elements.userAvatar.style.display = '';
            }
            if (this.elements.userName) {
                const displayName = this.authenticatedUser.user_metadata?.custom_username || 
                                   this.authenticatedUser.name || 
                                   this.authenticatedUser.email || '';
                this.elements.userName.textContent = displayName;
            }
            show(this.elements.userProfile, true);
        } else {
            show(this.elements.userProfile, false);
        }
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

    async fetchAndRenderRanking() {
        try {
            const res = await fetch('/.netlify/functions/dailyRanking', {
                method: 'GET',
                cache: 'no-store'
            });

            if (!res.ok) {
                throw new Error('Failed to fetch ranking');
            }

            const data = await res.json();
            this.rankingData = data.ranking || [];
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
            if (this.authenticatedUser && entry.user_id === this.authenticatedUser.sub) {
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

            // Time column (duration)
            const tdTime = document.createElement('td');
            tdTime.className = 'ranking-time';
            tdTime.textContent = this.formatDuration(entry.duration_seconds);

            // Time Valid column (timestamp)
            const tdTimeValid = document.createElement('td');
            tdTimeValid.className = 'ranking-time-valid';
            tdTimeValid.textContent = this.formatTime(entry.timestamp);

            tr.appendChild(tdRank);
            tr.appendChild(tdUser);
            tr.appendChild(tdAttempts);
            tr.appendChild(tdTime);
            tr.appendChild(tdTimeValid);

            tbody.appendChild(tr);
        });
    }

    formatDuration(seconds) {
        if (!seconds || seconds < 0) return '-';
        
        const hours = Math.floor(seconds / 3600);
        const minutes = Math.floor((seconds % 3600) / 60);
        const secs = Math.floor(seconds % 60);

        if (hours > 0) {
            return `${hours}h ${minutes}m ${secs}s`;
        } else if (minutes > 0) {
            return `${minutes}m ${secs}s`;
        } else {
            return `${secs}s`;
        }
    }

    formatTime(timestamp) {
        if (!timestamp) return '-';
        
        try {
            const date = new Date(timestamp);
            return date.toLocaleTimeString('en-US', { 
                hour: 'numeric',
                minute: '2-digit',
                hour12: true 
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
                <td colspan="5" style="text-align: center; padding: 2rem;">
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


