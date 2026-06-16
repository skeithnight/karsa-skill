---
name: implementation-audit
version: 1.0.0
description: Audits implementation quality including code structure, patterns, and completeness
category: audit
owner: skeithnight
requires: [karsa-build, karsa-test]
produces: [implementation-audit-report, finding-registry, compliance-matrix]
triggers: [audit implementation, review code quality, verify implementation]
---

# Implementation Audit

## Purpose
Verifies that the implementation meets design specifications: code structure follows architecture, patterns are applied consistently, error handling is comprehensive, edge cases are covered, and no critical functionality is missing.

## Execution Workflow
1. Static analysis of codebase.
2. Review against design specifications.
3. Identify deviations or bad practices.
4. Compile findings report.

## Inputs
| Name | Type | Required | Description |
|------|------|----------|-------------|
| Codebase | Directory | Yes | Source code |
| Design_Spec | File | Yes | Approved design |

## Outputs
| Name | Format | Description |
|------|--------|-------------|
| implementation-audit-report | Markdown | List of code defects |

## Success Criteria
1. Code structure matches design.
2. No critical patterns violated.
3. Findings documented with severity.

## Failure Handling
| Scenario | Action | Escalation |
|----------|--------|------------|
| Code won't compile | Abort audit | Return to Build phase |
| Missing tests | Log finding | Require Remediation |

## Evidence Requirements
1. Audit Report
2. Finding Registry
3. Compliance Matrix
