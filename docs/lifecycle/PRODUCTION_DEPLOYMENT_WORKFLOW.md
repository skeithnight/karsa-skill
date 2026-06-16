# Production Deployment Workflow

## Overview
Deploying a Karsa application to local production is now a fully automated operational sequence using the `karsa-local-production` skill.

## Triggering the Deployment

To trigger a deployment, run the `karsa-local-production` execution script with the target repository and destination path:

```bash
./skills/karsa-local-production/scripts/execute.sh <repo_url> <target_dir>
```

## Internal Execution
The `karsa-local-production` script delegates to `karsa-orchestrator`.
The orchestrator walks through:
- **Environment Setup**: Cloning, installing dependencies, config discovery.
- **Verification**: Building, testing, runtime checks, and browser UI tests.
- **Audit**: Production readiness assessment.

## Evidence
For every step, an evidence artifact (e.g. `clone-evidence.json`, `build-evidence.json`) is deposited in the `target_dir`. The final outcome is summarized in `final-deployment-summary.json`.

## Handling Failures
If a step fails (for example, missing a critical dependency), the orchestrator exits with a non-zero status. Upon fixing the issue, re-running the command will resume execution from the failed step.
