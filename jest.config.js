// ✨IntelliCommerce✨ Woo MCP - Jest Configuration
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

export default {
  preset: 'ts-jest',
  testEnvironment: 'node',
  extensionsToTreatAsEsm: ['.ts'],
  transform: {
    '^.+\\.ts$': [
      'ts-jest',
      {
        useESM: true,
      },
    ],
  },
  moduleNameMapper: {
    '^(\\.{1,2}/.*)\\.js$': '$1',
    '^@/(.*)$': '<rootDir>/src/$1',
  },
  testMatch: ['**/tests/**/*.test.ts', '**/src/**/__tests__/**/*.test.ts'],
  roots: ['<rootDir>/tests', '<rootDir>/src'],
  collectCoverageFrom: [
    'src/**/*.ts',
    '!src/**/*.d.ts',
    '!src/types/**',
    '!src/**/*.test.ts',
    '!build/**',
  ],
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
  setupFilesAfterEnv: ['<rootDir>/tests/setup.ts'],
  testTimeout: 15000,
  // MCP-specific test environment
  globalSetup: '<rootDir>/tests/global-setup.ts',
  globalTeardown: '<rootDir>/tests/global-teardown.ts',
  // Enhanced error reporting
  verbose: true,
  detectOpenHandles: true,
  forceExit: true,
};
