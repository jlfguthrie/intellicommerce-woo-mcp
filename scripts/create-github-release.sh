#!/bin/bash
# ✨IntelliCommerce✨ Woo MCP - GitHub Release Creator
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

echo -e "${PURPLE}🚀 IntelliCommerce✨ GitHub Release Creator${NC}"
echo -e "${BLUE}Made with 🧡 in Cape Town 🇿🇦${NC}"
echo ""

# Function to check if gh CLI is available
check_gh_cli() {
    if ! command -v gh &> /dev/null; then
        echo -e "${RED}❌ GitHub CLI (gh) is not installed${NC}"
        echo -e "${YELLOW}💡 Install it with: brew install gh${NC}"
        exit 1
    fi

    if ! gh auth status &> /dev/null; then
        echo -e "${RED}❌ GitHub CLI is not authenticated${NC}"
        echo -e "${YELLOW}💡 Run: gh auth login${NC}"
        exit 1
    fi

    echo -e "${GREEN}✅ GitHub CLI is ready${NC}"
}

# Function to check branch and status
check_git_status() {
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo -e "${RED}❌ Not in a git repository${NC}"
        exit 1
    fi

    # Check if we're on main branch
    CURRENT_BRANCH=$(git branch --show-current)
    if [ "$CURRENT_BRANCH" != "main" ]; then
        echo -e "${YELLOW}⚠️ Warning: You're on branch '$CURRENT_BRANCH', not 'main'${NC}"
        echo -e "${YELLOW}💡 Releases are typically created from 'main' branch${NC}"
        read -p "Continue anyway? [y/N]: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${RED}❌ Release cancelled${NC}"
            exit 1
        fi
    fi

    # Check for uncommitted changes
    if ! git diff-index --quiet HEAD --; then
        echo -e "${YELLOW}⚠️ Warning: Working directory has uncommitted changes${NC}"
        echo -e "${YELLOW}💡 Consider committing or stashing changes first${NC}"
        read -p "Continue anyway? [y/N]: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${RED}❌ Release cancelled${NC}"
            exit 1
        fi
    fi

    echo -e "${GREEN}✅ Git status is acceptable${NC}"
}

# Function to trigger GitHub Actions workflow
trigger_workflow() {
    local release_type=${1:-"patch"}

    echo -e "${BLUE}🚀 Triggering GitHub Actions release workflow...${NC}"
    echo -e "${BLUE}Release type: $release_type${NC}"

    # Use gh CLI to trigger the workflow
    if gh workflow run release.yml --field release_type="$release_type"; then
        echo -e "${GREEN}✅ Release workflow triggered successfully${NC}"
        echo ""
        echo -e "${BLUE}🔗 Monitor progress at:${NC}"
        echo -e "${BLUE}   https://github.com/jlfguthrie/intellicommerce-woo-mcp/actions/workflows/release.yml${NC}"
        echo ""
        echo -e "${YELLOW}💡 The workflow will:${NC}"
        echo -e "${YELLOW}   1. Validate the codebase${NC}"
        echo -e "${YELLOW}   2. Determine the new version${NC}"
        echo -e "${YELLOW}   3. Create a GitHub release${NC}"
        echo -e "${YELLOW}   4. Publish to npm (if NPM_TOKEN is configured)${NC}"
        echo ""
        echo -e "${GREEN}🎉 Release process initiated!${NC}"
        
        # Try to open the actions page
        if command -v open > /dev/null 2>&1; then
            echo -e "${BLUE}🌐 Opening GitHub Actions in browser...${NC}"
            open "https://github.com/jlfguthrie/intellicommerce-woo-mcp/actions/workflows/release.yml"
        fi
    else
        echo -e "${RED}❌ Failed to trigger release workflow${NC}"
        echo -e "${YELLOW}💡 You can also trigger it manually:${NC}"
        echo -e "${YELLOW}   1. Go to: https://github.com/jlfguthrie/intellicommerce-woo-mcp/actions/workflows/release.yml${NC}"
        echo -e "${YELLOW}   2. Click 'Run workflow'${NC}"
        echo -e "${YELLOW}   3. Select release type: $release_type${NC}"
        echo -e "${YELLOW}   4. Click 'Run workflow'${NC}"
        exit 1
    fi
}

# Function to show help
show_help() {
    echo -e "${BLUE}Usage: $0 [RELEASE_TYPE]${NC}"
    echo ""
    echo -e "${YELLOW}Release Types:${NC}"
    echo -e "  ${GREEN}patch${NC}  - Bug fixes (1.0.0 → 1.0.1)"
    echo -e "  ${GREEN}minor${NC}  - New features (1.0.0 → 1.1.0)"
    echo -e "  ${GREEN}major${NC}  - Breaking changes (1.0.0 → 2.0.0)"
    echo -e "  ${GREEN}auto${NC}   - Auto-determine from commit messages (default)"
    echo ""
    echo -e "${YELLOW}Examples:${NC}"
    echo -e "  $0 patch         # Create patch release"
    echo -e "  $0 minor         # Create minor release"
    echo -e "  $0 major         # Create major release"
    echo -e "  $0               # Auto-determine release type"
    echo ""
    echo -e "${PURPLE}Made with 🧡 in Cape Town 🇿🇦${NC}"
    echo -e "${PURPLE}Powered by Xstra AI✨ | Enabled by IntelliCommerce✨${NC}"
}

# Function to determine release type from commits
determine_release_type() {
    LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
    
    echo -e "${BLUE}🔍 Analyzing commits since $LAST_TAG...${NC}"
    
    # Check commit messages since last tag
    if git log --pretty=format:"%s" ${LAST_TAG}..HEAD | grep -qE "^(feat|✨|BREAKING|breaking)"; then
        if git log --pretty=format:"%s" ${LAST_TAG}..HEAD | grep -qE "BREAKING|breaking"; then
            echo "major"
        else
            echo "minor"
        fi
    else
        echo "patch"
    fi
}

# Main function
main() {
    local release_type=${1:-"auto"}

    # Handle help
    if [[ "$release_type" == "--help" ]] || [[ "$release_type" == "-h" ]]; then
        show_help
        exit 0
    fi

    # Auto-determine release type if needed
    if [[ "$release_type" == "auto" ]]; then
        release_type=$(determine_release_type)
        echo -e "${GREEN}🎯 Auto-determined release type: $release_type${NC}"
    fi

    # Validate release type
    case $release_type in
        "patch"|"minor"|"major")
            ;;
        *)
            echo -e "${RED}❌ Invalid release type: $release_type${NC}"
            echo -e "${YELLOW}💡 Valid options: patch, minor, major, auto${NC}"
            echo ""
            show_help
            exit 1
            ;;
    esac

    echo -e "${BLUE}Starting GitHub release process...${NC}"
    echo -e "${BLUE}Release type: $release_type${NC}"
    echo ""

    # Pre-flight checks
    check_gh_cli
    check_git_status

    # Check if there are commits to release
    LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
    COMMITS_SINCE_TAG=$(git rev-list ${LAST_TAG}..HEAD --count 2>/dev/null || echo "1")
    
    if [ "$COMMITS_SINCE_TAG" -eq "0" ]; then
        echo -e "${YELLOW}⚠️ No new commits since $LAST_TAG${NC}"
        echo -e "${YELLOW}💡 Nothing to release${NC}"
        read -p "Create release anyway? [y/N]: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${BLUE}⏭️ Release skipped${NC}"
            exit 0
        fi
    else
        echo -e "${GREEN}✅ Found $COMMITS_SINCE_TAG commits since $LAST_TAG${NC}"
    fi

    # Trigger the GitHub Actions workflow
    trigger_workflow "$release_type"
}

# Handle command line arguments
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi

        # Check commit messages since last tag
        if git log --pretty=format:"%s" ${LAST_TAG}..HEAD | grep -qE "^(feat|✨|BREAKING|breaking)"; then
            if git log --pretty=format:"%s" ${LAST_TAG}..HEAD | grep -qE "BREAKING|breaking"; then
                release_type="major"
            else
                release_type="minor"
            fi
        else
            release_type="patch"
        fi

        echo -e "${GREEN}🎯 Determined release type: $release_type${NC}"
    fi

    # Calculate new version
    case $release_type in
        "major")
            NEW_VERSION=$(npm version major --no-git-tag-version --no-commit-hooks)
            ;;
        "minor")
            NEW_VERSION=$(npm version minor --no-git-tag-version --no-commit-hooks)
            ;;
        "patch")
            NEW_VERSION=$(npm version patch --no-git-tag-version --no-commit-hooks)
            ;;
        *)
            echo -e "${RED}❌ Invalid release type: $release_type${NC}"
            exit 1
            ;;
    esac

    # Reset package.json (we don't want to commit this)
    git checkout -- package.json package-lock.json 2>/dev/null || true

    echo -e "${GREEN}✅ New version will be: $NEW_VERSION${NC}"
    TAG_NAME="v${NEW_VERSION#v}"
    echo -e "${GREEN}✅ Tag name will be: $TAG_NAME${NC}"
}

# Function to generate release notes
generate_release_notes() {
    echo -e "${BLUE}📝 Generating release notes...${NC}"

    # Create release notes file
    cat > release_notes.md << EOF
# 🚀 IntelliCommerce✨ Woo MCP ${TAG_NAME}

**Made with 🧡 in Cape Town 🇿🇦**
**Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**

## 📋 What's Changed

EOF

    # Add commit messages since last tag
    if [[ "$LAST_TAG" != "v0.0.0" ]]; then
        echo "### 🔄 Recent Changes" >> release_notes.md
        echo "" >> release_notes.md
        git log --pretty=format:"- %s (%h)" ${LAST_TAG}..HEAD >> release_notes.md
    else
        echo "### 🎉 Initial Release" >> release_notes.md
        echo "" >> release_notes.md
        echo "- Initial release of IntelliCommerce✨ Woo MCP" >> release_notes.md
        echo "- Full WooCommerce integration via Model Context Protocol" >> release_notes.md
        echo "- Support for all major WooCommerce entities" >> release_notes.md
    fi

    echo "" >> release_notes.md
    echo "" >> release_notes.md

    # Add links
    if [[ "$LAST_TAG" != "v0.0.0" ]]; then
        echo "🔗 **Full Changelog**: https://github.com/jlfguthrie/intellicommerce-woo-mcp/compare/${LAST_TAG}...${TAG_NAME}" >> release_notes.md
    else
        echo "🔗 **Repository**: https://github.com/jlfguthrie/intellicommerce-woo-mcp" >> release_notes.md
    fi

    echo "" >> release_notes.md
    echo "📦 **npm Package**: https://www.npmjs.com/package/intellicommerce-woo-mcp" >> release_notes.md
    echo "📚 **Documentation**: https://github.com/jlfguthrie/intellicommerce-woo-mcp#readme" >> release_notes.md

    echo -e "${GREEN}✅ Release notes generated${NC}"
}

# Function to create GitHub release
create_github_release() {
    echo -e "${BLUE}🚀 Creating GitHub release...${NC}"

    # Create the release
    gh release create "$TAG_NAME" \
        --target "$(git rev-parse HEAD)" \
        --title "🚀 $TAG_NAME" \
        --notes-file release_notes.md \
        --verify-tag=false

    echo -e "${GREEN}✅ GitHub release created: $TAG_NAME${NC}"
    echo -e "${BLUE}🔗 View at: https://github.com/jlfguthrie/intellicommerce-woo-mcp/releases/tag/$TAG_NAME${NC}"
}

# Function to build and attach assets
build_and_attach_assets() {
    echo -e "${BLUE}🏗️ Building release assets...${NC}"

    # Update version for build
    npm version "$NEW_VERSION" --no-git-tag-version --no-commit-hooks

    # Build the project
    npm run build

    # Create tarball
    npm pack

    # Rename tarball
    TARBALL_NAME="intellicommerce-woo-mcp-${NEW_VERSION#v}.tgz"
    mv intellicommerce-woo-mcp-*.tgz "$TARBALL_NAME"

    # Upload to release
    gh release upload "$TAG_NAME" "$TARBALL_NAME"

    echo -e "${GREEN}✅ Release asset uploaded: $TARBALL_NAME${NC}"

    # Reset package.json
    git checkout -- package.json package-lock.json 2>/dev/null || true

    # Cleanup
    rm -f "$TARBALL_NAME"
}

# Function to trigger npm publish workflow
trigger_npm_publish() {
    echo -e "${BLUE}📦 Triggering npm publish...${NC}"

    # Check if we can trigger the publish workflow
    if gh workflow list | grep -q "release.yml"; then
        echo -e "${GREEN}✅ Release workflow will handle npm publishing${NC}"
    else
        echo -e "${YELLOW}⚠️ Manual npm publish may be required${NC}"
        echo -e "${BLUE}💡 Run: npm run publish:automated${NC}"
    fi
}

# Function to show help
show_help() {
    echo -e "${BLUE}Usage: $0 [RELEASE_TYPE]${NC}"
    echo ""
    echo -e "${YELLOW}Release Types:${NC}"
    echo -e "  ${GREEN}patch${NC}  - Bug fixes (1.0.0 → 1.0.1)"
    echo -e "  ${GREEN}minor${NC}  - New features (1.0.0 → 1.1.0)"
    echo -e "  ${GREEN}major${NC}  - Breaking changes (1.0.0 → 2.0.0)"
    echo -e "  ${GREEN}auto${NC}   - Auto-determine from commit messages (default)"
    echo ""
    echo -e "${YELLOW}Examples:${NC}"
    echo -e "  $0 patch         # Create patch release"
    echo -e "  $0 minor         # Create minor release"
    echo -e "  $0 major         # Create major release"
    echo -e "  $0               # Auto-determine release type"
    echo ""
    echo -e "${PURPLE}Made with 🧡 in Cape Town 🇿🇦${NC}"
    echo -e "${PURPLE}Powered by Xstra AI✨ | Enabled by IntelliCommerce✨${NC}"
}

# Function to determine release type from commits
determine_release_type() {
    LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")

    echo -e "${BLUE}🔍 Analyzing commits since $LAST_TAG...${NC}"

    # Check commit messages since last tag
    if git log --pretty=format:"%s" ${LAST_TAG}..HEAD | grep -qE "^(feat|✨|BREAKING|breaking)"; then
        if git log --pretty=format:"%s" ${LAST_TAG}..HEAD | grep -qE "BREAKING|breaking"; then
            echo "major"
        else
            echo "minor"
        fi
    else
        echo "patch"
    fi
}

# Main function
main() {
    local release_type=${1:-"auto"}

    # Handle help
    if [[ "$release_type" == "--help" ]] || [[ "$release_type" == "-h" ]]; then
        show_help
        exit 0
    fi

    # Auto-determine release type if needed
    if [[ "$release_type" == "auto" ]]; then
        release_type=$(determine_release_type)
        echo -e "${GREEN}🎯 Auto-determined release type: $release_type${NC}"
    fi

    # Validate release type
    case $release_type in
        "patch"|"minor"|"major")
            ;;
        *)
            echo -e "${RED}❌ Invalid release type: $release_type${NC}"
            echo -e "${YELLOW}💡 Valid options: patch, minor, major, auto${NC}"
            echo ""
            show_help
            exit 1
            ;;
    esac

    echo -e "${BLUE}Starting GitHub release process...${NC}"
    echo -e "${BLUE}Release type: $release_type${NC}"
    echo ""

    # Pre-flight checks
    check_gh_cli
    check_git_status

    # Check if there are commits to release
    LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
    COMMITS_SINCE_TAG=$(git rev-list ${LAST_TAG}..HEAD --count 2>/dev/null || echo "1")

    if [ "$COMMITS_SINCE_TAG" -eq "0" ]; then
        echo -e "${YELLOW}⚠️ No new commits since $LAST_TAG${NC}"
        echo -e "${YELLOW}💡 Nothing to release${NC}"
        read -p "Create release anyway? [y/N]: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${BLUE}⏭️ Release skipped${NC}"
            exit 0
        fi
    else
        echo -e "${GREEN}✅ Found $COMMITS_SINCE_TAG commits since $LAST_TAG${NC}"
    fi

    # Trigger the GitHub Actions workflow
    trigger_workflow "$release_type"
}

# Handle command line arguments
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi

    # Show preview
    echo -e "${BLUE}📋 Release Preview:${NC}"
    echo -e "${GREEN}Version:${NC} $TAG_NAME"
    echo -e "${GREEN}Type:${NC} $release_type"
    echo ""
    echo -e "${BLUE}📝 Release Notes Preview:${NC}"
    head -20 release_notes.md
    echo ""

    # Confirm
    read -p "Create this release? [y/N]: " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}❌ Release cancelled${NC}"
        rm -f release_notes.md
        exit 1
    fi

    # Create release
    create_github_release

    # Build and attach assets
    build_and_attach_assets

    # Trigger npm publish
    trigger_npm_publish

    # Show summary
    show_summary

    # Cleanup
    rm -f release_notes.md
}

# Handle command line arguments
case "${1:-auto}" in
    "patch"|"minor"|"major"|"auto")
        main "$1"
        ;;
    *)
        echo "Usage: $0 [patch|minor|major|auto]"
        echo ""
        echo "Release Types:"
        echo "  patch    - Bug fixes (1.0.0 → 1.0.1)"
        echo "  minor    - New features (1.0.0 → 1.1.0)"
        echo "  major    - Breaking changes (1.0.0 → 2.0.0)"
        echo "  auto     - Automatic based on commit messages (default)"
        echo ""
        echo "Examples:"
        echo "  $0 patch"
        echo "  $0 minor"
        echo "  $0       # auto-detect"
        exit 1
        ;;
esac
