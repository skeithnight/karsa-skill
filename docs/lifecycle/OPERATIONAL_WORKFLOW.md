# Operational Workflow

## Overview
The operational workflow is driven by the newly upgraded `karsa-orchestrator`, acting as a master execution engine instead of merely a documentation coordinator.

## The Pipeline
The execution pipeline is deterministic and resume-capable.

1. **Clone**: Authenticates and retrieves the specified project repository to the target directory. Evidence is collected in `clone-evidence.json`.
2. **Audit**: Initial code scanning (currently delegates to pre-existing manual stubs or future execution skills).
3. **Install**: Determines the package manager (`npm`, `yarn`, `pnpm`) and installs dependencies.
4. **Configure**: Discovers `.env.example` and automatically provisions a `.env` to prevent startup crashes.
5. **Research**: If a failure occurs, queries authoritative documentation to resolve it.
6. **Build**: Executes `npm run build` or the respective build sequence. Evidence collected in `build-evidence.json`.
7. **Test**: Executes test suites.
8. **Runtime Verify**: Spawns the process and evaluates health checks.
9. **Browser Verify**: Programmatically hits major application routes to guarantee UI stability.
10. **Production Audit**: Final sign-off.
11. **Final Verdict**: Outputs the complete workflow state and evidence list.

## Resume Mechanism
The `karsa-orchestrator` tracks progress in `<target_dir>/.karsa/workflow-state.json`. If execution is aborted, it skips previously completed phases upon restart.
