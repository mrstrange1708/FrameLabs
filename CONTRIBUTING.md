# Contributing to FrameLabs

Thank you for your interest in contributing to FrameLabs. This document provides guidelines and instructions for contributing.

## Development Setup

### Prerequisites

- **Node.js** >= 22.x (managed via [nvm](https://github.com/nvm-sh/nvm))
- **pnpm** >= 9.x
- **Docker** & **Docker Compose** (for PostgreSQL and Redis)
- **Git**

### Getting Started

```bash
# Clone the repo
git clone https://github.com/mrstrange1708/FrameLabs.git
cd FrameLabs

# Switch to the correct Node.js version (reads .nvmrc)
nvm use

# Install dependencies
pnpm install

# Set up environment
cp .env.example .env

# Start infrastructure
docker compose up -d

# Start development
pnpm dev
```

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

2. **Make your changes** following the code standards below.

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

**Scope (optional):** `web`, `server`, `diagram-core`, `collaboration`, `shared`, `ci`

### Pull Request Guidelines

- Keep PRs focused — one feature or fix per PR
- Fill out the PR template completely
- Ensure all CI checks pass before requesting review
- Request review from at least one team member
- Address review comments promptly
- Squash-merge to keep `main` history clean

## Code Standards

### TypeScript

- Strict mode is enabled — no `any` types without explicit justification
- Use `type` imports for type-only imports: `import type { X } from 'y'`
- Define interfaces for all public API surfaces
- No unused variables or imports

### Formatting

- **Prettier** handles all formatting — do not manually format
- **2-space indentation**, single quotes, trailing commas, semicolons

### Testing

- Write unit tests for all business logic
- Write integration tests for API endpoints
- Test names should describe the expected behaviour, not the implementation

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

- [ ] TypeScript types are correct and strict
- [ ] No `any` types without justification
- [ ] Error handling is appropriate
- [ ] No security vulnerabilities (injection, XSS, etc.)
- [ ] Tests cover the changes
- [ ] No secrets or environment values committed
- [ ] Code follows existing patterns and conventions
- [ ] PR description explains the "why"
