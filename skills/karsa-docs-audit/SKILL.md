---
name: karsa-docs-audit
version: 1.0.0
description: Audits documentation completeness, accuracy, and quality
category: docs
owner: skeithnight
requires: []
produces: [docs-audit-report, documentation-inventory, quality-scores]
triggers: [audit documentation, check docs, verify documentation quality]
---

# Docs Audit

## Purpose
Verifies that project documentation is complete, accurate, and follows quality standards. Checks README files, API documentation, architecture docs, inline code comments, and user guides.

## Execution Workflow
1. Scan for required files.
2. Run markdown link checker.
3. Ensure no placeholder text.
4. Generate report.

## Inputs
| Name | Type | Required | Description |
|------|------|----------|-------------|
| Repo_Root | Dir | Yes | Documentation path |

## Outputs
| Name | Format | Description |
|------|--------|-------------|
| docs-audit-report | Markdown | List of missing docs |

## Success Criteria
1. All required files exist.
2. No broken links.
3. Quality checks pass.

## Failure Handling
| Scenario | Action | Escalation |
|----------|--------|------------|
| Broken links | Log error | Author fixes |
| Missing README | Reject Audit | Require addition |

## Evidence Requirements
1. Link checker output
2. Documentation checklist
