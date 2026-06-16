---
name: karsa-orchestrator
version: 1.0.0
description: Orchestrates the full delivery workflow from design through production release
category: orchestration
owner: skeithnight
requires: []
produces:
  - workflow-state
  - phase-reports
  - delivery-summary
triggers:
  - orchestrate delivery
  - run full workflow
  - manage delivery pipeline
---

# karsa-orchestrator

## Purpose

The karsa-orchestrator is the master coordination skill that drives the entire delivery lifecycle from initial design through production release. It exists to enforce a disciplined, gate-controlled workflow where every phase must pass validation before the next phase begins. Without a centralized orchestrator, teams risk skipping critical steps, shipping unaudited code, or losing traceability between design decisions and production artifacts.

This skill manages the canonical delivery pipeline: **DESIGN → AUDIT → REMEDIATION → IMPLEMENT → AUDIT → REMEDIATION → DONE**. Each transition between phases is guarded by explicit gate conditions that must be satisfied before progression. The orchestrator maintains persistent state across the entire workflow, ensuring that interruptions, failures, or scope changes are handled gracefully without losing context.

The orchestrator delegates actual work to specialized skills (karsa-bootstrap, karsa-environment-audit, karsa-governance-audit, karsa-build, karsa-test, karsa-runtime-verify, karsa-docs-audit) and is responsible for sequencing their execution, collecting their outputs, and making phase-transition decisions based on aggregated results. It serves as the single source of truth for delivery status and provides a unified reporting surface for all downstream consumers.

## Execution Workflow

1. **Initialize Workflow State** — Create or resume a workflow state file that tracks the current phase, completed gates, pending actions, and accumulated evidence. If a prior workflow exists for the same project, offer to resume from the last checkpoint.

2. **Validate Entry Conditions** — Verify that the project repository exists, is accessible, and contains the minimum required structure. If the project has not been bootstrapped, delegate to `karsa-bootstrap` before proceeding.

3. **Execute DESIGN Phase** — Collect and validate design artifacts: feature specifications, architecture decision records, and acceptance criteria. Confirm that all stakeholders have signed off on the design scope.

4. **Gate Check: Design Completeness** — Evaluate whether all required design artifacts are present and meet quality thresholds. Decision point: if design is incomplete, block progression and report missing items. If complete, transition to AUDIT.

5. **Execute First AUDIT Phase** — Invoke `karsa-environment-audit`, `karsa-governance-audit`, and `karsa-docs-audit` in parallel. Collect all audit reports and merge findings into a consolidated audit summary.

6. **Gate Check: Audit Results** — Evaluate consolidated audit findings. Decision point: if critical or high-severity findings exist, transition to REMEDIATION. If all findings are informational or low-severity, skip remediation and transition to IMPLEMENT.

7. **Execute First REMEDIATION Phase** — For each critical/high finding, generate a remediation task. Track remediation progress until all critical items are resolved. Re-run the relevant audit skills to verify fixes.

8. **Execute IMPLEMENT Phase** — Coordinate implementation work by invoking `karsa-build` and `karsa-test` in sequence. Verify that build artifacts are generated and test results meet coverage thresholds. Invoke `karsa-runtime-verify` to validate runtime behavior.

9. **Execute Second AUDIT Phase** — Re-run all audit skills against the implemented codebase. This post-implementation audit catches regressions, new governance violations, or documentation gaps introduced during implementation.

10. **Gate Check: Post-Implementation Audit** — Evaluate second audit results. Decision point: if new critical findings exist, transition to second REMEDIATION. If clean, transition to DONE.

11. **Execute Second REMEDIATION Phase** — Address any findings from the post-implementation audit. This phase follows the same pattern as the first remediation but is scoped to implementation-introduced issues only.

12. **Finalize and Transition to DONE** — Generate the delivery summary, archive all phase reports, update the workflow state to DONE, and produce the final delivery evidence package.

## Inputs

| Name | Type | Required | Description |
|------|------|----------|-------------|
| project-path | string | Yes | Absolute path to the project repository root directory |
| workflow-id | string | No | Identifier for resuming an existing workflow; auto-generated if omitted |
| target-phase | string | No | Phase to execute up to (e.g., AUDIT for partial runs); defaults to DONE |
| skip-remediation | boolean | No | If true, treat remediation phases as advisory only; defaults to false |
| parallel-audits | boolean | No | If true, run independent audit skills concurrently; defaults to true |
| config-overrides | object | No | Key-value pairs that override default gate thresholds and phase parameters |

## Outputs

| Name | Format | Description |
|------|--------|-------------|
| workflow-state | JSON | Persistent state object tracking current phase, completed gates, and transition history |
| phase-reports | Markdown | Individual reports generated by each phase, stored in `docs/workflow/` directory |
| delivery-summary | Markdown | Final summary document aggregating all phase outcomes, findings, and evidence |
| gate-log | JSON | Chronological log of all gate evaluations, including pass/fail decisions and rationale |
| evidence-package | Directory | Collection of all artifacts, reports, and logs produced during the workflow |

## Success Criteria

1. All phases in the workflow (DESIGN → AUDIT → REMEDIATION → IMPLEMENT → AUDIT → REMEDIATION → DONE) execute in the correct order without any phase being skipped unless explicitly authorized by gate conditions.
2. Every gate transition is logged with a timestamp, evaluation result, and the specific conditions that were checked.
3. All delegated skill invocations complete successfully and produce their expected output artifacts.
4. The final delivery summary contains references to every phase report and all critical findings are marked as resolved.
5. The workflow state file accurately reflects the terminal state and can be used for post-delivery auditing.
6. No critical or high-severity audit findings remain unresolved at the DONE phase unless explicitly waived with documented justification.

## Failure Handling

| Scenario | Action | Escalation |
|----------|--------|------------|
| Delegated skill fails to execute | Retry the skill invocation up to 2 times with exponential backoff; if still failing, log the error and block phase progression | Report failure to the operator with the skill name, error details, and the phase that is blocked |
| Gate condition cannot be evaluated | Treat the gate as failed (fail-closed), log the reason, and halt progression at the current phase | Notify the operator that manual gate evaluation is required and provide the conditions that could not be assessed |
| Workflow state file is corrupted or missing | Attempt to reconstruct state from existing phase reports and artifacts; if reconstruction fails, offer to restart the workflow from the beginning | Alert the operator with details of the corruption and the last known good state |
| Project repository becomes inaccessible during execution | Pause the workflow, preserve current state, and schedule a retry after a configurable delay (default: 60 seconds) | If the repository remains inaccessible after 3 retries, halt the workflow and notify the operator |
| Scope change detected mid-workflow | Invoke `scope-change` skill to evaluate the impact; if the change is approved, adjust the workflow plan and re-run affected phases | If scope change is rejected, continue with the original plan and log the rejected change request |

## Evidence Requirements

1. A timestamped workflow state file (`workflow-state.json`) that records every phase transition, gate evaluation, and decision point throughout the delivery lifecycle.
2. Individual phase reports for each executed phase, stored as Markdown files in the `docs/workflow/` directory with consistent naming conventions (e.g., `phase-01-design.md`, `phase-02-audit.md`).
3. A consolidated delivery summary (`delivery-summary.md`) that provides an executive overview of the entire workflow, including duration, findings count, remediation actions taken, and final disposition.
4. Gate evaluation logs that capture the specific conditions checked, their pass/fail status, and any overrides or waivers applied.
5. Delegated skill output artifacts collected and cross-referenced in the delivery summary, ensuring full traceability from design decisions to production artifacts.
