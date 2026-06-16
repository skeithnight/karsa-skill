# Skill Catalog

This catalog outlines all 16 canonical skills in the Karsa framework (Version 1.0.0). All skills are currently designated as **STABLE**.

## Category: Orchestration
| Name | Description | Dependencies | Outputs |
|------|-------------|--------------|---------|
| `karsa-orchestrator` | Orchestrates the full delivery workflow from design through release. | None | `workflow-state`, `phase-reports` |

## Category: Bootstrap
| Name | Description | Dependencies | Outputs |
|------|-------------|--------------|---------|
| `karsa-bootstrap` | Bootstraps new projects with standardized structure. | None | `project-structure`, `bootstrap-report` |

## Category: Audit
| Name | Description | Dependencies | Outputs |
|------|-------------|--------------|---------|
| `karsa-environment-audit` | Audits development environment configuration. | `karsa-bootstrap` | `environment-report` |
| `karsa-governance-audit` | Audits project governance compliance. | `karsa-bootstrap` | `governance-report` |
| `karsa-docs-audit` | Audits documentation completeness and quality. | None | `docs-audit-report` |
| `karsa-production-audit` | Comprehensive production readiness audit. | `karsa-build`, `karsa-test`, `karsa-runtime-verify` | `production-audit-report` |
| `implementation-audit` | Audits implementation quality and patterns. | `karsa-build`, `karsa-test` | `implementation-audit-report` |
| `final-audit` | Final audit verifying all quality gates before delivery. | `implementation-audit`, `implementation-remediation`, `karsa-docs-audit` | `final-audit-report` |

## Category: Build & Test
| Name | Description | Dependencies | Outputs |
|------|-------------|--------------|---------|
| `karsa-build` | Manages build compilation, bundling, and artifacts. | `karsa-environment-audit` | `build-artifacts`, `build-report` |
| `karsa-test` | Executes test suites and evaluates code coverage. | `karsa-build` | `test-results`, `coverage-report` |
| `karsa-runtime-verify` | Verifies runtime behavior and health checks. | `karsa-build`, `karsa-test` | `runtime-report` |

## Category: Workflow execution
| Name | Description | Dependencies | Outputs |
|------|-------------|--------------|---------|
| `karsa-release-readiness` | Evaluates release gate conditions. | `karsa-production-audit`, `karsa-docs-audit` | `release-decision` |
| `karsa-dev-loop` | Manages iterative development cycles. | None | `iteration-log` |
| `architecture-review` | Conducts structured architecture reviews. | None | `architecture-review-report` |
| `implementation-remediation` | Systematically resolves audit findings. | `implementation-audit` | `remediation-report` |
| `sprint-closeout` | Manages sprint completion and retrospective. | `final-audit` | `sprint-report` |

## Dependency Matrix Overview
A high-level view of how skills depend on each other:
`karsa-orchestrator` -> orchestrates all phases
`karsa-bootstrap` -> `karsa-environment-audit`, `karsa-governance-audit`
`karsa-environment-audit` -> `karsa-build`
`karsa-build` -> `karsa-test`, `implementation-audit`
`karsa-test` -> `karsa-runtime-verify`
`implementation-audit` -> `implementation-remediation`, `final-audit`
