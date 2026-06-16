# Architecture Frozen Decision

## Status
APPROVED

## Justification
The execution orchestrator design has passed audit and remediation. The target state of the system is well-understood:
- Karsa Skill framework will pivot to an active execution orchestration system.
- State management will be JSON-based.
- Execution will be bash/script-based per skill.
- 6 new active skills (`karsa-clone`, `karsa-install`, `karsa-config-discovery`, `karsa-web-research`, `karsa-browser-verify`, `karsa-local-production`) will be added.
- The `karsa-orchestrator` skill will be completely rewritten to orchestrate execution instead of static documentation processes.

All design decisions are now frozen for implementation.
