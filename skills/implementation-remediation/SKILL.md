---
name: implementation-remediation
version: 1.0.0
description: Systematically resolves audit findings with tracked remediation actions
category: remediation
owner: skeithnight
requires: [implementation-audit]
produces: [remediation-report, resolution-evidence, updated-finding-registry]
triggers: [remediate findings, fix audit issues, resolve implementation findings]
---

# Implementation Remediation

## Purpose
Takes audit findings and drives them to resolution: prioritizes by severity, creates remediation plans, tracks progress, verifies fixes, and produces evidence of resolution. Ensures no finding is left unresolved.

## Execution Workflow
1. Parse audit findings.
2. Prioritize HIGH and MEDIUM issues.
3. Implement required code changes.
4. Verify fixes with tests.
5. Generate remediation evidence.

## Inputs
| Name | Type | Required | Description |
|------|------|----------|-------------|
| Audit_Report | File | Yes | Findings list |
| Codebase | Dir | Yes | Source code |

## Outputs
| Name | Format | Description |
|------|--------|-------------|
| remediation-report | Markdown | Evidence of fixes |

## Success Criteria
1. All HIGH severity findings resolved.
2. Evidence captured for each fix.
3. Build and tests pass post-remediation.

## Failure Handling
| Scenario | Action | Escalation |
|----------|--------|------------|
| Cannot fix issue | Document workaround | Escalate to Architect |
| Fix breaks build | Revert change | Re-evaluate approach |

## Evidence Requirements
1. Remediation Report
2. Commit links for fixes
3. Clean build verification
