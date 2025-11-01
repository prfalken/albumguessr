import { AuthManager } from './js/shared/auth-manager.js';
import { ApiClient } from './js/shared/api-client.js';

class AlbumGuessrBugReport {
    constructor() {
        this.authManager = new AuthManager();
        this.apiClient = new ApiClient(this.authManager);
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
                await this.prefillEmail();
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
            navReportBug: document.getElementById('nav-report-bug'),
            // Form elements
            bugReportForm: document.getElementById('bug-report-form'),
            bugTitle: document.getElementById('bug-title'),
            bugDescription: document.getElementById('bug-description'),
            bugEmail: document.getElementById('bug-email'),
            bugScreenshot: document.getElementById('bug-screenshot'),
            bugReportMessage: document.getElementById('bug-report-message'),
            btnSubmitBug: document.getElementById('btn-submit-bug')
        };
    }

    bindEvents() {
        this.authManager.bindAuthButtons(this.elements);
        if (this.elements.bugReportForm) {
            this.elements.bugReportForm.addEventListener('submit', (e) => this.handleFormSubmit(e));
        }
    }

    async postDomAuthSetup() {
        try {
            const isAuthenticated = await this.authManager.postDomAuthSetup();
            
            // Redirect to login if not authenticated
            if (!isAuthenticated) {
                window.location.href = 'index.html';
                return;
            }
            
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
            await this.prefillEmail();
        } catch (err) {
            console.warn('Auth0 post-DOM setup skipped or failed (bug report):', err);
            // Still redirect if auth is not available
            window.location.href = 'index.html';
        }
    }

    updateAuthUI(isAuthenticated) {
        this.authManager.updateAuthUI(this.elements, isAuthenticated);
    }

    async prefillEmail() {
        if (!this.elements.bugEmail || !this.authManager.authenticatedUser) {
            return;
        }
        this.elements.bugEmail.value = this.authManager.authenticatedUser.email || '';
    }

    async handleFormSubmit(e) {
        e.preventDefault();
        
        const submitBtn = this.elements.btnSubmitBug;
        
        // Disable form while processing
        submitBtn.disabled = true;
        this.showMessage('Submitting bug report...', 'info');
        
        try {
            // Build JSON payload (simplified without file upload for now)
            const payload = {
                title: this.elements.bugTitle.value,
                description: this.elements.bugDescription.value,
                email: this.elements.bugEmail.value
            };
            
            // Get auth token if available
            const token = await this.authManager.getApiAccessToken();
            const headers = {
                'Content-Type': 'application/json'
            };
            if (token) {
                headers['Authorization'] = `Bearer ${token}`;
            }
            
            const response = await fetch('/.netlify/functions/submitBugReport', {
                method: 'POST',
                headers: headers,
                body: JSON.stringify(payload)
            });
            
            const result = await response.json();
            
            if (response.ok && result.success) {
                this.showMessage('Thank you! Your bug report has been submitted successfully. We will investigate and get back to you if needed.', 'success');
                this.elements.bugReportForm.reset();
                await this.prefillEmail();
                
                // Clear success message after 10 seconds
                setTimeout(() => {
                    this.elements.bugReportMessage.textContent = '';
                    this.elements.bugReportMessage.className = 'form-message';
                }, 10000);
            } else {
                throw new Error(result.error || 'Form submission failed');
            }
        } catch (error) {
            console.error('Bug report submission failed:', error);
            this.showMessage('Failed to submit bug report. Please try again later.', 'error');
        } finally {
            submitBtn.disabled = false;
        }
    }

    showMessage(text, type) {
        const messageEl = this.elements.bugReportMessage;
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
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new AlbumGuessrBugReport();
});

