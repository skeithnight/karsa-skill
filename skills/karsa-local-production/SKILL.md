---
name: karsa-local-production
version: 1.0.0
description: Orchestrates a full local production deployment.
category: operational
owner: karsa-system
requires: [karsa-clone, karsa-install, karsa-config-discovery, karsa-build, karsa-test, karsa-runtime-verify, karsa-browser-verify]
produces:
  - production-readiness-report
triggers:
  - karsa-local-production
---

# karsa-local-production

## Responsibilities
Full local production deployment.

## Workflow
Clone
→ Audit
→ Install
→ Configure
→ Research
→ Build
→ Test
→ Runtime Verify
→ Browser Verify
→ Production Audit
→ Final Verdict

## Inputs
* `repository_url`: URL of the project
* `target_directory`: Directory to deploy

## Outputs
* `production-readiness-report`: Final assessment.

## Execution
This skill acts as an alias wrapper for `karsa-orchestrator` with the local production preset. It drives the actual master orchestrator to run the sequence.
Execution should be driven by `./scripts/execute.sh <repo_url> <target_dir>`
