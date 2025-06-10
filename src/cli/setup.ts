// ✨IntelliCommerce✨ Woo MCP - CLI Setup Utility
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

import fs from 'fs/promises';
import path from 'path';
import { createInterface } from 'readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout
});

function question(prompt: string): Promise<string> {
  return new Promise((resolve) => {
    rl.question(prompt, resolve);
  });
}

export async function setupMCPConfig() {
  console.log('\n🚀 ✨IntelliCommerce✨ Woo MCP Setup');
  console.log('Made with 🧡 in Cape Town 🇿🇦\n');

  try {
    // Check if we're in a project directory
    const cwd = process.cwd();
    console.log(`📁 Current directory: ${cwd}`);

    // Ask user what type of setup they want
    console.log('\n🔧 Setup Options:');
    console.log('1. VS Code project configuration (.vscode/mcp.json)');
    console.log('2. Claude Desktop configuration');
    console.log('3. Both');

    const choice = await question('\nChoose setup type (1/2/3): ');

    if (choice === '1' || choice === '3') {
      await setupVSCodeConfig(cwd);
    }

    if (choice === '2' || choice === '3') {
      await setupClaudeConfig();
    }

    console.log('\n✅ Setup complete!');
    console.log('\n📋 Next steps:');
    console.log('1. Set your environment variables:');
    console.log('   export WOOCOMMERCE_API_URL="https://your-store.com"');
    console.log('   export WOOCOMMERCE_CONSUMER_KEY="ck_your_key"');
    console.log('   export WOOCOMMERCE_CONSUMER_SECRET="cs_your_secret"');
    console.log('\n2. Restart VS Code or Claude Desktop');
    console.log('\n🔗 Documentation: https://github.com/jlfguthrie/intellicommerce-woo-mcp');

  } catch (error) {
    console.error('❌ Setup failed:', error);
  } finally {
    rl.close();
  }
}

async function setupVSCodeConfig(projectPath: string) {
  const vscodeDir = path.join(projectPath, '.vscode');
  const mcpConfigPath = path.join(vscodeDir, 'mcp.json');

  // Create .vscode directory if it doesn't exist
  try {
    await fs.mkdir(vscodeDir, { recursive: true });
  } catch {
    // Directory might already exist
  }

  const mcpConfig = {
    inputs: [
      {
        type: 'promptString',
        id: 'woocommerce-api-url',
        description: 'WooCommerce Store URL (e.g., https://your-store.com)'
      },
      {
        type: 'promptString',
        id: 'woocommerce-consumer-key',
        description: 'WooCommerce Consumer Key'
      },
      {
        type: 'promptString',
        id: 'woocommerce-consumer-secret',
        description: 'WooCommerce Consumer Secret',
        password: true
      }
    ],
    servers: {
      intellicommerceWoo: {
        type: 'stdio',
        command: 'intellicommerce-woo-mcp',
        args: [],
        env: {
          WOOCOMMERCE_API_URL: '${input:woocommerce-api-url}',
          WOOCOMMERCE_CONSUMER_KEY: '${input:woocommerce-consumer-key}',
          WOOCOMMERCE_CONSUMER_SECRET: '${input:woocommerce-consumer-secret}'
        }
      }
    }
  };

  await fs.writeFile(mcpConfigPath, JSON.stringify(mcpConfig, null, 2));
  console.log(`✅ VS Code MCP config created: ${mcpConfigPath}`);
}

async function setupClaudeConfig() {
  const homeDir = process.env.HOME || process.env.USERPROFILE;
  if (!homeDir) {
    console.error('❌ Could not determine home directory');
    return;
  }

  const claudeConfigPath = path.join(homeDir, 'claude_desktop_config.json');

  console.log('\n📝 Claude Desktop Configuration:');
  console.log(`Add this to your ${claudeConfigPath}:`);
  console.log('\n```json');
  console.log(JSON.stringify({
    mcpServers: {
      'intellicommerce-woo': {
        command: 'intellicommerce-woo-mcp',
        args: [],
        env: {
          WOOCOMMERCE_API_URL: 'https://your-store.com',
          WOOCOMMERCE_CONSUMER_KEY: 'ck_your_key',
          WOOCOMMERCE_CONSUMER_SECRET: 'cs_your_secret'
        }
      }
    }
  }, null, 2));
  console.log('```\n');

  const shouldCreate = await question('Create/update Claude config automatically? (y/N): ');

  if (shouldCreate.toLowerCase() === 'y') {
    try {
      let existingConfig = {};
      try {
        const existingContent = await fs.readFile(claudeConfigPath, 'utf8');
        existingConfig = JSON.parse(existingContent);
      } catch {
        // File doesn't exist or invalid JSON, start fresh
      }

      const updatedConfig = {
        ...existingConfig,
        mcpServers: {
          ...(existingConfig as any).mcpServers,
          'intellicommerce-woo': {
            command: 'intellicommerce-woo-mcp',
            args: [],
            env: {
              WOOCOMMERCE_API_URL: 'https://your-store.com',
              WOOCOMMERCE_CONSUMER_KEY: 'ck_your_key',
              WOOCOMMERCE_CONSUMER_SECRET: 'cs_your_secret'
            }
          }
        }
      };

      await fs.writeFile(claudeConfigPath, JSON.stringify(updatedConfig, null, 2));
      console.log(`✅ Claude Desktop config updated: ${claudeConfigPath}`);
      console.log('⚠️  Remember to update the placeholder credentials!');
    } catch (error) {
      console.error('❌ Failed to update Claude config:', error);
    }
  }
}
