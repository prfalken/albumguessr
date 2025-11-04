import { AuthManager } from './js/shared/auth-manager.js';
import { ApiClient } from './js/shared/api-client.js';

class CoverGuessRanking {
    constructor() {
        this.authManager = new AuthManager();
        this.apiClient = new ApiClient(this.authManager);
        this.initializeDOM();
        this.authManager.initializeAuth0();
        this.postDomAuthSetup();
        
        // Function to setup auth UI after header is ready
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
        
        this.loadRanking();
    }

    initializeDOM() {
        this.elements = {
            tbody: document.getElementById('ranking-tbody'),
            empty: document.getElementById('ranking-empty'),
            btnLogin: null,
            btnLogout: null,
            userProfile: null,
            userAvatar: null,
            userName: null,
            navStatistics: null,
            navReportBug: null
        };
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
            console.warn('Auth0 post-DOM setup skipped or failed (cover-guess-ranking):', err);
        }
    }

    async loadRanking() {
        try {
            const response = await fetch('/.netlify/functions/coverGuessRanking');
            if (!response.ok) {
                const errorText = await response.text();
                console.error('Failed to load ranking:', response.status, errorText);
                throw new Error(`HTTP ${response.status}: ${errorText}`);
            }
            const data = await response.json();
            if (data.error) {
                console.error('Ranking API error:', data.error);
                throw new Error(data.error);
            }
            this.displayRanking(data.ranking || []);
        } catch (error) {
            console.error('Error loading ranking:', error);
            this.elements.tbody.innerHTML = `
                <tr>
                    <td colspan="4" style="text-align: center; padding: 2rem; color: var(--text-secondary);">
                        Erreur lors du chargement du classement.<br>
                        <small style="font-size: 0.85rem; margin-top: 0.5rem; display: block;">
                            ${error.message || 'Erreur inconnue'}
                        </small>
                        <small style="font-size: 0.75rem; margin-top: 0.5rem; display: block; opacity: 0.7;">
                            Vérifiez que la migration SQL a été exécutée (sql/migration_cover_guess.sql)
                        </small>
                    </td>
                </tr>
            `;
        }
    }

    displayRanking(ranking) {
        console.log('Displaying ranking with', ranking.length, 'entries');
        if (ranking.length === 0) {
            this.elements.tbody.style.display = 'none';
            this.elements.empty.style.display = 'block';
            return;
        }

        this.elements.empty.style.display = 'none';
        this.elements.tbody.innerHTML = '';

        ranking.forEach((entry, index) => {
            const row = document.createElement('tr');
            
            // Add current user highlight
            const currentUserId = this.authManager.authenticatedUser?.sub;
            if (currentUserId && entry.user_id === currentUserId) {
                row.classList.add('ranking-current-user');
            }

            // Rank
            const rankCell = document.createElement('td');
            rankCell.className = 'ranking-rank';
            rankCell.textContent = entry.rank;
            row.appendChild(rankCell);

            // Username with avatar
            const userCell = document.createElement('td');
            userCell.className = 'ranking-username';
            const userContainer = document.createElement('div');
            userContainer.className = 'ranking-user-container';

            // Avatar
            if (entry.avatar) {
                const avatar = document.createElement('img');
                avatar.className = 'ranking-avatar';
                avatar.src = entry.avatar;
                avatar.alt = entry.username;
                userContainer.appendChild(avatar);
            } else {
                const avatarPlaceholder = document.createElement('div');
                avatarPlaceholder.className = 'ranking-avatar-initials';
                avatarPlaceholder.textContent = entry.username.charAt(0).toUpperCase();
                userContainer.appendChild(avatarPlaceholder);
            }

            // Username text
            const usernameText = document.createElement('span');
            usernameText.className = 'ranking-username-text';
            usernameText.textContent = entry.username;
            userContainer.appendChild(usernameText);

            userCell.appendChild(userContainer);
            row.appendChild(userCell);

            // Total points
            const pointsCell = document.createElement('td');
            pointsCell.className = 'ranking-points';
            pointsCell.style.textAlign = 'center';
            pointsCell.style.fontWeight = '600';
            pointsCell.textContent = entry.total_points;
            row.appendChild(pointsCell);

            // Games won
            const gamesCell = document.createElement('td');
            gamesCell.className = 'ranking-games';
            gamesCell.style.textAlign = 'center';
            gamesCell.textContent = entry.games_won;
            row.appendChild(gamesCell);

            this.elements.tbody.appendChild(row);
        });
    }
}

// Initialize when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        new CoverGuessRanking();
    });
} else {
    new CoverGuessRanking();
}
