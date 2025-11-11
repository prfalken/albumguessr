// Google Analytics initialization
// Initializes GA only when GA_CONFIG is present and valid

(function() {
    'use strict';
    
    // Only initialize if GA_CONFIG is present and has a measurementId
    if (typeof GA_CONFIG === 'undefined' || !GA_CONFIG || !GA_CONFIG.measurementId) {
        return;
    }
    
    const measurementId = GA_CONFIG.measurementId;
    
    // Load gtag.js script
    const script = document.createElement('script');
    script.async = true;
    script.src = `https://www.googletagmanager.com/gtag/js?id=${measurementId}`;
    document.head.appendChild(script);
    
    // Initialize dataLayer and gtag function
    window.dataLayer = window.dataLayer || [];
    function gtag() {
        window.dataLayer.push(arguments);
    }
    window.gtag = gtag;
    
    // Configure Google Analytics
    gtag('js', new Date());
    gtag('config', measurementId, {
        anonymize_ip: true,
        cookie_flags: 'SameSite=None;Secure'
    });
    
    console.log('Google Analytics initialized with measurement ID:', measurementId);
})();

