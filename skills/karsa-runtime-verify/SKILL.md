---
name: karsa-runtime-verify
version: 1.0.0
description: Verifies runtime behavior including startup, health checks, and integration points
category: verify
owner: skeithnight
requires: [karsa-build, karsa-test]
produces: [runtime-report, health-check-results, integration-status]
triggers: [verify runtime, check health, validate startup]
---

# Runtime Verify

## Purpose
Validates that the application starts correctly, health endpoints respond, integrations connect, and runtime behavior matches expectations. Covers smoke testing, health verification, and runtime diagnostics.

## Execution Workflow
1. Start application in sandbox.
2. Poll health endpoints.
3. Simulate integration calls.
4. Capture telemetry.
5. Shut down safely.

## Inputs
| Name | Type | Required | Description |
|------|------|----------|-------------|
| Artifacts | Binary | Yes | Built application |
| Env_Vars | File | No | Configuration |

## Outputs
| Name | Format | Description |
|------|--------|-------------|
| runtime-report | Markdown | Boot sequence logs |

## Success Criteria
1. App boots without errors.
2. Endpoints return 200 OK.
3. Integrations succeed.

## Failure Handling
| Scenario | Action | Escalation |
|----------|--------|------------|
| Crash on boot | Collect dumps | Investigate code |
| DB timeout | Verify network | Infrastructure team |

## Evidence Requirements
1. Runtime log snapshot
2. Health check response payload
