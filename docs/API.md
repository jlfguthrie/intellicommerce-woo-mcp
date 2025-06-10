# 🛠️ IntelliCommerce✨ Woo MCP - API Reference

## 📊 Available MCP Tools

The **IntelliCommerce✨ Woo MCP** server provides comprehensive tools for interacting with WooCommerce stores through natural language.

### 🎫 Coupons

| Tool | Description | Parameters |
|------|-------------|------------|
| `list_coupons` | List all coupons with pagination | `page`, `per_page`, `search` |
| `get_coupon` | Get specific coupon by ID | `id` (required) |
| `create_coupon` | Create new coupon | Coupon object |
| `update_coupon` | Update existing coupon | `id` (required), coupon data |
| `delete_coupon` | Delete coupon by ID | `id` (required) |

### 👥 Customers

| Tool | Description | Parameters |
|------|-------------|------------|
| `list_customers` | List all customers with filtering | `page`, `per_page`, `search`, `email` |
| `get_customer` | Get specific customer by ID | `id` (required) |
| `create_customer` | Create new customer | Customer object |
| `update_customer` | Update existing customer | `id` (required), customer data |
| `delete_customer` | Delete customer by ID | `id` (required) |

### 📋 Orders

| Tool | Description | Parameters |
|------|-------------|------------|
| `list_orders` | List all orders with filtering | `page`, `per_page`, `status`, `customer` |
| `get_order` | Get specific order by ID | `id` (required) |
| `create_order` | Create new order | Order object |
| `update_order` | Update existing order | `id` (required), order data |
| `delete_order` | Delete order by ID | `id` (required) |

### 📦 Products

| Tool | Description | Parameters |
|------|-------------|------------|
| `list_products` | List all products with search | `page`, `per_page`, `search`, `category` |
| `get_product` | Get specific product by ID | `id` (required) |
| `create_product` | Create new product | Product object |
| `update_product` | Update existing product | `id` (required), product data |
| `delete_product` | Delete product by ID | `id` (required) |

### 🔄 Product Variations

| Tool | Description | Parameters |
|------|-------------|------------|
| `list_product_variations` | List variations for a product | `product_id` (required), `page`, `per_page` |
| `get_product_variation` | Get specific variation | `product_id` (required), `id` (required) |
| `create_product_variation` | Create new variation | `product_id` (required), variation object |
| `update_product_variation` | Update existing variation | `product_id` (required), `id` (required), data |
| `delete_product_variation` | Delete variation | `product_id` (required), `id` (required) |

### 💳 Payment Gateways

| Tool | Description | Parameters |
|------|-------------|------------|
| `list_payment_gateways` | List all payment gateways | None |
| `get_payment_gateway` | Get specific gateway | `id` (required) |
| `update_payment_gateway` | Update gateway settings | `id` (required), settings |

### 💰 Refunds

| Tool | Description | Parameters |
|------|-------------|------------|
| `list_refunds` | List refunds for an order | `order_id` (required), `page`, `per_page` |
| `get_refund` | Get specific refund | `order_id` (required), `id` (required) |
| `create_refund` | Create new refund | `order_id` (required), refund object |
| `delete_refund` | Delete refund | `order_id` (required), `id` (required) |

### 🚚 Shipping

| Tool | Description | Parameters |
|------|-------------|------------|
| `list_shipping_zones` | List all shipping zones | None |
| `get_shipping_zone` | Get specific zone | `id` (required) |
| `create_shipping_zone` | Create new zone | Zone object |
| `update_shipping_zone` | Update existing zone | `id` (required), zone data |
| `delete_shipping_zone` | Delete zone | `id` (required) |

### 💸 Tax Rates

| Tool | Description | Parameters |
|------|-------------|------------|
| `list_tax_rates` | List all tax rates | `page`, `per_page`, `class` |
| `get_tax_rate` | Get specific tax rate | `id` (required) |
| `create_tax_rate` | Create new tax rate | Tax rate object |
| `update_tax_rate` | Update existing rate | `id` (required), rate data |
| `delete_tax_rate` | Delete tax rate | `id` (required) |

## 🔧 Usage Examples

### Natural Language Examples

```
"List all products in my store"
"Show me orders from the last week"
"Get customer details for customer ID 123"
"Create a new 10% discount coupon"
"Update product 456 with new price"
"What are my current tax rates?"
```

### Direct Tool Calls

```javascript
// List products
{
  "tool": "list_products",
  "arguments": {
    "per_page": 10,
    "search": "shirt"
  }
}

// Get specific order
{
  "tool": "get_order",
  "arguments": {
    "id": 123
  }
}

// Create coupon
{
  "tool": "create_coupon",
  "arguments": {
    "code": "SAVE10",
    "discount_type": "percent",
    "amount": "10"
  }
}
```

## 📝 Response Format

All tools return standardized responses:

```javascript
{
  "success": true,
  "data": {
    // WooCommerce API response data
  },
  "message": "Operation completed successfully"
}
```

Error responses:

```javascript
{
  "success": false,
  "error": "Error message",
  "details": {
    // Additional error details
  }
}
```

## 🔒 Authentication

The server uses HTTP Basic Authentication with your WooCommerce API credentials:

- **Username**: Consumer Key
- **Password**: Consumer Secret

Ensure your API keys have appropriate permissions for the operations you want to perform.

## 📊 Rate Limiting

- Default timeout: 30 seconds per request
- Concurrent requests: 10 maximum
- Respects WooCommerce server rate limits

## 🌐 API Endpoints

All tools interact with the WooCommerce REST API v3:

```
https://your-store.com/wp-json/wc/v3/
```

### Supported Endpoints

- `/products` - Product management
- `/orders` - Order management
- `/customers` - Customer management
- `/coupons` - Coupon management
- `/payment_gateways` - Payment settings
- `/shipping/zones` - Shipping configuration
- `/taxes` - Tax rate management
- `/orders/{id}/refunds` - Refund processing

---

**Made with 🧡 in Cape Town 🇿🇦**
**Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**
