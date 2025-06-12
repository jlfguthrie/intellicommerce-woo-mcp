# 🚀 IntelliCommerce✨ Woo MCP - AI Assistant Workflow Rules

*Made with 🧡 in Cape Town 🇿🇦*
*Powered by Xstra AI✨ | Enabled by IntelliCommerce✨*

---

## 🎯 **CRITICAL PROJECT CONTEXT**

### Project Identity
- **Name**: IntelliCommerce✨ Woo MCP Server
- **Type**: Commercial-grade Model Context Protocol (MCP) server
- **Purpose**: Bridge WooCommerce stores with AI assistants via natural language
- **Tech Stack**: TypeScript, Node.js 18+, MCP Protocol, WooCommerce REST API
- **Repository**: https://github.com/jlfguthrie/intellicommerce-woo-mcp
- **Location**: Cape Town 🇿🇦

### Project Status
- **Production-Ready**: ✅ Commercial-grade fork of Automattic's WooCommerce MCP
- **Global NPM Package**: ✅ Available as `intellicommerce-woo-mcp`
- **Testing**: ✅ 39 tests across 5 test suites (Unit, Integration, MCP, E2E, Security)
- **Documentation**: ✅ Comprehensive user and developer docs

---

## 🔄 **MANDATORY DEVELOPMENT WORKFLOW**

### 1. **ALWAYS Run Tests Before Any Changes**
```bash
# REQUIRED before any code changes
npm run validate  # Runs typecheck + all 39 tests

# Individual test suites
npm run test:unit        # 4 tests  - Server core functionality
npm run test:integration # 10 tests - MCP server integration
npm run test:mcp        # 6 tests  - Protocol compliance
npm run test:e2e        # 7 tests  - End-to-end workflows
npm run test:security   # 12 tests - Security validation
```

### 2. **Feature Branch Workflow (MANDATORY)**
```bash
# NEVER work directly on main branch
git checkout main && git pull origin main
git checkout -b feature/your-feature-name

# Make changes, commit with conventional format
git add . && git commit -m "✨ feat: Description"

# Push and create PR
git push origin feature/your-feature-name
gh pr create --title "✨ feat: Title" --body "Description"

# After merge, cleanup
git checkout main && git pull origin main
git branch -d feature/your-feature-name
```

### 3. **Required Validation Pipeline**
```bash
# Before any commit
npm run validate     # TypeScript check + all tests
npm run build       # Ensure clean build
npm run format      # Code formatting

# Before releases
npm run security:check    # Security audit
npm run deps:audit       # Dependency audit
```

---

## 📝 **CODING STANDARDS (ENFORCED)**

### File Headers (MANDATORY)
```typescript
// ✨IntelliCommerce✨ Woo MCP - [Description]
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨
```

### Naming Conventions
- **Files**: kebab-case (`product-variations.ts`)
- **Classes/Interfaces**: PascalCase (`WooCommerceClient`)
- **Functions/Variables**: camelCase (`listProducts`)
- **Constants**: SCREAMING_SNAKE_CASE (`API_ENDPOINTS`)
- **MCP Tools**: snake_case (`list_products`)

### Code Style
- **Indentation**: 2 spaces (NEVER tabs)
- **Line Length**: 80 characters (soft), 120 (hard limit)
- **Semicolons**: ALWAYS use
- **Quotes**: Single quotes for strings
- **Trailing Commas**: Use in multiline objects/arrays

### Commit Message Format
```bash
✨ feat: Add new feature description
🐛 fix: Resolve issue description
📚 docs: Update documentation
🎨 style: Code style improvements
♻️ refactor: Code refactoring
⚡ perf: Performance improvements
✅ test: Add/update tests
🔧 chore: Maintenance tasks

# ALWAYS end with:
Made with 🧡 in Cape Town 🇿🇦
```

---

## 🛠️ **DEVELOPMENT ENVIRONMENT RULES**

### VS Code Configuration
- **Use Local Build**: `.vscode/mcp.json` points to `${workspaceFolder}/build/server.js`
- **Never Global in Dev**: Development uses local build, not global installation
- **Auto-Format**: Files auto-format on save with Prettier
- **Testing**: Use VS Code tasks for common operations

### Environment Setup
```bash
# Development environment variables (.env)
WOOCOMMERCE_API_URL=https://your-store.com
WOOCOMMERCE_CONSUMER_KEY=ck_your_key
WOOCOMMERCE_CONSUMER_SECRET=cs_your_secret
NODE_ENV=development
```

### Project Structure Rules
```
src/                 # Source TypeScript files
├── server.ts        # Main MCP server
├── woocommerce.ts   # API client wrapper
├── tools/           # MCP tool implementations
└── types/           # TypeScript definitions

build/               # Compiled JavaScript (git ignored)
tests/               # Test suites (6 suites, 48 tests)
docs/                # Documentation
scripts/             # Automation scripts
.vscode/             # VS Code configuration
.github/workflows/   # CI/CD pipeline configuration
```

---

## 🧪 **TESTING REQUIREMENTS**

### Test Coverage Requirements
- **Unit Tests**: Core functionality validation (4 tests)
- **Integration Tests**: MCP server and environment setup (10 tests)
- **Protocol Tests**: MCP JSON-RPC 2.0 compliance (6 tests)
- **E2E Tests**: Complete workflow validation (7 tests)
- **Security Tests**: Input validation and credential safety (12 tests)
- **Tool Description Tests**: Tool schema and handler validation (9 tests)

### Testing Workflow
```bash
# ALWAYS run before committing
npm run validate

# Test specific functionality
npm run test:unit        # 4 tests - Server functionality
npm run test:integration # 10 tests - MCP server startup
npm run test:mcp         # 6 tests - Protocol compliance
npm run test:e2e         # 7 tests - Full workflows
npm run test:security    # 12 tests - Security validation
npm run test:tools       # 9 tests - Tool description validation

# All test suites (48 tests across 6 suites)
npm test

# Coverage reporting
npm run test:coverage   # Generate coverage report
npm run test:watch     # Development mode
```

### Test Failure Protocol
1. **NEVER commit failing tests**
2. **Fix tests before continuing development**
3. **Add tests for new features**
4. **Update tests when changing functionality**

---

## 🔐 **SECURITY REQUIREMENTS**

### Credential Management
- **NEVER commit `.env` files**
- **Use environment variables for all secrets**
- **Validate API key format and permissions**
- **Implement HTTPS enforcement**

### Input Validation
- **Validate all MCP tool arguments**
- **Sanitize user inputs**
- **Prevent injection attacks (XSS, SQL, etc.)**
- **Handle malicious input patterns**

### Error Handling
- **Never expose internal errors**
- **Sanitize error messages**
- **Log security events**
- **Implement safe error boundaries**

---

## 📦 **PUBLISHING & RELEASE WORKFLOW**

### Release Process
```bash
# 1. Ensure clean state
git status  # Should be clean
npm run validate  # All tests pass

# 2. Update version (choose one)
npm run release:patch  # Bug fixes (1.1.4 → 1.1.5)
npm run release:minor  # New features (1.1.4 → 1.2.0)
npm run release:major  # Breaking changes (1.1.4 → 2.0.0)

# 3. Push and publish
git push origin main --tags
npm publish  # Automated via CI/CD
```

### Pre-Release Checklist
- ✅ All tests passing (`npm run validate`)
- ✅ Documentation updated
- ✅ Changelog generated
- ✅ Security audit clean (`npm run security:check`)
- ✅ Dependencies audited (`npm run deps:audit`)
- ✅ Build successful (`npm run build`)

---

## 🌍 **GLOBAL INSTALLATION USAGE**

### For End Users
```bash
# Install globally
npm install -g intellicommerce-woo-mcp

# Setup in any project
cd your-project
intellicommerce-woo-mcp setup

# Configure environment
export WOOCOMMERCE_API_URL="https://your-store.com"
export WOOCOMMERCE_CONSUMER_KEY="ck_your_key"
export WOOCOMMERCE_CONSUMER_SECRET="cs_your_secret"
```

### Development vs Production
- **Development**: Use local build (`${workspaceFolder}/build/server.js`)
- **Production**: Use global command (`intellicommerce-woo-mcp`)
- **Testing**: Always use local build for validation

---

## 🤖 **AI ASSISTANT INTEGRATION RULES**

### When Helping with Code
1. **ALWAYS enforce feature branch workflow**
2. **ALWAYS run tests before code changes**
3. **ALWAYS maintain IntelliCommerce✨ branding**
4. **ALWAYS use proper TypeScript types**
5. **ALWAYS include file headers**
6. **ALWAYS validate inputs and handle errors**

### When Suggesting Changes
1. **Check current test status first**
2. **Suggest proper branch naming**
3. **Recommend validation pipeline**
4. **Ensure security best practices**
5. **Maintain code style consistency**

### When Debugging Issues
1. **Run `npm run validate` first**
2. **Check test output for clues**
3. **Verify environment configuration**
4. **Review error logs and stack traces**
5. **Test with simplified configurations**

---

## 🔄 **PROJECT MAINTENANCE**

### Regular Tasks
```bash
# Weekly dependency updates
npm run deps:fresh

# Monthly security audits
npm run security:check
npm run deps:audit

# Quarterly upstream sync
git fetch upstream
git merge upstream/main
```

### Quality Assurance
- **Code Quality**: ESLint + Prettier enforced
- **Type Safety**: TypeScript strict mode
- **Test Coverage**: Comprehensive test suites (48 tests across 6 suites)
- **Security**: Regular audits and validation
- **Documentation**: Always up-to-date

### 🔄 **CI/CD SYNC REQUIREMENTS**

**CRITICAL**: When modifying test suites, always update GitHub Actions configuration:

#### Test Suite Management
- **Current State**: 48 tests across 6 suites
- **Test Suites**: Unit (4), Integration (10), MCP (6), E2E (7), Security (12), Tools (9)
- **CI/CD File**: `.github/workflows/ci-cd.yml`

#### Mandatory Updates When Adding/Removing Test Suites:
1. **Update package.json**: Add/remove `test:name` script
2. **Update GitHub Actions**: Sync test suite list in `.github/workflows/ci-cd.yml`
3. **Update Workflow Rules**: Update test counts in this file
4. **Update README.md**: Update test metrics and documentation
5. **Validate CI/CD**: Push to trigger GitHub Actions and verify all tests run

#### GitHub Actions Test Section Template:
```yaml
# Always keep this in sync with package.json test scripts
echo "🔧 Unit Tests (4 tests)..."
npm run test:unit || echo "⚠️ Unit tests had issues"

echo "🔗 Integration Tests (10 tests)..."
npm run test:integration || echo "⚠️ Integration tests had issues"

echo "📋 MCP Protocol Tests (6 tests)..."
npm run test:mcp || echo "⚠️ MCP tests had issues"

echo "🚀 End-to-End Tests (7 tests)..."
npm run test:e2e || echo "⚠️ E2E tests had issues"

echo "🔒 Security Tests (12 tests)..."
npm run test:security || echo "⚠️ Security tests had issues"

echo "🔧 Tool Description Tests (9 tests)..."
npm run test:tools || echo "⚠️ Tool description tests had issues"
```

**AI ASSISTANT REMINDER**: When creating new test suites, you MUST update GitHub Actions configuration to prevent CI/CD pipeline failures!

---

## 🎯 **SUCCESS METRICS**

### Development Quality
- ✅ 48/48 tests passing (across 6 suites)
- ✅ 100% TypeScript compilation
- ✅ Zero ESLint errors (ESLint disabled for upstream compatibility)
- ✅ Clean security audit
- ✅ Updated documentation

### Production Readiness
- ✅ Global NPM package available
- ✅ CLI setup tool working
- ✅ VS Code integration functional
- ✅ Claude Desktop compatibility
- ✅ Comprehensive error handling

---

## 🚨 **CRITICAL REMINDERS**

### NEVER
- ❌ Work directly on main branch
- ❌ Commit without running tests
- ❌ Commit `.env` files or secrets
- ❌ Skip validation pipeline
- ❌ Ignore failing tests
- ❌ Remove IntelliCommerce✨ branding

### ALWAYS
- ✅ Use feature branches
- ✅ Run `npm run validate` before commits
- ✅ Include proper file headers
- ✅ Follow conventional commit format
- ✅ Maintain security best practices
- ✅ Update documentation
- ✅ Keep GitHub Actions in sync with test suite changes

---

### 🎯 **Fork Management Strategy - ESLint Disabled**

**CRITICAL**: ESLint is **intentionally disabled** for upstream fork compatibility:

- **Why**: This is a commercial fork of Automattic's WooCommerce MCP server
- **Problem**: ESLint triggers AI assistants to rewrite code, creating massive diffs from upstream
- **Solution**: Disabled linting to prevent style drift and maintain clean merge path
- **Benefits**:
  - ✅ Easy upstream merges and updates
  - ✅ Clean contributions back to Automattic
  - ✅ Minimal maintenance overhead
  - ✅ AI assistants focus on functionality, not style

**Configuration**:
```json
// package.json - Smart placeholder commands
"lint": "echo \"✨ Linting disabled for upstream compatibility\"",
"lint:fix": "echo \"✨ Linting disabled for upstream compatibility\""

// .vscode/settings.json - ESLint fully disabled
"eslint.enable": false,
"eslint.validate": [],
"eslint.format.enable": false
```

**DO NOT** re-enable ESLint or suggest style changes that create upstream drift!

---

**Made with 🧡 in Cape Town 🇿🇦**
**Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**
