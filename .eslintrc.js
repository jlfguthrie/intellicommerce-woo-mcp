# ✨IntelliCommerce✨ Woo MCP - ESLint Configuration
# Made with 🧡 in Cape Town 🇿🇦
# Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

module.exports = {
  root: true,
  env: {
    node: true,
    es2022: true,
  },
  extends: [
    'eslint:recommended',
    '@typescript-eslint/recommended',
    'prettier',
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 2022,
    sourceType: 'module',
    project: './tsconfig.json',
  },
  plugins: ['@typescript-eslint'],
  rules: {
    // IntelliCommerce✨ Code Quality Rules
    '@typescript-eslint/explicit-function-return-type': 'warn',
    '@typescript-eslint/no-unused-vars': 'error',
    '@typescript-eslint/no-explicit-any': 'warn',
    '@typescript-eslint/prefer-const': 'error',
    '@typescript-eslint/no-var-requires': 'error',

    // Import organization
    'sort-imports': ['error', { ignoreDeclarationSort: true }],

    // Code style
    'prefer-const': 'error',
    'no-var': 'error',
    'no-console': 'off', // Allow console for MCP server logging
    'eqeqeq': 'error',
    'curly': 'error',

    // Naming conventions for IntelliCommerce✨
    '@typescript-eslint/naming-convention': [
      'error',
      {
        selector: 'variableLike',
        format: ['camelCase'],
      },
      {
        selector: 'typeLike',
        format: ['PascalCase'],
      },
      {
        selector: 'property',
        format: ['camelCase', 'snake_case'], // Allow snake_case for MCP tools
      },
    ],
  },
  ignorePatterns: [
    'build/',
    'node_modules/',
    '*.js',
    '*.d.ts',
  ],
};
