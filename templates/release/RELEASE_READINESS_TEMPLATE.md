# Release Readiness Template

## How to Use This Template
> Use this template to document the final go/no-go decision before a production deployment.

## Release Metadata
- **Version**: [vX.Y.Z]
- **Date**: [YYYY-MM-DD]
- **Release Manager**: [Name]

## Release Gate Checklist

| Gate | Criteria | Status | Evidence |
|------|----------|--------|----------|
| Testing | 100% pass rate, >80% coverage | PASS | Test Report Link |
| Audits | No HIGH severity findings | PASS | Final Audit Link |
| Docs | Changelog & README updated | PASS | PR Link |
| Security | Zero critical vulnerabilities | PASS | Scan Link |

## Quality Summary
- **Test Coverage**: [%]
- **Open Bugs**: [Count]

## Risk Assessment
[Identify any known risks with this release and mitigations]

## Release Notes Draft
[Summary of changes]

## Rollback Plan
[Steps to revert if deployment fails]

## Release Decision
- [ ] **GO**: All gates passed. Proceed with release.
- [ ] **NO-GO**: Blockers identified. Abort release.

## Approvals
- [Sign-offs]
