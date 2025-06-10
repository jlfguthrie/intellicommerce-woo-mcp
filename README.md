<div align="center">

# ✨IntelliCommerce✨ Woo MCP Server

<p align="center">
  <strong>🛒 Transform your WooCommerce store with AI-powered natural language interactions</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Node.js-22.15.0+-339933?style=for-the-badge&logo=node.js&logoColor=white" alt="Node.js" />
  <img src="https://img.shields.io/badge/TypeScript-5.8.3+-3178C6?style=for-the-badge&logo=typescript&logoColor=white" alt="TypeScript" />
  <img src="https://img.shields.io/badge/WooCommerce-96588A?style=for-the-badge&logo=woocommerce&logoColor=white" alt="WooCommerce" />
  <img src="https://img.shields.io/badge/MCP-Protocol-FF6B35?style=for-the-badge" alt="MCP Protocol" />
</p>

<p align="center">
  <img src="https://img.shields.io/github/license/jlfguthrie/intellicommerce-woo-mcp?style=for-the-badge" alt="License" />
  <img src="https://img.shields.io/github/stars/jlfguthrie/intellicommerce-woo-mcp?style=for-the-badge" alt="Stars" />
  <img src="https://img.shields.io/github/forks/jlfguthrie/intellicommerce-woo-mcp?style=for-the-badge" alt="Forks" />
  <img src="https://img.shields.io/github/issues/jlfguthrie/intellicommerce-woo-mcp?style=for-the-badge" alt="Issues" />
</p>

<p align="center">
  <a href="#-features">Features</a> •
  <a href="#-quick-start">Quick Start</a> •
  <a href="#-documentation">Documentation</a> •
  <a href="#-examples">Examples</a> •
  <a href="#-contributing">Contributing</a>
</p>

---

<p align="center">
  <strong>Made with 🧡 in Cape Town 🇿🇦</strong><br>
  <em>Powered by Xstra AI✨ | Enabled by IntelliCommerce✨</em>
</p>

</div>

## 🎯 Overview

The **IntelliCommerce✨ Woo MCP** server is a commercial-grade Model Context Protocol (MCP) implementation that bridges WooCommerce stores with AI assistants. Talk to your store in natural language through VS Code Copilot, Claude Desktop, or any MCP-compatible client.

> **🚀 Professional fork** of Automattic's WooCommerce MCP server, enhanced with commercial features, comprehensive documentation, and production-ready configuration.

## ✨ Features

<table>
<tr>
<td width="50%">

### 🛒 **Complete Store Management**
- **Products & Variations** - Full catalog control
- **Orders & Fulfillment** - Order lifecycle management
- **Customer Data** - Comprehensive customer insights
- **Coupons & Discounts** - Promotion management
- **Payment Gateways** - Payment configuration
- **Shipping & Tax** - Logistics and compliance

</td>
<td width="50%">

### 🤖 **AI Integration**
- **Natural Language** - Talk to your store conversationally
- **Multi-Client Support** - VS Code, Claude Desktop, and more
- **Real-time Data** - Live WooCommerce API integration
- **Type Safety** - Full TypeScript implementation
- **Error Handling** - Robust production-grade reliability
- **Security First** - Environment-based credential management

</td>
</tr>
</table>

## 🚀 Quick Start

<details>
<summary><strong>📋 Prerequisites</strong></summary>

- **Node.js 18+** (tested with v22.15.0)
- **WooCommerce Store** with REST API enabled
- **API Keys** with appropriate permissions
- **MCP Client** (VS Code Copilot, Claude Desktop, etc.)

</details>

### 1️⃣ **Installation**

```bash
# Clone the repository
git clone https://github.com/jlfguthrie/intellicommerce-woo-mcp.git
cd intellicommerce-woo-mcp

# Install dependencies
npm install

# Build the project
npm run build
```

### 2️⃣ **Configuration**

```bash
# Create environment file
cp .env.example .env
```

Edit `.env` with your WooCommerce credentials:

```env
WOOCOMMERCE_API_URL=https://your-store.com
WOOCOMMERCE_CONSUMER_KEY=ck_your_consumer_key
WOOCOMMERCE_CONSUMER_SECRET=cs_your_consumer_secret
```

### 3️⃣ **Client Setup**

<details>
<summary><strong>🔧 VS Code with Copilot</strong></summary>

Create `.vscode/mcp.json`:

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

> **🔐 Security Note:** Credentials are loaded from your `.env` file, not hardcoded in the MCP configuration.
```

</details>

<details>
<summary><strong>🖥️ Claude Desktop</strong></summary>

Add to `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "intellicommerce-woo": {
      "command": "node",
Add to `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "intellicommerce-woo": {
      "command": "node",
      "args": ["/absolute/path/to/build/server.js"],
      "env": {
        "WOOCOMMERCE_API_URL": "https://your-store.com",
        "WOOCOMMERCE_CONSUMER_KEY": "ck_your_key",
        "WOOCOMMERCE_CONSUMER_SECRET": "cs_your_secret"
      }
    }
  }
}
```

> **💡 Note:** For Claude Desktop, you need to include credentials in the config file since it doesn't automatically load `.env` files.
```

</details>

### 4️⃣ **Launch**

```bash
# Start the server
npm start
```

You'll see:
```
✨ IntelliCommerce✨ Woo MCP Server running on stdio
Made with 🧡 in Cape Town 🇿🇦
```

## 💬 Examples

<table>
<tr>
<td width="50%">

**📦 Product Management**
```
"List all products with 'shirt' in the name"
"What's the price of product ID 123?"
"Create a new product called 'Summer Hat'"
"Update product 456 to be on sale"
```

**📋 Order Operations**
```
"Show me orders from this week"
"Get details for order #1001"
"What's the status of recent orders?"
"List orders over $100"
```

</td>
<td width="50%">

**👥 Customer Insights**
```
"Show customer details for ID 789"
"List customers from Cape Town"
"Find customers with no orders"
"Get top spending customers"
```

**🎫 Promotions**
```
"List all active coupons"
"Create a 15% discount code"
"Show coupon usage statistics"
"Disable expired promotions"
```

</td>
</tr>
</table>

## 📚 Documentation

<div align="center">

| 📖 **Guide** | 🎯 **Purpose** | 🔗 **Link** |
|-------------|----------------|-------------|
| **Setup** | Installation & Configuration | [📋 Setup Guide](docs/SETUP.md) |
| **API Reference** | Complete Tool Documentation | [🛠️ API Docs](docs/API.md) |
| **Development** | Contributing & Building | [💻 Dev Guide](docs/DEVELOPMENT.md) |
| **Troubleshooting** | Common Issues & Solutions | [🔧 Troubleshooting](docs/TROUBLESHOOTING.md) |
| **Changelog** | Version History | [📈 Changelog](docs/CHANGELOG.md) |

</div>

## 🛠️ Available Tools

<details>
<summary><strong>📦 Products (6 tools)</strong></summary>

- `list_products` - List all products with search and pagination
- `get_product` - Get specific product details
- `create_product` - Create new products
- `update_product` - Update existing products
- `delete_product` - Remove products
- `list_product_variations` - Manage product variations

</details>

<details>
<summary><strong>📋 Orders (5 tools)</strong></summary>

- `list_orders` - List orders with filtering
- `get_order` - Get order details
- `create_order` - Create new orders
- `update_order` - Update order status
- `delete_order` - Remove orders

</details>

<details>
<summary><strong>👥 Customers (5 tools)</strong></summary>

- `list_customers` - List all customers
- `get_customer` - Get customer details
- `create_customer` - Add new customers
- `update_customer` - Update customer data
- `delete_customer` - Remove customers

</details>

<details>
<summary><strong>🎫 Coupons, 💳 Payments, 🚚 Shipping, 💰 Refunds, 💸 Tax Rates</strong></summary>

**45+ total tools** covering all major WooCommerce entities with full CRUD operations.

</details>

## 🔐 Security

- ✅ **Environment Variables** - Never commit credentials
- ✅ **API Key Permissions** - Least privilege access
- ✅ **Input Validation** - Prevent injection attacks
- ✅ **HTTPS Enforcement** - Secure API communications
- ✅ **Rate Limiting** - Prevent API abuse

## 🌟 Why Choose IntelliCommerce✨ Woo MCP?

<table>
<tr>
<td align="center" width="25%">
<img src="https://cdn-icons-png.flaticon.com/64/2910/2910791.png" width="48" height="48" alt="Commercial Grade" /><br>
<strong>Commercial Grade</strong><br>
<small>Production-ready with comprehensive error handling</small>
</td>
<td align="center" width="25%">
<img src="https://cdn-icons-png.flaticon.com/64/3281/3281306.png" width="48" height="48" alt="Type Safe" /><br>
<strong>Type Safe</strong><br>
<small>Full TypeScript implementation with type safety</small>
</td>
<td align="center" width="25%">
<img src="https://cdn-icons-png.flaticon.com/64/2920/2920277.png" width="48" height="48" alt="Well Documented" /><br>
<strong>Well Documented</strong><br>
<small>Comprehensive guides and troubleshooting</small>
</td>
<td align="center" width="25%">
<img src="https://cdn-icons-png.flaticon.com/64/3159/3159310.png" width="48" height="48" alt="Cape Town Built" /><br>
<strong>Cape Town Built</strong><br>
<small>Local South African development with pride</small>
</td>
</tr>
</table>

## 🤝 Contributing

We welcome contributions! Here's how to get started:

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/amazing-feature`
3. **Commit** changes: `git commit -m '✨ feat: Add amazing feature'`
4. **Push** to branch: `git push origin feature/amazing-feature`
5. **Open** a Pull Request

<details>
<summary><strong>📋 Development Setup</strong></summary>

```bash
# Install dependencies
npm install

# Start development with watch mode
npm run dev

# Run tests
npm test

# Lint code
npm run lint

# Format code
npm run format
```

</details>

See our [Contributing Guide](docs/DEVELOPMENT.md) for detailed instructions.

## 📊 Project Stats

<div align="center">

![GitHub repo size](https://img.shields.io/github/repo-size/jlfguthrie/intellicommerce-woo-mcp?style=for-the-badge)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/jlfguthrie/intellicommerce-woo-mcp?style=for-the-badge)
![GitHub language count](https://img.shields.io/github/languages/count/jlfguthrie/intellicommerce-woo-mcp?style=for-the-badge)
![GitHub top language](https://img.shields.io/github/languages/top/jlfguthrie/intellicommerce-woo-mcp?style=for-the-badge)

</div>

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

### 🙏 Attribution

This project is a commercial fork and enhancement of the WooCommerce MCP server originally created by **Automattic Inc.** as part of their [ai-experiments repository](https://github.com/Automattic/ai-experiments).

We gratefully acknowledge the original authors and contributors.

---

<div align="center">

### 🏷️ About IntelliCommerce✨

**IntelliCommerce✨** is a Cape Town-based technology company specializing in AI-powered e-commerce solutions. We create innovative tools and integrations that bridge the gap between artificial intelligence and online commerce platforms.

<p>
<a href="https://intellicommerce.co.za">🌐 Website</a> •
<a href="mailto:info@intellicommerce.co.za">📧 Email</a> •
<a href="https://github.com/jlfguthrie">👨‍💻 Developer</a>
</p>

<p>
<strong>Made with 🧡 in Cape Town 🇿🇦</strong><br>
<em>Powered by Xstra AI✨ | Enabled by IntelliCommerce✨</em>
</p>

</div>




## 🛠️ Development

<details>
<summary><strong>📋 Development Commands</strong></summary>

```bash
# Install dependencies
npm install

# Build the project
npm run build

# Start the server
npm start

# Development with watch mode
npm run dev

# Clean build directory
npm run clean

# Run linting
npm run lint

# Format code
npm run format
```

</details>

<details>
<summary><strong>🧪 Testing</strong></summary>

```bash
# Test MCP connection
npm run test:mcp

# Test WooCommerce API
npm run test:api

# Run all tests
npm test
```

</details>

## 🔧 Advanced Configuration

<details>
<summary><strong>⚙️ Environment Variables</strong></summary>

```env
# Required
WOOCOMMERCE_API_URL=https://your-store.com
WOOCOMMERCE_CONSUMER_KEY=ck_your_key
WOOCOMMERCE_CONSUMER_SECRET=cs_your_secret

# Optional
NODE_ENV=development
DEBUG=true
API_TIMEOUT=30000
LOG_LEVEL=info
LOG_REQUESTS=true
MAX_CONCURRENT_REQUESTS=10
DEFAULT_PAGE_SIZE=20
```

</details>

<details>
<summary><strong>🔍 Troubleshooting</strong></summary>

**Common Issues:**

1. **❌ "Missing required WooCommerce configuration"**
   - Check your `.env` file exists and has correct values
   - Ensure no extra spaces or quotes in environment variables

2. **❌ "Invalid signature" or 401 Unauthorized**
   - Regenerate API keys in WooCommerce admin
   - Verify API key permissions (Read/Write)
   - Check store URL includes `https://`

3. **❌ Server not showing in VS Code Copilot**
   - Verify absolute path to `build/server.js` in `.vscode/mcp.json`
   - Restart VS Code after MCP configuration changes

For more troubleshooting, see our [Troubleshooting Guide](docs/TROUBLESHOOTING.md).

</details>

## 📚 Documentation

<div align="center">

| 📖 **Guide** | 🎯 **Purpose** | 🔗 **Link** |
|-------------|----------------|-------------|
| **Setup** | Installation & Configuration | [📋 Setup Guide](docs/SETUP.md) |
| **API Reference** | Complete Tool Documentation | [🛠️ API Docs](docs/API.md) |
| **Development** | Contributing & Building | [💻 Dev Guide](docs/DEVELOPMENT.md) |
| **Troubleshooting** | Common Issues & Solutions | [🔧 Troubleshooting](docs/TROUBLESHOOTING.md) |
| **Changelog** | Version History | [📈 Changelog](docs/CHANGELOG.md) |

</div>

## 🔐 Security

- **Never commit your API keys or secrets to version control.** Use environment variables (the `.env` file) to store them securely.
- **Limit API key permissions:** Only grant the necessary permissions (read-only, if possible) to the WooCommerce API keys you use with the **IntelliCommerce✨ Woo MCP** server.
- **Validate Inputs:** Thoroughly validate all inputs received from the client (especially tool arguments) to prevent injection attacks or unintended behavior.
- **Consider HTTPS:** Use HTTPS for communication between the client and server, _especially_ if you're not using the stdio transport. The quickstart enables `queryStringAuth` and disables certificate checking for local development only. For production, use proper HTTPS certificates.
- **Rate Limiting:** Implement rate limiting to prevent abuse of your server and the WooCommerce API.

## 🤝 Contributing

Contributions are welcome! Please submit a pull request with your changes. Ensure your code follows the existing style and includes tests where appropriate.

**Made with 🧡 in Cape Town 🇿🇦**
**Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**

---

### 🏷️ About IntelliCommerce✨

**IntelliCommerce✨** is a Cape Town-based technology company specializing in AI-powered e-commerce solutions. We create innovative tools and integrations that bridge the gap between artificial intelligence and online commerce platforms.

- **Website**: https://intellicommerce.co.za
- **Email**: info@intellicommerce.co.za
- **Developer**: John Guthrie
- **Location**: Cape Town 🇿🇦
