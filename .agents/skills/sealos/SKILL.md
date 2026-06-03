```markdown
# sealos Development Patterns

> Auto-generated skill from repository analysis

## Overview
This skill provides guidance on contributing to the `sealos` TypeScript codebase. It covers coding conventions, commit patterns, file organization, and testing practices observed in the repository. Use this as a reference for maintaining consistency and quality in your contributions.

## Coding Conventions

### File Naming
- Use **camelCase** for file names.
  - Example: `userService.ts`, `apiClient.ts`

### Import Style
- Use **relative imports** for internal modules.
  ```typescript
  import { fetchData } from './apiClient';
  ```

### Export Style
- Use **named exports**.
  ```typescript
  // Good
  export function fetchData() { ... }

  // Good
  export const API_URL = '...';

  // Avoid default exports
  ```

### Commit Messages
- Follow **conventional commit** style.
- Common prefixes: `fix`, `chore`
- Keep messages concise (~49 characters).
  - Example: `fix: correct user role assignment logic`
  - Example: `chore: update dependencies`

## Workflows

### Fixing a Bug
**Trigger:** When you identify and resolve a bug in the codebase  
**Command:** `/fix-bug`

1. Create a new branch for your fix.
2. Make code changes following coding conventions.
3. Write or update tests as needed.
4. Commit with a message starting with `fix:`.
   ```shell
   git commit -m "fix: resolve API timeout issue"
   ```
5. Push your branch and open a pull request.

### Chore Maintenance
**Trigger:** When performing maintenance tasks (e.g., dependency updates, refactoring)  
**Command:** `/chore-maintenance`

1. Create a new branch for the chore.
2. Make the necessary changes.
3. Commit with a message starting with `chore:`.
   ```shell
   git commit -m "chore: update TypeScript version"
   ```
4. Push your branch and open a pull request.

## Testing Patterns

- Test files follow the pattern: `*.test.*` (e.g., `userService.test.ts`)
- The specific testing framework is not detected; check existing test files for examples.
- Place test files alongside the modules they test or in a dedicated `tests` directory.
- Example test file name: `apiClient.test.ts`

## Commands
| Command           | Purpose                                      |
|-------------------|----------------------------------------------|
| /fix-bug          | Start the bug fixing workflow                |
| /chore-maintenance| Start a maintenance or refactoring workflow  |
```
