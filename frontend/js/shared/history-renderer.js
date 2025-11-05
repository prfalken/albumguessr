/**
 * Shared history rendering logic
 * Renders user's album history in a consistent format across pages
 */
import { i18n } from './i18n.js';

export class HistoryRenderer {
    /**
     * @param {Object} elements - DOM elements
     * @param {HTMLElement} elements.userHistorySubtitle - Subtitle element
     * @param {HTMLElement} elements.userHistoryList - List container element
     * @param {Object} templates - HTML templates
     * @param {HTMLTemplateElement} templates.historyItem - History item template
     * @param {HTMLTemplateElement} templates.historyEmpty - Empty state template
     * @param {HTMLTemplateElement} templates.historyError - Error state template
     */
    constructor(elements, templates) {
        this.elements = elements;
        this.templates = templates;
    }

    /**
     * Create a game mode badge element
     * @param {string} gameMode - Game mode ('daily', 'random', or 'cover-guess')
     * @returns {HTMLElement} Badge element
     */
    createGameModeBadge(gameMode) {
        const badge = document.createElement('span');
        badge.className = 'game-mode-badge';
        
        // Normalize gameMode (handle different possible formats)
        const normalizedMode = gameMode ? String(gameMode).toLowerCase().trim() : 'random';
        
        console.log('createGameModeBadge - original:', gameMode, 'normalized:', normalizedMode);
        
        if (normalizedMode === 'daily') {
            badge.classList.add('game-mode-daily');
            badge.innerHTML = `<i class="bi bi-calendar-check"></i> ${i18n.t('game.gameModeDaily')}`;
            badge.title = i18n.t('game.gameModeDailyTitle');
        } else if (normalizedMode === 'cover-guess' || normalizedMode === 'coverguess') {
            console.log('Creating cover-guess badge');
            badge.classList.add('game-mode-cover-guess');
            badge.innerHTML = `<i class="bi bi-image"></i> ${i18n.t('game.gameModeCoverGuess')}`;
            badge.title = i18n.t('game.gameModeCoverGuessTitle');
        } else {
            badge.classList.add('game-mode-random');
            badge.innerHTML = `<i class="bi bi-shuffle"></i> ${i18n.t('game.gameModeRandom')}`;
            badge.title = i18n.t('game.gameModeRandomTitle');
        }
        
        return badge;
    }

    /**
     * Render user history
     * @param {Array} history - Array of history entries
     * @param {boolean} isAuthenticated - Whether user is authenticated
     */
    async render(history, isAuthenticated) {
        const subtitleEl = this.elements.userHistorySubtitle;
        const listEl = this.elements.userHistoryList;
        
        if (!subtitleEl || !listEl) return;

        if (!isAuthenticated) {
            subtitleEl.textContent = i18n.t('profile.historySubtitle');
            listEl.replaceChildren();
            return;
        }

        subtitleEl.textContent = i18n.t('profile.historySubtitleAuthed');
        
        try {
            if (!history || history.length === 0) {
                listEl.replaceChildren();
                const tpl = this.templates.historyEmpty;
                if (tpl) listEl.appendChild(tpl.content.firstElementChild.cloneNode(true));
                return;
            }
            
            listEl.replaceChildren();
            history.forEach(item => {
                const el = this.templates.historyItem.content.firstElementChild.cloneNode(true);
                
                // Render cover art
                const cover = el.querySelector('.history-cover');
                if (cover) {
                    if (item.coverUrl) {
                        cover.src = item.coverUrl;
                        cover.style.display = '';
                    } else {
                        cover.style.display = 'none';
                    }
                }
                
                // Format metadata
                const date = item.timestamp ? new Date(item.timestamp) : null;
                const guessWord = item.guesses === 1 ? i18n.t('stats.guess') : i18n.t('stats.guesses');
                const meta = [
                    item.release_year ? String(item.release_year) : null,
                    `${item.guesses} ${guessWord}`,
                    date && !isNaN(date.getTime()) ? date.toLocaleDateString() : null
                ].filter(Boolean).join(' • ');
                
                const artist = (item.artists && item.artists.length > 0) 
                    ? item.artists.join(', ') 
                    : i18n.t('game.unknownArtist');

                // Update text content
                const titleEl = el.querySelector('.history-title');
                const artistEl = el.querySelector('.history-artist');
                const metaEl = el.querySelector('.history-meta');
                if (titleEl) titleEl.textContent = item.title || '';
                if (artistEl) artistEl.textContent = artist;
                if (metaEl) metaEl.textContent = meta;
                
                // Add game mode badge
                const gameMode = item.gameMode || 'random';
                // Debug: log all gameMode values to see what we're getting
                console.log('History item gameMode:', gameMode, 'item:', item);
                const badge = this.createGameModeBadge(gameMode);
                const actionsEl = el.querySelector('.history-actions');
                if (actionsEl) {
                    actionsEl.appendChild(badge);
                }
                
                listEl.appendChild(el);
            });
        } catch (e) {
            console.warn('history render failed:', e);
            listEl.replaceChildren();
            const tplErr = this.templates.historyError;
            if (tplErr) listEl.appendChild(tplErr.content.firstElementChild.cloneNode(true));
        }
    }
}

