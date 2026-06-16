---
name: karsa-dev-loop
version: 1.0.0
description: Manages iterative development cycles with continuous feedback
category: dev-loop
owner: skeithnight
requires: []
produces:
  - iteration-log
  - progress-report
  - scope-tracking
triggers:
  - start dev loop
  - iterate on feature
  - development cycle
---

# karsa-dev-loop

## Purpose

The karsa-dev-loop skill provides a disciplined, repeatable framework for iterative development. Without structure, development iterations tend to sprawl — scope creeps unnoticed, progress becomes unmeasurable, and developers oscillate between tasks without completing any of them. This skill imposes a lightweight but rigorous cycle that keeps development focused and productive.

The core loop follows a four-phase pattern: implement → test → review → refine. Each iteration is time-boxed and scope-bounded. The skill tracks iteration count, records what was accomplished versus what was planned, detects scope drift, and prevents feature creep by requiring explicit scope change acknowledgment. Every iteration produces a measurable delta — code written, tests added, bugs fixed, or documentation updated.

This skill is designed for both solo developers and pair programming workflows. It does not depend on any upstream skills, making it the entry point for active development work. Its outputs — iteration logs, progress reports, and scope tracking — feed into downstream audit and review skills, creating a traceable development history from first keystroke to final delivery.

## Execution Workflow

1. **Initialize Loop Context**: Create the iteration workspace, set the iteration counter to 1, record the initial scope definition, and establish the time-box duration (default: 30 minutes per iteration).
2. **Define Iteration Goal**: Capture the specific, measurable goal for this iteration. The goal must be concrete enough to evaluate completion (e.g., "Implement the user validation endpoint with input sanitization" rather than "work on user feature").
3. **Implement Phase**: Execute the planned implementation work. Track files created, modified, and deleted. Record lines of code added and removed. Monitor for scope drift — any work not aligned with the iteration goal is flagged.
4. **Test Phase**: Run relevant tests against the implementation. Record test results (pass/fail/skip counts). If no tests exist for the new code, flag this as a gap requiring attention in the next iteration.
5. **Review Phase**: Evaluate the implementation against the iteration goal. Check code quality heuristics (complexity, duplication, naming conventions). Identify any technical debt introduced. Document review findings.
6. **Decision Point — Iteration Outcome**:
    - **COMPLETE**: The iteration goal has been fully achieved. Proceed to refinement.
    - **PARTIAL**: Progress was made but the goal is not fully met. Record what remains and carry it to the next iteration.
    - **BLOCKED**: An external dependency or unresolved question prevents progress. Document the blocker and pause the loop.
7. **Refine Phase**: Based on review findings, apply minor refinements (code cleanup, comment improvements, small optimizations). Major changes are deferred to the next iteration to prevent scope expansion.
8. **Log Iteration**: Record the iteration summary — goal, outcome, files changed, tests run, findings, time spent, and any scope adjustments.
9. **Scope Drift Check**: Compare the current scope against the original scope definition. If new items have been added, require explicit acknowledgment. Calculate scope drift percentage.
10. **Decision Point — Continue or Conclude**:
    - If more iterations are needed and no blockers exist: increment the iteration counter and return to step 2.
    - If the feature is complete or a maximum iteration count is reached: proceed to conclusion.
11. **Generate Outputs**: Produce the `iteration-log`, `progress-report`, and `scope-tracking` artifacts summarizing all iterations.
12. **Handoff**: Make outputs available for downstream skills (`implementation-audit`, `architecture-review`, etc.).

## Inputs

| Name | Type | Required | Description |
|------|------|----------|-------------|
| project_root | string | Yes | Absolute path to the project root directory |
| feature_scope | string | Yes | Description of the feature or work item being developed in this loop |
| max_iterations | number | No | Maximum number of iterations before forced conclusion (default: 10) |
| time_box_minutes | number | No | Time-box duration per iteration in minutes (default: 30) |
| scope_drift_threshold | number | No | Maximum acceptable scope drift percentage before requiring explicit approval (default: 20) |
| working_branch | string | No | Git branch name for tracking changes (default: current branch) |
| pair_mode | boolean | No | Whether the loop is operating in pair programming mode with two contributors (default: false) |
| initial_tasks | list | No | Pre-defined task breakdown for the feature scope |

## Outputs

| Name | Format | Description |
|------|--------|-------------|
| iteration-log | Markdown (.md) | Chronological log of all iterations with goals, outcomes, files changed, test results, and time spent per iteration |
| progress-report | JSON (.json) | Quantified progress summary including completion percentage, velocity metrics, scope drift percentage, and remaining work estimate |
| scope-tracking | Markdown (.md) | Scope evolution document showing original scope, additions, removals, and drift analysis with explicit change acknowledgments |

## Success Criteria

1. Every iteration has a documented goal, outcome (COMPLETE/PARTIAL/BLOCKED), and measurable deliverable.
2. Scope drift is tracked and any drift beyond the configured threshold has explicit developer acknowledgment recorded.
3. The progress report provides an accurate completion percentage that correlates with the remaining work items.
4. No iteration exceeds its time-box by more than 10% without a documented reason.
5. Test coverage for new code is tracked across iterations with a trend showing improvement or stability.
6. The iteration log provides sufficient detail for a reviewer to understand what was done in each iteration without examining the code directly.

## Failure Handling

| Scenario | Action | Escalation |
|----------|--------|------------|
| Iteration goal is too vague to evaluate completion | Reject the goal and prompt the developer to restate it in measurable terms before proceeding | Log the rejected goal and the revised version for traceability |
| Scope drift exceeds the configured threshold | Pause the loop, present the drift analysis to the developer, and require explicit acknowledgment or scope rollback | If drift exceeds 50%, recommend invoking the `scope-change` skill for formal scope management |
| Tests fail during the test phase | Record the failures, mark the iteration as PARTIAL, and carry test fixes as a priority goal for the next iteration | If the same tests fail across three consecutive iterations, flag as a systemic issue requiring architectural attention |
| Maximum iteration count reached without completion | Force-conclude the loop, generate outputs with the current state, and document remaining work as carryover | Recommend breaking the remaining work into a new feature scope with its own dev loop |
| Developer introduces work outside the defined scope | Flag the out-of-scope work in the scope tracking document, do not count it toward iteration progress | If out-of-scope work recurs across iterations, recommend a scope redefinition session |
| External blocker prevents iteration progress | Mark the iteration as BLOCKED, document the blocker with specifics, and pause the loop | Notify the relevant dependency owner and set a follow-up reminder |

## Evidence Requirements

1. Iteration log entries with timestamps for each phase (implement start/end, test start/end, review start/end, refine start/end).
2. Git diff summaries or file change lists for each iteration showing exactly what was modified.
3. Test execution results per iteration with pass/fail/skip counts and coverage delta.
4. Scope tracking document showing the original scope definition and any modifications with timestamps and acknowledgments.
5. Progress metrics showing velocity trend across iterations (e.g., story points or tasks completed per iteration).
6. Time tracking data showing actual time spent per iteration versus the configured time-box.
7. Blocker documentation with blocker description, identified date, resolution date, and impact on iteration progress.
