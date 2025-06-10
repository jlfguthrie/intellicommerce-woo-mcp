#!/bin/bash

# ✨IntelliCommerce✨ Woo MCP - Automated Publishing Script
# Made with 🧡 in Cape Town 🇿🇦
# Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

set -e

echo "🚀 IntelliCommerce✨ Automated Publishing"
echo "Made with 🧡 in Cape Town 🇿🇦"
echo ""

# Check if we're logged in to npm
if npm whoami > /dev/null 2>&1; then
    echo "✅ Already authenticated with npm as: $(npm whoami)"
else
    echo "❌ Not authenticated with npm"

    if [ -n "$NPM_TOKEN" ]; then
        echo "🔑 Using NPM_TOKEN for authentication"
        echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > ~/.npmrc
        echo "✅ NPM authentication configured"
    else
        echo "⚠️  No NPM_TOKEN found. Please either:"
        echo "   1. Set NPM_TOKEN environment variable"
        echo "   2. Run 'npm login' manually"
        exit 1
    fi
fi

# Pre-publish validation
echo "🔍 Running pre-publish validation..."
npm run pre-publish

# Build the project
echo "🔨 Building project..."
npm run build

# Publish to npm
echo "📦 Publishing to npm..."
if [ "$1" = "--dry-run" ]; then
    echo "🧪 Dry run mode - not actually publishing"
    npm publish --dry-run
else
    npm publish --access public
    echo "✅ Successfully published to npm!"
fi

echo ""
echo "🎉 Publishing process complete!"
echo "✨ Made with 🧡 in Cape Town 🇿🇦 ✨"
