# ✨IntelliCommerce✨ Woo MCP - Development Guide
# Made with 🧡 in Cape Town 🇿🇦
# Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

## 🚀 Quick Start Guide

### Prerequisites
- Node.js 18+ installed
- VS Code with GitHub Copilot
- WooCommerce store with REST API enabled
- WooCommerce API credentials

### Setup Steps

1. **Install Dependencies**
   ```bash
   npm install
   ```

2. **Configure Environment**
   ```bash
   cp .env.example .env
   # Edit .env with your WooCommerce credentials
   ```

3. **Build the Project**
   ```bash
   npm run build
   ```

4. **Test the Server**
   ```bash
   npm start
   ```

## 🛠️ Development Workflow

### 🌿 **Branching Strategy**

This project follows a **Feature Branch Workflow** to ensure main branch stability:

#### **Branch Types:**
- **`main`** - Production-ready code, protected branch
- **`feature/*`** - New features and enhancements
- **`fix/*`** - Bug fixes and patches
- **`chore/*`** - Maintenance tasks and updates

#### **Development Process:**

1. **Start New Feature**
   ```bash
   # Ensure you're on main and up to date
   git checkout main
   git pull origin main

   # Create feature branch
   git checkout -b feature/your-feature-name
   ```

2. **Work on Feature**
   ```bash
   # Make changes, commit regularly
   git add .
   git commit -m "✨ feat: Add feature description"

   # Push to your branch
   git push origin feature/your-feature-name
   ```

3. **Submit for Review**
   ```bash
   # Create Pull Request via GitHub CLI
   gh pr create --title "✨ feat: Your feature title" --body "Description of changes"
   ```

4. **After PR Approval**
   ```bash
   # Merge via GitHub (Squash and Merge preferred)
   # Clean up local branch
   git checkout main
   git pull origin main
   git branch -d feature/your-feature-name
   ```

### 🔄 **Upstream Integration**

This repository is a **commercial fork** of Automattic's WooCommerce MCP server:

- **Origin**: `https://github.com/jlfguthrie/intellicommerce-woo-mcp` (your repo)
- **Upstream**: `https://github.com/Automattic/ai-experiments` (original repo)

#### **Contributing Back to Upstream:**

1. **Create Upstream Contribution Branch**
   ```bash
   # Fetch latest upstream changes
   git fetch upstream

   # Create branch from upstream main
   git checkout -b fix/upstream-contribution upstream/main

   # Make your changes (remove IntelliCommerce✨ branding for upstream)
   # Commit and push to your fork
   git push origin fix/upstream-contribution

   # Create PR to Automattic's repository
   gh pr create --repo Automattic/ai-experiments --title "fix: Your contribution"
   ```

2. **Staying Updated with Upstream:**
   ```bash
   # Periodically sync with upstream (monthly or as needed)
   git fetch upstream
   git checkout main
   git merge upstream/main
   git push origin main
   ```

### 🎯 **VS Code Integration**

#### **Tasks Available:**
- **Build**: `Cmd+Shift+P` → "Tasks: Run Task" → "✨ Build IntelliCommerce✨ Woo MCP"
- **Start Server**: `Cmd+Shift+P` → "Tasks: Run Task" → "🚀 Start IntelliCommerce✨ Woo MCP Server"
- **Watch Mode**: `Cmd+Shift+P` → "Tasks: Run Task" → "🔄 Watch & Build IntelliCommerce✨ Woo MCP"
- **Test MCP**: `Cmd+Shift+P` → "Tasks: Run Task" → "🔍 Test MCP Connection"

#### **Git Integration:**
- **Auto-fetch**: Enabled for tracking upstream changes
- **Smart Commit**: Enabled for efficient workflow
- **Branch Protection**: Main branch should be protected on GitHub

### 📋 **Available NPM Scripts**
```bash
npm run build      # Build TypeScript to JavaScript
npm start          # Start the MCP server
npm run dev        # Start with TypeScript directly
npm run clean      # Clean build directory
npm run lint       # Run ESLint
npm run format     # Format code with Prettier
```

### 🔒 **Branch Protection Rules**

For production safety, configure these GitHub branch protection rules:

1. **Main Branch Protection:**
   ```bash
   # Via GitHub CLI
   gh api repos/jlfguthrie/intellicommerce-woo-mcp/branches/main/protection \
     --method PUT \
     --field required_status_checks='{"strict":true,"contexts":[]}' \
     --field enforce_admins=true \
     --field required_pull_request_reviews='{"required_approving_review_count":1,"dismiss_stale_reviews":true}' \
     --field restrictions=null
   ```

2. **Manual Setup via GitHub:**
   - Go to: https://github.com/jlfguthrie/intellicommerce-woo-mcp/settings/branches
   - Add rule for `main` branch:
     - ✅ Require a pull request before merging
     - ✅ Require approvals (1 minimum)
     - ✅ Dismiss stale PR approvals when new commits are pushed
     - ✅ Require status checks to pass before merging
     - ✅ Include administrators
- **Watch Mode**: `Cmd+Shift+P` → "Tasks: Run Task" → "🔄 Watch & Build IntelliCommerce✨ Woo MCP"
- **Test MCP**: `Cmd+Shift+P` → "Tasks: Run Task" → "🔍 Test MCP Connection"

### Available NPM Scripts
```bash
npm run build      # Build TypeScript to JavaScript
npm start          # Start the MCP server
npm run dev        # Start with TypeScript directly
npm run clean      # Clean build directory
npm run lint       # Run ESLint
npm run format     # Format code with Prettier
npm run test       # Run tests (when implemented)
```

## 🔧 Configuration Files

### Environment Variables (.env)
```env
WOOCOMMERCE_API_URL=https://your-store.com
WOOCOMMERCE_CONSUMER_KEY=ck_xxx
WOOCOMMERCE_CONSUMER_SECRET=cs_xxx
```

### VS Code MCP Configuration (.vscode/mcp.json)
```json
{
  "mcpServers": {
    "intellicommerce-woo": {
      "command": "node",
      "args": ["${workspaceFolder}/build/server.js"],
      "env": {}
    }
  }
}
```

> **🔐 Security Best Practice:** No credentials in MCP config! The server loads them from your `.env` file automatically.
```

## 🧪 Testing

### Manual Testing
1. Start the server: `npm start`
2. Use MCP Inspector: `npx @modelcontextprotocol/inspector node build/server.js`
3. Test individual tools through VS Code Copilot

### Integration Testing
1. Configure with a test WooCommerce store
2. Verify all CRUD operations work
3. Test error handling with invalid data
4. Check authentication and authorization

## 📝 Code Style

### File Headers
Always include in TypeScript files:
```typescript
// ✨IntelliCommerce✨ Woo MCP - [Description]
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨
```

### Naming Conventions
- **Files**: kebab-case (`product-variations.ts`)
- **Classes**: PascalCase (`WooCommerceClient`)
- **Functions**: camelCase (`listProducts`)
- **Constants**: SCREAMING_SNAKE_CASE (`API_ENDPOINTS`)
- **MCP Tools**: snake_case (`list_products`)

## 🔍 Debugging

### VS Code Debugging
1. Set breakpoints in TypeScript source
2. Press F5 or use "🚀 Debug IntelliCommerce✨ Woo MCP Server"
3. Debug with source maps enabled

### Console Logging
- Server startup: `✨ IntelliCommerce✨ Woo MCP Server running on stdio`
- Errors: Prefixed with `❌`
- Success: Prefixed with `✅`
- Info: Prefixed with `ℹ️`

## 🚨 Common Issues

### Server Won't Start
- Check Node.js version (18+)
- Verify all dependencies installed
- Check build output exists
- Validate environment variables

### WooCommerce Connection Failed
- Verify API URL includes `https://`
- Check API credentials are correct
- Ensure WooCommerce REST API is enabled
- Test with read-only permissions first

### MCP Client Not Detecting Server
- Check absolute paths in configuration
- Restart VS Code/Claude Desktop after config changes
- Verify server starts without errors
- Check MCP client logs

## 📚 Resources

- [Model Context Protocol Docs](https://modelcontextprotocol.io/)
- [WooCommerce REST API](https://woocommerce.github.io/woocommerce-rest-api-docs/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [VS Code MCP Extension](https://marketplace.visualstudio.com/items?itemName=modelcontextprotocol.mcp)

## 🆘 Support

- **Email**: info@intellicommerce.co.za
- **Repository**: https://github.com/jlfguthrie/intellicommerce-woo-mcp
- **Issues**: https://github.com/jlfguthrie/intellicommerce-woo-mcp/issues

---

**Made with 🧡 in Cape Town 🇿🇦**
**Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**
