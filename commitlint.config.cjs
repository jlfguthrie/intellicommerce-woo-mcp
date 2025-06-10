// ✨IntelliCommerce✨ Woo MCP - Commitlint Configuration
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    // Custom rules for IntelliCommerce✨ commit messages
    'subject-case': [2, 'always', 'sentence-case'],
    'header-max-length': [2, 'always', 100],
    'body-leading-blank': [1, 'always'],
    'footer-leading-blank': [1, 'always'],
    'type-enum': [
      2,
      'always',
      [
        'feat',     // ✨ New features
        'fix',      // 🐛 Bug fixes
        'docs',     // 📚 Documentation
        'style',    // 🎨 Code style
        'refactor', // ♻️ Code refactoring
        'perf',     // ⚡ Performance
        'test',     // ✅ Testing
        'chore',    // 🔧 Maintenance
        'ci',       // 👷 CI/CD
        'build',    // 📦 Build system
        'revert'    // ⏪ Revert changes
      ]
    ]
  }
};
