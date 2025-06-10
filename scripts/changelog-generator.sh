#!/bin/bash
# ✨IntelliCommerce✨ Woo MCP - Enhanced Changelog Generator
# Made with 🧡 in Cape Town 🇿🇦
# Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${BLUE}📈 Generating Enhanced Changelog...${NC}"

# Function to generate dependency changelog
generate_dependency_changelog() {
    echo -e "${BLUE}📦 Generating dependency changelog...${NC}"

    # Create temporary file for dependency changes
    DEPS_LOG="/tmp/dependency-changes.md"

    # Get the last release tag
    LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "")

    if [[ -n "$LAST_TAG" ]]; then
        echo "### 📦 Dependency Updates Since $LAST_TAG" > "$DEPS_LOG"
        echo "" >> "$DEPS_LOG"

        # Check for package.json changes since last tag
        if git diff --name-only "$LAST_TAG" HEAD | grep -q "package.json"; then
            echo "#### Updated Dependencies:" >> "$DEPS_LOG"
            echo "" >> "$DEPS_LOG"

            # Get dependency changes
            git log --oneline --grep="deps:" --grep="dependencies" --grep="📦" "$LAST_TAG"..HEAD | while IFS= read -r line; do
                echo "- $line" >> "$DEPS_LOG"
            done

            echo "" >> "$DEPS_LOG"
        fi

        # Check for security updates
        if git log --oneline --grep="security" --grep="🔒" "$LAST_TAG"..HEAD | grep -q .; then
            echo "#### Security Updates:" >> "$DEPS_LOG"
            echo "" >> "$DEPS_LOG"

            git log --oneline --grep="security" --grep="🔒" "$LAST_TAG"..HEAD | while IFS= read -r line; do
                echo "- $line" >> "$DEPS_LOG"
            done

            echo "" >> "$DEPS_LOG"
        fi
    else
        echo "### 📦 Initial Dependencies" > "$DEPS_LOG"
        echo "" >> "$DEPS_LOG"
        echo "- Initial project setup with comprehensive dependency management" >> "$DEPS_LOG"
        echo "" >> "$DEPS_LOG"
    fi
}

# Function to update the main changelog
update_main_changelog() {
    echo -e "${BLUE}📝 Updating main changelog...${NC}"

    # Backup current changelog
    if [[ -f "CHANGELOG.md" ]]; then
        cp CHANGELOG.md CHANGELOG.md.backup
        echo -e "${GREEN}✅ Backed up existing changelog${NC}"
    fi

    # Generate new changelog with standard-version
    npm run release:dry > /tmp/release-dry.log 2>&1 || echo "Dry run completed"

    echo -e "${GREEN}✅ Generated standard changelog${NC}"
}

# Function to add custom sections
add_custom_sections() {
    echo -e "${BLUE}🎨 Adding custom sections...${NC}"

    # Get current version from package.json
    CURRENT_VERSION=$(node -p "require('./package.json').version")

    # Create enhanced changelog header
    cat > /tmp/changelog-header.md << EOF
# 📈 IntelliCommerce✨ Woo MCP - Changelog

**Made with 🧡 in Cape Town 🇿🇦**
**Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**

## Project Overview

The **IntelliCommerce✨ Woo MCP** is a commercial-grade Model Context Protocol server that enables AI assistants to interact with WooCommerce stores. This changelog tracks all feature additions, improvements, and dependency updates.

---

EOF

    echo -e "${GREEN}✅ Created enhanced header${NC}"
}

# Function to generate development changelog
generate_dev_changelog() {
    echo -e "${BLUE}🔧 Generating development changelog...${NC}"

    # Get unreleased changes
    echo "### 🚧 Unreleased Changes" > /tmp/unreleased.md
    echo "" >> /tmp/unreleased.md

    # Get commits since last tag
    LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "HEAD~10")

    echo "#### Recent Commits:" >> /tmp/unreleased.md
    git log --oneline --pretty=format:"- %s (%h)" "$LAST_TAG"..HEAD >> /tmp/unreleased.md
    echo "" >> /tmp/unreleased.md
    echo "" >> /tmp/unreleased.md
}

# Function to combine all changelogs
combine_changelogs() {
    echo -e "${BLUE}🔗 Combining changelog sections...${NC}"

    # Create final changelog
    cat > CHANGELOG.md << EOF
# 📈 IntelliCommerce✨ Woo MCP - Changelog

**Made with 🧡 in Cape Town 🇿🇦**
**Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**

## Project Overview

The **IntelliCommerce✨ Woo MCP** is a commercial-grade Model Context Protocol server that enables AI assistants to interact with WooCommerce stores. This changelog tracks all feature additions, improvements, and dependency updates.

---

EOF

    # Add unreleased changes if they exist
    if [[ -f "/tmp/unreleased.md" ]]; then
        cat /tmp/unreleased.md >> CHANGELOG.md
    fi

    # Add dependency changes if they exist
    if [[ -f "/tmp/dependency-changes.md" ]]; then
        cat /tmp/dependency-changes.md >> CHANGELOG.md
    fi

    # Add the main changelog content (skip the header)
    if [[ -f "docs/CHANGELOG.md" ]]; then
        tail -n +6 docs/CHANGELOG.md >> CHANGELOG.md
    fi

    echo -e "${GREEN}✅ Combined all changelog sections${NC}"
}

# Function to validate changelog
validate_changelog() {
    echo -e "${BLUE}✅ Validating changelog...${NC}"

    if [[ -f "CHANGELOG.md" ]]; then
        # Check if changelog has content
        if [[ $(wc -l < CHANGELOG.md) -gt 10 ]]; then
            echo -e "${GREEN}✅ Changelog generated successfully${NC}"
            echo -e "${BLUE}📊 Changelog stats:${NC}"
            echo -e "  Lines: $(wc -l < CHANGELOG.md)"
            echo -e "  Words: $(wc -w < CHANGELOG.md)"
            echo -e "  Size: $(du -h CHANGELOG.md | cut -f1)"
        else
            echo -e "${YELLOW}⚠️  Changelog seems small, please review${NC}"
        fi
    else
        echo -e "${RED}❌ Failed to generate changelog${NC}"
        exit 1
    fi
}

# Main execution
main() {
    echo -e "${PURPLE}🚀 Starting Enhanced Changelog Generation${NC}"
    echo -e "${BLUE}Made with 🧡 in Cape Town 🇿🇦${NC}"
    echo ""

    # Check if we're in git repo
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo -e "${RED}❌ Not in a git repository${NC}"
        exit 1
    fi

    # Generate different changelog sections
    generate_dependency_changelog
    generate_dev_changelog
    add_custom_sections
    combine_changelogs
    validate_changelog

    echo ""
    echo -e "${GREEN}🎉 Changelog generation completed!${NC}"
    echo -e "${BLUE}📁 Generated: CHANGELOG.md${NC}"
    echo -e "${YELLOW}💡 Run 'npm run release' to create a new version${NC}"

    # Cleanup
    rm -f /tmp/dependency-changes.md /tmp/unreleased.md /tmp/changelog-header.md
}

# Check command line arguments
case "${1:-generate}" in
    "generate")
        main
        ;;
    "deps")
        generate_dependency_changelog
        echo -e "${GREEN}✅ Dependency changelog generated${NC}"
        ;;
    "dev")
        generate_dev_changelog
        echo -e "${GREEN}✅ Development changelog generated${NC}"
        ;;
    *)
        echo "Usage: $0 [generate|deps|dev]"
        echo "  generate: Generate full changelog (default)"
        echo "  deps: Generate dependency changelog only"
        echo "  dev: Generate development changelog only"
        exit 1
        ;;
esac
