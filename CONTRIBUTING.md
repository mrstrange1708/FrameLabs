# Contributing to FrameLabs

Thank you for your interest in contributing to FrameLabs. This document provides guidelines and instructions for contributing.

## Getting Started

```bash
# Clone the repo
git clone https://github.com/mrstrange1708/FrameLabs.git
cd FrameLabs
```

> Development setup instructions (dependencies, environment, infrastructure) will be added once the codebase is in place. For now, contributions are focused on documentation and project planning.

## Workflow

### Branch Naming

```
feat/<short-description>     # New features
fix/<short-description>      # Bug fixes
refactor/<short-description> # Code refactoring
docs/<short-description>     # Documentation changes
test/<short-description>     # Test additions or changes
chore/<short-description>    # Build, CI, dependency changes
```

### Making Changes

1. **Create a branch** from `main`:

   ```bash
   git checkout main
   git pull origin main
   git checkout -b feat/your-feature-name
   ```

2. **Make your changes** following the standards below.

3. **Commit** with a clear, descriptive message:

   ```bash
   git commit -m "feat: add table node component for database workspace"
   ```

4. **Push** and create a pull request:
   ```bash
   git push -u origin feat/your-feature-name
   ```

### Commit Message Format

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]
[optional footer]
```

**Types:** `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `perf`, `ci`

### Pull Request Guidelines

- Keep PRs focused — one feature or fix per PR
- Fill out the PR template completely
- Ensure all CI checks pass before requesting review
- Request review from at least one team member
- Address review comments promptly
- Squash-merge to keep `main` history clean

## Code Standards

These standards apply once the codebase is set up:

- **TypeScript** with strict mode — no `any` types without justification
- **Prettier** for formatting — 2-space indentation, single quotes, trailing commas, semicolons
- **ESLint** with zero warnings policy
- **Vitest** for unit and integration tests
- **Playwright** for end-to-end tests

## What NOT to Commit

The following must NEVER be committed:

- `.env`, `.env.local`, `.env.*.local` — environment variables
- `node_modules/` — dependencies
- `.next/`, `dist/`, `build/` — build artefacts
- `*.pem`, `*.key`, `*.cert` — certificates and keys
- Database files or dumps
- Any file containing secrets, tokens, passwords, or API keys

## Code Review Checklist

When reviewing pull requests, check for:

- [ ] No secrets or environment values committed
- [ ] Code follows existing patterns and conventions
- [ ] PR description explains the "why"
- [ ] Tests cover the changes (once testing is set up)
- [ ] No security vulnerabilities (injection, XSS, etc.)
