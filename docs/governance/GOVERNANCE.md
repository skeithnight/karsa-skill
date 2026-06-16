# Governance

## Governance Overview
The Karsa Skill framework enforces technical governance through structured reviews, explicit quality gates, and a robust conflict resolution process. 

## Skill Naming Convention
- **Core Lifecycle Skills**: Prefixed with `karsa-` (e.g., `karsa-orchestrator`, `karsa-build`).
- **Workflow-Phase Skills**: Descriptive kebab-case (e.g., `architecture-review`, `final-audit`).

## Skill Quality Gates
Every proposed skill must pass the following checks:
1. **Structural Validation**: Ensures `SKILL.md` contains all required markdown sections.
2. **Schema Compliance**: Verifies YAML frontmatter structure.
3. **Documentation Completeness**: No missing descriptions, TBDs, or placeholders.
4. **Cross-Reference Integrity**: Links to other skills or docs must be valid.
5. **Version Consistency**: SemVer compliance in `SKILL.md` metadata.

## Review Process
All skill modifications require peer review evaluating content accuracy, workflow logic, and adherence to Karsa design principles.

## Change Management
- **Minor**: Typo fixes or minor clarifications (direct commit permitted for maintainers).
- **Feature**: Adding new workflows or extending skill inputs/outputs (PR required).
- **Breaking**: Changing skill schemas, renaming skills, or modifying core lifecycle phases (RFC required).
- **New Skill**: Requires a proposal, draft, review, and acceptance phases.

## Conflict Resolution
- **Single Maintainer**: The repository owner makes the final decision.
- **Multi-Maintainer**: Disagreements trigger a structured discussion, followed by a 48-hour cooling period, a maintainer vote, and a tiebreaker by the lead maintainer.

## Dependency Validation
Skills must list required prerequisites in the `requires` field. Validation ensures the listed skills exist within the catalog to prevent broken workflows.

## Ownership Model
Each skill requires an `owner` attribute in the YAML frontmatter designating the responsible individual or team.
