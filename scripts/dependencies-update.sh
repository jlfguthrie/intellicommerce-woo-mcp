#!/bin/bash
# ✨IntelliCommerce✨ Woo MCP - Dependency Update Manager
# Made with 🧡 in Cape Town 🇿🇦
# Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

set -e

echo "📦 Managing package dependencies..."

# Install npm-check-updates if not present
if ! command -v ncu &> /dev/null; then
    echo "📥 Installing npm-check-updates..."
    npm install -g npm-check-updates
fi

# Check for outdated packages
echo "🔍 Checking for outdated packages..."
echo ""
echo "📊 Current outdated packages:"
ncu

echo ""
echo "🔒 Security audit..."
npm audit

# Function to update packages safely
update_packages() {
    local update_type=$1

    case $update_type in
        "patch")
            echo "🩹 Updating patch versions only..."
            ncu -u --target patch
            ;;
        "minor")
            echo "📈 Updating minor versions..."
            ncu -u --target minor
            ;;
        "major")
            echo "🚀 Updating major versions (CAUTION!)..."
            ncu -u --target latest
            ;;
        "interactive")
            echo "🎯 Interactive update selection..."
            ncu -i
            ;;
        *)
            echo "Usage: $0 [patch|minor|major|interactive]"
            echo "  patch: Update patch versions only (safest)"
            echo "  minor: Update minor versions (safe)"
            echo "  major: Update major versions (breaking changes possible)"
            echo "  interactive: Choose which packages to update"
            return 1
            ;;
    esac

    if [[ -f "package-lock.json" ]]; then
        echo "🔄 Updating package-lock.json..."
        npm install
    fi

    echo "🧪 Running tests after update..."
    npm run test:unit

    echo "🔨 Testing build..."
    npm run build

    echo "✅ Package updates completed successfully!"
}

# If argument provided, run update
if [[ $# -gt 0 ]]; then
    update_packages "$1"
else
    echo ""
    echo "💡 To update packages, run:"
    echo "  ./scripts/dependencies-update.sh patch   # Safest: patch updates only"
    echo "  ./scripts/dependencies-update.sh minor   # Safe: minor updates"
    echo "  ./scripts/dependencies-update.sh major   # Caution: major updates"
    echo "  ./scripts/dependencies-update.sh interactive  # Choose updates"
fi
