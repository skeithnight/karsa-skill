# Delivery Workflow

## Workflow Overview
The Karsa Skill delivery workflow is a structured, phase-based approach to software engineering. It ensures that quality, governance, and auditability are embedded in every step.

## Phase Definitions
- **DESIGN**: Establish requirements, system architecture, and technical approach.
- **DESIGN_AUDIT**: Independent review of the proposed design against governance and quality standards.
- **DESIGN_REMEDIATION**: Resolution of all findings identified in the design audit.
- **ARCHITECTURE_FROZEN**: Formal gate authorizing implementation to begin.
- **IMPLEMENTATION**: Execution of the technical work.
- **IMPLEMENTATION_AUDIT**: Code review, security scanning, and functional validation against the frozen design.
- **IMPLEMENTATION_REMEDIATION**: Correction of code defects and implementation gaps.
- **FINAL_AUDIT**: Final verification of all deliverables, documentation, and release readiness.
- **DONE**: The feature or project is accepted and ready for deployment.

## Phase Transitions
Transitions occur only when specific gate conditions are met. No phase can be skipped in the standard workflow.

## Gate Conditions
Each audit phase acts as a quality gate. A gate is passed only if:
1. No HIGH severity findings remain unresolved.
2. Required artifacts (reports, diagrams, metrics) are produced.
3. Automated checks (e.g., tests, linters) pass successfully.

## State Management
The `karsa-orchestrator` skill tracks the current workflow state, preventing unauthorized transitions.

## Workflow Variants
- **Full Workflow**: Standard process for new features and significant architecture changes.
- **Abbreviated**: For minor modifications. Skips formal design review but requires implementation audit.
- **Hotfix**: Emergency resolution path prioritizing speed. Demands post-deployment audits.

## Failure Recovery
If a phase fails (e.g., `IMPLEMENTATION_AUDIT` yields critical blockers), the workflow returns to the preceding remediation phase (`IMPLEMENTATION_REMEDIATION`) until standards are met.
