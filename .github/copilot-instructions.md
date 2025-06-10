# ✨IntelliCommerce✨ Woo MCP - AI Assistant Instructions

## 🏷️ Project Identity & Branding

### Company Information
- **Company**: ✨IntelliCommerce✨
- **Project**: IntelliCommerce✨ Woo MCP Server
- **Location**: Cape Town 🇿🇦
- **Developer**: John Guthrie
- **Email**: info@intellicommerce.co.za
- **Website**: https://intellicommerce.co.za
- **Repository**: https://github.com/jlfguthrie/intellicommerce-woo-mcp
- **Powered by**: Xstra AI✨
- **Enabled by**: IntelliCommerce✨

### Branding Guidelines
- **Always** use "IntelliCommerce✨" with the sparkle emoji
- **Never** use "IntelliCommerce" without the sparkle emoji ✨
- **Always** include the Cape Town 🇿🇦 reference in footers
- **Always** maintain the "Made with 🧡 in Cape Town 🇿🇦" signature

## 🎯 Project Purpose & Context

The **IntelliCommerce✨ Woo MCP** is a commercial-grade Model Context Protocol (MCP) server that enables AI assistants to interact with WooCommerce stores through natural language. This is a professional fork of Automattic's WooCommerce MCP server, rebranded and enhanced for commercial use.

### Core Functionality
- **WooCommerce Integration**: Full CRUD operations for all major WooCommerce entities
- **MCP Protocol**: Standards-compliant MCP server for AI assistant integration
- **Multi-Client Support**: Works with VS Code Copilot, Claude Desktop, and other MCP clients
- **Production Ready**: Commercial-grade error handling, validation, and security

### Target Users
- **E-commerce Developers**: Building WooCommerce integrations
- **AI/ML Engineers**: Creating AI-powered e-commerce solutions
- **Store Owners**: Managing WooCommerce stores through AI assistants
- **Agencies**: Providing AI-enhanced WooCommerce services

## 🔧 Technical Architecture

### Technology Stack
- **Runtime**: Node.js 18+
- **Language**: TypeScript
- **Protocol**: Model Context Protocol (MCP)
- **API Integration**: WooCommerce REST API
- **Build System**: TypeScript Compiler (tsc)

### Project Structure
```
src/
├── server.ts              # Main MCP server implementation
├── woocommerce.ts         # WooCommerce API client wrapper
├── tools/                 # MCP tool implementations
│   ├── index.ts           # Tool registry and exports
│   ├── coupons.ts         # Coupon management tools
│   ├── customers.ts       # Customer management tools
│   ├── orders.ts          # Order management tools
│   ├── products.ts        # Product management tools
│   ├── product_variations.ts # Product variation tools
│   ├── payment_gateways.ts # Payment gateway tools
│   ├── refunds.ts         # Refund management tools
│   ├── shipping.ts        # Shipping management tools
│   └── tax_rates.ts       # Tax rate management tools
└── types/
    └── woocommerce-types.ts # TypeScript type definitions
```

### Available MCP Tools
- **Coupons**: list, get, create, update, delete
- **Customers**: list, get, create, update, delete
- **Orders**: list, get, create, update, delete
- **Products**: list, get, create, update, delete
- **Product Variations**: list, get, create, update, delete
- **Payment Gateways**: list, get, update
- **Refunds**: list, get, create, delete
- **Shipping**: list, get, create, update, delete
- **Tax Rates**: list, get, create, update, delete

## 📝 Coding Standards & Conventions

### File Headers
Always include this header in TypeScript files:
```typescript
// ✨IntelliCommerce✨ Woo MCP - [Description]
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨
```

### Naming Conventions
- **Files**: kebab-case (`product-variations.ts`)
- **Classes/Interfaces**: PascalCase (`WooCommerceClient`, `ProductData`)
- **Functions/Variables**: camelCase (`listProducts`, `customerData`)
- **Constants**: SCREAMING_SNAKE_CASE (`API_ENDPOINTS`, `DEFAULT_PAGE_SIZE`)
- **MCP Tools**: snake_case (`list_products`, `get_customer`)

### Code Style
- **Indentation**: 2 spaces (no tabs)
- **Line Length**: 80 characters (soft), 120 (hard limit)
- **Semicolons**: Always use
- **Quotes**: Single quotes for strings
- **Trailing Commas**: Use in multiline objects/arrays

### Error Handling
- Use descriptive error messages
- Include context in error logs
- Validate all inputs thoroughly
- Handle WooCommerce API errors gracefully
- Never expose sensitive data in error messages

### TypeScript Standards
- Use explicit return types for functions
- Prefer interfaces over type aliases for object shapes
- Use readonly for immutable data
- Implement proper generic constraints
- Use union types for known string constants

## 🚀 Development Workflow

### Getting Started
1. Clone repository: `git clone https://github.com/jlfguthrie/intellicommerce-woo-mcp.git`
2. Install dependencies: `npm install`
3. Create `.env` file with WooCommerce credentials
4. Build project: `npm run build`
5. Test server: `npm start`

### VS Code Integration
- Use `.vscode/mcp.json` for MCP server configuration
- Configure environment variables in MCP settings
- Use VS Code tasks for common operations
- Debug with provided launch configurations

### Testing & Validation
- Test all MCP tools with MCP Inspector
- Validate WooCommerce API connectivity
- Verify error handling and edge cases
- Test with multiple WooCommerce store configurations

## 🔐 Security & Best Practices

### Environment Security
- Never commit `.env` files or API keys
- Use environment variables for all sensitive data
- Implement proper API key validation
- Use HTTPS for all WooCommerce API calls

### Input Validation
- Validate all MCP tool arguments
- Sanitize user inputs
- Implement proper error boundaries
- Use TypeScript for compile-time type checking

### API Best Practices
- Implement rate limiting
- Handle authentication errors gracefully
- Use proper HTTP status codes
- Log security-relevant events

## 📚 Documentation Standards

### Code Comments
- Document complex business logic
- Explain WooCommerce-specific concepts
- Include usage examples for public APIs
- Document error conditions and recovery

### README Updates
- Keep installation instructions current
- Document all configuration options
- Provide troubleshooting guides
- Include usage examples

### API Documentation
- Document all MCP tools and their parameters
- Provide request/response examples
- Document error conditions
- Include integration guides

## 🎨 AI Assistant Interaction Guidelines

### When Helping with Code
1. **Always** maintain IntelliCommerce✨ branding
2. **Use** proper TypeScript types and interfaces
3. **Follow** established naming conventions
4. **Include** appropriate error handling
5. **Add** descriptive comments for complex logic
6. **Validate** inputs and handle edge cases

### When Adding New Features
1. **Understand** WooCommerce API capabilities
2. **Design** consistent tool interfaces
3. **Implement** proper error handling
4. **Add** comprehensive type definitions
5. **Test** with real WooCommerce stores
6. **Document** new functionality

### When Debugging Issues
1. **Check** WooCommerce API credentials and permissions
2. **Verify** MCP server configuration
3. **Validate** tool arguments and parameters
4. **Review** error logs and stack traces
5. **Test** with simplified configurations
6. **Document** solutions for future reference

## 🔄 Commit Message Format

```bash
✨ feat: Add new feature description

[Optional detailed description]

Made with 🧡 in Cape Town 🇿🇦
```

### Commit Types
- `✨ feat` - New features
- `🐛 fix` - Bug fixes
- `📚 docs` - Documentation updates
- `🎨 style` - Code style changes
- `♻️ refactor` - Code refactoring
- `⚡ perf` - Performance improvements
- `✅ test` - Testing additions
- `🔧 chore` - Maintenance tasks

## 🌟 Quality Standards

### Code Quality
- All code must be properly typed
- Follow ESLint and Prettier configurations
- Include error handling for all operations
- Write self-documenting code

### Performance
- Implement efficient API calls
- Use appropriate caching strategies
- Handle large datasets properly
- Optimize for MCP protocol efficiency

### Reliability
- Handle network failures gracefully
- Implement proper retry mechanisms
- Validate all external data
- Provide meaningful error messages

---

**Made with 🧡 in Cape Town 🇿🇦**
**Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**
