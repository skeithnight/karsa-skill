---
name: final-audit
version: 1.0.0
description: Comprehensive final audit verifying all quality gates before delivery
category: audit
owner: skeithnight
requires: [implementation-audit, implementation-remediation, karsa-docs-audit]
produces: [final-audit-report, delivery-verdict, evidence-package]
triggers: [run final audit, final quality check, pre-delivery audit]
---

# Final Audit

## Purpose
Performs the definitive quality assessment before delivery: verifies all prior audit findings are resolved, validates end-to-end functionality, checks documentation completeness, confirms governance compliance, and produces a final verdict.

## Execution Workflow
1. Verify all previous gates (Build, Test, Audit).
2. Check that no open remediations exist.
3. Review final documentation state.
4. Generate Final Audit Report.

## Inputs
| Name | Type | Required | Description |
|------|------|----------|-------------|
| Remediation_Report | File | Yes | Proof of fixes |
| Docs_Audit | File | Yes | Doc readiness |

## Outputs
| Name | Format | Description |
|------|--------|-------------|
| final-audit-report | Markdown | Comprehensive overview |
| delivery-verdict | Boolean | DONE or NOT_DONE |

## Success Criteria
1. No pending tasks or open findings.
2. 100% test pass rate.
3. Verdict is DONE.

## Failure Handling
| Scenario | Action | Escalation |
|----------|--------|------------|
| Open findings | Fail audit | Return to remediation |
| Missing docs | Fail audit | Trigger docs update |

## Evidence Requirements
1. Final Audit Report
2. Signed Verdict
3. Consolidated evidence package
