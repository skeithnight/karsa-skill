---
name: karsa-orchestrator
version: 2.0.0
description: Master execution engine that sequences operational skills for a full local production deployment.
category: orchestration
owner: karsa-system
requires: []
produces:
  - workflow-state
  - delivery-summary
triggers:
  - run orchestrator
---

# karsa-orchestrator

## Responsibilities
Current role: Workflow coordinator.
New role: Master execution engine.

The orchestrator must:
1. Execute real operational skills.
2. Maintain state.
3. Maintain evidence.
4. Support resume.
5. Support remediation loops.
6. Produce final deployment summary.

## Workflow Pipeline
Clone → Audit → Install → Configure → Research → Build → Test → Runtime Verify → Browser Verify → Production Audit → Final Verdict

## Script
Execution should be driven by `./scripts/execute.sh <repo_url> <target_dir>`
