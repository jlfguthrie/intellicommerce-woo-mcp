// ✨IntelliCommerce✨ Woo MCP - Integration Tests
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

import { afterAll, beforeAll, describe, expect, test } from '@jest/globals';
import { ChildProcess, spawn } from 'child_process';
import path from 'path';

describe('IntelliCommerce✨ Woo MCP Integration Tests', () => {
  let mcpServer: ChildProcess;

  beforeAll(async () => {
    // Set up test environment variables
    process.env.WOOCOMMERCE_URL =
      process.env.TEST_WOOCOMMERCE_URL || 'https://example.com';
    process.env.WOOCOMMERCE_CONSUMER_KEY =
      process.env.TEST_WOOCOMMERCE_CONSUMER_KEY || 'test_key';
    process.env.WOOCOMMERCE_CONSUMER_SECRET =
      process.env.TEST_WOOCOMMERCE_CONSUMER_SECRET || 'test_secret';
  });

  afterAll(async () => {
    if (mcpServer) {
      mcpServer.kill();
    }
  });

  describe('MCP Server Integration', () => {
    test('should start MCP server without errors', done => {
      const serverPath = path.join(process.cwd(), 'build', 'server.js');
      mcpServer = spawn('node', [serverPath], {
        stdio: ['pipe', 'pipe', 'pipe'],
        env: { ...process.env, NODE_ENV: 'test' },
      });

      mcpServer.on('error', error => {
        expect(error).toBeUndefined();
        done();
      });

      // Give the server time to start
      setTimeout(() => {
        expect(mcpServer.pid).toBeDefined();
        done();
      }, 2000);
    }, 10000);

    test('should handle server shutdown gracefully', async () => {
      if (mcpServer && mcpServer.pid) {
        const killPromise = new Promise(resolve => {
          mcpServer.on('exit', resolve);
        });
        mcpServer.kill('SIGTERM');
        await killPromise;
        expect(mcpServer.killed).toBe(true);
      }
    });
  });

  describe('Environment Configuration', () => {
    test('should have required environment variables for testing', () => {
      expect(process.env.WOOCOMMERCE_URL).toBeDefined();
      expect(process.env.WOOCOMMERCE_CONSUMER_KEY).toBeDefined();
      expect(process.env.WOOCOMMERCE_CONSUMER_SECRET).toBeDefined();
    });

    test('should be in test environment', () => {
      expect(process.env.NODE_ENV).toBe('test');
    });
  });

  describe('File System Integration', () => {
    test('should have built server file', () => {
      const fs = require('fs');
      const serverPath = path.join(process.cwd(), 'build', 'server.js');
      expect(fs.existsSync(serverPath)).toBe(true);
    });

    test('should have package.json configured correctly', () => {
      const fs = require('fs');
      const packagePath = path.join(process.cwd(), 'package.json');
      const packageJson = JSON.parse(fs.readFileSync(packagePath, 'utf8'));

      expect(packageJson.name).toBe('intellicommerce-woo-mcp');
      expect(packageJson.main).toBe('./build/server.js');
      expect(packageJson.description).toContain('✨IntelliCommerce✨');
    });
  });

  describe('Dependency Integration', () => {
    test('should have MCP SDK available in package.json', () => {
      const fs = require('fs');
      const packagePath = path.join(process.cwd(), 'package.json');
      const packageJson = JSON.parse(fs.readFileSync(packagePath, 'utf8'));

      expect(
        packageJson.dependencies['@modelcontextprotocol/sdk']
      ).toBeDefined();
    });

    test('should have axios available', () => {
      expect(() => require('axios')).not.toThrow();
    });

    test('should have zod available', () => {
      expect(() => require('zod')).not.toThrow();
    });

    test('should have dotenv available', () => {
      expect(() => require('dotenv')).not.toThrow();
    });
  });
});
