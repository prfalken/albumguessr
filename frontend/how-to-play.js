import { AuthManager } from './js/shared/auth-manager.js';
import { ApiClient } from './js/shared/api-client.js';
import { i18n } from './js/shared/i18n.js';

class AlbumGuessrHowToPlay {
    constructor() {
        this.authManager = new AuthManager();
        this.apiClient = new ApiClient(this.authManager);
        
        this.authManager.initializeAuth0();
        this.postDomAuthSetup();
        
        // Re-wire auth controls after header injection
        document.addEventListener('albumguessr:header-ready', async () => {
            this.elements = {
                btnLogin: document.getElementById('btn-login'),
                btnLogout: document.getElementById('btn-logout'),
                userProfile: document.getElementById('user-profile'),
                userAvatar: document.getElementById('user-avatar'),
                userName: document.getElementById('user-name'),
                navStatistics: document.getElementById('nav-statistics'),
                navReportBug: document.getElementById('nav-report-bug')
            };
            
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
        } catch (err) {
            console.warn('Auth0 post-DOM setup skipped or failed:', err);
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new AlbumGuessrHowToPlay();
});

