#!/bin/bash
# ✨IntelliCommerce✨ Woo MCP - Folder Structure Validation
# Made with 🧡 in Cape Town 🇿🇦
# Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

set -e

echo "📂 Validating folder structure..."

# Define allowed files in root
ALLOWED_ROOT_FILES=(
    "package.json"
    "README.md"
    "LICENSE"
    "tsconfig.json"
    ".eslintrc.js"
    "eslint.config.js"
    ".prettierrc.js"
    ".prettierignore"
    "commitlint.config.js"
    "jest.config.js"
    ".versionrc.json"
    ".gitignore"
    ".npmignore"
    "TODO"
    "intellicommerce-woo-mcp.code-workspace"
)

# Check for non-development docs in root
echo "🔍 Checking for development artifacts in root..."
for file in *.md; do
    if [[ -f "$file" && "$file" != "README.md" ]]; then
        case "$file" in
            "CHANGELOG.md"|"API.md"|"SETUP.md")
                echo "⚠️  $file should be moved to docs/"
                ;;
            "SESSION_"*|"MCP_STATUS_"*|"PROJECT_STATUS"*|"COMPLETION_REPORT"*)
                echo "❌ Development doc $file should be in docs/internal/"
                exit 1
                ;;
        esac
    fi
done

# Check for proper docs organization
echo "🔍 Validating docs folder structure..."
if [[ -d "docs" ]]; then
    # Check for session files in main docs
    if find docs/ -maxdepth 1 -name "SESSION_*" -o -name "MCP_STATUS_*" -o -name "*STATUS*" | grep -q .; then
        echo "❌ Session/status files found in docs/ - should be in docs/internal/"
        exit 1
    fi

    # Ensure internal docs are properly separated
    if [[ ! -d "docs/internal" ]]; then
        echo "📁 Creating docs/internal directory..."
        mkdir -p docs/internal
    fi
fi

# Check for test files in wrong locations
echo "🔍 Checking test file locations..."
if find src/ -name "*.test.*" -o -name "*.spec.*" | grep -q .; then
    echo "❌ Test files found in src/ - should be in tests/"
    exit 1
fi

# Check for build artifacts in source
echo "🔍 Checking for build artifacts in source..."
if find src/ -name "*.js" -o -name "*.d.ts" | grep -q .; then
    echo "❌ Build artifacts found in src/ directory!"
    exit 1
fi

echo "✅ Folder structure validation passed!"
