// ✨IntelliCommerce✨ Woo MCP - Standard Version Configuration
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

module.exports = {
  // Changelog generation
  header: '# 📈 IntelliCommerce✨ Woo MCP - Changelog\n\n**Made with 🧡 in Cape Town 🇿🇦**\n**Powered by Xstra AI✨ | Enabled by IntelliCommerce✨**\n\n',

  // Custom types for our emoji-based commits
  types: [
    { type: 'feat', section: '✨ Features' },
    { type: 'fix', section: '🐛 Bug Fixes' },
    { type: 'docs', section: '📚 Documentation' },
    { type: 'style', section: '🎨 Styling' },
    { type: 'refactor', section: '♻️ Code Refactoring' },
    { type: 'perf', section: '⚡ Performance' },
    { type: 'test', section: '✅ Tests' },
    { type: 'chore', section: '🔧 Maintenance' },
    { type: 'ci', section: '👷 CI/CD' },
    { type: 'build', section: '📦 Build System' },
    { type: 'revert', section: '⏪ Reverts' }
  ],

  // Skip questions during release
  skip: {
    bump: false,
    changelog: false,
    commit: false,
    tag: false
  },

  // Custom changelog sections
  sections: [
    { title: '✨ New Features', labels: ['feature', 'feat'] },
    { title: '🐛 Bug Fixes', labels: ['fix', 'bugfix'] },
    { title: '📦 Dependencies', labels: ['dependencies', 'deps'] },
    { title: '🔒 Security', labels: ['security'] },
    { title: '📚 Documentation', labels: ['docs', 'documentation'] },
    { title: '🔧 Maintenance', labels: ['chore', 'maintenance'] },
    { title: '⚡ Performance', labels: ['performance', 'perf'] },
    { title: '👷 CI/CD', labels: ['ci', 'cd', 'pipeline'] }
  ],

  // Git settings
  gitTagFallback: false,
  preset: 'conventionalcommits',

  // Release files to update
  packageFiles: [
    {
      filename: 'package.json',
      type: 'json'
    }
  ],

  // Changelog location
  infile: 'CHANGELOG.md',

  // Commit message for release
  releaseCommitMessageFormat: '🔖 chore(release): {{currentTag}}\n\n✨ New release with enhanced features and improvements\n\nMade with 🧡 in Cape Town 🇿🇦',

  // Tag prefix
  tagPrefix: 'v',

  // Custom scripts to run
  scripts: {
    prerelease: 'npm run deps:audit && npm run validate',
    postrelease: 'echo "🎉 Release v$npm_package_version published! Made with 🧡 in Cape Town 🇿🇦"'
  }
};
