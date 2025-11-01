/**
 * Language switcher component
 * Handles language dropdown UI and updates
 */

import { i18n } from './i18n.js';

class LanguageSwitcher {
    constructor() {
        this.dropdown = null;
        this.button = null;
        this.isOpen = false;
        this.onLanguageChangeCallbacks = [];
    }

    /**
     * Initialize language switcher
     * @param {HTMLElement} container - Container element for the switcher
     */
    init(container) {
        if (!container) return;

        // Create dropdown structure
        this.createDropdown(container);
        this.bindEvents();
        
        // Set initial language display
        this.updateDisplay();
    }

    /**
     * Create dropdown HTML structure
     * @param {HTMLElement} container - Container element
     */
    createDropdown(container) {
        const li = document.createElement('li');
        li.className = 'language-switcher';
        
        this.button = document.createElement('button');
        this.button.className = 'footer-button language-button';
        this.button.innerHTML = '<i class="bi bi-globe"></i><span class="language-code">EN</span>';
        this.button.setAttribute('aria-expanded', 'false');
        this.button.setAttribute('aria-label', 'Select language');
        
        this.dropdown = document.createElement('ul');
        this.dropdown.className = 'language-dropdown';
        this.dropdown.setAttribute('role', 'menu');
        
        const supportedLangs = i18n.getSupportedLanguages();
        supportedLangs.forEach(lang => {
            const item = document.createElement('li');
            item.className = 'language-item';
            item.setAttribute('role', 'menuitem');
            item.dataset.lang = lang;
            
            const link = document.createElement('a');
            link.href = '#';
            link.className = 'language-link';
            link.textContent = i18n.getLanguageDisplayName(lang);
            link.dataset.lang = lang;
            
            item.appendChild(link);
            this.dropdown.appendChild(item);
        });
        
        li.appendChild(this.button);
        li.appendChild(this.dropdown);
        container.appendChild(li);
    }

    /**
     * Bind event listeners
     */
    bindEvents() {
        if (!this.button || !this.dropdown) return;

        // Toggle dropdown on button click
        this.button.addEventListener('click', (e) => {
            e.preventDefault();
            e.stopPropagation();
            this.toggleDropdown();
        });

        // Handle language selection
        this.dropdown.addEventListener('click', (e) => {
            e.preventDefault();
            e.stopPropagation();
            
            const link = e.target.closest('.language-link');
            if (link && link.dataset.lang) {
                this.selectLanguage(link.dataset.lang);
            }
        });

        // Close dropdown when clicking outside
        document.addEventListener('click', (e) => {
            if (!this.button.contains(e.target) && !this.dropdown.contains(e.target)) {
                this.closeDropdown();
            }
        });

        // Close dropdown on ESC key
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && this.isOpen) {
                this.closeDropdown();
            }
        });
    }

    /**
     * Toggle dropdown open/close
     */
    toggleDropdown() {
        if (this.isOpen) {
            this.closeDropdown();
        } else {
            this.openDropdown();
        }
    }

    /**
     * Open dropdown
     */
    openDropdown() {
        if (!this.button || !this.dropdown) return;
        
        this.isOpen = true;
        this.button.setAttribute('aria-expanded', 'true');
        this.dropdown.classList.add('open');
        
        // Highlight current language
        const currentLang = i18n.getCurrentLanguage();
        this.dropdown.querySelectorAll('.language-item').forEach(item => {
            if (item.dataset.lang === currentLang) {
                item.classList.add('active');
            } else {
                item.classList.remove('active');
            }
        });
    }

    /**
     * Close dropdown
     */
    closeDropdown() {
        if (!this.button || !this.dropdown) return;
        
        this.isOpen = false;
        this.button.setAttribute('aria-expanded', 'false');
        this.dropdown.classList.remove('open');
    }

    /**
     * Select language
     * @param {string} lang - Language code
     */
    selectLanguage(lang) {
        if (!i18n.setLanguage(lang)) return;
        
        this.updateDisplay();
        this.closeDropdown();
        
        // Notify listeners
        this.notifyLanguageChange(lang);
    }

    /**
     * Update button display
     */
    updateDisplay() {
        if (!this.button) return;
        
        const currentLang = i18n.getCurrentLanguage().toUpperCase();
        const codeSpan = this.button.querySelector('.language-code');
        if (codeSpan) {
            codeSpan.textContent = currentLang;
        }
    }

    /**
     * Notify language change listeners
     * @param {string} lang - New language code
     */
    notifyLanguageChange(lang) {
        this.onLanguageChangeCallbacks.forEach(callback => {
            try {
                callback(lang);
            } catch (error) {
                console.error('Error in language change callback:', error);
            }
        });
    }

    /**
     * Register callback for language changes
     * @param {Function} callback - Callback function
     */
    onLanguageChange(callback) {
        if (typeof callback === 'function') {
            this.onLanguageChangeCallbacks.push(callback);
        }
    }
}

// Export singleton instance
export const languageSwitcher = new LanguageSwitcher();

