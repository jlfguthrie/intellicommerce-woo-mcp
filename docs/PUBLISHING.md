# 📦 Publishing Guide - IntelliCommerce✨ Woo MCP
# Made with 🧡 in Cape Town 🇿🇦
# Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

## 🎯 Overview

This guide covers how to publish the **IntelliCommerce✨ Woo MCP** package to npm for global installation and distribution.

## 📋 Pre-Publishing Checklist

### ✅ **Code Quality**
- [ ] All TypeScript compiles without errors (`npm run build`)
- [ ] Linting passes (`npm run lint`)
- [ ] Code is properly formatted (`npm run format`)
- [ ] All tests pass (`npm test`)

### ✅ **Documentation**
- [ ] README.md is updated with latest features
- [ ] CHANGELOG.md includes version changes
- [ ] API documentation is current
- [ ] Installation instructions are accurate

### ✅ **Package Configuration**
- [ ] `package.json` version is bumped
- [ ] Binary executable is included (`bin/intellicommerce-woo-mcp`)
- [ ] All required files are included (check `.npmignore`)
- [ ] Dependencies are properly listed

### ✅ **Security**
- [ ] No sensitive data in published files
- [ ] `.env` files are gitignored and npm-ignored
- [ ] API credentials are not hardcoded

## 🚀 Publishing Process

### 1️⃣ **Prepare Release**

```bash
# Ensure you're on main branch
git checkout main
git pull origin main

# Create release branch
git checkout -b release/v1.0.1

# Update version in package.json
npm version patch  # or minor/major

# Build the project
npm run build

# Test global installation locally
npm run global:install
intellicommerce-woo-mcp --help
```

### 2️⃣ **Test the Package**

```bash
# Test in a clean directory
cd /tmp
mkdir npm-test && cd npm-test

# Test global installation
npm install -g /path/to/intellicommerce-woo-mcp

# Test setup command
intellicommerce-woo-mcp setup

# Test MCP server start (should show help)
intellicommerce-woo-mcp --help

# Cleanup
npm uninstall -g intellicommerce-woo-mcp
cd ~ && rm -rf /tmp/npm-test
```

### 3️⃣ **Publish to npm**

```bash
# Login to npm (first time only)
npm login

# Dry run to check what will be published
npm publish --dry-run

# Publish to npm
npm publish

# Tag the release in git
git tag v1.0.1
git push origin v1.0.1
```

### 4️⃣ **Post-Publishing**

```bash
# Merge release branch
git checkout main
git merge release/v1.0.1
git push origin main

# Update GitHub release
gh release create v1.0.1 --title "v1.0.1: Description" --notes "Release notes"

# Cleanup release branch
git branch -d release/v1.0.1
```

## 📝 Version Management

### 🏷️ **Semantic Versioning**

- **Patch** (`1.0.1`): Bug fixes, documentation updates
- **Minor** (`1.1.0`): New features, backwards compatible
- **Major** (`2.0.0`): Breaking changes

### 📈 **Release Notes Template**

```markdown
## [1.0.1] - 2025-06-10

### ✨ Added
- New feature descriptions

### 🔧 Changed
- Updated functionality

### 🐛 Fixed
- Bug fix descriptions

### 🔒 Security
- Security improvements

Made with 🧡 in Cape Town 🇿🇦
```

## 🔧 Package Configuration

### 📦 **package.json Key Fields**

```json
{
  "name": "intellicommerce-woo-mcp",
  "version": "1.0.0",
  "description": "✨IntelliCommerce✨ Woo MCP - Commercial-grade Model Context Protocol server",
  "bin": {
    "intellicommerce-woo-mcp": "./bin/intellicommerce-woo-mcp"
  },
  "preferGlobal": true,
  "files": [
    "build/",
    "bin/",
    "README.md",
    "LICENSE"
  ]
}
```

### 📄 **.npmignore File**

Create `.npmignore` to exclude development files:

```ignore
# Source files (only ship built files)
src/
tsconfig.json
.eslintrc.js
.prettierrc.js

# Development
.env*
.vscode/
docs/
test/
coverage/

# Git
.git/
.gitignore

# OS
.DS_Store
Thumbs.db

# Logs
*.log
npm-debug.log*

# Runtime
node_modules/
```

## 🌍 Distribution Strategy

### 🎯 **Target Audiences**

1. **Individual Developers**
   - Simple global installation: `npm install -g intellicommerce-woo-mcp`
   - Easy setup: `intellicommerce-woo-mcp setup`

2. **Development Teams**
   - Project-specific configurations
   - Environment variable management
   - CI/CD integration

3. **Enterprise Users**
   - Professional support (info@intellicommerce.co.za)
   - Custom integrations
   - Training and onboarding

### 📊 **Marketing Channels**

- **npm Registry**: Primary distribution
- **GitHub**: Open source development
- **Website**: https://intellicommerce.co.za
- **Documentation**: Comprehensive guides
- **Community**: Support through GitHub Issues

## 🔒 Security Considerations

### 🛡️ **Before Publishing**

- [ ] Audit dependencies: `npm audit`
- [ ] Check for credentials in code
- [ ] Verify `.npmignore` excludes sensitive files
- [ ] Test in clean environment

### 🔐 **Access Control**

```bash
# Set up 2FA for npm account
npm profile enable-tfa

# Restrict publishing access
npm access restricted intellicommerce-woo-mcp

# Grant access to team members
npm team add @intellicommerce:developers username
```

## 📈 Monitoring & Analytics

### 📊 **Track Usage**

- **npm downloads**: https://npmjs.com/package/intellicommerce-woo-mcp
- **GitHub stars/forks**: Repository metrics
- **Issue tracking**: User feedback and bug reports
- **Documentation views**: Usage patterns

### 🔄 **Maintenance Schedule**

- **Weekly**: Monitor issues and support requests
- **Monthly**: Update dependencies and security patches
- **Quarterly**: Feature releases and major updates
- **Annually**: Major version releases

## 🎯 Success Metrics

### 📈 **Key Performance Indicators**

- **Downloads**: npm package downloads per month
- **Stars**: GitHub repository stars
- **Issues**: Support ticket resolution time
- **Adoption**: Community usage and feedback
- **Revenue**: Commercial support contracts

### 🏆 **Success Milestones**

- [ ] 1,000 npm downloads
- [ ] 100 GitHub stars
- [ ] 10 community contributors
- [ ] Enterprise customers
- [ ] International adoption

---

**Made with 🧡 in Cape Town 🇿🇦**
**Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**
