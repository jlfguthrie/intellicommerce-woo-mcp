#!/bin/bash
# ✨IntelliCommerce✨ Woo MCP - Dependency Update Manager
# Made with 🧡 in Cape Town 🇿🇦
# Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

set -e

echo "📦 Managing package dependencies..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Install npm-check-updates if not present
if ! command -v ncu &> /dev/null; then
    echo -e "${BLUE}📥 Installing npm-check-updates...${NC}"
    npm install -g npm-check-updates
fi

# Check Node.js and npm versions
echo -e "${BLUE}🔍 System Information:${NC}"
echo "Node.js: $(node --version)"
echo "npm: $(npm --version)"
echo "ncu: $(ncu --version)"
echo ""

# Pre-update security check
echo -e "${BLUE}🔒 Pre-update security audit...${NC}"
if npm audit --audit-level=high; then
    echo -e "${GREEN}✅ No high-severity vulnerabilities found${NC}"
else
    echo -e "${YELLOW}⚠️  High-severity vulnerabilities detected${NC}"
    echo -e "${YELLOW}💡 Consider running 'npm audit fix' first${NC}"
fi

# Check for outdated packages
echo -e "${BLUE}🔍 Checking for outdated packages...${NC}"
echo ""
echo -e "${BLUE}📊 Current outdated packages:${NC}"
ncu

echo ""

# Function to update packages safely
update_packages() {
    local update_type=$1

    echo -e "${BLUE}🚀 Starting $update_type updates...${NC}"

    case $update_type in
        "patch")
            echo -e "${GREEN}🩹 Updating patch versions only...${NC}"
            ncu -u --target patch
            ;;
        "minor")
            echo -e "${BLUE}📈 Updating minor versions...${NC}"
            ncu -u --target minor
            ;;
        "major")
            echo -e "${RED}🚀 Updating major versions (CAUTION!)...${NC}"
            echo -e "${YELLOW}⚠️  Major updates may introduce breaking changes${NC}"
            read -p "Are you sure you want to continue? [y/N]: " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                echo -e "${YELLOW}❌ Major update cancelled${NC}"
                return 1
            fi
            ncu -u --target latest
            ;;
        "interactive")
            echo -e "${BLUE}🎯 Interactive update selection...${NC}"
            ncu -i
            ;;
        *)
            echo -e "${RED}Usage: $0 [patch|minor|major|interactive]${NC}"
            echo "  patch: Update patch versions only (safest)"
            echo "  minor: Update minor versions (safe)"
            echo "  major: Update major versions (breaking changes possible)"
            echo "  interactive: Choose which packages to update"
            return 1
            ;;
    esac

    # Check if any changes were made
    if ! git diff --quiet package.json; then
        echo -e "${GREEN}📝 Package.json updated with new versions${NC}"

        if [[ -f "package-lock.json" ]]; then
            echo -e "${BLUE}🔄 Updating package-lock.json...${NC}"
            npm install
        fi

        echo -e "${BLUE}🧪 Running tests after update...${NC}"
        if npm run test:unit; then
            echo -e "${GREEN}✅ Tests passed${NC}"
        else
            echo -e "${RED}❌ Tests failed after update${NC}"
            echo -e "${YELLOW}💡 Consider reverting changes or fixing tests${NC}"
            return 1
        fi

        echo -e "${BLUE}🔨 Testing build...${NC}"
        if npm run build; then
            echo -e "${GREEN}✅ Build successful${NC}"
        else
            echo -e "${RED}❌ Build failed after update${NC}"
            return 1
        fi

        echo -e "${BLUE}🔒 Post-update security audit...${NC}"
        if npm audit --audit-level=high; then
            echo -e "${GREEN}✅ Security audit clean${NC}"
        else
            echo -e "${YELLOW}⚠️  New security issues detected${NC}"
        fi        echo -e "${GREEN}✅ Package updates completed successfully!${NC}"
        echo -e "${BLUE}📋 Summary of changes:${NC}"
        git diff --no-color package.json | grep -E "^\+.*\".*\":" | sed 's/^+/  /' || echo "  No dependency changes detected"

        echo -e "${BLUE}📝 Updating changelog with dependency changes...${NC}"
        npm run changelog:deps

    else
        echo -e "${GREEN}✅ All packages are already up to date!${NC}"
    fi
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
