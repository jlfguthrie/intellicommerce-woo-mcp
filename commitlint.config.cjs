// ✨IntelliCommerce✨ Woo MCP - Commitlint Configuration
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

module.exports = {
  // Use a much more flexible configuration
  parserPreset: {
    parserOpts: {
      // Custom parser that handles emoji-prefixed commits
      headerPattern:
        /^(?:(?:✨|🛒|🧡|🇿🇦|🎯|🚀|🤖|📋|⭐|1️⃣|2️⃣|3️⃣|🔧|🔐|🖥️|💡|4️⃣|🌍|💻|💬|📦|👥|🎫|📚|📖|🛠️|💰|💸|🚚|💳|✅|🌟|🧪|🔗|🔒|🏃‍♂️|📊|📈|🔍|🔖|🔄|🌿|📤|🔀|🧹|🤝|📄|🙏|🏷️|🌐|📧|👨‍💻|⚙️|❌|™|🌀|🌤️|🐛|🎨|♻️|⚡|👷|⏪)\s+)?(\w+)(?:\(([^)]*)\))?\s*:\s*(.*)$/,
      headerCorrespondence: ['type', 'scope', 'subject']
    }
  },
  rules: {
    // Very minimal rules - focus on productivity
    'header-max-length': [1, 'always', 120], // Warning only
    'body-leading-blank': [0], // Disabled
    'footer-leading-blank': [0], // Disabled
    'subject-case': [0], // Disabled
    'subject-empty': [1, 'never'], // Warning only
    'type-empty': [1, 'never'], // Warning only
    'type-case': [0], // Disabled
    'type-enum': [
      1, // Warning only - don't block commits
      'always',
      [
        'feat',
        'fix',
        'docs',
        'style',
        'refactor',
        'perf',
        'test',
        'chore',
        'ci',
        'build',
        'revert',
        'release',
        'hotfix',
        'wip',
        'bump'
      ]
    ]
  }
};
