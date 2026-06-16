# Architecture

## Architecture Overview
Karsa Skill is an AI Engineering Workflow Framework built around the concept of composable, verifiable skills. Instead of prompting an LLM with ad-hoc requests, users invoke specialized skills that encode production-grade workflows.

## Design Principles
1. **Workflow-First**: Focus on the end-to-end delivery process, not just isolated tasks.
2. **Composability**: Complex workflows are built by chaining simple, single-purpose skills.
3. **Auditability**: Every decision and action produces evidence that can be reviewed.
4. **Extensibility**: The framework is designed to support custom, community-driven skills.

## Component Architecture
- **Skills (`skills/`)**: The core logic definitions encoded in `SKILL.md` files.
- **Documentation (`docs/`)**: Framework-level guidance and standards.
- **Templates (`templates/`)**: Reusable markdown templates for reports, reviews, and closeouts.
- **Examples (`examples/`)**: Pre-defined workflow sequences for common personas.

## Skill Dependency Graph
The skills form a Directed Acyclic Graph (DAG) representing the software delivery lifecycle. 
- Entry points: `karsa-orchestrator`, `karsa-bootstrap`, `karsa-dev-loop`, `architecture-review`.
- Dependencies ensure prerequisites are met (e.g., `karsa-build` requires `karsa-environment-audit`).

## Data Flow
Inputs and outputs are explicitly typed in each `SKILL.md`. Outputs from one skill (e.g., `build-report`) become inputs to subsequent skills (e.g., `karsa-test`).

## Extension Points
- Users can create new skills following the `SKILL.md` schema.
- Custom templates can be added to standard workflows.

## Architecture Decision Records
1. **Single-file skills**: `SKILL.md` encapsulates metadata and logic for portability.
2. **Category organization**: Skills are grouped by lifecycle phase for discoverability.
3. **YAML frontmatter**: Standardizes metadata parsing for orchestrators.
4. **Separation of docs/skills**: Isolates framework guidelines from executable skill logic.
