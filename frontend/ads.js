// Google AdSense initialization
// Initializes AdSense only when ADS_CONFIG is present and valid (same pattern as analytics.js)

(function() {
    'use strict';

    if (typeof ADS_CONFIG === 'undefined' || !ADS_CONFIG || !ADS_CONFIG.clientId) {
        return;
    }

    const clientId = ADS_CONFIG.clientId;

    // Load the AdSense loader script once
    const script = document.createElement('script');
    script.async = true;
    script.src = `https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=${clientId}`;
    script.crossOrigin = 'anonymous';
    document.head.appendChild(script);

    window.adsbygoogle = window.adsbygoogle || [];

    // Stamps every <ins class="adsbygoogle"> that hasn't been requested yet.
    // Ad slots injected later (e.g. the footer partial) are picked up via the
    // 'albumguessr:footer-ready' event dispatched by includes.js.
    // Markup only declares data-ad-slot; the client ID is filled in here so it
    // stays in one place (ADS_CONFIG, generated from the ADSENSE_CLIENT_ID env var).
    function activateAdSlots(root) {
        const slots = (root || document).querySelectorAll('ins.adsbygoogle:not([data-ads-initialized])');
        slots.forEach((slot) => {
            slot.setAttribute('data-ad-client', clientId);
            slot.setAttribute('data-ads-initialized', 'true');
            try {
                window.adsbygoogle.push({});
            } catch (_) {
                // AdSense not yet ready or blocked (ad blocker) — ignore
            }
        });
    }

    document.addEventListener('DOMContentLoaded', () => activateAdSlots(document));
    document.addEventListener('albumguessr:footer-ready', () => activateAdSlots(document));
})();
