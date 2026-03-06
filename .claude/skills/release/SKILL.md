---
name: release
description: Manages release process - version bumping, changelog generation, tagging, and deployment preparation
---

# Release Skill

Manages the complete release process for the CentralStore project.

## Trigger
When user asks to create a release, bump version, prepare for deployment, or tag a version.

## Process

### 1. Pre-release Checks
```bash
# Verify clean working tree
git status

# Ensure on main branch and up to date
git checkout main
git pull origin main

# Run all tests
dotnet test

# Build in Release mode
dotnet build -c Release
```

### 2. Version Management
- Read current version from `.csproj` files (`<Version>` or `<PackageVersion>`)
- Determine version bump based on changes since last tag:
  - **Major** (X.0.0): Breaking API changes, major architecture shifts
  - **Minor** (0.X.0): New features, new modules, new endpoints
  - **Patch** (0.0.X): Bug fixes, performance improvements, doc updates
- Update version in ALL .csproj files consistently
- Update CLAUDE.md if version is referenced

### 3. Changelog Generation
- Collect all commits since last git tag: `git log $(git describe --tags --abbrev=0)..HEAD --oneline`
- Group by type based on commit message prefix:
  - `feat:` -> New Features
  - `fix:` -> Bug Fixes
  - `refactor:` -> Code Improvements
  - `docs:` -> Documentation
  - `test:` -> Testing
  - `chore:` -> Maintenance
- Write to CHANGELOG.md in format:
  ```markdown
  ## [1.2.0] - 2026-03-06
  ### New Features
  - Add product import from CSV (#45)
  ### Bug Fixes
  - Fix inventory count calculation (#42)
  ```

### 4. Create Release
```bash
# Commit version bump
git add -A
git commit -m "release: v1.2.0"

# Tag
git tag -a v1.2.0 -m "Release v1.2.0"

# Push
git push origin main --tags

# Create GitHub release
gh release create v1.2.0 --title "v1.2.0" --notes-file CHANGELOG.md
```

### 5. Docker (if applicable)
```bash
# Build Docker images
docker build -t centralstore-api:1.2.0 -f docker/Dockerfile.Api .
docker build -t centralstore-web:1.2.0 -f docker/Dockerfile.Web .
```

### 6. Post-release
- Verify release on GitHub
- Update version to next development version (e.g., 1.3.0-dev)
- Create new branch for next development cycle if needed
