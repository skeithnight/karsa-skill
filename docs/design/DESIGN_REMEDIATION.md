# Design Remediation

## Resolved Findings
1. **DES-01**: The orchestrator state will be maintained in a `.karsa/workflow-state.json` file in the target project root. This file will track the current phase, completed phases, collected evidence paths, and failure details. The orchestrator will use this file to resume operations after a failure.
2. **DES-02**: All new skills will be implemented in `skills/<skill-name>/` with a `SKILL.md` defining their contract and `scripts/` containing the execution bash/Node/Python scripts.

## Outcome
Design is fully remediated and accepted.
