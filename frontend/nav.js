document.addEventListener('DOMContentLoaded', () => {
    const nav = document.querySelector('.site-nav');
    const toggle = document.querySelector('.nav-toggle');
    const navList = document.getElementById('primary-nav');

    if (!nav || !toggle || !navList) return;

    const closeMenu = () => {
        nav.classList.remove('open');
        toggle.setAttribute('aria-expanded', 'false');
    };

    const openMenu = () => {
        nav.classList.add('open');
        toggle.setAttribute('aria-expanded', 'true');
    };

    toggle.addEventListener('click', () => {
        const isOpen = nav.classList.contains('open');
        if (isOpen) {
            closeMenu();
        } else {
            openMenu();
        }
    });

    // Close when clicking a link
    navList.addEventListener('click', (e) => {
        const target = e.target;
        if (target && target.closest('a')) {
            closeMenu();
        }
    });

    // Close on Escape
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') closeMenu();
    });

    // Close when clicking outside
    document.addEventListener('click', (e) => {
        if (!nav.contains(e.target) && e.target !== toggle) {
            closeMenu();
        }
    });
});


