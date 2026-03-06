---
name: release
description: Manages release process - version bumping, changelog generation, tagging, and deployment preparation
---

# Release Skill

Manages the release process for CentralStore.

## Trigger
When user asks to create a release or prepare for deployment.

## Process
1. Pre-release checks (tests, uncommitted changes)
2. Version management (.csproj files)
3. Changelog generation
4. Tag & GitHub release creation
5. Docker image build preparation
