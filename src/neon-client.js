// Neon Database Client for Browser
import { neon } from '@neondatabase/serverless';

// Wait for the DOM to be fully loaded before setting global variables
document.addEventListener('DOMContentLoaded', () => {
    // Export the neon function for use in the browser
    window.neonClient = neon;
    
    // Also export it as a global function for backward compatibility
    window.neon = neon;
    
    console.log('✅ [NEON] Client loaded and exported to window.neonClient and window.neon');
});

// Also try to set immediately in case DOMContentLoaded already fired
if (document.readyState === 'loading') {
    // Document still loading, wait for DOMContentLoaded
} else {
    // Document already loaded, set immediately
    window.neonClient = neon;
    window.neon = neon;
    console.log('✅ [NEON] Client loaded and exported immediately to window.neonClient and window.neon');
}
