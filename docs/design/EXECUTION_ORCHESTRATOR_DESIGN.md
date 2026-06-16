# Execution Orchestrator Design

## Objective
Refactor the entire Karsa Skill Framework to become an executable production orchestration system rather than a documentation-only workflow framework.

## Skill Catalog Audit Findings
- **karsa-orchestrator**: Currently acts as a project manager, coordinating documentation phases rather than actual deployment phases. Produces documentation only. No execution capability.
- **karsa-bootstrap**: Describes project setup but lacks automated scripts to scaffold or clone repositories.
- **karsa-environment-audit**: Checklists environment versions but does not execute checks.
- **karsa-governance-audit**: Documentation governance only.
- **karsa-build**: Describes build processes but does not execute compilers or bundlers.
- **karsa-test**: Describes testing but does not execute test suites.
- **karsa-runtime-verify**: Describes runtime checks but does not execute them.
- **karsa-docs-audit**: Manual documentation review.
- **karsa-production-audit**: Manual readiness checklist.
- **karsa-release-readiness**: Go/no-go manual checklist.
- **karsa-dev-loop**: Documentation for dev loop.
- **architecture-review**: Documentation only.
- **implementation-audit**: Documentation only.
- **implementation-remediation**: Documentation only.
- **final-audit**: Documentation only.
- **sprint-closeout**: Documentation only.

**Conclusion**: All current skills are Category A (Produces documentation only) or C (verifiable evidence via manual checklist), but NONE are Category B (Performs real execution).

## Target Architecture

The new orchestrator will support real execution.
We will introduce 6 new operational skills:
1. `karsa-clone`
2. `karsa-install`
3. `karsa-config-discovery`
4. `karsa-web-research`
5. `karsa-browser-verify`
6. `karsa-local-production`

The `karsa-orchestrator` will be rewritten to act as a stateful execution engine that sequences these operational skills.

### Evidence Requirements
All skills will collect and output evidence JSON files containing execution results (e.g., exit codes, standard output, URLs, commit hashes).

### Remediation
If an execution fails (e.g., `karsa-install` fails), the orchestrator will invoke `karsa-web-research` to resolve the failure, or pause for manual intervention.

## Target Execution Pipeline for `karsa-local-production`:
Clone → Audit → Install → Configure → Research → Build → Test → Runtime Verify → Browser Verify → Production Audit → Final Verdict.
