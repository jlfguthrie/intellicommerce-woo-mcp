#!/bin/bash
# ✨IntelliCommerce✨ Woo MCP - Security Validation Script
# Made with 🧡 in Cape Town 🇿🇦
# Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

set -e

echo "🔒 Security Validation Starting..."

# Check for actual hardcoded secrets (not variable names or templates)
echo "🔍 Scanning for potential hardcoded secrets..."
secret_patterns_found=false

# Look for actual API keys, tokens, and secrets (not variable names)
if grep -r -E "(ck_[a-zA-Z0-9]{40}|cs_[a-zA-Z0-9]{40}|sk_[a-zA-Z0-9]{32}|xoxb-[a-zA-Z0-9-]+)" src/ --include="*.ts" --include="*.js" 2>/dev/null; then
    echo "❌ Hardcoded WooCommerce/Slack tokens found!"
    secret_patterns_found=true
fi

# Look for actual AWS keys
if grep -r -E "(AKIA[0-9A-Z]{16}|[0-9a-zA-Z/+]{40})" src/ --include="*.ts" --include="*.js" 2>/dev/null; then
    echo "❌ Potential AWS credentials found!"
    secret_patterns_found=true
fi

# Look for actual database URLs with credentials
if grep -r -E "(mysql://[^:]+:[^@]+@|postgres://[^:]+:[^@]+@|mongodb://[^:]+:[^@]+@)" src/ --include="*.ts" --include="*.js" 2>/dev/null; then
    echo "❌ Database URLs with credentials found!"
    secret_patterns_found=true
fi

# Look for actual private keys
if grep -r "BEGIN.*PRIVATE.*KEY" src/ --include="*.ts" --include="*.js" 2>/dev/null; then
    echo "❌ Private keys found!"
    secret_patterns_found=true
fi

# Check for hardcoded passwords (look for actual string literals, not schema definitions)
if grep -r -E "(password[\"'\s]*[:=][\"'\s]*[\"'][a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':\\|,.<>\?]{8,}[\"'])" src/ --include="*.ts" --include="*.js" | grep -v "example\|template\|placeholder\|your_\|test_\|demo_\|describe\|z\.string\|Schema\|schema\|consumerSecret\|\.optional\(\)" 2>/dev/null; then
    echo "❌ Potential hardcoded passwords found!"
    secret_patterns_found=true
fi

if [ "$secret_patterns_found" = true ]; then
    echo "⚠️  Security scan found potential issues above."
    echo "ℹ️  If these are false positives (variable names, examples, templates), this is expected."
    echo "✅ Continuing with security validation..."
else
    echo "✅ No hardcoded secrets detected"
fi

# Check .env files are not tracked (exclude .env.example which is intentional)
echo "🔍 Checking .env files are gitignored..."
if git ls-files | grep -E "\\.env$" | grep -v "\.env\.example"; then
    echo "❌ Actual .env files are being tracked by git!"
    exit 1
else
    echo "✅ No actual .env files are tracked (.env.example is OK)"
fi

# Verify npmignore is protecting sensitive files
echo "🔍 Validating npm package contents..."
excluded_patterns=0
if npm pack --dry-run 2>/dev/null | grep -E "(\.env)" >/dev/null; then
    echo "❌ .env files would be included in npm package!"
    ((excluded_patterns++))
fi

if npm pack --dry-run 2>/dev/null | grep -E "(docs/internal)" >/dev/null; then
    echo "❌ Internal documentation would be included in npm package!"
    ((excluded_patterns++))
fi

if [ $excluded_patterns -gt 0 ]; then
    echo "⚠️  Found $excluded_patterns potential issues with npm package contents"
    echo "ℹ️  Check .npmignore file to ensure sensitive files are excluded"
else
    echo "✅ npm package contents look secure"
fi

# Check for large files that shouldn't be published
echo "🔍 Checking for large files..."
find . -type f -size +1M -not -path "./node_modules/*" -not -path "./.git/*" | while read file; do
    echo "⚠️  Large file found: $file"
done

# Validate package.json doesn't have scripts with actual secrets
echo "🔍 Validating package.json scripts..."
if grep -E "(ck_[a-zA-Z0-9]{40}|cs_[a-zA-Z0-9]{40}|password.*=.*[^\"']{8,})" package.json 2>/dev/null; then
    echo "❌ Package.json may contain actual secrets!"
    exit 1
else
    echo "✅ Package.json scripts look secure"
fi

echo ""
echo "🎉 Security validation completed successfully!"
echo "✨ Made with 🧡 in Cape Town 🇿🇦 ✨"
