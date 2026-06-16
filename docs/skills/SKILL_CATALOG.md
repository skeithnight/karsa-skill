# Skill Catalog

This catalog outlines all canonical skills in the Karsa framework, now updated with the Execution Orchestrator Refactor. All skills are designated as **STABLE**.

## Category: Orchestration
| Name | Description | Dependencies | Outputs |
|------|-------------|--------------|---------|
| `karsa-orchestrator` | Master execution engine that sequences operational skills for deployment. | None | `workflow-state`, `delivery-summary` |
| `karsa-local-production` | Orchestrates a full local production deployment. | `karsa-clone`, `karsa-install`, `karsa-config-discovery`, `karsa-build`, `karsa-test`, `karsa-runtime-verify`, `karsa-browser-verify` | `production-readiness-report` |

## Category: Operational (Execution)
| Name | Description | Dependencies | Outputs |
|------|-------------|--------------|---------|
| `karsa-clone` | Clones a repository and verifies its integrity. | None | `clone-report` |
| `karsa-install` | Detects package manager and installs dependencies. | `karsa-clone` | `dependency-report` |
| `karsa-config-discovery` | Discovers missing configuration and copies from examples. | `karsa-clone` | `config-report` |
| `karsa-web-research` | Resolves missing prerequisites via authoritative search. | None | `research-evidence` |
| `karsa-browser-verify` | Verifies UI routes and features via browser. | `karsa-runtime-verify` | `browser-verification-report` |

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
| `karsa-production-audit` | Comprehensive production readiness execution audit. | `karsa-build`, `karsa-test`, `karsa-runtime-verify` | `production-audit-report` |
| `implementation-audit` | Audits implementation quality and patterns. | `karsa-build`, `karsa-test` | `implementation-audit-report` |
| `final-audit` | Final audit verifying all quality gates before delivery. | `implementation-audit`, `implementation-remediation`, `karsa-docs-audit` | `final-audit-report` |

## Category: Build & Test
| Name | Description | Dependencies | Outputs |
|------|-------------|--------------|---------|
| `karsa-build` | Executes build compilation, bundling, and artifacts. | `karsa-environment-audit` | `build-artifacts`, `build-report` |
| `karsa-test` | Executes test suites and evaluates code coverage. | `karsa-build` | `test-results`, `coverage-report` |
| `karsa-runtime-verify` | Executes runtime behavior and health checks. | `karsa-build`, `karsa-test` | `runtime-report` |

## Category: Workflow execution
| Name | Description | Dependencies | Outputs |
|------|-------------|--------------|---------|
| `karsa-release-readiness` | Evaluates release gate conditions. | `karsa-production-audit`, `karsa-docs-audit` | `release-decision` |
| `karsa-dev-loop` | Manages iterative development cycles. | None | `iteration-log` |
| `architecture-review` | Conducts structured architecture reviews. | None | `architecture-review-report` |
| `implementation-remediation` | Systematically resolves audit findings. | `implementation-audit` | `remediation-report` |
| `sprint-closeout` | Manages sprint completion and retrospective. | `final-audit` | `sprint-report` |
