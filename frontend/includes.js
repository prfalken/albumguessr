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

    const headerInjected = await inject('#site-header', 'partials/header.html', 'albumguessr:header-ready');

    if (headerInjected) {
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
    }

    await inject('#site-footer', 'partials/footer.html', 'albumguessr:footer-ready');
});


