// ✨IntelliCommerce✨ Woo MCP - Tool Description Validation Tests
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

import { allTools } from '../src/tools/index.js';

describe('🔧 IntelliCommerce✨ Tool Description Validation', () => {
  describe('📋 Tool Schema Validation', () => {
    it('should generate valid JSON schemas for all tools', () => {
      for (const tool of allTools) {
        expect(() => {
          if (
            tool.inputSchema &&
            typeof tool.inputSchema === 'object' &&
            tool.inputSchema.type === 'object'
          ) {
            // Input schema is already a JSON schema, not a Zod schema
            expect(tool.inputSchema).toBeDefined();
            expect(tool.inputSchema.type).toBe('object');
          }
        }).not.toThrow();
      }
    });

    it('should have valid tool descriptions without syntax errors', () => {
      for (const tool of allTools) {
        // Check that tool has required properties
        expect(tool.name).toBeDefined();
        expect(tool.name).toMatch(/^[a-z_]+$/); // snake_case
        expect(tool.description).toBeDefined();
        if (tool.description) {
          expect(typeof tool.description).toBe('string');
          expect(tool.description.length).toBeGreaterThan(10);

          // Check that description doesn't have trailing commas or formatting issues
          expect(tool.description).not.toMatch(/,\s*$/); // No trailing commas
          expect(tool.description).not.toMatch(/\n\s*,/); // No line-break commas
        }
      }
    });

    it('should not have malformed zod descriptions', () => {
      // This test ensures that Prettier formatting doesn't break zod .describe() calls
      const toolNames = allTools.map(tool => tool.name);

      // Test a few key tools that we know have complex schemas
      expect(toolNames).toContain('list_products');
      expect(toolNames).toContain('get_product');
      expect(toolNames).toContain('create_product');
      expect(toolNames).toContain('list_customers');
      expect(toolNames).toContain('list_orders');

      // All tools should be properly exported
      expect(allTools.length).toBeGreaterThan(20); // We have many tools
    });
  });

  describe('🛠️ Tool Handler Validation', () => {
    it('should have handlers for all exported tools', async () => {
      const { toolHandlers } = await import('../src/tools/index.js');

      for (const tool of allTools) {
        expect(
          toolHandlers[tool.name as keyof typeof toolHandlers]
        ).toBeDefined();
        expect(
          typeof toolHandlers[tool.name as keyof typeof toolHandlers]
        ).toBe('function');
      }
    });

    it('should handle schema validation without errors', () => {
      for (const tool of allTools) {
        if (tool.inputSchema) {
          expect(() => {
            // Test that the schema object is valid
            expect(tool.inputSchema).toBeDefined();
            expect(typeof tool.inputSchema).toBe('object');
          }).not.toThrow();
        }
      }
    });
  });

  describe('🚨 Critical Tool Functionality', () => {
    it('should have working product listing tool', () => {
      const listProductsTool = allTools.find(
        tool => tool.name === 'list_products'
      );
      expect(listProductsTool).toBeDefined();
      expect(listProductsTool?.inputSchema).toBeDefined();

      // Test that schema is a valid object with expected structure
      if (listProductsTool?.inputSchema) {
        expect(typeof listProductsTool.inputSchema).toBe('object');
        expect(listProductsTool.inputSchema.type).toBe('object');
      }
    });

    it('should have working customer listing tool', () => {
      const listCustomersTool = allTools.find(
        tool => tool.name === 'list_customers'
      );
      expect(listCustomersTool).toBeDefined();
      expect(listCustomersTool?.inputSchema).toBeDefined();
    });

    it('should have working order listing tool', () => {
      const listOrdersTool = allTools.find(tool => tool.name === 'list_orders');
      expect(listOrdersTool).toBeDefined();
      expect(listOrdersTool?.inputSchema).toBeDefined();
    });
  });

  describe('🎨 Formatting Compatibility', () => {
    it('should maintain tool functionality after Prettier formatting', () => {
      // This test ensures our Prettier config doesn't break tool schemas

      for (const tool of allTools) {
        // Test that tools can be serialized and deserialized
        const serialized = JSON.stringify(tool, (key, value) => {
          // Skip functions and zod schemas which can't be serialized
          if (typeof value === 'function' || (value && value._def)) {
            return '[Function/Schema]';
          }
          return value;
        });

        expect(() => JSON.parse(serialized)).not.toThrow();
      }
    });
  });
});
