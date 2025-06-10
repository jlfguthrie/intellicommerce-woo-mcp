#!/bin/bash
# ✨IntelliCommerce✨ Woo MCP - Release Script
# Made with 🧡 in Cape Town 🇿🇦
# Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

set -e

echo "🚀 IntelliCommerce✨ Woo MCP Release Pipeline"
echo "============================================="

# Check if we're on main branch
BRANCH=$(git branch --show-current)
if [ "$BRANCH" != "main" ]; then
  echo "❌ Must be on main branch to release. Current: $BRANCH"
  exit 1
fi

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
  echo "❌ Working directory not clean. Please commit or stash changes."
  exit 1
fi

# Pull latest changes
echo "📥 Pulling latest changes..."
git pull origin main

# Run full validation
echo "🔍 Running validation pipeline..."
npm run validate

# Ask for release type
echo ""
echo "🏷️ Select release type:"
echo "1) patch (1.0.1 → 1.0.2)"
echo "2) minor (1.0.1 → 1.1.0)"
echo "3) major (1.0.1 → 2.0.0)"
echo "4) custom"
echo ""
read -p "Choose (1-4): " choice

case $choice in
  1)
    RELEASE_TYPE="patch"
    ;;
  2)
    RELEASE_TYPE="minor"
    ;;
  3)
    RELEASE_TYPE="major"
    ;;
  4)
    read -p "Enter version (e.g., 1.2.3): " CUSTOM_VERSION
    RELEASE_TYPE="--release-as $CUSTOM_VERSION"
    ;;
  *)
    echo "❌ Invalid choice"
    exit 1
    ;;
esac

echo ""
echo "🏗️ Creating release..."

# Dry run first
npm run release:dry

echo ""
read -p "Continue with release? (y/N): " confirm
if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
  echo "❌ Release cancelled"
  exit 1
fi

# Create release
if [ "$choice" = "4" ]; then
  npm run release -- $RELEASE_TYPE
else
  npm run release:$RELEASE_TYPE
fi

# Build and publish
echo "📦 Building and publishing..."
npm run build
npm publish

# Push tags
echo "📤 Pushing changes and tags..."
git push --follow-tags origin main

echo ""
echo "✅ Release complete! 🎉"
echo "Made with 🧡 in Cape Town 🇿🇦"
