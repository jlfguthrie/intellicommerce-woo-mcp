# 🐛 IntelliCommerce✨ Woo MCP - Troubleshooting Guide

## 🚨 Common Issues & Solutions

### Server Won't Start

#### ❌ "Missing required WooCommerce configuration"

**Problem**: Environment variables not loaded

**Solutions**:
1. Ensure `.env` file exists in project root
2. Check environment variable names are correct:
   - `WOOCOMMERCE_API_URL`
   - `WOOCOMMERCE_CONSUMER_KEY`
   - `WOOCOMMERCE_CONSUMER_SECRET`
3. Verify no extra spaces or quotes in `.env` file
4. Try running: `npm run build` before `npm start`

#### ❌ "ECONNREFUSED" or Connection Refused

**Problem**: Cannot connect to WooCommerce store

**Solutions**:
1. Verify store URL includes `https://`
2. Check if store is accessible from your network
3. Test store URL in browser
4. Check firewall/VPN settings
5. For local development, use `WOOCOMMERCE_INSECURE_HTTP=true`

### API Authentication Issues

#### ❌ "Invalid signature" or 401 Unauthorized

**Problem**: API credentials are incorrect or malformed

**Solutions**:
1. Regenerate API keys in WooCommerce admin
2. Check Consumer Key starts with `ck_`
3. Check Consumer Secret starts with `cs_`
4. Ensure API key has correct permissions (Read/Write)
5. Verify store has REST API enabled

#### ❌ "woocommerce_rest_authentication_error"

**Problem**: Authentication method mismatch

**Solutions**:
1. Our server uses HTTP Basic Auth (recommended)
2. Ensure WooCommerce supports Basic Auth
3. Check if your hosting provider blocks Basic Auth
4. Try OAuth 1.0a if Basic Auth fails

### MCP Client Issues

#### ❌ Server not showing in VS Code Copilot

**Problem**: MCP configuration incorrect

**Solutions**:
1. Check `.vscode/mcp.json` file exists
2. Verify absolute path to `build/server.js`
3. Restart VS Code completely
4. Check VS Code Copilot extension is enabled
5. Verify environment variables in MCP config

#### ❌ "Tool not found" in Claude Desktop

**Problem**: MCP server not registered properly

**Solutions**:
1. Check `claude_desktop_config.json` syntax
2. Restart Claude Desktop after config changes
3. Verify server is built: `npm run build`
4. Test server manually: `npm start`

### Build & Development Issues

#### ❌ TypeScript compilation errors

**Problem**: Type checking failures

**Solutions**:
1. Update TypeScript: `npm install -D typescript@latest`
2. Clean build: `npm run clean && npm run build`
3. Check Node.js version (requires 18+)
4. Install missing types: `npm install -D @types/node`

#### ❌ "Cannot find module" errors

**Problem**: Missing dependencies

**Solutions**:
1. Delete `node_modules` and reinstall: `rm -rf node_modules && npm install`
2. Check package.json for missing dependencies
3. Install specific missing packages
4. Verify npm version is current

### WooCommerce Store Issues

#### ❌ "woocommerce_rest_cannot_view" errors

**Problem**: Insufficient API permissions

**Solutions**:
1. Regenerate API keys with Read/Write permissions
2. Check user role has appropriate capabilities
3. Verify WooCommerce version supports REST API v3
4. Check if any security plugins block API access

#### ❌ "rest_no_route" errors

**Problem**: API endpoint not available

**Solutions**:
1. Update WooCommerce to latest version
2. Check if endpoint exists in your WooCommerce version
3. Verify permalinks are set to "Post name" in WordPress
4. Clear any caching plugins

### Performance Issues

#### ❌ Slow response times

**Problem**: API requests taking too long

**Solutions**:
1. Increase timeout: Add `API_TIMEOUT=60000` to `.env`
2. Reduce pagination: Use smaller `per_page` values
3. Check server resources on hosting provider
4. Verify no conflicting plugins

#### ❌ Rate limiting errors

**Problem**: Too many requests to WooCommerce

**Solutions**:
1. Add delays between requests
2. Reduce concurrent operations
3. Check hosting provider rate limits
4. Consider WooCommerce caching plugins

## 🔧 Debugging Steps

### 1. Test API Connection

```bash
# Test WooCommerce API directly
curl -u "consumer_key:consumer_secret" \
  https://your-store.com/wp-json/wc/v3/products
```

### 2. Check Server Logs

```bash
# Run server with debug output
DEBUG=true npm start
```

### 3. Test MCP Connection

```bash
# Use MCP Inspector
npx @modelcontextprotocol/inspector node build/server.js
```

### 4. Verify Environment

```bash
# Check environment variables
node -e "require('dotenv').config(); console.log(process.env.WOOCOMMERCE_API_URL)"
```

## 📞 Getting Help

### Before Asking for Help

1. Check this troubleshooting guide
2. Review the [SETUP.md](SETUP.md) instructions
3. Test with a fresh `.env` file
4. Try with a different WooCommerce store

### Support Channels

- **Email**: info@intellicommerce.co.za
- **GitHub Issues**: https://github.com/jlfguthrie/intellicommerce-woo-mcp/issues
- **Documentation**: https://intellicommerce.co.za

### Include in Support Requests

1. Operating system and version
2. Node.js version (`node --version`)
3. WooCommerce version
4. Error messages (sanitized - no API keys!)
5. Steps to reproduce the issue

## 🛠️ Advanced Troubleshooting

### Enable Debug Logging

Add to `.env`:
```env
DEBUG=true
LOG_LEVEL=debug
LOG_REQUESTS=true
```

### Test Individual Components

```bash
# Test TypeScript compilation
npx tsc --noEmit

# Test WooCommerce connection only
node test-connection.cjs

# Test MCP server without clients
npm start
```

### Network Debugging

```bash
# Test HTTPS connectivity
openssl s_client -connect your-store.com:443

# Check DNS resolution
nslookup your-store.com

# Test port connectivity
telnet your-store.com 443
```

---

**Made with 🧡 in Cape Town 🇿🇦**
**Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**
