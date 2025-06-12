# 🔄 Development Workflow - IntelliCommerce✨ Woo MCP

_Made with 🧡 in Cape Town 🇿🇦_

## 🚀 **Automated Development Pipeline**

This project uses a comprehensive automation system for testing, versioning, and releasing. Here's
how everything works:

## 📋 **Quick Commands**

```bash
# 🧪 Development & Testing
npm run dev              # Start development server with watch
npm run build            # Build the project
npm run test:unit        # Run unit tests
npm run test:integration # Run MCP integration tests
npm run validate         # Run complete validation pipeline

# 🎨 Code Quality
npm run lint             # Check code style
npm run lint:fix         # Fix linting issues
npm run format           # Format code with Prettier
npm run format:check     # Check code formatting

# 🏷️ Versioning & Releases
npm run release:patch    # Create patch release (1.0.1 → 1.0.2)
npm run release:minor    # Create minor release (1.0.1 → 1.1.0)
npm run release:major    # Create major release (1.0.1 → 2.0.0)
npm run release:dry      # Dry run to see what would be released
./scripts/release.sh     # Interactive release script

# 📦 Publishing
npm run publish:npm      # Publish to NPM
npm run publish:auto     # Automated release + publish + push
```

## 🔧 **Pre-commit Automation**

### **Git Hooks (Husky)**

- **Pre-commit**: Automatically runs linting, formatting, tests, and build
- **Commit-msg**: Validates commit message format using conventional commits

### **Lint-staged**

- Automatically formats and lints only staged files
- Runs before every commit to maintain code quality

## 📈 **Automated Changelog**

### **Conventional Commits**

Use these commit message formats:

```bash
✨ feat: Add new WooCommerce integration feature
🐛 fix: Resolve MCP server startup issue
📚 docs: Update API documentation
🎨 style: Improve code formatting
♻️ refactor: Simplify tool registration logic
⚡ perf: Optimize API response handling
✅ test: Add unit tests for customer tools
🔧 chore: Update dependencies
```

### **Automatic Changelog Generation**

- Changelog is automatically generated from commit messages
- Follows conventional commit standards
- Updates `docs/CHANGELOG.md` on every release
- Includes proper GitHub links and version comparisons

## 🎯 **Release Process**

### **1. Automated Release (Recommended)**

```bash
# Interactive release script
./scripts/release.sh

# Follow prompts to:
# - Select release type (patch/minor/major)
# - Review changes
# - Confirm release
# - Automatically publish to NPM
```

### **2. Manual Release**

```bash
# 1. Ensure you're on main branch with latest changes
git checkout main && git pull origin main

# 2. Run validation pipeline
npm run validate

# 3. Create release (choose one)
npm run release:patch    # For bug fixes
npm run release:minor    # For new features
npm run release:major    # For breaking changes

# 4. Review generated changelog and version
git log --oneline -5

# 5. Push changes and tags
git push --follow-tags origin main

# 6. Publish to NPM
npm run publish:npm
```

## 🔄 **CI/CD Pipeline (GitHub Actions)**

### **Automatic Testing**

- Runs on every push to `main` and `feature/*` branches
- Tests on Node.js 18, 20, and 22
- Validates TypeScript, linting, formatting, and tests
- Runs MCP integration tests

### **Automatic Publishing**

- Triggers on pushes to `main` branch
- Creates GitHub release with generated changelog
- Publishes to NPM automatically
- Requires `NPM_TOKEN` secret in repository settings

## 🔍 **Quality Gates**

### **Pre-commit Checks**

✅ TypeScript compilation ✅ ESLint code quality ✅ Prettier formatting ✅ Unit tests ✅ Build
verification

### **Pre-release Checks**

✅ All pre-commit checks ✅ Integration tests ✅ Version validation ✅ Changelog generation

### **Pre-publish Checks**

✅ All pre-release checks ✅ Git working directory clean ✅ On main branch ✅ Latest changes pulled

## 🛠️ **Development Setup**

### **First Time Setup**

```bash
# 1. Clone and install
git clone https://github.com/jlfguthrie/intellicommerce-woo-mcp.git
cd intellicommerce-woo-mcp
npm install

# 2. Setup environment
cp .env.example .env
# Edit .env with your WooCommerce credentials

# 3. Test everything works
npm run validate
```

### **Daily Development**

```bash
# 1. Create feature branch
git checkout main && git pull origin main
git checkout -b feature/your-feature-name

# 2. Development with hot reload
npm run dev

# 3. Make changes and commit (hooks will auto-validate)
git add .
git commit -m "✨ feat: Your feature description"

# 4. Push and create PR
git push -u origin feature/your-feature-name
gh pr create --web
```

## 🔄 **Upstream Relationship & Contribution Strategy**

### **Repository Structure**

**IntelliCommerce✨ Woo MCP** is a commercial fork of Automattic's WooCommerce MCP server:

- **Our Repository**: `https://github.com/jlfguthrie/intellicommerce-woo-mcp`
- **Upstream Repository**: `https://github.com/Automattic/ai-experiments`
- **Upstream MCP Path**: `/mcp/woo/` (subdirectory within larger AI experiments repo)

### **Why We Track Only MCP Subdirectory**

The upstream repository contains multiple AI experiment projects. We only track changes relevant to
the MCP server functionality in `/mcp/woo/`.

### **Monitoring Upstream Changes**

#### Check for new commits in MCP directory:

```bash
git fetch upstream-mcp
git log --oneline upstream-mcp/trunk -- mcp/woo/
```

#### View specific changes:

```bash
# See what files changed in MCP directory
git diff upstream-mcp/trunk~5..upstream-mcp/trunk -- mcp/woo/

# View specific file changes
git show upstream-mcp/trunk:mcp/woo/src/server.ts
```

#### VS Code Task for Monitoring:

Use **"⬆️ Check Upstream MCP Changes"** task in VS Code to monitor upstream updates.

### **Selective Integration Process**

```bash
# Create feature branch for upstream integration
git checkout -b feature/upstream-sync-YYYY-MM-DD

# Cherry-pick specific commits (if applicable)
git cherry-pick <commit-hash>

# Or manually apply relevant changes and commit
git add . && git commit -m "🔄 sync: Apply upstream changes from <commit>"
```

### **When to Sync from Upstream**

- **Bug fixes** in core WooCommerce functionality
- **Security patches**
- **New WooCommerce API features**
- **MCP protocol updates**

### **What NOT to Sync**

- Non-MCP related changes
- Experimental features not relevant to our use case
- Changes that conflict with our commercial structure

### **Contributing Back to Upstream**

#### When to Contribute:

- **Bug fixes** that benefit the broader community
- **Performance improvements**
- **Security enhancements**
- **General code quality improvements**

#### Contribution Process:

1. Remove IntelliCommerce✨ specific branding
2. Create clean commits focused on the improvement
3. Submit PR to `Automattic/ai-experiments`
4. Reference the contribution in our changelog

## 📊 **Testing Strategy**

### **Unit Tests** (`npm run test:unit`)

- Fast, isolated tests
- Mock external dependencies
- Test business logic and utilities

### **Integration Tests** (`npm run test:integration`)

- Test MCP server startup and connectivity
- Validate tool registration
- Test with real WooCommerce API (using test credentials)

### **End-to-End Tests** (Future)

- Test complete workflows
- Test with VS Code and Claude Desktop
- Validate user experience

## 🔒 **Security & Best Practices**

### **Secrets Management**

- Never commit `.env` files
- Use GitHub Secrets for CI/CD
- Rotate API keys regularly

### **Dependency Management**

- Regular security audits with `npm audit`
- Automated dependency updates
- Lock file management

### **Code Quality**

- TypeScript strict mode
- ESLint with strict rules
- Prettier for consistent formatting
- Pre-commit validation

## 📚 **Documentation Updates**

### **Automatic Updates**

- Changelog generated from commits
- Version numbers updated automatically
- GitHub releases created with proper formatting

### **Manual Updates**

- README.md for major features
- API.md for tool documentation
- TROUBLESHOOTING.md for common issues

## 🎉 **Best Practices**

### **Commit Messages**

- Use conventional commit format
- Be descriptive but concise
- Include context for complex changes

### **Branch Management**

- Use feature branches for all development
- Keep branches focused and small
- Delete branches after merging

### **Release Management**

- Follow semantic versioning
- Test releases in staging environment
- Communicate breaking changes clearly

---

**Made with 🧡 in Cape Town 🇿🇦** **Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**
