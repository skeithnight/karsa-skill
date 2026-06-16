---
name: karsa-test
version: 1.0.0
description: Executes test suites and evaluates code coverage
category: test
owner: skeithnight
requires: [karsa-build]
produces: [test-results, coverage-report, test-gap-analysis]
triggers: [run tests, execute test suite, evaluate coverage]
---

# Test

## Purpose
Runs unit tests, integration tests, and end-to-end tests. Evaluates code coverage, identifies uncovered code paths, generates test reports, and validates that coverage thresholds are met.

## Execution Workflow
1. Discover test files.
2. Execute test runner.
3. Calculate code coverage.
4. Compare against thresholds.
5. Generate reports.

## Inputs
| Name | Type | Required | Description |
|------|------|----------|-------------|
| Source | Dir | Yes | Source and test code |

## Outputs
| Name | Format | Description |
|------|--------|-------------|
| test-results | XML/JSON | JUnit format results |
| coverage-report | LCOV | Coverage metrics |

## Success Criteria
1. 100% pass rate.
2. Coverage > threshold.
3. No flaky tests detected.

## Failure Handling
| Scenario | Action | Escalation |
|----------|--------|------------|
| Test fails | Capture stack trace | Return to dev loop |
| Low coverage | Reject PR | Author adds tests |

## Evidence Requirements
1. CI Test Report
2. Code Coverage Badge/Report
