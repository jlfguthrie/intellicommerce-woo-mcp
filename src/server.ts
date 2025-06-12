#!/usr/bin/env node
// ✨IntelliCommerce✨ Woo MCP Server - Main Server Implementation
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

import * as dotenv from 'dotenv';
dotenv.config(); // Load environment variables from .env first

import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import { allTools, toolHandlers } from './tools/index.js';

// Create IntelliCommerce✨ Woo MCP server instance
const server = new McpServer(
  {
    name: 'intellicommerce-woo-mcp',
    version: '1.0.0',
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

// Register each tool from our tools list with its corresponding handler
for (const tool of allTools) {
  const handler = toolHandlers[tool.name as keyof typeof toolHandlers];
  if (!handler) continue;

  const wrappedHandler = async (args: any) => {
    // The handler functions are already typed with their specific parameter types
    const result = await handler(args);
    return {
      content: result.toolResult.content.map(
        (item: { type: string; text: string }) => ({
          ...item,
          type: 'text' as const,
        })
      ),
      isError: result.toolResult.isError,
    };
  };

  // Register tool with proper description and input schema
  server.tool(
    tool.name,
    tool.description || 'No description available',
    tool.inputSchema,
    wrappedHandler
  );
}

async function main() {
  // console.log('Starting WooCommerce MCP server...');

  if (
    !process.env.WOOCOMMERCE_API_URL ||
    !process.env.WOOCOMMERCE_CONSUMER_KEY ||
    !process.env.WOOCOMMERCE_CONSUMER_SECRET
  ) {
    // console.error('Missing required environment variables. Please check your .env file.');
    process.exit(1);
  }

  if (
    process.env.WOOCOMMERCE_API_URL?.startsWith('http:') &&
    process.env.WOOCOMMERCE_INSECURE_HTTP !== 'true'
  ) {
    // console.error('Insecure HTTP URL detected. Set WOOCOMMERCE_INSECURE_HTTP=true to allow HTTP connections.');
    process.exit(1);
  }

  try {
    console.log('🚀 Initializing ✨IntelliCommerce✨ Woo MCP Server...');
    const { initWooCommerce } = await import('./woocommerce.js');
    await initWooCommerce();
    console.log('✅ WooCommerce client initialized successfully.');

    console.log('🔧 Setting up server transport...');
    const transport = new StdioServerTransport();
    await server.connect(transport);
    console.log('✨ IntelliCommerce✨ Woo MCP Server running on stdio');
    console.log('Made with 🧡 in Cape Town 🇿🇦');
  } catch (error) {
    console.error(
      '❌ Failed to initialize ✨IntelliCommerce✨ Woo MCP Server:',
      error
    );
    process.exit(1);
  }
}

// Handle process signals and errors gracefully
process.on('SIGTERM', () => {
  console.log(
    '🛑 Received SIGTERM signal, shutting down ✨IntelliCommerce✨ Woo MCP Server...'
  );
  process.exit(0);
});
process.on('SIGINT', () => {
  console.log(
    '🛑 Received SIGINT signal, shutting down ✨IntelliCommerce✨ Woo MCP Server...'
  );
  process.exit(0);
});
process.on('uncaughtException', error => {
  console.error(
    '❌ Uncaught exception in ✨IntelliCommerce✨ Woo MCP Server:',
    error
  );
  process.exit(1);
});
process.on('unhandledRejection', error => {
  console.error(
    '❌ Unhandled rejection in ✨IntelliCommerce✨ Woo MCP Server:',
    error
  );
  process.exit(1);
});

main().catch(() => process.exit(1));
