# Audit Report Template

## How to Use This Template
> Copy this template to generate a formal audit report.
> Remove the blockquotes before publishing.
> Fill in all sections thoroughly. Use "N/A" if a section does not apply.

## Audit Metadata
- **Audit Type**: [e.g., Governance, Documentation, Environment]
- **Date**: [YYYY-MM-DD]
- **Auditor**: [Name/Handle]
- **Scope**: [What is being audited]

## Audit Scope
[Define the exact boundaries of this audit. What repositories, components, or documents were reviewed? What was explicitly excluded?]

## Methodology
[Describe the tools used, the standard referenced, or the process followed during the audit.]

## Findings

| ID | Severity | Category | Finding | Risk | Recommendation | Status |
|----|----------|----------|---------|------|----------------|--------|
| F01 | HIGH | Security | Hardcoded credentials | System compromise | Remove and use env vars | OPEN |
| F02 | LOW | Style | Missing docstrings | Reduced maintainability | Add docstrings to public API | OPEN |

## Finding Details

### F01: [Finding Summary]
**Description**: [Detailed description]
**Evidence**: [Link or snippet]
**Impact**: [Detailed impact analysis]

## Summary Statistics
- **HIGH**: 0
- **MEDIUM**: 0
- **LOW**: 0

## Audit Verdict
- [ ] **PASS**: No findings or only LOW severity findings.
- [ ] **PASS_WITH_FINDINGS**: MEDIUM severity findings exist. Remediation plan required.
- [ ] **FAIL**: HIGH severity findings exist. Immediate remediation required.

## Remediation Requirements
[Outline the next steps, timelines, and who is responsible for addressing the findings.]
