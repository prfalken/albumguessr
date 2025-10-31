/**
 * Shared statistics calculation and rendering
 * Computes and displays user stats based on their game history
 */
export class StatsRenderer {
    /**
     * Compute statistics from user history
     * @param {Array} history - Array of history entries
     * @returns {Object} Computed statistics
     */
    computeStats(history) {
        const totalWins = history.length;
        const guessesList = history.map(h => Number(h.guesses || 0)).filter(n => !isNaN(n) && n > 0);
        const avgGuesses = guessesList.length ? (guessesList.reduce((a,b)=>a+b,0) / guessesList.length) : 0;
        const fastest = history.reduce((min, h) => (!min || (h.guesses||999) < min.guesses) ? h : min, null);
        const slowest = history.reduce((max, h) => (!max || (h.guesses||0) > max.guesses) ? h : max, null);

        // Group wins by day
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

        // Calculate streaks
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

        // Check if current streak is active (today or yesterday)
        const today = new Date();
        const todayKey = `${today.getUTCFullYear()}-${String(today.getUTCMonth()+1).padStart(2,'0')}-${String(today.getUTCDate()).padStart(2,'0')}`;
        const yesterday = new Date(Date.UTC(today.getUTCFullYear(), today.getUTCMonth(), today.getUTCDate()-1));
        const yesterdayKey = `${yesterday.getUTCFullYear()}-${String(yesterday.getUTCMonth()+1).padStart(2,'0')}-${String(yesterday.getUTCDate()).padStart(2,'0')}`;
        if (!byDay.has(todayKey) && !byDay.has(yesterdayKey)) {
            currentStreak = byDay.has(sortedDays[sortedDays.length-1]) ? 1 : 0;
        }

        // Year statistics
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

    /**
     * Build stat card DOM elements
     * @param {Object} stats - Computed statistics
     * @returns {HTMLElement[]} Array of stat card elements
     */
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
        cards.push(make('bi-lightning-charge', 'Fastest win', 
            stats.fastest ? `${stats.fastest.guesses} guess(es)` : '—', 
            stats.fastest ? `${stats.fastest.title}` : undefined));
        cards.push(make('bi-hourglass-split', 'Slowest win', 
            stats.slowest ? `${stats.slowest.guesses} guess(es)` : '—', 
            stats.slowest ? `${stats.slowest.title}` : undefined));
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

    /**
     * Render statistics to a container
     * @param {HTMLElement} container - Container element for stats cards
     * @param {Array} history - User history data
     */
    render(container, history) {
        if (!container) return;
        
        container.replaceChildren();
        
        if (!history || history.length === 0) {
            return;
        }

        const stats = this.computeStats(history);
        const cards = this.buildStatCards(stats);
        cards.forEach(card => container.appendChild(card));
    }
}

