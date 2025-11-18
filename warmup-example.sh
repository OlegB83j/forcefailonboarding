#!/bin/bash
# Example warmup script for testing dependency installation
# This demonstrates what the remote environment should check

set -e

echo "🚀 Starting warmup script..."
echo ""

# Check if Node.js is available
echo "✓ Checking Node.js..."
if command -v node &> /dev/null; then
    echo "  Node.js version: $(node --version)"
else
    echo "  ❌ Node.js not found!"
    exit 1
fi

# Check if npm is available
echo "✓ Checking npm..."
if command -v npm &> /dev/null; then
    echo "  npm version: $(npm --version)"
else
    echo "  ❌ npm not found!"
    exit 1
fi

# Check if package.json exists
echo "✓ Checking package.json..."
if [ ! -f "package.json" ]; then
    echo "  ❌ package.json not found!"
    exit 1
fi

# Check if node_modules exists
echo "✓ Checking dependencies..."
if [ ! -d "node_modules" ]; then
    echo "  ⚠️  node_modules not found. Installing dependencies..."
    npm install
else
    echo "  node_modules exists. Checking for missing dependencies..."
    
    # Check critical dependencies
    MISSING_DEPS=()
    
    # Check for runtime dependencies
    [ ! -d "node_modules/axios" ] && MISSING_DEPS+=("axios")
    [ ! -d "node_modules/clsx" ] && MISSING_DEPS+=("clsx")
    [ ! -d "node_modules/date-fns" ] && MISSING_DEPS+=("date-fns")
    [ ! -d "node_modules/react" ] && MISSING_DEPS+=("react")
    [ ! -d "node_modules/react-dom" ] && MISSING_DEPS+=("react-dom")
    
    # Check for dev dependencies
    [ ! -d "node_modules/vite" ] && MISSING_DEPS+=("vite")
    [ ! -d "node_modules/sass" ] && MISSING_DEPS+=("sass")
    [ ! -d "node_modules/vite-plugin-inspect" ] && MISSING_DEPS+=("vite-plugin-inspect")
    [ ! -d "node_modules/@vitejs/plugin-react" ] && MISSING_DEPS+=("@vitejs/plugin-react")
    
    if [ ${#MISSING_DEPS[@]} -gt 0 ]; then
        echo "  ⚠️  Missing dependencies detected: ${MISSING_DEPS[*]}"
        echo "  Installing missing dependencies..."
        npm install
    else
        echo "  ✓ All critical dependencies are present"
    fi
fi

# Verify that key dependencies are importable
echo "✓ Verifying dependency integrity..."
node -e "
try {
    require('axios');
    require('clsx');
    require('date-fns');
    require('vite');
    require('sass');
    console.log('  ✓ All critical dependencies can be loaded');
} catch (err) {
    console.error('  ❌ Failed to load dependencies:', err.message);
    process.exit(1);
}
"

# Test that vite config is valid
echo "✓ Validating Vite configuration..."
if [ -f "vite.config.js" ]; then
    node -e "
    try {
        require('./vite.config.js');
        console.log('  ✓ Vite config is valid');
    } catch (err) {
        console.error('  ❌ Invalid Vite config:', err.message);
        process.exit(1);
    }
    "
else
    echo "  ❌ vite.config.js not found!"
    exit 1
fi

echo ""
echo "✅ Warmup complete! Ready to start dev server."
echo ""
echo "To start the development server, run:"
echo "  npm run dev"

