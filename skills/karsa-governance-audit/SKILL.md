---
name: karsa-governance-audit
version: 1.0.0
description: Audits project governance compliance including standards and policies
category: governance
owner: skeithnight
requires: [karsa-bootstrap]
produces: [governance-report, compliance-matrix, policy-violations]
triggers: [audit governance, check compliance, verify standards]
---

# Governance Audit

## Purpose
Verifies that the project follows established governance standards: coding conventions, commit message formats, branch naming, PR templates, license compliance, security policies, and documentation standards.

## Execution Workflow
1. Check repository layout and templates.
2. Validate license and branch names.
3. Check PR constraints.
4. Issue Governance Report.

## Inputs
| Name | Type | Required | Description |
|------|------|----------|-------------|
| Project_Dir | Dir | Yes | Repository root |

## Outputs
| Name | Format | Description |
|------|--------|-------------|
| governance-report | Markdown | Findings and compliance |

## Success Criteria
1. 100% compliance with conventions.
2. Licensing verified.
3. Templates exist.

## Failure Handling
| Scenario | Action | Escalation |
|----------|--------|------------|
| Missing License | Block PR | Require addition |
| Bad commit format | Reject commit | Developer fixes history |

## Evidence Requirements
1. Governance Report
2. Policy Violations List
