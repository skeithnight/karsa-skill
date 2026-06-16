---
name: architecture-review
version: 1.0.0
description: Conducts structured architecture reviews with documented findings
category: review
owner: skeithnight
requires: []
produces: [architecture-review-report, component-diagram, risk-assessment]
triggers: [review architecture, evaluate design, architecture assessment]
---

# Architecture Review

## Purpose
This skill performs systematic architecture evaluation: component design, coupling analysis, scalability assessment, security posture, performance implications, maintainability evaluation, and technology fit. It ensures designs align with governance standards before implementation.

## Execution Workflow
1. Collect context (design docs, code structure).
2. Evaluate component cohesion and coupling.
3. Analyze security and scalability risks.
4. Document findings using the standard template.
5. Issue an architectural decision (Approved/Rejected).

## Inputs
| Name | Type | Required | Description |
|------|------|----------|-------------|
| Design_Doc | File | Yes | Proposed system architecture |
| Context | String | No | Background information |

## Outputs
| Name | Format | Description |
|------|--------|-------------|
| architecture-review-report | Markdown | Detailed findings |

## Success Criteria
1. All components analyzed.
2. Risks identified and rated.
3. Decision formally recorded.

## Failure Handling
| Scenario | Action | Escalation |
|----------|--------|------------|
| Missing context | Request documentation | Reject review |
| Unclear diagrams | Ask for clarification | Mark as finding |

## Evidence Requirements
1. Architecture Review Report
2. Risk Assessment Matrix
3. Formal Decision Record
