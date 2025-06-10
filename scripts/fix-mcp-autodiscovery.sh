#!/bin/bash

# ✨IntelliCommerce✨ Woo MCP - Fix VS Code MCP Auto-Discovery
# Made with 🧡 in Cape Town 🇿🇦
# Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

echo "🔧 Fixing VS Code MCP Auto-Discovery Settings..."
echo ""

VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"

# Backup current settings
if [ -f "$VSCODE_SETTINGS" ]; then
    cp "$VSCODE_SETTINGS" "$VSCODE_SETTINGS.backup.$(date +%Y%m%d_%H%M%S)"
    echo "✅ Backup created: $VSCODE_SETTINGS.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Create temporary Python script to safely update JSON
cat > /tmp/fix_mcp_settings.py << 'EOF'
import json
import sys
import os

settings_path = os.path.expanduser("~/Library/Application Support/Code/User/settings.json")

try:
    # Read current settings
    with open(settings_path, 'r') as f:
        settings = json.load(f)
except FileNotFoundError:
    settings = {}
except json.JSONDecodeError:
    print("❌ Error: Invalid JSON in settings file")
    sys.exit(1)

# Add MCP auto-discovery disable settings
mcp_settings = {
    "chat.mcp.enabled": True,
    "chat.mcp.discovery.enabled": False,
    "chat.mcp.tools.autoSelect": False,
    "chat.agent.tools.autoSelect": False,
    "github.copilot.chat.agent.tools.defaultSelection": "none"
}

# Update settings
settings.update(mcp_settings)

# Write back to file
with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)

print("✅ VS Code global settings updated successfully")
print("✅ MCP auto-discovery disabled")
print("✅ MCP tool auto-selection disabled")
EOF

# Run the Python script
python3 /tmp/fix_mcp_settings.py

# Clean up
rm /tmp/fix_mcp_settings.py

echo ""
echo "🚀 Settings Updated! Next steps:"
echo "1. Restart VS Code completely"
echo "2. Open Chat (Cmd+Ctrl+I)"
echo "3. Switch to Agent mode"
echo "4. Click Tools button to manually select only the tools you want"
echo "5. VS Code will remember your manual selections"
echo ""
echo "🔧 Your IntelliCommerce✨ Woo MCP server will appear in the list"
echo "   but won't be auto-selected until you choose it manually."
echo ""
echo "Made with 🧡 in Cape Town 🇿🇦"
