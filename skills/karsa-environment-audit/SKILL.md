---
name: karsa-environment-audit
version: 1.0.0
description: Audits development environment configuration and dependencies
category: audit
owner: skeithnight
requires:
  - karsa-bootstrap
produces:
  - environment-report
  - dependency-matrix
  - compatibility-assessment
triggers:
  - audit environment
  - verify setup
  - check development environment
---

# karsa-environment-audit

## Purpose

The karsa-environment-audit skill systematically verifies that the development environment meets all requirements for a project to build, test, and run successfully. Environment misconfiguration is one of the most common sources of "works on my machine" failures, CI/CD pipeline breakages, and wasted developer time. This skill eliminates guesswork by programmatically validating every environmental dependency before any build or test work begins.

This skill inspects runtime versions (Node.js, Java, Python, Go, Rust), required CLI tools (Docker, kubectl, terraform), environment variables, network connectivity to registries and APIs, filesystem permissions, and operating system compatibility. It produces a structured dependency matrix that maps each project requirement to the current environment's capability, flagging mismatches with severity levels.

The environment audit serves as a prerequisite gate for `karsa-build` and `karsa-test`. By catching environment issues early — before compilation or test execution — it prevents cryptic build failures and reduces the debugging surface area. The skill is designed to run both locally on developer machines and in CI environments, producing consistent reports regardless of execution context. Its outputs feed directly into the `karsa-orchestrator` workflow as evidence for the AUDIT phase gate check.

## Execution Workflow

1. **Load Project Requirements** — Parse the project's dependency manifests (`package.json`, `pom.xml`, `go.mod`, `requirements.txt`, `Cargo.toml`, etc.) and any explicit environment requirement files (`.tool-versions`, `.nvmrc`, `.python-version`, `Dockerfile`) to build a requirements checklist.

2. **Audit Runtime Versions** — For each required runtime (language interpreters, compilers, virtual machines), verify that the correct version is installed and accessible on the system PATH. Compare installed versions against required version ranges using semantic versioning rules.

3. **Audit CLI Tool Availability** — Check that all required command-line tools are installed and executable. This includes build tools (make, gradle, maven, npm, cargo), container tools (docker, podman), infrastructure tools (terraform, kubectl), and version control (git). Verify minimum version requirements where specified.

4. **Audit Environment Variables** — Validate that all required environment variables are set and contain syntactically valid values. Check for common misconfigurations such as trailing whitespace, incorrect URL formats, or expired credential tokens. Mask sensitive values in reports.

5. **Audit Network Connectivity** — Test connectivity to package registries (npm, Maven Central, PyPI, crates.io), container registries (Docker Hub, ECR, GCR), and project-specific API endpoints. Measure response times and flag slow or unreachable endpoints. Decision point: if running in an air-gapped environment, skip network checks and note the limitation.

6. **Audit Filesystem State** — Verify that required directories exist and are writable, disk space meets minimum thresholds, and file watchers or inode limits are sufficient for the project size. Check for stale lock files or corrupted caches that could affect builds.

7. **Build Dependency Matrix** — Construct a structured matrix mapping each project requirement to the environment's current state: requirement name, required version/value, actual version/value, status (pass/fail/warning), and severity level.

8. **Assess Compatibility** — Analyze the dependency matrix holistically to determine overall environment compatibility. Identify transitive conflicts (e.g., two tools requiring incompatible shared library versions) and generate a compatibility score.

9. **Generate Environment Report** — Produce a comprehensive Markdown report summarizing all findings, organized by category (runtimes, tools, environment variables, network, filesystem). Include remediation instructions for each failed check.

10. **Emit Gate Signal** — Based on the audit results, emit a pass/fail/warn signal that the `karsa-orchestrator` uses for gate evaluation. Critical failures block progression; warnings are logged but do not block.

## Inputs

| Name | Type | Required | Description |
|------|------|----------|-------------|
| project-path | string | Yes | Absolute path to the project repository root directory |
| environment-type | string | No | Execution context identifier: local, ci, container, remote; defaults to auto-detection |
| skip-network-checks | boolean | No | If true, skip all network connectivity tests; useful for air-gapped environments; defaults to false |
| custom-requirements | object | No | Additional tool/version requirements not captured in standard manifest files |
| severity-threshold | string | No | Minimum severity level that blocks the audit gate: critical, high, medium, low; defaults to high |
| timeout-seconds | integer | No | Maximum time in seconds for network connectivity checks per endpoint; defaults to 10 |

## Outputs

| Name | Format | Description |
|------|--------|-------------|
| environment-report | Markdown | Comprehensive audit report with findings organized by category, severity, and remediation steps |
| dependency-matrix | JSON | Structured matrix mapping every project requirement to the environment's actual state with pass/fail status |
| compatibility-assessment | JSON | Holistic compatibility evaluation including overall score, blocking issues, and transitive conflict analysis |
| gate-signal | string | Pass, fail, or warn signal consumed by the karsa-orchestrator for phase gate evaluation |

## Success Criteria

1. Every runtime version requirement specified in the project manifests is validated against the installed version, and the comparison uses correct semantic versioning range evaluation (not just string equality).
2. The dependency matrix contains an entry for every detectable project requirement with no gaps or "unknown" status entries for requirements that can be programmatically verified.
3. All critical and high-severity findings include actionable remediation instructions with specific commands or configuration changes the operator can execute.
4. Network connectivity tests complete within the configured timeout and correctly distinguish between unreachable endpoints, authentication failures, and slow responses.
5. The environment report is generated even when failures are detected, ensuring that partial results are not lost and all findings are captured for the operator.
6. Sensitive values (API keys, tokens, passwords) discovered in environment variables are masked in all output artifacts using consistent redaction patterns.

## Failure Handling

| Scenario | Action | Escalation |
|----------|--------|------------|
| Project manifest file is missing or unparseable | Report the specific manifest that could not be parsed; attempt to infer requirements from other indicators (Dockerfile, CI config); log the gap in the environment report | Block the audit gate and notify the operator that the project may not have been properly bootstrapped; recommend running `karsa-bootstrap` |
| Runtime version is installed but outside the required range | Log the version mismatch with the required range and installed version; provide the exact install/upgrade command for the operator's platform | If the mismatch is for the primary language runtime, classify as critical severity and block the gate |
| Environment variable contains an invalid or expired credential | Detect the format violation (e.g., expired JWT, malformed URL) and report it as a high-severity finding; do not log the actual credential value | Recommend credential rotation and provide links to the relevant credential management documentation |
| Network connectivity test times out | Record the timeout with the endpoint URL and response time; classify based on endpoint criticality (package registry = critical, optional API = warning) | If a package registry is unreachable, recommend verifying proxy settings, VPN connectivity, or registry status pages |
| Audit process itself crashes mid-execution | Capture the stack trace, preserve any partial results that have been collected, and write a partial environment report with a clear indication of where the audit was interrupted | Report the crash to the operator with the error details and recommend re-running the audit after resolving the underlying issue |

## Evidence Requirements

1. A complete environment report (`environment-report.md`) documenting every check performed, its result, and remediation guidance for any failures, stored in the `docs/audit/` directory.
2. A machine-readable dependency matrix (`dependency-matrix.json`) that can be consumed by downstream skills and CI systems for automated gate evaluation.
3. A compatibility assessment (`compatibility-assessment.json`) providing the overall environment compatibility score, a list of blocking issues, and identified transitive dependency conflicts.
4. Timestamped execution metadata including the audit start time, end time, environment type detected, and the list of manifest files that were parsed during requirements loading.
