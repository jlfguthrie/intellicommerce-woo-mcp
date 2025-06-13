#!/bin/bash

# ✨IntelliCommerce✨ Woo MCP - Local Release Script
# Made with 🧡 in Cape Town 🇿🇦
# Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

set -e

RELEASE_TYPE=${1:-patch}

echo "🚀 ✨IntelliCommerce✨ Woo MCP - Local Release"
echo "=============================================="
echo "Made with 🧡 in Cape Town 🇿🇦"
echo ""
echo "Release type: $RELEASE_TYPE"
echo ""

# Function to print step headers
print_step() {
    echo ""
    echo "🔍 $1"
    echo "----------------------------------------"
}

# Validate release type
if [[ ! "$RELEASE_TYPE" =~ ^(patch|minor|major)$ ]]; then
    echo "❌ Error: Release type must be 'patch', 'minor', or 'major'"
    echo "Usage: $0 [patch|minor|major]"
    exit 1
fi

# Check if we're in the right directory
if [ ! -f "package.json" ] || [ ! -f "src/server.ts" ]; then
    echo "❌ Error: Run this script from the project root directory"
    exit 1
fi

# Check if git working directory is clean
if [ -n "$(git status --porcelain)" ]; then
    echo "❌ Error: Git working directory is not clean"
    echo "Please commit or stash your changes first"
    git status
    exit 1
fi

print_step "Pre-Release Validation"
echo "Running full sanity check..."
npm run sanity:check

print_step "Version Bump"
echo "Current version: $(node -p "require('./package.json').version")"

# Bump version
npm version $RELEASE_TYPE --no-git-tag-version
NEW_VERSION=$(node -p "require('./package.json').version")
echo "New version: $NEW_VERSION"

print_step "Final Build"
npm run build

print_step "Generate Changelog"
npm run changelog:generate

print_step "Git Commit & Tag"
git add .
git commit -m "🚀 release: v$NEW_VERSION

- Bump version to $NEW_VERSION
- Update changelog
- Build for release

Made with 🧡 in Cape Town 🇿🇦"

git tag "v$NEW_VERSION"

print_step "Publish to npm"
echo "Publishing to npm registry..."
npm publish --access public

print_step "Push to GitHub"
git push origin main
git push origin "v$NEW_VERSION"

print_step "Create GitHub Release (Optional)"
echo "Creating GitHub release..."
if command -v gh &> /dev/null; then
    gh release create "v$NEW_VERSION" \
        --title "🚀 v$NEW_VERSION" \
        --notes "Release v$NEW_VERSION

Made with 🧡 in Cape Town 🇿🇦
Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

See CHANGELOG.md for details." \
        || echo "⚠️ GitHub release creation failed (not critical)"
else
    echo "⚠️ GitHub CLI not installed, skipping GitHub release"
    echo "💡 Install with: brew install gh"
fi

echo ""
echo "🎉 Release v$NEW_VERSION completed successfully!"
echo ""
echo "📋 What happened:"
echo "   ✅ Version bumped to v$NEW_VERSION"
echo "   ✅ Built and tested"
echo "   ✅ Published to npm"
echo "   ✅ Pushed to GitHub"
echo "   ✅ GitHub release created"
echo ""
echo "🔗 Links:"
echo "   📦 npm: https://www.npmjs.com/package/intellicommerce-woo-mcp"
echo "   🐙 GitHub: https://github.com/jlfguthrie/intellicommerce-woo-mcp"
echo ""
echo "✨ Made with 🧡 in Cape Town 🇿🇦 ✨"
