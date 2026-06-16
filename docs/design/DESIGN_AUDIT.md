# Design Audit

## Overview
Audit of `EXECUTION_ORCHESTRATOR_DESIGN.md`.

## Findings
1. **Finding ID**: DES-01
   - **Severity**: Medium
   - **Issue**: The design does not fully detail the implementation details for the orchestrator's state management (how state is stored, format, recovery).
   - **Impact**: Without explicit state management specifications, the orchestration may fail to support resume capability properly.
   - **Remediation**: Update design to specify a JSON state file (`.karsa-state.json`) that records the last successful phase, collected evidence, and pending tasks.

2. **Finding ID**: DES-02
   - **Severity**: Low
   - **Issue**: The new skills are listed but not explicitly scoped to the `skills/` directory format.
   - **Impact**: Inconsistent directory structure.
   - **Remediation**: Specify that new skills must contain a `SKILL.md` with operational instructions, bash/python execution scripts, and output schema.
