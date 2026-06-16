# Team Delivery Workflow

## Scenario
A Team Lead manages a sprint aiming to deploy a major application update. They require a rigorous process that ensures all governance, testing, and readiness criteria are met before handing off to the release team.

## Persona
Team Lead

## Skills Used
- `karsa-orchestrator`
- `karsa-build`
- `karsa-test`
- `final-audit`
- `karsa-release-readiness`

## Workflow Steps
1. **Orchestrate**: The Team Lead invokes `karsa-orchestrator` at the start of the week to map out the required phases.
2. **Build**: The team merges their code, and `karsa-build` is run to compile the artifacts and verify dependencies.
3. **Test**: `karsa-test` executes the automated suite, ensuring coverage thresholds are not breached.
4. **Implementation Audit**: The orchestrator triggers code quality audits to check against team conventions.
5. **Final Audit**: `final-audit` validates that all previous findings have been remediated.
6. **Release Check**: `karsa-release-readiness` verifies approvals and generates a go/no-go decision.
7. **Deploy**: The team proceeds with the rollout.
8. **Sprint Closeout**: `sprint-closeout` gathers metrics and organizes carryover tasks.

## Expected Outputs
- `workflow-state` (Continuous tracking of the sprint progress).
- `build-artifacts` & `test-results` (Proof of functional correctness).
- `release-decision` (The go/no-go document authorizing the deployment).
- `sprint-report` (Metrics summarizing team velocity and quality).
