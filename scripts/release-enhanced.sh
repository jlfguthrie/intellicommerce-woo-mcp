#!/bin/bash
# ✨IntelliCommerce✨ Woo MCP - Enhanced Release Script
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

echo -e "${PURPLE}🚀 IntelliCommerce✨ Enhanced Release Process${NC}"
echo -e "${BLUE}Made with 🧡 in Cape Town 🇿🇦${NC}"
echo ""

# Function to check if we're on the right branch
check_branch() {
    CURRENT_BRANCH=$(git branch --show-current)
    if [[ "$CURRENT_BRANCH" != "main" && "$CURRENT_BRANCH" != "feature/"* ]]; then
        echo -e "${YELLOW}⚠️  Warning: You're on branch '$CURRENT_BRANCH'${NC}"
        echo -e "${YELLOW}💡 Releases are typically done from 'main' branch${NC}"
        read -p "Continue anyway? [y/N]: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${RED}❌ Release cancelled${NC}"
            exit 1
        fi
    fi
}

# Function to check working directory
check_working_directory() {
    if ! git diff-index --quiet HEAD --; then
        echo -e "${RED}❌ Working directory is not clean${NC}"
        echo -e "${YELLOW}💡 Please commit or stash your changes first${NC}"
        git status --short
        exit 1
    fi
    echo -e "${GREEN}✅ Working directory is clean${NC}"
}

# Function to run pre-release checks
pre_release_checks() {
    echo -e "${BLUE}🔍 Running pre-release checks...${NC}"

    # Security audit
    echo -e "${BLUE}🔒 Security audit...${NC}"
    if npm run security:check; then
        echo -e "${GREEN}✅ Security audit passed${NC}"
    else
        echo -e "${YELLOW}⚠️  Security audit has warnings, but continuing...${NC}"
    fi

    # Dependency audit
    echo -e "${BLUE}📦 Dependency audit...${NC}"
    if npm audit --audit-level=high; then
        echo -e "${GREEN}✅ No high-severity vulnerabilities${NC}"
    else
        echo -e "${RED}❌ High-severity vulnerabilities found${NC}"
        echo -e "${YELLOW}💡 Run 'npm audit fix' before release${NC}"
        exit 1
    fi

    # Type checking
    echo -e "${BLUE}📝 Type checking...${NC}"
    if npm run typecheck; then
        echo -e "${GREEN}✅ Type checking passed${NC}"
    else
        echo -e "${RED}❌ Type checking failed${NC}"
        exit 1
    fi

    # Build test
    echo -e "${BLUE}🔨 Build test...${NC}"
    if npm run build; then
        echo -e "${GREEN}✅ Build successful${NC}"
    else
        echo -e "${RED}❌ Build failed${NC}"
        exit 1
    fi

    # Unit tests
    echo -e "${BLUE}🧪 Running tests...${NC}"
    if npm run test:unit; then
        echo -e "${GREEN}✅ All tests passed${NC}"
    else
        echo -e "${RED}❌ Tests failed${NC}"
        exit 1
    fi
}

# Function to generate enhanced changelog
generate_enhanced_changelog() {
    echo -e "${BLUE}📈 Generating enhanced changelog...${NC}"

    # Generate our custom changelog
    npm run changelog:generate

    echo -e "${GREEN}✅ Enhanced changelog generated${NC}"
}

# Function to perform release
perform_release() {
    local release_type=${1:-"auto"}

    echo -e "${BLUE}🔖 Creating release (type: $release_type)...${NC}"

    case $release_type in
        "patch")
            npm run release:patch
            ;;
        "minor")
            npm run release:minor
            ;;
        "major")
            npm run release:major
            ;;
        "auto"|*)
            npm run release
            ;;
    esac

    # Get the new version
    NEW_VERSION=$(node -p "require('./package.json').version")
    echo -e "${GREEN}✅ Released version v$NEW_VERSION${NC}"
}

# Function to post-release actions
post_release_actions() {
    echo -e "${BLUE}🎉 Post-release actions...${NC}"

    # Update our enhanced changelog with the release
    npm run changelog:generate

    # Stage the updated changelog
    git add CHANGELOG.md

    # Amend the release commit to include our enhanced changelog
    git commit --amend --no-edit

    echo -e "${GREEN}✅ Enhanced changelog integrated with release${NC}"
}

# Function to show release summary
show_release_summary() {
    local version=$(node -p "require('./package.json').version")
    local tag="v$version"

    echo ""
    echo -e "${GREEN}🎉 Release Summary${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}Version:${NC} $version"
    echo -e "${GREEN}Tag:${NC} $tag"
    echo -e "${GREEN}Branch:${NC} $(git branch --show-current)"
    echo -e "${GREEN}Commit:${NC} $(git rev-parse --short HEAD)"
    echo ""
    echo -e "${YELLOW}📋 Next Steps:${NC}"
    echo -e "1. Review the changes: ${BLUE}git show HEAD${NC}"
    echo -e "2. Push to origin: ${BLUE}git push --follow-tags origin $(git branch --show-current)${NC}"
    echo -e "3. Create GitHub release: ${BLUE}gh release create $tag --generate-notes${NC}"
    echo -e "4. Publish to npm: ${BLUE}npm publish${NC}"
    echo ""
    echo -e "${PURPLE}Made with 🧡 in Cape Town 🇿🇦${NC}"
    echo -e "${PURPLE}Powered by Xstra AI✨ | Enabled by IntelliCommerce✨${NC}"
}

# Main function
main() {
    local release_type=${1:-"auto"}

    echo -e "${BLUE}Starting release process for: $release_type${NC}"
    echo ""

    # Checks
    check_branch
    check_working_directory
    pre_release_checks

    # Changelog
    generate_enhanced_changelog

    # Release
    perform_release "$release_type"

    # Post-release
    post_release_actions

    # Summary
    show_release_summary
}

# Handle command line arguments
case "${1:-auto}" in
    "patch"|"minor"|"major"|"auto")
        main "$1"
        ;;
    "check")
        echo -e "${BLUE}Running pre-release checks only...${NC}"
        check_working_directory
        pre_release_checks
        echo -e "${GREEN}✅ All checks passed! Ready for release.${NC}"
        ;;
    "changelog")
        echo -e "${BLUE}Generating changelog only...${NC}"
        generate_enhanced_changelog
        echo -e "${GREEN}✅ Changelog generated!${NC}"
        ;;
    *)
        echo "Usage: $0 [patch|minor|major|auto|check|changelog]"
        echo ""
        echo "Release Types:"
        echo "  patch    - Bug fixes (1.0.0 → 1.0.1)"
        echo "  minor    - New features (1.0.0 → 1.1.0)"
        echo "  major    - Breaking changes (1.0.0 → 2.0.0)"
        echo "  auto     - Automatic based on commit messages (default)"
        echo ""
        echo "Utilities:"
        echo "  check     - Run pre-release checks only"
        echo "  changelog - Generate changelog only"
        exit 1
        ;;
esac
