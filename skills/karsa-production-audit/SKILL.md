---
name: karsa-production-audit
version: 1.0.0
description: Comprehensive production readiness audit covering security, performance, and reliability
category: audit
owner: skeithnight
requires:
  - karsa-build
  - karsa-test
  - karsa-runtime-verify
produces:
  - production-audit-report
  - readiness-scorecard
  - risk-registry
triggers:
  - audit production readiness
  - check production
  - verify production ready
---

# karsa-production-audit

## Purpose

The karsa-production-audit skill performs a comprehensive assessment of whether a system is genuinely ready for production deployment. Production readiness extends far beyond passing tests — it encompasses security hardening, performance baselines, error handling resilience, observability, and operational preparedness. This skill exists because deploying software that hasn't undergone rigorous production scrutiny leads to incidents, data loss, and eroded stakeholder trust.

This skill systematically evaluates nine production readiness dimensions: security hardening, performance baselines, error handling coverage, logging adequacy, monitoring completeness, alerting configuration, backup strategies, disaster recovery procedures, and operational runbook availability. Each dimension receives a quantified score contributing to an overall readiness scorecard.

By enforcing a structured audit before any production deployment, this skill prevents the common failure mode of "it works on my machine" reaching customers. It integrates with the upstream `karsa-build`, `karsa-test`, and `karsa-runtime-verify` skills to ensure that foundational quality gates have already been satisfied before the production-level assessment begins.

## Execution Workflow

1. **Verify Prerequisites**: Confirm that `karsa-build`, `karsa-test`, and `karsa-runtime-verify` have completed successfully. If any prerequisite has not passed, halt the audit and report the blocking dependency.
2. **Initialize Audit Context**: Create the audit workspace, generate a unique audit ID, and establish the scoring template with all nine readiness dimensions.
3. **Security Hardening Assessment**: Evaluate authentication mechanisms, authorization policies, secret management, dependency vulnerability scans, TLS configuration, CORS policies, and input validation coverage. Assign a security score (0–100).
4. **Performance Baseline Evaluation**: Review response time benchmarks, throughput capacity, resource utilization under load, connection pool sizing, cache hit ratios, and database query performance. Assign a performance score (0–100).
5. **Error Handling Audit**: Verify that all external integration points have error handling, retry policies are configured with backoff, circuit breakers are in place for downstream services, and graceful degradation paths exist. Assign an error handling score (0–100).
6. **Logging and Observability Check**: Validate structured logging format, log level configuration, correlation ID propagation, sensitive data redaction, log rotation policies, and distributed tracing integration. Assign a logging score (0–100).
7. **Monitoring and Alerting Review**: Confirm health check endpoints exist, key metrics are instrumented (latency, error rate, saturation), dashboards are provisioned, alert thresholds are defined with appropriate severity levels, and escalation paths are documented. Assign a monitoring score (0–100).
8. **Backup and Disaster Recovery Verification**: Validate backup schedules, retention policies, restore procedures, RTO/RPO targets, failover mechanisms, and data integrity verification processes. Assign a DR score (0–100).
9. **Operational Runbook Assessment**: Confirm runbooks exist for common operational scenarios (deployment, rollback, scaling, incident response), runbooks are current, and on-call procedures are documented. Assign an operations score (0–100).
10. **Decision Point — Calculate Readiness Verdict**:
    - If all dimension scores ≥ 80 and no critical findings: verdict is **PRODUCTION_READY**.
    - If any dimension score is 60–79 with no critical findings: verdict is **CONDITIONAL_READY** (proceed with documented risks).
    - If any dimension score < 60 or critical findings exist: verdict is **NOT_READY** (remediation required).
11. **Generate Outputs**: Produce the `production-audit-report`, `readiness-scorecard`, and `risk-registry` artifacts. Write all evidence to the audit workspace.
12. **Archive and Notify**: Store the audit artifacts in the project's `docs/audits/` directory and notify stakeholders of the verdict.

## Inputs

| Name | Type | Required | Description |
|------|------|----------|-------------|
| project_root | string | Yes | Absolute path to the project root directory containing source code and configuration |
| environment_target | string | Yes | Target environment being audited (e.g., `production`, `staging`, `pre-prod`) |
| build_artifact_path | string | Yes | Path to the build output from the `karsa-build` skill |
| test_report_path | string | Yes | Path to the test execution report from `karsa-test` |
| runtime_verify_report | string | Yes | Path to the runtime verification report from `karsa-runtime-verify` |
| security_policy_path | string | No | Path to organization security policy for compliance checking |
| performance_sla | object | No | Expected SLA targets (response_time_p99_ms, uptime_percent, error_rate_threshold) |
| custom_checklist | list | No | Additional audit checklist items specific to the project |

## Outputs

| Name | Format | Description |
|------|--------|-------------|
| production-audit-report | Markdown (.md) | Comprehensive audit report with findings organized by dimension, severity ratings, and remediation recommendations |
| readiness-scorecard | JSON (.json) | Quantified scores for each of the nine readiness dimensions with an overall composite score and verdict |
| risk-registry | Markdown (.md) | Catalog of identified risks with likelihood, impact, mitigation strategies, and risk owners |

## Success Criteria

1. All nine readiness dimensions have been evaluated and scored with documented evidence supporting each score.
2. Every critical and high-severity finding includes a specific, actionable remediation recommendation with an assigned owner.
3. The readiness scorecard produces a definitive verdict (PRODUCTION_READY, CONDITIONAL_READY, or NOT_READY) with no ambiguous or partial assessments.
4. The risk registry contains all identified risks with likelihood/impact ratings and proposed mitigation strategies.
5. All prerequisite skill outputs (build, test, runtime-verify) have been validated and cross-referenced in the audit report.
6. The audit report is stored in the project's documentation directory with a timestamped filename for traceability.

## Failure Handling

| Scenario | Action | Escalation |
|----------|--------|------------|
| Prerequisite skill output is missing or invalid | Halt audit, report which prerequisite failed, and provide instructions to re-run the dependency | Notify the developer with the specific prerequisite that must be resolved before re-attempting the audit |
| Security vulnerability scanner is unavailable | Fall back to manual dependency review using lockfile analysis; document reduced confidence in security score | Flag the security dimension as partially assessed and recommend a full scan before final deployment approval |
| Performance baseline data is insufficient | Document the gap, assign a provisional score with a "low confidence" flag, and recommend load testing | Escalate to the team lead with a recommendation to run `karsa-runtime-verify` with extended performance scenarios |
| Cannot access monitoring or alerting configuration | Record the dimension as NOT_ASSESSED, assign a score of 0, and block production readiness | Escalate to the infrastructure or DevOps team to provide monitoring access or documentation |
| Audit produces contradictory findings across dimensions | Flag the contradiction in the report, request manual review, and assign the lower score | Escalate to the architect or senior developer for resolution before finalizing the audit |

## Evidence Requirements

1. Timestamped audit execution log showing start time, end time, and each dimension evaluation with its duration.
2. Security scan output (dependency vulnerability report, static analysis results, or manual review checklist).
3. Performance measurement data (benchmark results, load test summaries, or baseline metrics from monitoring tools).
4. Screenshots or configuration exports of monitoring dashboards and alerting rules.
5. Backup and disaster recovery procedure documentation with last-tested dates.
6. Operational runbook file paths with last-updated timestamps confirming currency.
7. Cross-reference matrix linking each audit finding to its source evidence and recommended remediation action.
