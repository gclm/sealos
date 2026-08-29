```markdown
# sealos Development Patterns

> Auto-generated skill from repository analysis

## Overview
This skill teaches the core development patterns and conventions used in the `sealos` TypeScript codebase. It covers file naming, import/export styles, commit message conventions, and testing patterns. While no specific workflows were detected, this guide suggests useful commands for common development tasks.

## Coding Conventions

### File Naming
- Use **camelCase** for filenames.
  - Example: `userProfile.ts`, `apiClient.ts`

### Import Style
- Use **alias imports** to reference modules.
  - Example:
    ```typescript
    import { fetchData as getData } from './apiClient';
    ```

### Export Style
- Use **named exports** for functions, classes, and constants.
  - Example:
    ```typescript
    // In userProfile.ts
    export function getUserProfile(id: string) { ... }
    export const DEFAULT_AVATAR = 'avatar.png';
    ```

### Commit Message Conventions
- Use **Conventional Commits** with the `feat` prefix for new features.
  - Example:
    ```
    feat: add user profile image upload
    ```
- Average commit message length: ~48 characters.

## Workflows

### Add a New Feature
**Trigger:** When implementing a new feature.
**Command:** `/add-feature`

1. Create a new file using camelCase naming.
2. Use alias imports for dependencies.
3. Export new functions or constants using named exports.
4. Write or update tests in a corresponding `*.test.*` file.
5. Commit changes using a conventional commit message with the `feat` prefix.
   - Example: `feat: implement user authentication flow`

### Run Tests
**Trigger:** When validating code changes.
**Command:** `/run-tests`

1. Locate or create test files matching the pattern `*.test.*`.
2. Run the test suite using your project's test runner.
3. Review test results and fix any failures.

## Testing Patterns

- Test files follow the pattern: `*.test.*` (e.g., `userProfile.test.ts`)
- The specific testing framework is not detected; use standard TypeScript testing tools (e.g., Jest, Mocha) as appropriate.
- Example test file:
  ```typescript
  // userProfile.test.ts
  import { getUserProfile } from './userProfile';

  test('should return user profile data', () => {
    const profile = getUserProfile('123');
    expect(profile).toHaveProperty('id', '123');
  });
  ```

## Commands
| Command        | Purpose                                 |
|----------------|-----------------------------------------|
| /add-feature   | Scaffold and commit a new feature       |
| /run-tests     | Run all test suites                     |
```