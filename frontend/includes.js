document.addEventListener('DOMContentLoaded', async () => {
    async function inject(targetSelector, url, readyEventName) {
        const target = document.querySelector(targetSelector);
        if (!target) return false;
        try {
            const res = await fetch(url, { cache: 'no-cache' });
            if (!res.ok) return false;
            const html = await res.text();
            target.innerHTML = html;
            if (readyEventName) {
                document.dispatchEvent(new CustomEvent(readyEventName));
            }
            return true;
        } catch (_) {
            return false;
        }
    }

    // Initialize i18n and language switcher
    const { i18n } = await import('./js/shared/i18n.js');
    const { languageSwitcher } = await import('./js/shared/language-switcher.js');
    
    i18n.init();
    
    const headerInjected = await inject('#site-header', 'partials/header.html', 'albumguessr:header-ready');

    if (headerInjected) {
        // Initialize language switcher
        const rightNav = document.querySelector('.droite .nav-list');
        if (rightNav) {
            languageSwitcher.init(rightNav);
            
            // Listen for language changes and reload translations
            languageSwitcher.onLanguageChange(() => {
                i18n.applyTranslations();
                document.dispatchEvent(new CustomEvent('albumguessr:language-changed'));
            });
        }
        
        // Mark current nav item
        const current = (window.location.pathname.split('/').pop() || 'index.html');
        const navLinks = document.querySelectorAll('#primary-nav a.nav-link');
        navLinks.forEach(a => {
            const href = a.getAttribute('href');
            if (href === current || (current === '' && href === 'index.html')) {
                a.setAttribute('aria-current', 'page');
            } else {
                a.removeAttribute('aria-current');
            }
        });
        
        // Apply translations to static elements with data-i18n
        i18n.applyTranslations();
    }

    await inject('#site-footer', 'partials/footer.html', 'albumguessr:footer-ready');
});


