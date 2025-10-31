/**
 * Centralized API client for Netlify Functions
 * Handles all backend API calls with proper authentication
 */
export class ApiClient {
    /**
     * @param {import('./auth-manager.js').AuthManager} authManager - Auth manager instance
     */
    constructor(authManager) {
        this.authManager = authManager;
    }

    /**
     * Fetch user's album history from the API
     * @returns {Promise<Array>} Array of history entries
     */
    async fetchUserHistory() {
        const token = await this.authManager.getApiAccessToken();
        if (!token) return [];
        
        try {
            const res = await fetch('/.netlify/functions/history', {
                method: 'GET',
                headers: { Authorization: `Bearer ${token}` }
            });
            
            if (!res.ok) {
                let details = '';
                try { details = await res.text(); } catch {}
                console.warn('history_get_failed_response:', res.status, details);
                throw new Error('history_get_failed');
            }
            
            return await res.json();
        } catch (error) {
            console.error('Failed to fetch user history:', error);
            return [];
        }
    }

    /**
     * Save a history entry (win) to the API
     * @param {Object} entry - History entry to save
     * @param {string} entry.objectID - Album object ID
     * @param {string} entry.title - Album title
     * @param {string[]} entry.artists - Album artists
     * @param {number} entry.release_year - Release year
     * @param {string} entry.coverUrl - Cover art URL
     * @param {number} entry.guesses - Number of guesses
     * @param {Object} entry.userProfile - User profile data
     * @returns {Promise<boolean>} True if successful
     */
    async saveHistoryEntry(entry) {
        const token = await this.authManager.getApiAccessToken();
        if (!token) {
            console.warn('saveHistoryEntry: No token available, cannot save history');
            return false;
        }
        
        try {
            console.log('saveHistoryEntry: Sending entry to API:', entry);
            const res = await fetch('/.netlify/functions/history', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: `Bearer ${token}`
                },
                body: JSON.stringify(entry)
            });
            
            if (!res.ok) {
                const text = await res.text();
                console.error('saveHistoryEntry: Failed to save history:', res.status, text);
                return false;
            }
            
            console.log('saveHistoryEntry: Successfully saved to history');
            return true;
        } catch (error) {
            console.error('saveHistoryEntry: Error:', error);
            return false;
        }
    }

    /**
     * Fetch user profile from the API
     * @returns {Promise<Object|null>} Profile data or null
     */
    async fetchProfile() {
        const token = await this.authManager.getApiAccessToken();
        if (!token) return null;
        
        try {
            const response = await fetch('/.netlify/functions/updateProfile', {
                method: 'GET',
                headers: { 'Authorization': `Bearer ${token}` }
            });
            
            if (!response.ok) return null;
            
            return await response.json();
        } catch (error) {
            console.warn('Failed to fetch profile:', error);
            return null;
        }
    }

    /**
     * Update user profile (custom username)
     * @param {string} username - New username
     * @returns {Promise<Object>} Result object with success status
     */
    async updateProfile(username) {
        const token = await this.authManager.getApiAccessToken();
        if (!token) {
            return { success: false, error: 'Authentication failed. Please log in again.' };
        }
        
        try {
            const response = await fetch('/.netlify/functions/updateProfile', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify({ name: username })
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
                return { success: false, error: errorMsg };
            }

            return { success: true };
        } catch (error) {
            console.error('Profile update failed:', error);
            return { success: false, error: 'Failed to update username. Please try again.' };
        }
    }

    /**
     * Fetch daily ranking from the API
     * @returns {Promise<Array>} Ranking data
     */
    async fetchDailyRanking() {
        try {
            const res = await fetch('/.netlify/functions/dailyRanking', {
                method: 'GET',
                cache: 'no-store'
            });

            if (!res.ok) {
                throw new Error('Failed to fetch ranking');
            }

            const data = await res.json();
            return data.ranking || [];
        } catch (error) {
            console.warn('Failed to fetch ranking:', error);
            throw error;
        }
    }
}

