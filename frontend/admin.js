import { AuthManager } from './js/shared/auth-manager.js';
import { ApiClient } from './js/shared/api-client.js';

class AdminDashboard {
    constructor() {
        this.authManager = new AuthManager();
        this.apiClient = new ApiClient(this.authManager);
        this.algoliaClient = null;
        this.algoliaIndex = null;
        this.searchResults = [];
        this.selectedAlbum = null;
        this.scheduleData = [];
        this.currentPage = 1;
        this.itemsPerPage = 10;
        this.genres = [];
        this.editingGenre = null;
        
        this.init();
    }

    async init() {
        // Initialize Auth0
        await this.authManager.initializeAuth0();
        
        // Check authentication and admin status
        await this.checkAdminAccess();
        
        // Initialize Algolia
        this.initializeAlgolia();
        
        // Get DOM elements
        this.initializeDOM();
        
        // Bind events
        this.bindEvents();
        
        // Load schedule data
        await this.loadSchedule();
        
        // Load genres data
        await this.loadGenres();
        
        // Set minimum date to today
        const today = new Date().toISOString().split('T')[0];
        this.elements.dateInput.setAttribute('min', today);
        
        // Wire up auth controls after header injection
        document.addEventListener('albumguessr:header-ready', async () => {
            this.elements.btnLogin = document.getElementById('btn-login');
            this.elements.btnLogout = document.getElementById('btn-logout');
            this.elements.userProfile = document.getElementById('user-profile');
            this.elements.userAvatar = document.getElementById('user-avatar');
            this.elements.userName = document.getElementById('user-name');
            this.elements.navStatistics = document.getElementById('nav-statistics');
            this.elements.navReportBug = document.getElementById('nav-report-bug');
            this.authManager.bindAuthButtons(this.elements);
            const authed = await this.authManager.isAuthenticated();
            this.authManager.updateAuthUI(this.elements, authed);
        });
    }

    async checkAdminAccess() {
        try {
            const isAuth = await this.authManager.isAuthenticated();
            if (!isAuth) {
                console.warn('User not authenticated, redirecting to home');
                window.location.href = '/';
                return;
            }

            // Fetch profile to check admin status
            const profile = await this.apiClient.fetchProfile();
            if (!profile || profile.admin !== 1) {
                console.warn('User is not an admin, redirecting to home');
                window.location.href = '/';
                return;
            }

            console.log('Admin access verified');
        } catch (error) {
            console.error('Failed to verify admin access:', error);
            window.location.href = '/';
        }
    }

    initializeAlgolia() {
        try {
            this.algoliaClient = algoliasearch(
                ALGOLIA_CONFIG.applicationId,
                ALGOLIA_CONFIG.apiKey
            );
            this.algoliaIndex = this.algoliaClient.initIndex(ALGOLIA_CONFIG.indexName);
            console.log('Algolia initialized successfully');
        } catch (error) {
            console.error('Failed to initialize Algolia:', error);
            this.showMessage('Failed to initialize search. Please refresh the page.', 'error');
        }
    }

    initializeDOM() {
        this.elements = {
            form: document.getElementById('admin-schedule-form'),
            dateInput: document.getElementById('schedule-date'),
            searchInput: document.getElementById('album-search'),
            searchResults: document.getElementById('admin-search-results'),
            selectedObjectId: document.getElementById('selected-object-id'),
            selectedAlbumDisplay: document.getElementById('selected-album-display'),
            messageDiv: document.getElementById('schedule-message'),
            scheduleList: document.getElementById('admin-schedule-list'),
            genresList: document.getElementById('admin-genres-list'),
            btnAddGenre: document.getElementById('btn-add-genre'),
            genreModal: document.getElementById('genre-edit-modal'),
            genreForm: document.getElementById('genre-edit-form'),
            closeGenreModal: document.getElementById('close-genre-modal'),
            cancelGenreEdit: document.getElementById('cancel-genre-edit'),
            genreId: document.getElementById('genre-id'),
            genreName: document.getElementById('genre-name'),
            genreDisplayName: document.getElementById('genre-display-name'),
            genreDisplayOrder: document.getElementById('genre-display-order'),
            genreEnabled: document.getElementById('genre-enabled'),
            genreMessage: document.getElementById('genre-message'),
            genreModalTitle: document.getElementById('genre-modal-title-text'),
            btnReorganize: document.getElementById('btn-reorganize-duplicates'),
            reorganizeStatus: document.getElementById('reorganize-status'),
            btnLogin: null,
            btnLogout: null,
            userProfile: null,
            userAvatar: null,
            userName: null,
            navStatistics: null,
            navReportBug: null
        };
    }

    bindEvents() {
        // Form submission
        this.elements.form.addEventListener('submit', (e) => this.handleSubmit(e));
        
        // Album search with debounce
        let searchTimeout;
        this.elements.searchInput.addEventListener('input', (e) => {
            clearTimeout(searchTimeout);
            const query = e.target.value.trim();
            if (query.length >= 2) {
                searchTimeout = setTimeout(() => this.searchAlbums(query), 300);
            } else {
                this.clearSearchResults();
            }
        });
        
        // Clear search results when clicking outside
        document.addEventListener('click', (e) => {
            if (!this.elements.searchInput.contains(e.target) && !this.elements.searchResults.contains(e.target)) {
                this.clearSearchResults();
            }
        });

        // Reorganize duplicates button
        if (this.elements.btnReorganize) {
            this.elements.btnReorganize.addEventListener('click', () => this.reorganizeDuplicates());
        }

        // Genre management events
        if (this.elements.btnAddGenre) {
            this.elements.btnAddGenre.addEventListener('click', () => this.showGenreModal());
        }
        if (this.elements.genreForm) {
            this.elements.genreForm.addEventListener('submit', (e) => this.handleGenreSubmit(e));
        }
        if (this.elements.closeGenreModal) {
            this.elements.closeGenreModal.addEventListener('click', () => this.hideGenreModal());
        }
        if (this.elements.cancelGenreEdit) {
            this.elements.cancelGenreEdit.addEventListener('click', () => this.hideGenreModal());
        }
        // Close modal on background click
        if (this.elements.genreModal) {
            this.elements.genreModal.addEventListener('click', (e) => {
                if (e.target === this.elements.genreModal) {
                    this.hideGenreModal();
                }
            });
        }
    }

    async searchAlbums(query) {
        try {
            const results = await this.algoliaIndex.search(query, {
                hitsPerPage: 20,
                attributesToRetrieve: ['objectID', 'title', 'main_artist', 'artists', 'release_year', 'cover_art_url']
            });

            this.searchResults = results.hits;
            this.renderSearchResults();
        } catch (error) {
            console.error('Search failed:', error);
            this.showMessage('Search failed. Please try again.', 'error');
        }
    }

    renderSearchResults() {
        if (this.searchResults.length === 0) {
            this.elements.searchResults.innerHTML = '<div class="admin-search-no-results">No albums found</div>';
            this.elements.searchResults.style.display = 'block';
            return;
        }

        const html = this.searchResults.map(album => `
            <div class="admin-search-result" data-object-id="${album.objectID}">
                <img src="${album.cover_art_url || ''}" alt="${album.title}" class="admin-search-result-cover" onerror="this.style.display='none'">
                <div class="admin-search-result-info">
                    <div class="admin-search-result-title">${this.escapeHtml(album.title)}</div>
                    <div class="admin-search-result-artist">${this.escapeHtml(album.main_artist || album.artists?.[0] || '')}</div>
                    <div class="admin-search-result-year">${album.release_year || ''}</div>
                </div>
            </div>
        `).join('');

        this.elements.searchResults.innerHTML = html;
        this.elements.searchResults.style.display = 'block';

        // Bind click events to results
        this.elements.searchResults.querySelectorAll('.admin-search-result').forEach(el => {
            el.addEventListener('click', () => {
                const objectId = el.getAttribute('data-object-id');
                const album = this.searchResults.find(a => a.objectID === objectId);
                this.selectAlbum(album);
            });
        });
    }

    selectAlbum(album) {
        this.selectedAlbum = album;
        this.elements.selectedObjectId.value = album.objectID;
        
        // Display selected album
        this.elements.selectedAlbumDisplay.innerHTML = `
            <div class="selected-album-card">
                <img src="${album.cover_art_url || ''}" alt="${album.title}" class="selected-album-cover" onerror="this.style.display='none'">
                <div class="selected-album-info">
                    <div class="selected-album-title">${this.escapeHtml(album.title)}</div>
                    <div class="selected-album-artist">${this.escapeHtml(album.main_artist || album.artists?.[0] || '')}</div>
                    <div class="selected-album-year">${album.release_year || ''}</div>
                </div>
                <button type="button" class="selected-album-remove" aria-label="Remove selection">
                    <i class="bi bi-x-circle"></i>
                </button>
            </div>
        `;
        
        this.elements.selectedAlbumDisplay.style.display = 'block';
        
        // Bind remove button
        this.elements.selectedAlbumDisplay.querySelector('.selected-album-remove').addEventListener('click', () => {
            this.clearSelection();
        });
        
        // Clear search
        this.clearSearchResults();
        this.elements.searchInput.value = '';
    }

    clearSelection() {
        this.selectedAlbum = null;
        this.elements.selectedObjectId.value = '';
        this.elements.selectedAlbumDisplay.innerHTML = '';
        this.elements.selectedAlbumDisplay.style.display = 'none';
    }

    clearSearchResults() {
        this.elements.searchResults.innerHTML = '';
        this.elements.searchResults.style.display = 'none';
        this.searchResults = [];
    }

    async handleSubmit(e) {
        e.preventDefault();
        
        const date = this.elements.dateInput.value;
        const objectId = this.elements.selectedObjectId.value;
        
        if (!date || !objectId) {
            this.showMessage('Please select a date and an album', 'error');
            return;
        }
        
        try {
            this.showMessage('Saving...', 'info');
            await this.apiClient.updateSchedule(date, objectId);
            this.showMessage('Schedule updated successfully!', 'success');
            
            // Reset form
            this.elements.form.reset();
            this.clearSelection();
            
            // Show refreshing message
            this.elements.scheduleList.innerHTML = `
                <div class="no-clues">
                    <i class="bi bi-arrow-clockwise spinning"></i>
                    <p>Refreshing schedule...</p>
                </div>
            `;
            
            // Reset to first page and reload schedule
            this.currentPage = 1;
            await this.loadSchedule();
            
            // Scroll to schedule table
            this.elements.scheduleList.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        } catch (error) {
            console.error('Failed to update schedule:', error);
            this.showMessage(error.message || 'Failed to update schedule', 'error');
        }
    }

    async loadSchedule() {
        try {
            this.scheduleData = await this.apiClient.fetchSchedule();
            await this.renderSchedule();
        } catch (error) {
            console.error('Failed to load schedule:', error);
            this.elements.scheduleList.innerHTML = `
                <div class="no-clues">
                    <i class="bi bi-exclamation-triangle"></i>
                    <p>Failed to load schedule</p>
                </div>
            `;
        }
    }

    async enrichScheduleWithAlbumData(entries) {
        if (!entries || entries.length === 0) return;
        
        // Fetch only the albums for the paginated entries
        const promises = entries.map(async (entry) => {
            // Skip if already fetched
            if (entry.albumData !== undefined) return;
            
            try {
                const result = await this.algoliaIndex.getObject(entry.object_id, {
                    attributesToRetrieve: ['objectID', 'title', 'main_artist', 'artists', 'cover_art_url']
                });
                entry.albumData = result;
            } catch (error) {
                console.warn(`Failed to fetch album data for ${entry.object_id}:`, error);
                entry.albumData = null;
            }
        });
        
        await Promise.all(promises);
    }

    async renderSchedule() {
        if (!this.scheduleData || this.scheduleData.length === 0) {
            this.elements.scheduleList.innerHTML = `
                <div class="no-clues">
                    <i class="bi bi-calendar-x"></i>
                    <p>No albums scheduled yet</p>
                </div>
            `;
            return;
        }

        const today = new Date().toISOString().split('T')[0];
        
        // Filter out completed (past) albums
        const futureSchedule = this.scheduleData.filter(entry => entry.schedule_date >= today);
        
        if (futureSchedule.length === 0) {
            this.elements.scheduleList.innerHTML = `
                <div class="no-clues">
                    <i class="bi bi-calendar-check"></i>
                    <p>No upcoming albums scheduled</p>
                </div>
            `;
            return;
        }
        
        // Calculate pagination
        const totalPages = Math.ceil(futureSchedule.length / this.itemsPerPage);
        const startIndex = (this.currentPage - 1) * this.itemsPerPage;
        const endIndex = startIndex + this.itemsPerPage;
        const paginatedData = futureSchedule.slice(startIndex, endIndex);
        
        // Fetch album data only for paginated items
        await this.enrichScheduleWithAlbumData(paginatedData);
        
        const html = `
            <div class="admin-schedule-grid">
                ${paginatedData.map(entry => {
                    const entryDate = entry.schedule_date;
                    let statusClass = 'status-future';
                    let statusText = 'Scheduled';
                    
                    if (entryDate === today) {
                        statusClass = 'status-today';
                        statusText = 'Today';
                    }
                    
                    // Render album card
                    if (entry.albumData) {
                        const album = entry.albumData;
                        const artist = this.escapeHtml(album.main_artist || album.artists?.[0] || 'Unknown Artist');
                        const title = this.escapeHtml(album.title || 'Unknown Title');
                        const coverUrl = album.cover_art_url || '';
                        
                        return `
                            <div class="admin-album-card">
                                ${coverUrl ? `<img src="${coverUrl}" alt="${title}" class="album-cover">` : ''}
                                <div class="album-date">${this.formatDate(entryDate)}</div>
                                <div class="album-info">
                                    <div class="album-title">${title}</div>
                                    <div class="album-artist">${artist}</div>
                                </div>
                            </div>
                        `;
                    } else {
                        return `
                            <div class="admin-album-card">
                                <div class="album-date">${this.formatDate(entryDate)}</div>
                                <div class="album-info">
                                    <div class="album-title">Album not found</div>
                                    <div class="album-artist">${this.escapeHtml(entry.object_id)}</div>
                                </div>
                            </div>
                        `;
                    }
                }).join('')}
            </div>
            ${this.renderPagination(totalPages)}
        `;
        
        this.elements.scheduleList.innerHTML = html;
        this.bindPaginationEvents();
    }

    renderPagination(totalPages) {
        if (totalPages <= 1) return '';
        
        const pages = [];
        const maxVisiblePages = 5;
        let startPage = Math.max(1, this.currentPage - Math.floor(maxVisiblePages / 2));
        let endPage = Math.min(totalPages, startPage + maxVisiblePages - 1);
        
        if (endPage - startPage < maxVisiblePages - 1) {
            startPage = Math.max(1, endPage - maxVisiblePages + 1);
        }
        
        for (let i = startPage; i <= endPage; i++) {
            pages.push(i);
        }
        
        return `
            <div class="pagination">
                <button 
                    class="pagination-btn pagination-prev" 
                    data-page="${this.currentPage - 1}"
                    ${this.currentPage === 1 ? 'disabled' : ''}
                >
                    <i class="bi bi-chevron-left"></i>
                    Previous
                </button>
                
                <div class="pagination-pages">
                    ${startPage > 1 ? `
                        <button class="pagination-page" data-page="1">1</button>
                        ${startPage > 2 ? '<span class="pagination-ellipsis">...</span>' : ''}
                    ` : ''}
                    
                    ${pages.map(page => `
                        <button 
                            class="pagination-page ${page === this.currentPage ? 'active' : ''}" 
                            data-page="${page}"
                        >
                            ${page}
                        </button>
                    `).join('')}
                    
                    ${endPage < totalPages ? `
                        ${endPage < totalPages - 1 ? '<span class="pagination-ellipsis">...</span>' : ''}
                        <button class="pagination-page" data-page="${totalPages}">${totalPages}</button>
                    ` : ''}
                </div>
                
                <button 
                    class="pagination-btn pagination-next" 
                    data-page="${this.currentPage + 1}"
                    ${this.currentPage === totalPages ? 'disabled' : ''}
                >
                    Next
                    <i class="bi bi-chevron-right"></i>
                </button>
            </div>
        `;
    }

    bindPaginationEvents() {
        const paginationBtns = this.elements.scheduleList.querySelectorAll('[data-page]');
        paginationBtns.forEach(btn => {
            btn.addEventListener('click', async () => {
                const page = parseInt(btn.getAttribute('data-page'));
                const today = new Date().toISOString().split('T')[0];
                const futureSchedule = this.scheduleData.filter(entry => entry.schedule_date >= today);
                
                if (page > 0 && page <= Math.ceil(futureSchedule.length / this.itemsPerPage)) {
                    this.currentPage = page;
                    await this.renderSchedule();
                    // Scroll to top of schedule list
                    this.elements.scheduleList.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
            });
        });
    }

    formatDate(dateStr) {
        if (!dateStr) return 'Invalid date';
        
        // Handle both "YYYY-MM-DD" and full ISO strings
        const cleanDate = dateStr.split('T')[0]; // Get just the date part
        const [year, month, day] = cleanDate.split('-');
        
        if (!year || !month || !day) return 'Invalid date';
        
        // Create date in UTC to avoid timezone issues
        const date = new Date(Date.UTC(parseInt(year), parseInt(month) - 1, parseInt(day)));
        
        if (isNaN(date.getTime())) return 'Invalid date';
        
        return date.toLocaleDateString('en-US', { 
            year: 'numeric', 
            month: 'short', 
            day: 'numeric',
            timeZone: 'UTC'
        });
    }

    showMessage(message, type) {
        this.elements.messageDiv.textContent = message;
        this.elements.messageDiv.className = `form-message form-message-${type}`;
        this.elements.messageDiv.style.display = 'block';
        
        if (type === 'success') {
            setTimeout(() => {
                this.elements.messageDiv.style.display = 'none';
            }, 5000);
        }
    }

    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // ============================================================================
    // GENRE MANAGEMENT METHODS
    // ============================================================================

    async loadGenres() {
        try {
            const token = await this.authManager.auth0Client.getTokenSilently();
            const response = await fetch('/.netlify/functions/manageGenres', {
                headers: {
                    'Authorization': `Bearer ${token}`
                }
            });
            
            if (!response.ok) {
                throw new Error('Failed to load genres');
            }
            
            const data = await response.json();
            this.genres = data.genres || [];
            this.renderGenres();
        } catch (error) {
            console.error('Failed to load genres:', error);
            this.elements.genresList.innerHTML = `
                <div class="no-clues">
                    <i class="bi bi-exclamation-triangle"></i>
                    <p>Failed to load genres</p>
                </div>
            `;
        }
    }

    renderGenres() {
        if (this.genres.length === 0) {
            this.elements.genresList.innerHTML = `
                <div class="no-clues">
                    <i class="bi bi-music-note-list"></i>
                    <p>No genres configured yet</p>
                </div>
            `;
            return;
        }

        const html = `
            <table class="admin-schedule-table">
                <thead>
                    <tr>
                        <th>Display Name</th>
                        <th>Internal Name</th>
                        <th>Order</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    ${this.genres.map(genre => `
                        <tr>
                            <td><strong>${this.escapeHtml(genre.displayName)}</strong></td>
                            <td><code>${this.escapeHtml(genre.name)}</code></td>
                            <td>${genre.displayOrder}</td>
                            <td>
                                <span class="schedule-status ${genre.enabled ? 'status-today' : 'status-future'}">
                                    ${genre.enabled ? 'Enabled' : 'Disabled'}
                                </span>
                            </td>
                            <td>
                                <button class="btn-edit-genre" data-genre-id="${genre.id}" title="Edit">
                                    <i class="bi bi-pencil"></i>
                                </button>
                                <button class="btn-delete-genre" data-genre-id="${genre.id}" title="Delete">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                        </tr>
                    `).join('')}
                </tbody>
            </table>
        `;
        
        this.elements.genresList.innerHTML = html;
        
        // Bind action buttons
        this.elements.genresList.querySelectorAll('.btn-edit-genre').forEach(btn => {
            btn.addEventListener('click', () => {
                const genreId = parseInt(btn.getAttribute('data-genre-id'));
                const genre = this.genres.find(g => g.id === genreId);
                if (genre) {
                    this.showGenreModal(genre);
                }
            });
        });
        
        this.elements.genresList.querySelectorAll('.btn-delete-genre').forEach(btn => {
            btn.addEventListener('click', () => {
                const genreId = parseInt(btn.getAttribute('data-genre-id'));
                const genre = this.genres.find(g => g.id === genreId);
                if (genre && confirm(`Delete genre "${genre.displayName}"?`)) {
                    this.deleteGenre(genreId);
                }
            });
        });
    }

    showGenreModal(genre = null) {
        this.editingGenre = genre;
        
        if (genre) {
            // Edit mode
            this.elements.genreModalTitle.textContent = 'Edit Genre';
            this.elements.genreId.value = genre.id;
            this.elements.genreName.value = genre.name;
            this.elements.genreDisplayName.value = genre.displayName;
            this.elements.genreDisplayOrder.value = genre.displayOrder;
            this.elements.genreEnabled.checked = genre.enabled;
        } else {
            // Add mode
            this.elements.genreModalTitle.textContent = 'Add Genre';
            this.elements.genreForm.reset();
            this.elements.genreId.value = '';
            this.elements.genreEnabled.checked = true;
        }
        
        this.elements.genreMessage.textContent = '';
        this.elements.genreMessage.style.display = 'none';
        this.elements.genreModal.style.display = 'flex';
    }

    hideGenreModal() {
        this.elements.genreModal.style.display = 'none';
        this.editingGenre = null;
        this.elements.genreForm.reset();
    }

    async handleGenreSubmit(e) {
        e.preventDefault();
        
        const genreId = this.elements.genreId.value;
        const genreData = {
            name: this.elements.genreName.value.trim().toLowerCase(),
            displayName: this.elements.genreDisplayName.value.trim(),
            displayOrder: parseInt(this.elements.genreDisplayOrder.value),
            enabled: this.elements.genreEnabled.checked
        };
        
        try {
            const token = await this.authManager.auth0Client.getTokenSilently();
            const method = genreId ? 'PUT' : 'POST';
            const body = genreId ? { ...genreData, id: parseInt(genreId) } : genreData;
            
            const response = await fetch('/.netlify/functions/manageGenres', {
                method,
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(body)
            });
            
            if (!response.ok) {
                const error = await response.json();
                throw new Error(error.error || 'Failed to save genre');
            }
            
            // Success
            this.hideGenreModal();
            await this.loadGenres();
        } catch (error) {
            console.error('Failed to save genre:', error);
            this.elements.genreMessage.textContent = error.message || 'Failed to save genre';
            this.elements.genreMessage.className = 'form-message form-message-error';
            this.elements.genreMessage.style.display = 'block';
        }
    }

    async deleteGenre(genreId) {
        try {
            const token = await this.authManager.auth0Client.getTokenSilently();
            const response = await fetch('/.netlify/functions/manageGenres', {
                method: 'DELETE',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ id: genreId })
            });
            
            if (!response.ok) {
                throw new Error('Failed to delete genre');
            }
            
            // Success
            await this.loadGenres();
        } catch (error) {
            console.error('Failed to delete genre:', error);
            alert('Failed to delete genre: ' + error.message);
        }
    }

    async reorganizeDuplicates() {
        try {
            this.elements.reorganizeStatus.innerHTML = '<i class="bi bi-hourglass-split"></i> Analyse en cours...';
            this.elements.btnReorganize.disabled = true;
            
            // Charger tous les albums avec leurs données
            await this.enrichScheduleWithAlbumData(this.scheduleData);
            
            // Analyser les doublons par mois
            const conflicts = this.findArtistDuplicatesByMonth();
            
            if (conflicts.length === 0) {
                this.elements.reorganizeStatus.innerHTML = '<span style="color: #10b981;">✓ Aucun doublon trouvé ! Tous les mois ont des artistes uniques.</span>';
                this.elements.btnReorganize.disabled = false;
                return;
            }
            
            // Compter le nombre total d'albums à déplacer
            const totalToMove = conflicts.reduce((sum, c) => sum + (c.dates.length - 1), 0);
            
            // Afficher un avertissement si le planning est très chargé
            let warningMessage = '';
            if (this.scheduleData.length > 365) {
                warningMessage = `
                    <div style="background: rgba(251, 191, 36, 0.1); padding: 0.75rem; border-radius: 6px; margin-bottom: 1rem; border-left: 4px solid #fbbf24;">
                        <div style="color: #fbbf24; font-weight: 600; font-size: 0.9rem;">
                            ⚠️ Planning très chargé (${this.scheduleData.length} albums)
                        </div>
                        <div style="color: #94a3b8; font-size: 0.8rem; margin-top: 0.25rem;">
                            Certains artistes pourraient ne pas trouver de mois disponible dans les 36 prochains mois.
                        </div>
                    </div>
                `;
            }
            
            // Afficher les conflits trouvés
            this.elements.reorganizeStatus.innerHTML = `
                ${warningMessage}
                <div style="color: #fbbf24; margin-bottom: 1rem;">
                    <strong>⚠️ ${conflicts.length} conflit(s) détecté(s) - ${totalToMove} album(s) à déplacer</strong>
                </div>
                <div style="background: var(--surface); padding: 1rem; border-radius: 8px; max-height: 300px; overflow-y: auto; text-align: left;">
                    ${conflicts.map(c => `
                        <div style="margin-bottom: 0.75rem; padding: 0.5rem; border-left: 3px solid #fbbf24;">
                            <strong>${c.month}</strong> : ${c.artist}<br>
                            <small style="color: #94a3b8;">
                                ${c.dates.map(d => d.date).join(', ')}
                            </small>
                        </div>
                    `).join('')}
                </div>
                <button id="btn-confirm-reorganize" class="btn-primary" style="margin-top: 1rem; background: #ef4444;">
                    <i class="bi bi-shuffle"></i> Confirmer la réorganisation
                </button>
                <button id="btn-cancel-reorganize" class="btn-secondary" style="margin-top: 1rem; margin-left: 0.5rem;">
                    Annuler
                </button>
            `;
            
            // Bind confirmation buttons
            document.getElementById('btn-confirm-reorganize').addEventListener('click', () => {
                this.executeReorganization(conflicts);
            });
            document.getElementById('btn-cancel-reorganize').addEventListener('click', () => {
                this.elements.reorganizeStatus.innerHTML = '';
                this.elements.btnReorganize.disabled = false;
            });
            
        } catch (error) {
            console.error('Erreur lors de l\'analyse:', error);
            this.elements.reorganizeStatus.innerHTML = `<span style="color: #ef4444;">Erreur: ${error.message}</span>`;
            this.elements.btnReorganize.disabled = false;
        }
    }

    findArtistDuplicatesByMonth() {
        const conflicts = [];
        const monthGroups = {};
        
        // Grouper les albums par mois
        this.scheduleData.forEach(entry => {
            if (!entry.albumData) return;
            
            const date = new Date(entry.schedule_date);
            const monthKey = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}`;
            const monthName = date.toLocaleDateString('fr-FR', { month: 'long', year: 'numeric' });
            
            if (!monthGroups[monthKey]) {
                monthGroups[monthKey] = { name: monthName, albums: [] };
            }
            
            const artist = entry.albumData.main_artist || entry.albumData.artists?.[0];
            if (artist) {
                monthGroups[monthKey].albums.push({
                    date: entry.schedule_date,
                    artist: artist,
                    artistLower: artist.toLowerCase(),
                    objectId: entry.object_id,
                    albumData: entry.albumData
                });
            }
        });
        
        // Détecter les doublons d'artistes par mois
        Object.entries(monthGroups).forEach(([monthKey, group]) => {
            const artistCounts = {};
            
            group.albums.forEach(album => {
                if (!artistCounts[album.artistLower]) {
                    artistCounts[album.artistLower] = [];
                }
                artistCounts[album.artistLower].push(album);
            });
            
            // Si un artiste apparaît plus d'une fois dans le mois
            Object.entries(artistCounts).forEach(([artistLower, albums]) => {
                if (albums.length > 1) {
                    conflicts.push({
                        month: group.name,
                        monthKey: monthKey,
                        artist: albums[0].artist,
                        dates: albums
                    });
                }
            });
        });
        
        return conflicts;
    }

    async executeReorganization(conflicts) {
        try {
            this.elements.reorganizeStatus.innerHTML = '<i class="bi bi-hourglass-split"></i> Réorganisation en cours...';
            
            let movedCount = 0;
            const errors = [];
            
            // Pour chaque conflit, garder le premier album et déplacer les autres
            for (const conflict of conflicts) {
                // Garder le premier album (le plus tôt dans le mois)
                const albumsToMove = conflict.dates.slice(1);
                
                for (const album of albumsToMove) {
                    try {
                        // Trouver le prochain mois disponible pour cet artiste
                        const newDate = await this.findNextAvailableMonth(album.artistLower, album.date);
                        
                        if (newDate) {
                            await this.apiClient.updateSchedule(newDate, album.objectId);
                            movedCount++;
                            console.log(`Déplacé ${album.artist} de ${album.date} vers ${newDate}`);
                        } else {
                            errors.push(`Impossible de trouver un mois disponible pour ${album.artist}`);
                        }
                    } catch (error) {
                        errors.push(`Erreur pour ${album.artist}: ${error.message}`);
                    }
                }
            }
            
            // Recharger le planning
            await this.loadSchedule();
            
            // Afficher le résultat
            let message = '';
            
            if (movedCount > 0) {
                message += `<span style="color: #10b981;">✓ Réorganisation terminée : ${movedCount} album(s) déplacé(s)</span>`;
            }
            
            if (errors.length > 0) {
                const uniqueErrors = [...new Set(errors)];
                const artistsNotMoved = uniqueErrors.length;
                
                message += `
                    <div style="margin-top: 1rem; padding: 1rem; background: rgba(239, 68, 68, 0.1); border-radius: 8px; border-left: 4px solid #ef4444;">
                        <div style="color: #ef4444; font-weight: 600; margin-bottom: 0.5rem;">
                            ⚠️ ${artistsNotMoved} album(s) non déplacé(s)
                        </div>
                        <div style="color: #94a3b8; font-size: 0.85rem; margin-bottom: 0.5rem;">
                            Ces artistes apparaissent déjà dans tous les mois disponibles sur les 36 prochains mois.
                        </div>
                        <details style="margin-top: 0.5rem;">
                            <summary style="cursor: pointer; color: #fbbf24; font-size: 0.85rem;">
                                Voir la liste complète (${uniqueErrors.length} artistes)
                            </summary>
                            <div style="margin-top: 0.5rem; max-height: 150px; overflow-y: auto; font-size: 0.8rem; color: #94a3b8;">
                                ${uniqueErrors.join('<br>')}
                            </div>
                        </details>
                        <div style="margin-top: 1rem; padding: 0.75rem; background: rgba(251, 191, 36, 0.1); border-radius: 6px; font-size: 0.85rem; color: #fbbf24;">
                            💡 <strong>Solutions :</strong><br>
                            • Supprimez manuellement certains doublons<br>
                            • Ou relancez la réorganisation après le premier traitement
                        </div>
                    </div>
                `;
            }
            
            this.elements.reorganizeStatus.innerHTML = message;
            this.elements.btnReorganize.disabled = false;
            
        } catch (error) {
            console.error('Erreur lors de la réorganisation:', error);
            this.elements.reorganizeStatus.innerHTML = `<span style="color: #ef4444;">Erreur: ${error.message}</span>`;
            this.elements.btnReorganize.disabled = false;
        }
    }

    async findNextAvailableMonth(artistLower, currentDate) {
        const startDate = new Date(currentDate);
        let testDate = new Date(startDate);
        testDate.setMonth(testDate.getMonth() + 1);
        testDate.setDate(15); // Mettre au 15 du mois suivant
        
        // Chercher jusqu'à 36 mois dans le futur
        for (let i = 0; i < 36; i++) {
            const monthKey = `${testDate.getFullYear()}-${String(testDate.getMonth() + 1).padStart(2, '0')}`;
            
            // Vérifier si l'artiste existe déjà dans ce mois
            const artistExistsInMonth = this.scheduleData.some(entry => {
                if (!entry.albumData) return false;
                const entryDate = new Date(entry.schedule_date);
                const entryMonthKey = `${entryDate.getFullYear()}-${String(entryDate.getMonth() + 1).padStart(2, '0')}`;
                
                if (entryMonthKey !== monthKey) return false;
                
                const entryArtist = entry.albumData.main_artist || entry.albumData.artists?.[0];
                return entryArtist && entryArtist.toLowerCase() === artistLower;
            });
            
            if (!artistExistsInMonth) {
                // Trouver une date libre dans ce mois
                const freeDate = this.findFreeDateInMonth(testDate);
                return freeDate;
            }
            
            // Passer au mois suivant
            testDate.setMonth(testDate.getMonth() + 1);
        }
        
        return null; // Aucun mois disponible trouvé
    }

    findFreeDateInMonth(monthDate) {
        const year = monthDate.getFullYear();
        const month = monthDate.getMonth();
        
        // Essayer chaque jour du mois
        for (let day = 1; day <= 31; day++) {
            const testDate = new Date(year, month, day);
            
            // Vérifier que c'est bien dans le bon mois (évite les débordements)
            if (testDate.getMonth() !== month) break;
            
            const dateStr = testDate.toISOString().split('T')[0];
            
            // Vérifier si cette date est libre
            const isOccupied = this.scheduleData.some(entry => entry.schedule_date === dateStr);
            
            if (!isOccupied) {
                return dateStr;
            }
        }
        
        return null; // Aucune date libre dans ce mois
    }
}

// Initialize when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => new AdminDashboard());
} else {
    new AdminDashboard();
}

