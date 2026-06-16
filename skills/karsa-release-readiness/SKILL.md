---
name: karsa-release-readiness
version: 1.0.0
description: Evaluates release gate conditions and produces go/no-go decision
category: release
owner: skeithnight
requires:
  - karsa-production-audit
  - karsa-docs-audit
produces:
  - release-decision
  - release-checklist
  - release-notes-draft
triggers:
  - check release readiness
  - evaluate release gates
  - release go/no-go
---

# karsa-release-readiness

## Purpose

The karsa-release-readiness skill serves as the final decision gate between development completion and software release. Releasing software without a systematic evaluation of prerequisites is a leading cause of post-release incidents, rollbacks, and customer-facing defects. This skill eliminates subjective "feels ready" judgments by enforcing an objective, evidence-based go/no-go framework.

This skill evaluates the full spectrum of release prerequisites: test pass rates must meet defined thresholds, code coverage must satisfy minimum requirements, all audit findings must be resolved or explicitly accepted, documentation must be complete and current, the changelog must reflect all changes, version numbers must be bumped according to semantic versioning, and required stakeholder approvals must be obtained. Each prerequisite is evaluated independently and contributes to the overall release decision.

The skill depends on upstream outputs from `karsa-production-audit` and `karsa-docs-audit` to ensure that both operational readiness and documentation quality have been independently verified. By consolidating all release gate evaluations into a single skill, it provides a single source of truth for release decisions and creates an auditable record of what was evaluated and what the outcome was.

## Execution Workflow

1. **Collect Gate Inputs**: Gather all prerequisite artifacts — production audit report, documentation audit report, test results, coverage reports, and version metadata.
2. **Validate Prerequisite Completion**: Verify that both `karsa-production-audit` and `karsa-docs-audit` have completed with acceptable verdicts. If either has a blocking verdict, halt with a NOT_READY decision.
3. **Evaluate Test Gate**: Check test pass rate against the configured threshold (default: 100% pass rate). Identify any failing, skipped, or flaky tests. Record pass/fail for this gate.
4. **Evaluate Coverage Gate**: Verify code coverage meets the minimum threshold (default: 80% line coverage, 70% branch coverage). Record pass/fail for this gate.
5. **Evaluate Audit Findings Gate**: Confirm all critical and high-severity findings from prior audits are resolved. Medium-severity findings must have documented acceptance or deferral justification. Record pass/fail for this gate.
6. **Evaluate Documentation Gate**: Verify README is current, API documentation matches implementation, migration guides exist for breaking changes, and user-facing documentation reflects new features. Record pass/fail for this gate.
7. **Evaluate Changelog Gate**: Confirm the changelog has been updated with all changes since the last release, entries follow the project's changelog format, and no unreleased changes are missing. Record pass/fail for this gate.
8. **Evaluate Version Gate**: Verify the version has been bumped according to semantic versioning rules — major for breaking changes, minor for new features, patch for bug fixes. Confirm version consistency across all manifests (package.json, pom.xml, build.gradle, etc.). Record pass/fail for this gate.
9. **Evaluate Approval Gate**: Check that all required stakeholder approvals are recorded (code review approvals, QA sign-off, product owner acceptance). Record pass/fail for this gate.
10. **Decision Point — Render Go/No-Go Verdict**:
    - **GO**: All gates pass. Release is approved.
    - **CONDITIONAL_GO**: Non-critical gates have documented waivers. Release is approved with noted risks.
    - **NO_GO**: One or more critical gates fail. Release is blocked with specific remediation requirements.
11. **Generate Release Checklist**: Produce a comprehensive pre-release checklist covering deployment steps, rollback procedures, monitoring actions, and communication plans.
12. **Draft Release Notes**: Auto-generate release notes from the changelog, commit history, and resolved issues. Organize by category (features, fixes, breaking changes, known issues).
13. **Archive Decision**: Store the release decision, checklist, and release notes draft in the project's `docs/releases/` directory with version-stamped filenames.

## Inputs

| Name | Type | Required | Description |
|------|------|----------|-------------|
| project_root | string | Yes | Absolute path to the project root directory |
| production_audit_report | string | Yes | Path to the production audit report from `karsa-production-audit` |
| docs_audit_report | string | Yes | Path to the documentation audit report from `karsa-docs-audit` |
| test_report_path | string | Yes | Path to the test execution report with pass/fail/skip counts |
| coverage_report_path | string | Yes | Path to the code coverage report |
| target_version | string | Yes | The intended release version (e.g., `2.1.0`) |
| test_pass_threshold | number | No | Minimum test pass rate percentage (default: 100) |
| coverage_threshold | object | No | Minimum coverage thresholds (`line_percent`, `branch_percent`; defaults: 80, 70) |
| approvers | list | No | List of required approver identifiers for the approval gate |
| changelog_path | string | No | Path to the changelog file (default: `CHANGELOG.md` in project root) |

## Outputs

| Name | Format | Description |
|------|--------|-------------|
| release-decision | JSON (.json) | Structured go/no-go decision with per-gate pass/fail status, overall verdict, blocking issues, and waiver records |
| release-checklist | Markdown (.md) | Pre-release checklist covering deployment, rollback, monitoring, and stakeholder communication steps |
| release-notes-draft | Markdown (.md) | Auto-generated release notes organized by features, fixes, breaking changes, and known issues |

## Success Criteria

1. Every configured release gate has been evaluated with a definitive pass or fail status and supporting evidence.
2. The release decision document contains no ambiguous or partially evaluated gates — every gate has a clear verdict.
3. All blocking issues identified in the NO_GO decision include specific remediation steps and responsible parties.
4. The release checklist is comprehensive enough to guide a deployment engineer through the release process without additional context.
5. Release notes accurately reflect all changes since the previous release with proper categorization and no omitted items.
6. The decision, checklist, and release notes are archived with version-stamped filenames for historical traceability.

## Failure Handling

| Scenario | Action | Escalation |
|----------|--------|------------|
| Production audit report is missing or has NOT_READY verdict | Immediately issue NO_GO decision with the production audit as the blocking dependency | Notify the development team to run `karsa-production-audit` and resolve findings before re-evaluation |
| Documentation audit report is unavailable | Issue NO_GO decision for the documentation gate; allow other gates to be evaluated | Notify the technical writer or documentation owner to complete the documentation audit |
| Test results contain flaky tests above tolerance threshold | Mark the test gate as CONDITIONAL_PASS, document the flaky tests, and flag for review | Escalate to the QA lead with a list of flaky tests requiring stabilization |
| Version has not been bumped or is inconsistent across manifests | Fail the version gate, list all manifests with version mismatches | Notify the release engineer to reconcile version numbers before re-evaluation |
| Required approver has not signed off | Fail the approval gate, list pending approvals with approver identifiers | Send a direct notification to the pending approvers requesting timely sign-off |
| Changelog is empty or missing entries for known changes | Fail the changelog gate with a list of commits not reflected in the changelog | Notify the developer to update the changelog with missing entries |

## Evidence Requirements

1. Per-gate evaluation results with timestamps showing when each gate was assessed and what data was used.
2. Test execution summary showing total tests, passed, failed, skipped, and flaky counts with their corresponding pass rate.
3. Code coverage report summary showing line coverage, branch coverage, and any modules below threshold.
4. Audit finding resolution status showing each finding ID, its original severity, and its current resolution state.
5. Version consistency check results showing the version string found in each manifest file.
6. Stakeholder approval records with approver identity, timestamp, and approval scope.
7. Changelog diff showing entries added since the last release tag.
