#!/bin/bash
# ✨IntelliCommerce✨ Woo MCP - Security Validation Script
# Made with 🧡 in Cape Town 🇿🇦
# Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

set -e

echo "🔒 Security Validation Starting..."

# Check for secrets in code
echo "🔍 Scanning for potential secrets..."
if grep -r -i "api[_-]key\|secret\|password\|token" src/ --include="*.ts" --include="*.js" | grep -v "process.env" | grep -v "config" | grep -v "example" | grep -v "TODO"; then
    echo "❌ Potential secrets found in source code!"
    exit 1
fi

# Check .env files are not tracked
echo "🔍 Checking .env files are gitignored..."
if git ls-files | grep -E "\\.env"; then
    echo "❌ .env files are being tracked by git!"
    exit 1
fi

# Verify npmignore is protecting sensitive files
echo "🔍 Validating npm package contents..."
if npm pack --dry-run | grep -E "(src/|\.env|test|\.vscode|docs/internal)"; then
    echo "❌ Sensitive files would be included in npm package!"
    exit 1
fi

# Check for large files that shouldn't be published
echo "🔍 Checking for large files..."
find . -type f -size +1M -not -path "./node_modules/*" -not -path "./.git/*" | while read file; do
    echo "⚠️  Large file found: $file"
done

# Validate package.json doesn't have test scripts pointing to sensitive data
echo "🔍 Validating package.json scripts..."
if grep -i "test.*\.env\|test.*secret\|test.*password" package.json; then
    echo "❌ Test scripts may reference sensitive data!"
    exit 1
fi

echo "✅ Security validation passed!"
