# Development Setup Guide

## Prerequisites

- Node.js (v18 or higher)
- npm (comes with Node.js)

## Initial Setup

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Build the Neon client:**
   ```bash
   npm run build
   ```

## Development Workflow

### Option 1: Simple Development (Recommended)
1. Build the Neon client: `npm run build`
2. Open `dev.html` directly in your browser
3. The app will work with the bundled Neon client

### Option 2: Development Server
1. Start the development server: `npm run dev`
2. Open `http://localhost:8000/dev.html` in your browser
3. This provides a local server environment

## Build Commands

- `npm run build` - Build the Neon client bundle
- `npm run start` - Start a simple HTTP server on port 8000
- `npm run dev` - Build and start development server

## File Structure

- `src/neon-client.js` - Source file for Neon client
- `dist/neon-client.js` - Bundled Neon client (generated)
- `dev.html` - Main development application
- `build.js` - Build script using esbuild

## Neon Database Integration

The app now uses a properly bundled Neon client that:
- ✅ Works in browsers without CDN issues
- ✅ Provides real database connectivity
- ✅ Falls back to localStorage if database is unavailable
- ✅ Supports cross-device data sharing

## Troubleshooting

### If the Neon client doesn't load:
1. Run `npm run build` to regenerate the bundle
2. Check browser console for errors
3. Ensure `dist/neon-client.js` exists

### If database connection fails:
1. Verify your Neon connection string in `dev.html`
2. Check that your Neon database is accessible
3. The app will fall back to localStorage automatically

## Production Deployment

For production, you can:
1. Use the bundled client from `dist/neon-client.js`
2. Deploy the HTML file and dist folder to any static hosting
3. The Neon client will work in production browsers
