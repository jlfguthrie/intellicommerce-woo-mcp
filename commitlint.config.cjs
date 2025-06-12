// ✨IntelliCommerce✨ Woo MCP - Commitlint Configuration
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    // Relaxed rules for productive development
    'subject-case': [0], // Disable case restrictions - too pedantic
    'header-max-length': [1, 'always', 120], // Warning only, longer limit
    'body-leading-blank': [0], // Disable - not critical
    'footer-leading-blank': [0], // Disable - not critical
    'subject-empty': [2, 'never'], // Still require a subject
    'type-empty': [2, 'never'], // Still require a type
    'type-enum': [
      2,
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
        // Allow emoji prefixed versions (more flexible)
        '✨ feat',
        '🐛 fix',
        '📚 docs',
        '🎨 style',
        '♻️ refactor',
        '⚡ perf',
        '✅ test',
        '🔧 chore',
        '👷 ci',
        '📦 build',
        '⏪ revert'
      ]
    ]
  }
};
