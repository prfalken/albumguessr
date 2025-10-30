class AlbumGuessrStats {
    constructor() {
        this.auth0Client = null;
        this.authenticatedUser = null;

        this.initializeDOM();
        this.initializeAuth0();
        this.bindEvents();
        this.postDomAuthSetup();
    }

    initializeDOM() {
        this.elements = {
            // Auth controls
            btnLogin: document.getElementById('btn-login'),
            btnLogout: document.getElementById('btn-logout'),
            userProfile: document.getElementById('user-profile'),
            userAvatar: document.getElementById('user-avatar'),
            userName: document.getElementById('user-name'),
            // History elements
            userHistorySubtitle: document.getElementById('user-history-subtitle'),
            userHistoryList: document.getElementById('user-history-list')
        };

        this.templates = {
            historyItem: document.getElementById('tpl-history-item'),
            historyEmpty: document.getElementById('tpl-history-empty'),
            historyError: document.getElementById('tpl-history-error')
        };
    }

    bindEvents() {
        if (this.elements.btnLogin) {
            this.elements.btnLogin.addEventListener('click', () => this.login());
        }
        if (this.elements.btnLogout) {
            this.elements.btnLogout.addEventListener('click', () => this.logout());
        }
    }

    async initializeAuth0() {
        try {
            if (typeof AUTH0_CONFIG === 'object' && AUTH0_CONFIG && typeof auth0 !== 'undefined') {
                this.auth0Client = await auth0.createAuth0Client(AUTH0_CONFIG);
                console.log('Auth0 initialized (stats)');
            }
        } catch (error) {
            console.warn('Auth0 initialization failed or skipped (stats):', error);
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
            console.warn('Unable to create Auth0 client (stats):', e);
        }
        return null;
    }

    async postDomAuthSetup() {
        try {
            await this.ensureAuth0Client();
            if (!this.auth0Client) return;

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
            console.warn('Auth0 post-DOM setup skipped or failed (stats):', err);
        }
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
    }

    async login() {
        const client = await this.ensureAuth0Client();
        if (!client) return;
        await client.loginWithRedirect({
            authorizationParams: { redirect_uri: window.location.origin + '/statistics.html' }
        });
    }

    async logout() {
        const client = await this.ensureAuth0Client();
        if (!client) return;
        client.logout({ logoutParams: { returnTo: window.location.origin + '/statistics.html' } });
    }

    async getApiAccessToken() {
        const client = await this.ensureAuth0Client();
        const audience = AUTH0_CONFIG && AUTH0_CONFIG.authorizationParams && AUTH0_CONFIG.authorizationParams.audience;
        if (!client || !audience) return null;
        try {
            return await client.getTokenSilently({ authorizationParams: { audience } });
        } catch (e) {
            console.warn('Failed to obtain API token (stats):', e);
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
            console.warn('history_get_failed_response (stats):', res.status, details);
            throw new Error('history_get_failed');
        }
        return await res.json();
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
            console.warn('history render failed (stats):', e);
            listEl.replaceChildren();
            const tplErr = this.templates.historyError;
            if (tplErr) listEl.appendChild(tplErr.content.firstElementChild.cloneNode(true));
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new AlbumGuessrStats();
});


