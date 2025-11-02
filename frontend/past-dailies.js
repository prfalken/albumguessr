import { AuthManager } from './js/shared/auth-manager.js';
import { ApiClient } from './js/shared/api-client.js';
import { i18n } from './js/shared/i18n.js';

class AlbumGuessrPastDailies {
    constructor() {
        this.authManager = new AuthManager();
        this.apiClient = new ApiClient(this.authManager);
        this.pastAlbums = [];
        
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
        
        // Load and render past albums
        this.loadPastAlbums();
    }
    
    initializeDOM() {
        this.elements = {
            calendarContainer: document.getElementById('calendar-container'),
            // Templates
            tplCompleted: document.getElementById('tpl-calendar-day-completed'),
            tplUncompleted: document.getElementById('tpl-calendar-day-uncompleted'),
            tplFuture: document.getElementById('tpl-calendar-day-future'),
            tplMonth: document.getElementById('tpl-calendar-month')
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
        } catch (err) {
            console.warn('Auth0 post-DOM setup skipped or failed:', err);
        }
    }
    
    async loadPastAlbums() {
        try {
            const token = await this.authManager.getApiAccessToken();
            const headers = {};
            if (token) {
                headers['Authorization'] = `Bearer ${token}`;
            }
            
            const response = await fetch('/.netlify/functions/getPastDailies', {
                method: 'GET',
                headers: headers,
                cache: 'no-store'
            });
            
            if (!response.ok) {
                throw new Error('Failed to fetch past albums');
            }
            
            const data = await response.json();
            this.pastAlbums = data.albums || [];
            this.renderCalendar();
        } catch (error) {
            console.error('Failed to load past albums:', error);
            this.showError();
        }
    }
    
    renderCalendar() {
        if (!this.elements.calendarContainer) return;
        
        // Filter albums to only include those from today or before
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const pastAlbumsOnly = this.pastAlbums.filter(album => {
            const albumDate = new Date(album.date + 'T00:00:00');
            albumDate.setHours(0, 0, 0, 0);
            return albumDate <= today;
        });
        
        // Group albums by month
        const albumsByMonth = this.groupAlbumsByMonth(pastAlbumsOnly);
        
        // Separate months into past and future
        const todayMonthKey = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}`;
        const pastMonths = {};
        const futureMonths = {};
        
        for (const [monthKey, albums] of Object.entries(albumsByMonth)) {            
            if (monthKey > todayMonthKey) {
                futureMonths[monthKey] = albums;
            } else if (monthKey <= todayMonthKey) {
                pastMonths[monthKey] = albums;
            }
        }
        
        // Clear container
        this.elements.calendarContainer.innerHTML = '';
        
        // Render future months first (at the top)
        const sortedFutureMonths = Object.entries(futureMonths).sort((a, b) => a[0].localeCompare(b[0]));
        for (const [monthKey, albums] of sortedFutureMonths) {
            const monthEl = this.renderMonth(monthKey, albums);
            this.elements.calendarContainer.appendChild(monthEl);
        }
        
        // Render past months after (latest first)
        const sortedPastMonths = Object.entries(pastMonths).sort((a, b) => b[0].localeCompare(a[0]));
        for (const [monthKey, albums] of sortedPastMonths) {
            const monthEl = this.renderMonth(monthKey, albums);
            this.elements.calendarContainer.appendChild(monthEl);
        }
        
        // If no albums, show empty state
        if (pastAlbumsOnly.length === 0 && Object.keys(pastMonths).length === 0 && Object.keys(futureMonths).length === 0) {
            this.showEmptyState();
        }
    }
    
    groupAlbumsByMonth(albums) {
        const grouped = {};
        
        albums.forEach(album => {
            const date = new Date(album.date + 'T00:00:00');
            const monthKey = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}`;
            
            if (!grouped[monthKey]) {
                grouped[monthKey] = [];
            }
            grouped[monthKey].push(album);
        });
        
        // Sort months ascending (oldest first)
        return Object.fromEntries(
            Object.entries(grouped).sort((a, b) => a[0].localeCompare(b[0]))
        );
    }
    
    renderMonth(monthKey, albums) {
        const [year, month] = monthKey.split('-');
        const monthNum = parseInt(month, 10);
        
        // Clone month template
        const monthEl = this.elements.tplMonth.content.cloneNode(true).querySelector('.calendar-month');
        const monthTitle = monthEl.querySelector('.calendar-month-title');
        const monthGrid = monthEl.querySelector('.calendar-grid');
        
        // Set month title
        const monthNames = [
            'January', 'February', 'March', 'April', 'May', 'June',
            'July', 'August', 'September', 'October', 'November', 'December'
        ];
        const monthName = monthNames[monthNum - 1];
        monthTitle.textContent = `${monthName} ${year}`;
        
        // Create a map of albums by day
        const albumsByDay = {};
        albums.forEach(album => {
            const date = new Date(album.date + 'T00:00:00');
            const day = date.getDate();
            albumsByDay[day] = album;
        });
        
        // Get number of days in month
        const daysInMonth = new Date(year, monthNum, 0).getDate();
        
        // Add cells for each day of the month in reverse order (from last day to first)
        for (let day = daysInMonth; day >= 1; day--) {
            const album = albumsByDay[day];
            const date = new Date(year, monthNum - 1, day);
            const isFuture = date > new Date();
            
            let dayCard;
            if (isFuture) {
                dayCard = this.renderDayCardFuture(day);
            } else if (album) {
                if (album.completed) {
                    dayCard = this.renderDayCardCompleted(day, album);
                } else {
                    dayCard = this.renderDayCardUncompleted(day, album);
                }
            } else {
                // Day exists in month but no album scheduled
                dayCard = this.renderDayCardFuture(day);
            }
            
            monthGrid.appendChild(dayCard);
        }
        
        return monthEl;
    }
    
    renderDayCardCompleted(day, album) {
        const card = this.elements.tplCompleted.content.cloneNode(true).querySelector('.calendar-day-card');
        card.querySelector('.day-number').textContent = String(day).padStart(2, '0');
        
        const coverImg = card.querySelector('.day-cover');
        if (album.cover_url) {
            coverImg.src = album.cover_url;
            coverImg.style.display = '';
        } else {
            coverImg.style.display = 'none';
        }
        
        const titleEl = card.querySelector('.day-title');
        const artistEl = card.querySelector('.day-artist');
        
        if (album.album_title) {
            titleEl.textContent = album.album_title;
            titleEl.style.display = '';
        } else {
            titleEl.style.display = 'none';
        }
        
        if (album.album_artists && album.album_artists.length > 0) {
            artistEl.textContent = Array.isArray(album.album_artists) 
                ? album.album_artists.join(', ')
                : album.album_artists;
            artistEl.style.display = '';
        } else {
            artistEl.style.display = 'none';
        }
        
        return card;
    }
    
    renderDayCardUncompleted(day, album) {
        const card = this.elements.tplUncompleted.content.cloneNode(true).querySelector('.calendar-day-card');
        card.querySelector('.day-number').textContent = String(day).padStart(2, '0');
        
        // Set link to play this album
        const date = album.date;
        card.href = `index.html?date=${date}`;
        
        const coverImg = card.querySelector('.day-cover');
        // For uncompleted albums, we might not have the cover yet
        // We could fetch it from Algolia, but for now show a placeholder
        coverImg.style.display = 'none';
        
        return card;
    }
    
    renderDayCardFuture(day) {
        const card = this.elements.tplFuture.content.cloneNode(true).querySelector('.calendar-day-card');
        card.querySelector('.day-number').textContent = String(day).padStart(2, '0');
        return card;
    }
    
    showError() {
        if (!this.elements.calendarContainer) return;
        this.elements.calendarContainer.innerHTML = `
            <div class="no-clues" style="padding: 2rem; text-align: center;">
                <i class="bi bi-exclamation-triangle" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                <p>Failed to load past albums. Please try again later.</p>
            </div>
        `;
    }
    
    showEmptyState() {
        if (!this.elements.calendarContainer) return;
        this.elements.calendarContainer.innerHTML = `
            <div class="no-clues" style="padding: 2rem; text-align: center;">
                <i class="bi bi-calendar-x" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                <p data-i18n="archive.empty">No past daily albums available yet.</p>
            </div>
        `;
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new AlbumGuessrPastDailies();
});

