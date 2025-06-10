// ✨IntelliCommerce✨ Woo MCP - Test Setup
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

import { jest } from '@jest/globals';

// Mock environment variables for testing
process.env.NODE_ENV = 'test';
process.env.WOOCOMMERCE_API_URL = 'https://test-store.example.com';
process.env.WOOCOMMERCE_CONSUMER_KEY = 'test_key';
process.env.WOOCOMMERCE_CONSUMER_SECRET = 'test_secret';

// Set test timeout
jest.setTimeout(10000);

// Global test setup
beforeEach(() => {
  // Clear all mocks before each test
  jest.clearAllMocks();
});

afterEach(() => {
  // Cleanup after each test
  jest.restoreAllMocks();
});
