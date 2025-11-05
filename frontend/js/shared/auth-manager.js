/**
 * Centralized Auth0 authentication management
 * Handles initialization, login/logout, token management, and UI updates
 */
export class AuthManager {
    constructor() {
        this.auth0Client = null;
        this.authenticatedUser = null;
        this.customUsername = null;
    }

    /**
     * Initialize Auth0 client
     * @returns {Promise<void>}
     */
    async initializeAuth0() {
        try {
            if (typeof AUTH0_CONFIG === 'object' && AUTH0_CONFIG && typeof auth0 !== 'undefined') {
                this.clearStaleAuthCache();
                this.auth0Client = await auth0.createAuth0Client(AUTH0_CONFIG);
                console.log('Auth0 initialized');
            }
        } catch (error) {
            console.warn('Auth0 initialization failed or skipped:', error);
        }
    }

    /**
     * Clear stale Auth0 cache if client ID has changed
     * This prevents "Unknown client" errors when Auth0 config is updated
     */
    clearStaleAuthCache() {
        try {
            if (!AUTH0_CONFIG || !AUTH0_CONFIG.clientId) return;
            
            const currentClientId = AUTH0_CONFIG.clientId;
            const cacheKey = 'auth0.client_id';
            const cachedClientId = localStorage.getItem(cacheKey);
            
            if (cachedClientId && cachedClientId !== currentClientId) {
                console.warn(`Auth0 client ID mismatch detected. Clearing stale cache. Old: ${cachedClientId}, New: ${currentClientId}`);
                
                // Clear all Auth0-related items from localStorage
                const keysToRemove = [];
                for (let i = 0; i < localStorage.length; i++) {
                    const key = localStorage.key(i);
                    if (key && (key.startsWith('@@auth0') || key.startsWith('auth0.'))) {
                        keysToRemove.push(key);
                    }
                }
                keysToRemove.forEach(key => localStorage.removeItem(key));
                
                console.log(`Cleared ${keysToRemove.length} Auth0 cache entries`);
            }
            
            // Store current client ID for future checks
            localStorage.setItem(cacheKey, currentClientId);
        } catch (error) {
            console.warn('Failed to clear stale Auth0 cache:', error);
        }
    }

    /**
     * Ensure Auth0 client is initialized, loading library if needed
     * @returns {Promise<object|null>} The Auth0 client or null if unavailable
     */
    async ensureAuth0Client() {
        if (this.auth0Client) return this.auth0Client;
        try {
            if (typeof AUTH0_CONFIG === 'object' && AUTH0_CONFIG) {
                if (typeof auth0 === 'undefined') {
                    await this.loadAuth0Library();
                }
                if (typeof auth0 === 'undefined') return null;
                this.clearStaleAuthCache();
                this.auth0Client = await auth0.createAuth0Client(AUTH0_CONFIG);
                return this.auth0Client;
            }
        } catch (e) {
            console.warn('Unable to create Auth0 client:', e);
        }
        return null;
    }

    /**
     * Dynamically load Auth0 SPA SDK if not already loaded
     * @returns {Promise<void>}
     */
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

    /**
     * Handle Auth0 post-DOM setup including redirect callback
     * @returns {Promise<boolean>} True if user is authenticated
     */
    async postDomAuthSetup() {
        try {
            await this.ensureAuth0Client();
            if (!this.auth0Client) return false;

            // Handle redirect callback if returning from Auth0
            const hasAuthParams = window.location.search.includes('code=') && window.location.search.includes('state=');
            if (hasAuthParams) {
                try {
                    const result = await this.auth0Client.handleRedirectCallback();
                    const returnTo = (result.appState && result.appState.returnTo) ? result.appState.returnTo : '/';
                    window.history.replaceState({}, document.title, returnTo);
                } catch (e) {
                    console.warn('Auth0 redirect callback failed:', e);
                    window.history.replaceState({}, document.title, window.location.pathname);
                }
            }

            const isAuthenticated = await this.auth0Client.isAuthenticated();
            if (isAuthenticated) {
                this.authenticatedUser = await this.auth0Client.getUser();
            } else {
                this.authenticatedUser = null;
            }
            return isAuthenticated;
        } catch (err) {
            console.warn('Auth0 post-DOM setup skipped or failed:', err);
            return false;
        }
    }

    /**
     * Initiate Auth0 login flow
     * @param {string} [returnPath] - Path to return to after login (defaults to current path)
     * @returns {Promise<void>}
     */
    async login(returnPath) {
        const client = await this.ensureAuth0Client();
        if (!client) {
            alert('Login is currently unavailable. Please try again later.');
            return;
        }
        await client.loginWithRedirect({
            authorizationParams: { redirect_uri: window.location.origin },
            appState: { returnTo: returnPath || window.location.pathname }
        });
    }

    /**
     * Logout from Auth0
     * @returns {Promise<void>}
     */
    async logout() {
        const client = await this.ensureAuth0Client();
        if (!client) {
            alert('Logout is currently unavailable. Please try again later.');
            return;
        }
        client.logout({ logoutParams: { returnTo: window.location.origin } });
    }

    /**
     * Get API access token for authenticated requests
     * @returns {Promise<string|null>} Access token or null if unavailable
     */
    async getApiAccessToken() {
        const client = await this.ensureAuth0Client();
        const audience = AUTH0_CONFIG && AUTH0_CONFIG.authorizationParams && AUTH0_CONFIG.authorizationParams.audience;
        if (!client || !audience) {
            console.warn('getApiAccessToken: No client or audience available');
            return null;
        }
        try {
            const token = await client.getTokenSilently({ authorizationParams: { audience } });
            return token;
        } catch (e) {
            console.error('Failed to obtain API token:', e);
            return null;
        }
    }

    /**
     * Update UI elements based on authentication state
     * @param {Object} elements - DOM elements to update
     * @param {HTMLElement} elements.btnLogin - Login button
     * @param {HTMLElement} elements.btnLogout - Logout button
     * @param {HTMLElement} elements.userProfile - User profile container
     * @param {HTMLElement} elements.userAvatar - User avatar image
     * @param {HTMLElement} elements.userName - User name display
     * @param {HTMLElement} elements.navStatistics - Statistics nav item
     * @param {HTMLElement} elements.navReportBug - Report Bug nav item
     * @param {boolean} isAuthenticated - Whether user is authenticated
     */
    updateAuthUI(elements, isAuthenticated) {
        const show = (el, visible) => { if (el) el.style.display = visible ? '' : 'none'; };
        
        show(elements.btnLogin, !isAuthenticated);
        show(elements.btnLogout, !!isAuthenticated);
        
        // Show/hide items in profile dropdown menu
        const navStatisticsDropdown = document.getElementById('nav-statistics-dropdown');
        if (navStatisticsDropdown) {
            navStatisticsDropdown.style.display = isAuthenticated ? '' : 'none';
        }
        
        // Show/hide report bug in main menu
        const navReportBug = document.getElementById('nav-report-bug');
        if (navReportBug) {
            navReportBug.style.display = isAuthenticated ? '' : 'none';
        }
        
        // Show/hide profile menu container
        const userProfileMenu = document.getElementById('user-profile-menu');
        if (userProfileMenu) {
            userProfileMenu.style.display = isAuthenticated ? '' : 'none';
        }
        
        if (isAuthenticated && this.authenticatedUser) {
            if (elements.userAvatar) {
                const displayName = this.customUsername || 
                                   this.authenticatedUser.name || 
                                   this.authenticatedUser.email || '';
                
                // Remove existing placeholder if any (check in toggle button)
                const toggleButton = elements.userAvatar.closest('.user-profile-toggle');
                const existingPlaceholder = toggleButton ? toggleButton.querySelector('.avatar-placeholder') : null;
                if (existingPlaceholder) {
                    existingPlaceholder.remove();
                }
                
                if (this.authenticatedUser.picture) {
                    // Always reset the image state to ensure proper error handling
                    elements.userAvatar.src = this.authenticatedUser.picture;
                    elements.userAvatar.style.display = '';
                    
                    // Set up error handler that will create placeholder if image fails
                    elements.userAvatar.onerror = () => {
                        elements.userAvatar.style.display = 'none';
                        // Clear the src to prevent repeated error events
                        elements.userAvatar.src = '';
                        this.showAvatarPlaceholder(elements.userAvatar, displayName);
                        elements.userAvatar.onerror = null;
                    };
                    
                    // Check if image is already loaded and valid
                    if (elements.userAvatar.complete && elements.userAvatar.naturalHeight === 0) {
                        // Image failed to load, show placeholder
                        elements.userAvatar.style.display = 'none';
                        elements.userAvatar.src = '';
                        this.showAvatarPlaceholder(elements.userAvatar, displayName);
                    }
                } else {
                    elements.userAvatar.style.display = 'none';
                    elements.userAvatar.src = '';
                    this.showAvatarPlaceholder(elements.userAvatar, displayName);
                }
            }
            if (elements.userName) {
                const displayName = this.customUsername || 
                                   this.authenticatedUser.name || 
                                   this.authenticatedUser.email || '';
                elements.userName.textContent = displayName;
            }
        }
    }

    /**
     * Show avatar placeholder with initials
     * @param {HTMLElement} avatarElement - The avatar image element
     * @param {string} displayName - User's display name
     */
    showAvatarPlaceholder(avatarElement, displayName) {
        if (!avatarElement) return;
        
        // Find the toggle button parent (new structure) or parent element (old structure)
        const toggleButton = avatarElement.closest('.user-profile-toggle');
        const parentElement = toggleButton || avatarElement.parentElement;
        if (!parentElement) return;
        
        // Check if placeholder already exists
        const existingPlaceholder = parentElement.querySelector('.avatar-placeholder');
        if (existingPlaceholder) return;
        
        const placeholder = document.createElement('div');
        placeholder.className = 'avatar-placeholder';
        const initials = (displayName || 'U').substring(0, 2).toUpperCase();
        placeholder.textContent = initials;
        
        // Insert placeholder in the toggle button (new structure) or before avatar (old structure)
        if (toggleButton) {
            toggleButton.insertBefore(placeholder, avatarElement);
        } else {
            avatarElement.parentElement.insertBefore(placeholder, avatarElement);
        }
    }

    /**
     * Bind auth button event handlers
     * @param {Object} elements - DOM elements
     * @param {HTMLElement} elements.btnLogin - Login button
     * @param {HTMLElement} elements.btnLogout - Logout button
     */
    bindAuthButtons(elements) {
        if (elements.btnLogin) {
            elements.btnLogin.addEventListener('click', () => this.login());
        }
        if (elements.btnLogout) {
            elements.btnLogout.addEventListener('click', () => this.logout());
        }
    }

    /**
     * Set custom username from database
     * @param {string|null} username - Custom username or null to clear
     */
    setCustomUsername(username) {
        this.customUsername = username;
    }

    /**
     * Check if user is currently authenticated
     * @returns {Promise<boolean>}
     */
    async isAuthenticated() {
        await this.ensureAuth0Client();
        if (!this.auth0Client) return false;
        return await this.auth0Client.isAuthenticated();
    }
}

