---
name: karsa-browser-verify
version: 1.0.0
description: Verifies UI routes and features via browser.
category: operational
owner: karsa-system
requires: [karsa-runtime-verify]
produces:
  - browser-verification-report
triggers:
  - verify browser
---

# karsa-browser-verify

## Responsibilities
Verify:
* homepage
* dashboard
* navigation
* search
* thesis pages
* runtime errors

## Inputs
* `target_url`: The base URL of the running application.

## Outputs
* `browser-verification-report`: A JSON file documenting evidence of route validation.

## Evidence Collection
Produces `browser-evidence.json` with:
- `route_validation`
- `screenshots` (paths or skipped)
- `console_errors`

## Script
Execution should be driven by `./scripts/execute.sh <target_url>`
