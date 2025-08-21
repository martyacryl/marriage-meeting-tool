#!/usr/bin/env node

/**
 * Simple Development Server for Marriage Meeting Tool
 * 
 * This script provides a basic HTTP server for local development.
 * It serves static files and provides basic routing for the development environment.
 */

const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

// Configuration
const PORT = process.env.PORT || 3000;
const HOST = 'localhost';

// MIME types for different file extensions
const mimeTypes = {
    '.html': 'text/html',
    '.js': 'text/javascript',
    '.css': 'text/css',
    '.json': 'application/json',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.gif': 'image/gif',
    '.svg': 'image/svg+xml',
    '.ico': 'image/x-icon',
    '.sql': 'text/plain',
    '.md': 'text/markdown'
};

// Create HTTP server
const server = http.createServer((req, res) => {
    const parsedUrl = url.parse(req.url, true);
    let pathname = parsedUrl.pathname;
    
    // Default to dev.html for root path
    if (pathname === '/') {
        pathname = '/dev.html';
    }
    
    // Remove leading slash
    pathname = pathname.substring(1);
    
    // Security: prevent directory traversal
    if (pathname.includes('..')) {
        res.writeHead(403, { 'Content-Type': 'text/plain' });
        res.end('Forbidden');
        return;
    }
    
    // Get file path
    const filePath = path.join(__dirname, pathname);
    
    // Check if file exists
    fs.access(filePath, fs.constants.F_OK, (err) => {
        if (err) {
            // File not found
            res.writeHead(404, { 'Content-Type': 'text/html' });
            res.end(`
                <!DOCTYPE html>
                <html>
                <head>
                    <title>404 - File Not Found</title>
                    <style>
                        body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
                        .error { color: #dc2626; font-size: 24px; margin-bottom: 20px; }
                        .message { color: #6b7280; margin-bottom: 30px; }
                        .links { display: flex; justify-content: center; gap: 20px; }
                        .links a { color: #059669; text-decoration: none; padding: 10px 20px; border: 2px solid #059669; border-radius: 5px; }
                        .links a:hover { background: #059669; color: white; }
                    </style>
                </head>
                <body>
                    <div class="error">🚧 404 - File Not Found</div>
                    <div class="message">The requested file could not be found on this development server.</div>
                    <div class="links">
                        <a href="/">Development Version</a>
                        <a href="/index.html">Production Version</a>
                        <a href="/DEV_README.md">Development Guide</a>
                    </div>
                </body>
                </html>
            `);
            return;
        }
        
        // Get file extension
        const ext = path.extname(filePath).toLowerCase();
        const contentType = mimeTypes[ext] || 'application/octet-stream';
        
        // Read and serve file
        fs.readFile(filePath, (err, data) => {
            if (err) {
                res.writeHead(500, { 'Content-Type': 'text/plain' });
                res.end('Internal Server Error');
                return;
            }
            
            // Set CORS headers for development
            res.setHeader('Access-Control-Allow-Origin', '*');
            res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
            res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
            
            // Handle preflight requests
            if (req.method === 'OPTIONS') {
                res.writeHead(200);
                res.end();
                return;
            }
            
            res.writeHead(200, { 'Content-Type': contentType });
            res.end(data);
        });
    });
});

// Start server
server.listen(PORT, HOST, () => {
    console.log(`
🚀 Marriage Meeting Tool - Development Server
==============================================

📍 Server running at: http://${HOST}:${PORT}
🔧 Development version: http://${HOST}:${PORT}/dev.html
🚀 Production version: http://${HOST}:${PORT}/index.html
📚 Development guide: http://${HOST}:${PORT}/DEV_README.md

💡 Tips:
   - Open http://${HOST}:${PORT} to start developing
   - Use the dev tools button (bottom right) for testing
   - Check the console for debug logs
   - Load mock data to test functionality

🛑 Press Ctrl+C to stop the server
    `);
});

// Handle graceful shutdown
process.on('SIGINT', () => {
    console.log('\n\n🛑 Shutting down development server...');
    server.close(() => {
        console.log('✅ Development server stopped');
        process.exit(0);
    });
});

// Handle errors
server.on('error', (err) => {
    if (err.code === 'EADDRINUSE') {
        console.error(`❌ Port ${PORT} is already in use`);
        console.error(`💡 Try using a different port: PORT=3001 node dev-server.js`);
    } else {
        console.error('❌ Server error:', err);
    }
    process.exit(1);
});
