/**
 * Shared history rendering logic
 * Renders user's album history in a consistent format across pages
 */
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
     * Render user history
     * @param {Array} history - Array of history entries
     * @param {boolean} isAuthenticated - Whether user is authenticated
     */
    async render(history, isAuthenticated) {
        const subtitleEl = this.elements.userHistorySubtitle;
        const listEl = this.elements.userHistoryList;
        
        if (!subtitleEl || !listEl) return;

        if (!isAuthenticated) {
            subtitleEl.textContent = 'Log in to save and see your history';
            listEl.replaceChildren();
            return;
        }

        subtitleEl.textContent = 'Recent wins saved to your account';
        
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
                const meta = [
                    item.release_year ? String(item.release_year) : null,
                    `${item.guesses} guess${item.guesses === 1 ? '' : 'es'}`,
                    date && !isNaN(date.getTime()) ? date.toLocaleDateString() : null
                ].filter(Boolean).join(' • ');
                
                const artist = (item.artists && item.artists.length > 0) 
                    ? item.artists.join(', ') 
                    : 'Unknown artist';

                // Update text content
                const titleEl = el.querySelector('.history-title');
                const artistEl = el.querySelector('.history-artist');
                const metaEl = el.querySelector('.history-meta');
                if (titleEl) titleEl.textContent = item.title || '';
                if (artistEl) artistEl.textContent = artist;
                if (metaEl) metaEl.textContent = meta;
                
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

