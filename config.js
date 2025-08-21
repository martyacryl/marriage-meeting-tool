// Configuration file for Marriage Meeting Tool
// Supports multiple environments: development, staging, production

const config = {
  // Development Environment
  development: {
    supabaseUrl: 'https://gkmclzlgrcmqocfoxkui.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpydXRxZGVzdXJuYW5zeWZ5ZGJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU1NTA4MzgsImV4cCI6MjA3MTEyNjgzOH0.G-sTw0eF-tQEcqvbaz-hSM2h0KVr2NMOYMq4x0iwIIc',
    serviceRoleKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpydXRxZGVzdXJuYW5zeWZ5ZGJmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1NTU1MDgzOCwiZXhwIjoyMDcxMTI2ODM4fQ.DZFYORSXw99L7SmqoB-KHGf-F4RpTO99PC2wLCA1RBA',
    tableName: 'marriage_meetings_dev', // Development table
    enableDebugLogging: true,
    enableMockData: true,
    environment: 'development',
    netlifyUrl: 'https://stjohnmarriagemeetingsdev.netlify.app' // TODO: Replace with your actual dev Netlify URL
  },

  // Production Environment
  production: {
    supabaseUrl: 'https://gkmclzlgrcmqocfoxkui.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpydXRxZGVzdXJuYW5zeWZ5ZGJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU1NTA4MzgsImV4cCI6MjA3MTEyNjgzOH0.G-sTw0eF-tQEcqvbaz-hSM2h0KVr2NMOYMq4x0iwIIc',
    serviceRoleKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpydXRxZGVzdXJuYW5zeWZ5ZGJmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1NTU1MDgzOCwiZXhwIjoyMDcxMTI2ODM4fQ.DZFYORSXw99L7SmqoB-KHGf-F4RpTO99PC2wLCA1RBA',
    tableName: 'marriage_meetings', // Production table
    enableDebugLogging: false,
    enableMockData: false,
    environment: 'production',
    netlifyUrl: 'https://stjohnmarriagemeetings.netlify.app/' // TODO: Replace with your actual prod Netlify URL
  }
};

// Get current environment (default to development)
const getCurrentEnvironment = () => {
  const urlParams = new URLSearchParams(window.location.search);
  const env = urlParams.get('env') || 'development';
  return env in config ? env : 'development';
};

// Get current config
const getConfig = () => {
  const env = getCurrentEnvironment();
  return config[env];
};

// Export for use in other files
if (typeof module !== 'undefined' && module.exports) {
  module.exports = { config, getCurrentEnvironment, getConfig };
} else {
  window.appConfig = { config, getCurrentEnvironment, getConfig };
}
