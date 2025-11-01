function initNav() {
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

    navList.addEventListener('click', (e) => {
        const target = e.target;
        if (target && target.closest('a')) {
            closeMenu();
        }
    });

    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') closeMenu();
    });

    document.addEventListener('click', (e) => {
        if (!nav.contains(e.target) && e.target !== toggle) {
            closeMenu();
        }
    });
}

document.addEventListener('DOMContentLoaded', initNav);
document.addEventListener('albumguessr:header-ready', initNav);

// Update footer link for admin users
async function updateFooterForAdmin() {
    const footerLink = document.getElementById('footer-1j1f-link');
    if (!footerLink) return;

    try {
        // Check if Auth0 is configured and available
        if (typeof AUTH0_CONFIG !== 'object' || !AUTH0_CONFIG) return;
        if (typeof auth0 === 'undefined') return;

        // Create a minimal auth client to check authentication
        const auth0Client = await auth0.createAuth0Client(AUTH0_CONFIG);
        const isAuthenticated = await auth0Client.isAuthenticated();
        
        if (!isAuthenticated) return;

        // Get access token and fetch profile
        const audience = AUTH0_CONFIG?.authorizationParams?.audience;
        if (!audience) return;
        
        const token = await auth0Client.getTokenSilently({ 
            authorizationParams: { audience } 
        });
        
        if (!token) return;

        // Fetch profile to check admin status
        const response = await fetch('/.netlify/functions/updateProfile', {
            method: 'GET',
            headers: { 'Authorization': `Bearer ${token}` }
        });

        if (!response.ok) return;

        const profile = await response.json();
        
        // If user is admin, update the link
        if (profile && profile.admin === 1) {
            footerLink.href = '/admin.html';
            footerLink.removeAttribute('target');
            console.log('Footer link updated for admin user');
        }
    } catch (error) {
        // Silently fail - this is a progressive enhancement
        console.debug('Could not check admin status for footer link:', error);
    }
}

document.addEventListener('albumguessr:footer-ready', updateFooterForAdmin);


