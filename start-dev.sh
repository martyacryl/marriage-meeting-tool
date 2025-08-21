#!/bin/bash

# Quick Start Script for Marriage Meeting Tool Development
# This script sets up and starts the development environment

echo "🚀 Marriage Meeting Tool - Development Quick Start"
echo "=================================================="
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first:"
    echo "   Visit: https://nodejs.org/"
    echo "   Or use: brew install node (on macOS)"
    echo ""
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 14 ]; then
    echo "❌ Node.js version 14 or higher is required. Current version: $(node -v)"
    echo "   Please update Node.js: https://nodejs.org/"
    echo ""
    exit 1
fi

echo "✅ Node.js $(node -v) detected"
echo ""

# Check if we're in the right directory
if [ ! -f "dev.html" ] || [ ! -f "config.js" ]; then
    echo "❌ Please run this script from the marriage-meeting-tool directory"
    echo "   cd marriage-meeting-tool"
    echo "   ./start-dev.sh"
    echo ""
    exit 1
fi

# Check if dev-server.js exists
if [ ! -f "dev-server.js" ]; then
    echo "❌ Development server not found. Please ensure all files are present."
    echo ""
    exit 1
fi

# Make dev-server.js executable
chmod +x dev-server.js

echo "🔧 Starting development server..."
echo ""

# Start the development server
node dev-server.js
