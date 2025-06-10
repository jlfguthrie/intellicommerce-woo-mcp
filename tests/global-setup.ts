// ✨IntelliCommerce✨ Woo MCP - Jest Global Setup
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

export default async function globalSetup() {
  // Set test environment variables
  process.env.NODE_ENV = 'test';
  process.env.LOG_LEVEL = 'error';

  // Mock WooCommerce API for testing
  process.env.WOOCOMMERCE_URL = 'https://test-store.example.com';
  process.env.WOOCOMMERCE_CONSUMER_KEY = 'test_consumer_key';
  process.env.WOOCOMMERCE_CONSUMER_SECRET = 'test_consumer_secret';

  console.log('🚀 ✨IntelliCommerce✨ Woo MCP Test Suite Starting...');
  console.log('📍 Made with 🧡 in Cape Town 🇿🇦');
}
