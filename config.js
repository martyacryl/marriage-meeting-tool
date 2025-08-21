// Configuration file for Marriage Meeting Tool
// Supports multiple environments: development, staging, production

const config = {
  // Development Environment
  development: {
    supabaseUrl: 'https://gkmclzlgrcmqocfoxkui.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdrbWNsemxncmNtcW9jZm94a3VpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU2MDYzNzEsImV4cCI6MjA3MTE4MjM3MX0.ovOR0iMGao5qvrAThrx8KucLyTctiRkVbNJvYdPEyk0',
    serviceRoleKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdrbWNsemxncmNtcW9jZm94a3VpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1NTYwNjM3MSwiZXhwIjoyMDcxMTgyMzcxfQ.Iz1__lQGZmxAiiMlildaypRObXBUzGu72DznKsGxTWk',
    tableName: 'marriage_meetings_dev', // Development table
    enableDebugLogging: true,
    enableMockData: true,
    environment: 'development'
  },

  // Production Environment
  production: {
    supabaseUrl: 'https://gkmclzlgrcmqocfoxkui.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdrbWNsemxncmNtcW9jZm94a3VpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU2MDYzNzEsImV4cCI6MjA3MTE4MjM3MX0.ovOR0iMGao5qvrAThrx8KucLyTctiRkVbNJvYdPEyk0',
    serviceRoleKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdrbWNsemxncmNtcW9jZm94a3VpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1NTYwNjM3MSwiZXhwIjoyMDcxMTgyMzcxfQ.Iz1__lQGZmxAiiMlildaypRObXBUzGUzGu72DznKsGxTWk',
    tableName: 'marriage_meetings', // Production table
    enableDebugLogging: false,
    enableMockData: false,
    environment: 'production'
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
