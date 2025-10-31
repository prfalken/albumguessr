class AlbumGuessrProfile {
    constructor() {
        this.auth0Client = null;
        this.authenticatedUser = null;

        this.initializeDOM();
        this.initializeAuth0();
        this.bindEvents();
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
                await this.renderUserProfile();
                this.renderUserHistory();
                this.renderUserStats();
                await this.refreshHeaderUsernameFromDb();
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
    }

    bindEvents() {
        this.bindAuthButtons();
        if (this.elements.usernameForm) {
            this.elements.usernameForm.addEventListener('submit', (e) => this.handleUsernameChange(e));
        }
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
                console.log('Auth0 initialized (profile)');
            }
        } catch (error) {
            console.warn('Auth0 initialization failed or skipped (profile):', error);
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
            console.warn('Unable to create Auth0 client (profile):', e);
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
                    const returnTo = (result.appState && result.appState.returnTo) ? result.appState.returnTo : '/profile.html';
                    window.history.replaceState({}, document.title, returnTo);
                } catch (e) {
                    console.warn('Auth0 redirect callback failed (profile):', e);
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
            await this.renderUserProfile();
            this.renderUserHistory();
            this.renderUserStats();
            await this.refreshHeaderUsernameFromDb();
        } catch (err) {
            console.warn('Auth0 post-DOM setup skipped or failed (profile):', err);
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
        // update subtitles visibility
        const statsSubtitle = this.elements.userStatsSubtitle;
        const histSubtitle = this.elements.userHistorySubtitle;
        if (statsSubtitle) statsSubtitle.textContent = isAuthenticated ? 'Your personal game stats' : 'Log in to see your stats';
        if (histSubtitle) histSubtitle.textContent = isAuthenticated ? 'Recent wins saved to your account' : 'Log in to save and see your history';
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

    async getApiAccessToken() {
        const client = await this.ensureAuth0Client();
        const audience = AUTH0_CONFIG && AUTH0_CONFIG.authorizationParams && AUTH0_CONFIG.authorizationParams.audience;
        if (!client || !audience) return null;
        try {
            return await client.getTokenSilently({ authorizationParams: { audience } });
        } catch (e) {
            console.warn('Failed to obtain API token (profile):', e);
            return null;
        }
    }

    async renderUserProfile() {
        if (!this.authenticatedUser) {
            // Redirect to home if not authenticated
            window.location.href = 'index.html';
            return;
        }

        const avatarEl = this.elements.profileAvatar;
        const emailEl = this.elements.profileEmail;
        const currentUsernameEl = this.elements.currentUsername;

        if (avatarEl && this.authenticatedUser.picture) {
            avatarEl.src = this.authenticatedUser.picture;
            avatarEl.onerror = () => {
                avatarEl.style.display = 'none';
                avatarEl.onerror = null;
            };
        }

        if (emailEl) {
            emailEl.textContent = this.authenticatedUser.email || '';
        }

        if (currentUsernameEl) {
            // Try to fetch username from database first, fall back to Auth0 metadata
            let customUsername = null;
            try {
                const token = await this.getApiAccessToken();
                if (token) {
                    const response = await fetch('/.netlify/functions/updateProfile', {
                        method: 'GET',
                        headers: {
                            'Authorization': `Bearer ${token}`
                        }
                    });
                    if (response.ok) {
                        const profileData = await response.json();
                        customUsername = profileData.custom_username;
                    }
                }
            } catch (e) {
                console.warn('Failed to fetch profile from database, using Auth0 data:', e);
            }

            // Fall back to Auth0 user_metadata if database doesn't have it
            if (!customUsername) {
                customUsername = this.authenticatedUser.user_metadata?.custom_username;
            }

            // Final fallback to name or email
            currentUsernameEl.value = customUsername || this.authenticatedUser.name || this.authenticatedUser.email || '';
        }
    }

    async handleUsernameChange(e) {
        e.preventDefault();
        
        const newUsername = this.elements.newUsername.value.trim();
        const messageEl = this.elements.usernameMessage;
        const submitBtn = this.elements.btnSaveUsername;

        if (!newUsername || newUsername.length < 3) {
            this.showMessage('Username must be at least 3 characters long', 'error');
            return;
        }

        // Disable form while processing
        submitBtn.disabled = true;
        this.showMessage('Updating username...', 'info');

        try {
            const token = await this.getApiAccessToken();
            if (!token) {
                this.showMessage('Authentication failed. Please log in again.', 'error');
                submitBtn.disabled = false;
                return;
            }

            const response = await fetch('/.netlify/functions/updateProfile', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify({ name: newUsername })
            });

            if (!response.ok) {
                let errorMsg = 'Failed to update username';
                try {
                    const errorData = await response.json();
                    console.error('Update profile error:', errorData);
                    errorMsg = errorData.error || errorData.message || errorMsg;
                } catch (e) {
                    const errorText = await response.text();
                    console.error('Update profile error (text):', errorText);
                    errorMsg = errorText || errorMsg;
                }
                throw new Error(errorMsg);
            }

            // Update local user object with custom username in metadata
            if (!this.authenticatedUser.user_metadata) {
                this.authenticatedUser.user_metadata = {};
            }
            this.authenticatedUser.user_metadata.custom_username = newUsername;
            
            // Refresh current username from database to ensure consistency
            await this.renderUserProfile();
            this.elements.newUsername.value = '';
            
            // Update header display
            if (this.elements.userName) {
                this.elements.userName.textContent = newUsername;
            }

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
            console.warn('history_get_failed_response (profile):', res.status, details);
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
            console.warn('history render failed (profile):', e);
            listEl.replaceChildren();
            const tplErr = this.templates.historyError;
            if (tplErr) listEl.appendChild(tplErr.content.firstElementChild.cloneNode(true));
        }
    }

    // ---------- Stats rendering ----------
    async renderUserStats() {
        const listEl = this.elements.statsCards;
        const subtitleEl = this.elements.userStatsSubtitle;
        if (!listEl || !subtitleEl) return;

        if (!this.authenticatedUser) {
            listEl.replaceChildren();
            return;
        }

        try {
            const history = await this.fetchUserHistoryFromApi();
            listEl.replaceChildren();
            if (!history || history.length === 0) {
                return;
            }

            const stats = this.computeStats(history);
            const cards = this.buildStatCards(stats);
            cards.forEach(card => listEl.appendChild(card));
        } catch (e) {
            console.warn('stats render failed (profile):', e);
            listEl.replaceChildren();
        }
    }

    computeStats(history) {
        const totalWins = history.length;
        const guessesList = history.map(h => Number(h.guesses || 0)).filter(n => !isNaN(n) && n > 0);
        const avgGuesses = guessesList.length ? (guessesList.reduce((a,b)=>a+b,0) / guessesList.length) : 0;
        const fastest = history.reduce((min, h) => (!min || (h.guesses||999) < min.guesses) ? h : min, null);
        const slowest = history.reduce((max, h) => (!max || (h.guesses||0) > max.guesses) ? h : max, null);

        const byDay = new Map();
        const dayKey = (ts) => {
            const d = ts ? new Date(ts) : null;
            if (!d || isNaN(d.getTime())) return null;
            const y = d.getUTCFullYear();
            const m = String(d.getUTCMonth()+1).padStart(2,'0');
            const dd = String(d.getUTCDate()).padStart(2,'0');
            return `${y}-${m}-${dd}`;
        };
        history.forEach(h => {
            const k = dayKey(h.timestamp);
            if (!k) return;
            byDay.set(k, (byDay.get(k)||0)+1);
        });

        const sortedDays = Array.from(byDay.keys()).sort();
        let bestStreak = 0, currentStreak = 0;
        let prev = null;
        const toDateObj = (k) => new Date(`${k}T00:00:00Z`);
        sortedDays.forEach(k => {
            if (!prev) {
                currentStreak = 1;
            } else {
                const prevDate = toDateObj(prev);
                const curDate = toDateObj(k);
                const diff = (curDate - prevDate) / (1000*60*60*24);
                if (diff === 1) {
                    currentStreak += 1;
                } else if (diff > 1) {
                    currentStreak = 1;
                }
            }
            bestStreak = Math.max(bestStreak, currentStreak);
            prev = k;
        });

        const today = new Date();
        const todayKey = `${today.getUTCFullYear()}-${String(today.getUTCMonth()+1).padStart(2,'0')}-${String(today.getUTCDate()).padStart(2,'0')}`;
        const yesterday = new Date(Date.UTC(today.getUTCFullYear(), today.getUTCMonth(), today.getUTCDate()-1));
        const yesterdayKey = `${yesterday.getUTCFullYear()}-${String(yesterday.getUTCMonth()+1).padStart(2,'0')}-${String(yesterday.getUTCDate()).padStart(2,'0')}`;
        if (!byDay.has(todayKey) && !byDay.has(yesterdayKey)) {
            currentStreak = byDay.has(sortedDays[sortedDays.length-1]) ? 1 : 0;
        }

        const years = history.map(h => Number(h.release_year)).filter(n => !isNaN(n) && n > 0);
        const oldestYear = years.length ? Math.min(...years) : null;
        const newestYear = years.length ? Math.max(...years) : null;
        const avgYear = years.length ? Math.round(years.reduce((a,b)=>a+b,0)/years.length) : null;

        return {
            totalWins,
            avgGuesses: guessesList.length ? Number(avgGuesses.toFixed(2)) : 0,
            fastest,
            slowest,
            bestStreak,
            currentStreak,
            oldestYear,
            newestYear,
            avgYear
        };
    }

    buildStatCards(stats) {
        const make = (iconClass, title, value, note) => {
            const card = document.createElement('div');
            card.className = 'stat-card';
            const titleEl = document.createElement('div');
            titleEl.className = 'stat-card-title';
            const icon = document.createElement('i');
            icon.className = `bi ${iconClass}`;
            const titleText = document.createElement('span');
            titleText.textContent = title;
            titleEl.appendChild(icon);
            titleEl.appendChild(titleText);
            const valueEl = document.createElement('div');
            valueEl.className = 'stat-card-value';
            valueEl.textContent = value;
            card.appendChild(titleEl);
            card.appendChild(valueEl);
            if (note) {
                const noteEl = document.createElement('div');
                noteEl.className = 'stat-card-note';
                noteEl.textContent = note;
                card.appendChild(noteEl);
            }
            return card;
        };

        const cards = [];
        cards.push(make('bi-trophy', 'Albums found', String(stats.totalWins)));
        cards.push(make('bi-lightning-charge', 'Fastest win', stats.fastest ? `${stats.fastest.guesses} guess(es)` : '—', stats.fastest ? `${stats.fastest.title}` : undefined));
        cards.push(make('bi-hourglass-split', 'Slowest win', stats.slowest ? `${stats.slowest.guesses} guess(es)` : '—', stats.slowest ? `${stats.slowest.title}` : undefined));
        cards.push(make('bi-bar-chart', 'Average guesses', `${stats.avgGuesses || 0}`));
        cards.push(make('bi-fire', 'Best streak', `${stats.bestStreak} day(s)`));
        cards.push(make('bi-activity', 'Current streak', `${stats.currentStreak} day(s)`));
        if (stats.oldestYear || stats.newestYear) {
            cards.push(make('bi-calendar2', 'Oldest win year', stats.oldestYear ? String(stats.oldestYear) : '—'));
            cards.push(make('bi-calendar-event', 'Newest win year', stats.newestYear ? String(stats.newestYear) : '—'));
        }
        if (stats.avgYear) {
            cards.push(make('bi-calendar3', 'Average year', String(stats.avgYear)));
        }

        return cards;
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new AlbumGuessrProfile();
});

