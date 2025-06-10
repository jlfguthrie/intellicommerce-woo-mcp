# 🚀 IntelliCommerce✨ Woo MCP - Setup Guide

## 📋 Prerequisites

- **Node.js**: Version 18+ (tested with v22.15.0)
- **npm**: Latest version (comes with Node.js)
- **WooCommerce Store**: Active store with REST API enabled
- **MCP Client**: VS Code with Copilot, Claude Desktop, or any MCP-compatible client

## 🔧 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/jlfguthrie/intellicommerce-woo-mcp.git
cd intellicommerce-woo-mcp
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Configure Environment

Copy the environment template and add your WooCommerce credentials:

```bash
cp .env.example .env
```

Edit `.env` with your WooCommerce store details:

```env
WOOCOMMERCE_API_URL=https://your-store.com
WOOCOMMERCE_CONSUMER_KEY=ck_your_consumer_key
WOOCOMMERCE_CONSUMER_SECRET=cs_your_consumer_secret
```

#### 🔑 Getting WooCommerce API Keys

1. Log into your WooCommerce admin dashboard
2. Go to **WooCommerce** → **Settings** → **Advanced** → **REST API**
3. Click **Add key**
4. Set description: "IntelliCommerce✨ Woo MCP"
5. Set user and permissions (Read/Write as needed)
6. Click **Generate API key**
7. Copy the Consumer Key and Consumer Secret

### 4. Build the Project

```bash
npm run build
```

### 5. Test the Connection

```bash
npm start
```

You should see:
```
✨ IntelliCommerce✨ Woo MCP Server running on stdio
Made with 🧡 in Cape Town 🇿🇦
```

## 🔌 Client Configuration

### VS Code with GitHub Copilot

Create or update `.vscode/mcp.json` in your workspace:

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

> **🔐 Security:** The server automatically loads credentials from your `.env` file. No need to hardcode them in the MCP configuration!
```

### Claude Desktop

Add to your `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "intellicommerce-woo": {
      "command": "node",
      "args": ["/absolute/path/to/intellicommerce-woo-mcp/build/server.js"],
      "env": {
        "WOOCOMMERCE_API_URL": "https://your-store.com",
        "WOOCOMMERCE_CONSUMER_KEY": "ck_your_key",
        "WOOCOMMERCE_CONSUMER_SECRET": "cs_your_secret"
      }
    }
  }
}
```

## ✅ Verification

### Test API Connection

Run the built-in connection test:

```bash
# If you have the test file
node test-connection.cjs
```

### Test MCP Tools

Use the MCP Inspector to test tools:

```bash
npx @modelcontextprotocol/inspector node build/server.js
```

### Example Usage

In your MCP client, try these commands:

- "List all products in my WooCommerce store"
- "Show me recent orders"
- "Get customer information for ID 123"
- "List all available coupons"

## 🔐 Security Notes

- **Never commit `.env` files** to version control
- Use **read-only API keys** when possible
- Ensure your WooCommerce store uses **HTTPS**
- **Regularly rotate** API keys
- **Monitor API usage** in your WooCommerce logs

## 🎯 Next Steps

- See [DEVELOPMENT.md](DEVELOPMENT.md) for development setup
- Check [API.md](API.md) for available tools and endpoints
- Visit [TROUBLESHOOTING.md](TROUBLESHOOTING.md) if you encounter issues

---

**Made with 🧡 in Cape Town 🇿🇦**
**Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**
