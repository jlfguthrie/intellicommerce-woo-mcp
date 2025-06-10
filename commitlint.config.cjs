// ✨IntelliCommerce✨ Woo MCP - Commitlint Configuration
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

module.exports = {
  extends: ['@commitlint/config-conventional'],
  parserPreset: {
    parserOpts: {
      // Custom parser to handle emoji prefixes
      headerPattern:
        /^(?:(?<emoji>[\u{1F600}-\u{1F64F}]|[\u{1F300}-\u{1F5FF}]|[\u{1F680}-\u{1F6FF}]|[\u{1F1E0}-\u{1F1FF}]|[\u{2600}-\u{26FF}]|[\u{2700}-\u{27BF}])\s)?(?<type>\w*)(?:\((?<scope>.*)\))?:\s(?<subject>.*)$/u,
      headerCorrespondence: ['emoji', 'type', 'scope', 'subject'],
    },
  },
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
        'feat', // ✨ New features
        'fix', // 🐛 Bug fixes
        'docs', // 📚 Documentation
        'style', // 🎨 Code style
        'refactor', // ♻️ Code refactoring
        'perf', // ⚡ Performance
        'test', // ✅ Testing
        'chore', // 🔧 Maintenance
        'ci', // 👷 CI/CD
        'build', // 📦 Build system
        'revert', // ⏪ Revert changes
      ],
    ],
  },
};
