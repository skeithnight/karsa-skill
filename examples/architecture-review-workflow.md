# Architecture Review Workflow

## Scenario
An Architect needs to evaluate a proposed microservice integration to ensure it aligns with corporate security policies, scalability requirements, and established design patterns.

## Persona
Architect

## Skills Used
- `architecture-review`
- `karsa-governance-audit`

## Workflow Steps
1. **Prepare**: The team provides a design document and context.
2. **Review Execution**: The architect runs `architecture-review` to analyze the component coupling, potential bottlenecks, and security boundaries.
3. **Governance Check**: `karsa-governance-audit` is triggered to ensure the proposed design complies with naming conventions, data privacy standards, and existing reference architectures.
4. **Compile Findings**: The architect collates the severity-rated findings from both skills.
5. **Report**: The `architecture-review-report` is produced and shared with the development team.
6. **Decision**: Based on the findings, the architect formally issues a decision (APPROVED, APPROVED_WITH_FINDINGS, or REJECTED).

## Expected Outputs
- `architecture-review-report` (Detailed component analysis and risk assessment).
- `governance-report` (Compliance checks against corporate standards).
- Architecture Decision (Formal recorded outcome).
