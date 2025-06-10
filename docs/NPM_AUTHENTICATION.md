# 🔑 NPM Authentication Setup - IntelliCommerce✨ Woo MCP

Made with 🧡 in Cape Town 🇿🇦 Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

## 🎯 Overview

This guide explains how to set up non-interactive npm publishing for the **IntelliCommerce✨ Woo
MCP** project.

## 🔐 Local Development Authentication

### Option 1: NPM Login (Interactive)

```bash
# Login to npm (opens browser)
npm login

# Verify authentication
npm whoami
```

### Option 2: Auth Token (Non-Interactive)

1. **Create an NPM Access Token**:

   - Go to [npmjs.com](https://www.npmjs.com/settings/tokens)
   - Click "Generate New Token"
   - Choose "Automation" type
   - Copy the token

2. **Set the token locally**:

   ```bash
   # Option A: Environment variable
   export NPM_TOKEN="your_token_here"

   # Option B: Direct npm config
   npm config set //registry.npmjs.org/:_authToken "your_token_here"
   ```

3. **Verify authentication**:
   ```bash
   npm whoami
   # Should show: jlfguthrie
   ```

## 🤖 Automated Publishing

### Use the Automated Script

```bash
# Test automated publishing (dry run)
npm run publish:automated:dry

# Actual automated publishing
npm run publish:automated
```

### Manual Non-Interactive Publishing

```bash
# Set auth token and publish
NPM_TOKEN="your_token" npm publish --access public
```

## 🚀 GitHub Actions Setup

### Required Repository Secrets

1. Go to your GitHub repo:
   `https://github.com/jlfguthrie/intellicommerce-woo-mcp/settings/secrets/actions`

2. Add these secrets:

   - **`NPM_TOKEN`**: Your npm automation token
   - **`GITHUB_TOKEN`**: Auto-generated (already available)

3. The CI/CD pipeline will automatically publish on main branch pushes.

## 🔧 Troubleshooting

### Issue: "Authentication required"

```bash
# Check current authentication
npm whoami

# If not authenticated, set token
echo "//registry.npmjs.org/:_authToken=YOUR_TOKEN" >> ~/.npmrc
```

### Issue: "403 Forbidden"

```bash
# Check package permissions
npm owner ls intellicommerce-woo-mcp

# Add yourself as owner if needed
npm owner add jlfguthrie intellicommerce-woo-mcp
```

### Issue: "2FA Required"

```bash
# Publish with OTP
npm publish --otp=123456

# Or disable 2FA for automation tokens
# (Go to npmjs.com account settings)
```

## 📝 Scripts Reference

| Script                          | Purpose                              |
| ------------------------------- | ------------------------------------ |
| `npm run publish:automated`     | Automated publishing with validation |
| `npm run publish:automated:dry` | Test publishing (dry run)            |
| `npm run publish:npm`           | Standard npm publish                 |
| `npm run publish:auto`          | Release + publish + push             |

## 🔒 Security Best Practices

1. **Use Automation Tokens**: Never use personal tokens for CI/CD
2. **Scope Permissions**: Limit token access to specific packages
3. **Rotate Tokens**: Update tokens regularly
4. **Environment Variables**: Never commit tokens to git
5. **2FA Bypass**: Use automation tokens to avoid 2FA prompts

---

**Made with 🧡 in Cape Town 🇿🇦** **Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**
