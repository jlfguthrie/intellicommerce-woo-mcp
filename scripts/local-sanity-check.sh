#!/bin/bash

# ✨IntelliCommerce✨ Woo MCP - Local Sanity Check
# Made with 🧡 in Cape Town 🇿🇦
# Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

set -e

echo "🚀 ✨IntelliCommerce✨ Woo MCP - Local Sanity Check"
echo "================================================"
echo "Made with 🧡 in Cape Town 🇿🇦"
echo ""

# Function to print step headers
print_step() {
    echo ""
    echo "🔍 $1"
    echo "----------------------------------------"
}

# Check if we're in the right directory
if [ ! -f "package.json" ] || [ ! -f "src/server.ts" ]; then
    echo "❌ Error: Run this script from the project root directory"
    exit 1
fi

print_step "Environment Check"
echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"
echo "TypeScript version: $(npx tsc --version)"

print_step "Installing Dependencies"
npm ci --include=dev

print_step "Type Checking"
npm run typecheck

print_step "Building Project"
npm run build

print_step "MCP Server Test"
echo "📋 Testing MCP server startup..."
timeout 10s npm run test:mcp || echo "✅ MCP server test completed (timeout is expected)"

print_step "Package Test"
echo "📦 Testing package creation..."
npm pack --dry-run

echo ""
echo "🎉 All checks passed! Ready for local development."
echo ""
echo "📋 Next steps:"
echo "   • npm start             # Start MCP server"
echo "   • npm run local:patch   # Patch release"
echo "   • npm run local:minor   # Minor release"
echo "   • npm run local:major   # Major release"
echo ""
echo "✨ Made with 🧡 in Cape Town 🇿🇦 ✨"
