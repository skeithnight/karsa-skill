---
name: sprint-closeout
version: 1.0.0
description: Manages sprint completion including retrospective, metrics, and handoff
category: sprint
owner: skeithnight
requires: [final-audit]
produces: [sprint-report, retrospective-notes, carryover-backlog, metrics-summary]
triggers: [close sprint, sprint retrospective, end of sprint, sprint wrapup]
---

# Sprint Closeout

## Purpose
Handles sprint closure: collects delivery metrics, documents completed work, captures lessons learned, identifies carryover items, generates sprint reports, and prepares handoff documentation for the next sprint.

## Execution Workflow
1. Aggregate tickets and commits.
2. Compile velocity and quality metrics.
3. Identify incomplete work.
4. Generate Sprint Closeout Report.

## Inputs
| Name | Type | Required | Description |
|------|------|----------|-------------|
| Sprint_Data | JSON | Yes | Board export |
| Final_Audits | Dir | Yes | Completed audits |

## Outputs
| Name | Format | Description |
|------|--------|-------------|
| sprint-report | Markdown | End of sprint summary |
| carryover-backlog | List | Unfinished tasks |

## Success Criteria
1. Metrics accurately calculated.
2. Carryover items documented.
3. Report matches the standard template.

## Failure Handling
| Scenario | Action | Escalation |
|----------|--------|------------|
| Missing data | Request from tracker | Skip metrics |
| No retrospectives | Prompt team | N/A |

## Evidence Requirements
1. Sprint Closeout Report
2. Exported metrics payload
