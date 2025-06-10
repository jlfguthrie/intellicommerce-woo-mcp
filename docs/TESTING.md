# 🧪 Testing Guide - IntelliCommerce✨ Woo MCP

Made with 🧡 in Cape Town 🇿🇦 Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

## 📋 Overview

The **IntelliCommerce✨ Woo MCP** testing framework provides comprehensive validation across 5 test
suites with 35+ test cases, ensuring reliability, security, and MCP protocol compliance.

## 🧪 Test Suites

### 1. 🔧 Unit Tests (`tests/server.test.ts`)

**Purpose**: Validate core server functionality and business logic.

```bash
npm run test:unit
```

**Test Cases**:

- Server initialization and configuration
- Tool registration and validation
- Environment variable handling
- Core functionality verification

### 2. 🔗 Integration Tests (`tests/integration.test.ts`)

**Purpose**: Test system integration and component interaction.

```bash
npm run test:integration
```

**Test Cases**:

- MCP server startup without errors
- Graceful server shutdown handling
- Environment configuration validation
- File system integration (built files, package.json)
- Dependency availability (MCP SDK, axios, zod, dotenv)

### 3. 📋 MCP Protocol Tests (`tests/mcp-protocol.test.ts`)

**Purpose**: Ensure MCP JSON-RPC 2.0 protocol compliance.

```bash
npm run test:mcp
```

**Test Cases**:

- JSON-RPC 2.0 message format validation
- MCP tool call format compliance
- Tool schema validation
- Performance requirements (response time < 5000ms)
- Security compliance (no sensitive data exposure)
- Input parameter validation

### 4. 🚀 End-to-End Tests (`tests/e2e.test.ts`)

**Purpose**: Validate complete workflow scenarios.

```bash
npm run test:e2e
```

**Test Cases**:

- **Product Management**: Complete product lifecycle workflow
- **Order Management**: Order processing flow validation
- **Customer Management**: Customer onboarding workflow
- **Coupon Management**: Promotional campaign flow
- **Cross-Entity Workflows**: Complex multi-entity scenarios
- **Performance Testing**: Concurrent request handling
- **Load Testing**: Large dataset query handling

### 5. 🔒 Security Tests (`tests/security.test.ts`)

**Purpose**: Comprehensive security validation and threat protection.

```bash
npm run test:security
```

**Test Cases**:

#### 🔐 Credential Handling

- Required credentials validation
- Credential exposure prevention in logs
- HTTPS enforcement for WooCommerce connections

#### 🛡️ Input Validation

- Product data input validation
- Customer data input validation
- Malicious input pattern rejection (XSS, SQL injection, path traversal, etc.)

#### 🔒 Data Sanitization

- Customer data sanitization before logging
- API response data minimization
- Sensitive data removal from logs

#### 🚨 Error Handling Security

- Internal error message sanitization
- Security event logging
- Safe error message generation

#### 🔐 Authentication & Authorization

- API key format validation
- Permission level validation
- Access control verification

## 🏃‍♂️ Running Tests

### Basic Test Commands

```bash
# Run all test suites (recommended)
npm test

# Run specific test suite
npm run test:unit
npm run test:integration
npm run test:mcp
npm run test:e2e
npm run test:security
```

### Advanced Test Commands

```bash
# Run with coverage report
npm run test:coverage

# Watch mode for development
npm run test:watch

# CI mode (no watch, with coverage)
npm run test:ci

# Run all tests in sequence
npm run test:all
```

### VS Code Integration

Run tests directly from VS Code:

1. Open Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`)
2. Type "Tasks: Run Task"
3. Select your desired test task

## 📊 Test Configuration

### Jest Configuration (`jest.config.js`)

```javascript
export default {
  preset: 'ts-jest/presets/default-esm',
  extensionsToTreatAsEsm: ['.ts'],
  testEnvironment: 'node',
  roots: ['<rootDir>/tests'],
  testMatch: ['**/*.test.ts'],
  moduleNameMapping: {
    '^(\\.{1,2}/.*)\\.js$': '$1',
  },
  globalSetup: '<rootDir>/tests/global-setup.ts',
  globalTeardown: '<rootDir>/tests/global-teardown.ts',
  setupFilesAfterEnv: ['<rootDir>/tests/setup.ts'],
  collectCoverageFrom: ['src/**/*.ts', '!src/**/*.d.ts', '!src/cli/**'],
  coverageReporters: ['text', 'lcov', 'html'],
  verbose: true,
  testTimeout: 30000,
};
```

### Environment Setup

Tests require these environment variables (use `.env.test` or `.env`):

```env
NODE_ENV=test
WOOCOMMERCE_URL=https://your-test-store.com
WOOCOMMERCE_CONSUMER_KEY=ck_test_key
WOOCOMMERCE_CONSUMER_SECRET=cs_test_secret
```

## 🔍 Test Development

### Writing New Tests

1. **Create test file**: `tests/your-feature.test.ts`
2. **Follow naming convention**: `describe('IntelliCommerce✨ Feature Tests', () => {})`
3. **Use proper test structure**:

```typescript
// ✨IntelliCommerce✨ Woo MCP - Feature Tests
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

import { describe, expect, test } from '@jest/globals';

describe('IntelliCommerce✨ Feature Tests', () => {
  describe('🎯 Feature Category', () => {
    test('should validate specific behavior', () => {
      // Test implementation
      expect(result).toBe(expected);
    });
  });
});
```

### Test Categories

Use these emoji categories for consistency:

- 🔧 **Core/Unit**: Basic functionality
- 🔗 **Integration**: Component interaction
- 📋 **Protocol**: MCP compliance
- 🚀 **E2E**: End-to-end workflows
- 🔒 **Security**: Security validation
- ⚡ **Performance**: Speed and load
- 🛡️ **Validation**: Input/output validation
- 🎯 **Business Logic**: Domain-specific logic

## 🚨 Troubleshooting

### Common Issues

#### Test Environment Setup

```bash
# Missing environment variables
cp .env.example .env.test
# Edit .env.test with test credentials
```

#### Dependencies

```bash
# Reinstall dependencies
npm ci
```

#### Build Issues

```bash
# Clean build and rebuild
npm run clean && npm run build
```

### Test-Specific Issues

#### Integration Tests Failing

- Verify `.env` file exists with valid credentials
- Check WooCommerce store accessibility
- Ensure build files exist (`npm run build`)

#### Security Tests Failing

- Verify malicious input patterns are correctly detected
- Check credential validation logic
- Ensure error handling doesn't expose sensitive data

#### MCP Protocol Tests Failing

- Verify MCP SDK version compatibility
- Check tool schema definitions
- Validate JSON-RPC 2.0 message format

## 📈 Test Metrics

### Coverage Goals

- **Overall Coverage**: > 80%
- **Function Coverage**: > 85%
- **Branch Coverage**: > 75%
- **Line Coverage**: > 80%

### Performance Benchmarks

- **Test Suite Execution**: < 30 seconds
- **Individual Test**: < 5 seconds
- **MCP Tool Response**: < 5000ms
- **Server Startup**: < 10 seconds

## 🔄 Continuous Integration

Tests run automatically on:

- **Push to main branch**
- **Pull request creation**
- **Release creation**
- **Daily dependency checks**

### GitHub Actions Integration

Tests are integrated with GitHub Actions for:

- Automated testing on multiple Node.js versions
- Security vulnerability scanning
- Dependency audit checks
- Coverage reporting
- Release validation

## 📚 Additional Resources

- [Jest Documentation](https://jestjs.io/docs/)
- [MCP Protocol Specification](https://modelcontextprotocol.io/)
- [WooCommerce REST API](https://woocommerce.github.io/woocommerce-rest-api-docs/)
- [TypeScript Testing Best Practices](https://typescript-eslint.io/docs/)

---

**Made with 🧡 in Cape Town 🇿🇦** **Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**
