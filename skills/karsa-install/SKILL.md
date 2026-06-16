---
name: karsa-install
version: 1.0.0
description: Detects package manager and installs dependencies.
category: operational
owner: karsa-system
requires: [karsa-clone]
produces:
  - dependency-report
triggers:
  - install dependencies
---

# karsa-install

## Responsibilities
* Detect package manager (npm, yarn, pnpm)
* Install dependencies
* Verify lockfiles
* Verify installation success

## Inputs
* `target_directory`: Directory of the project

## Outputs
* `dependency-report`: A JSON file documenting evidence of the install operation.

## Evidence Collection
Produces `dependency-evidence.json` with:
- `package_manager`
- `version`
- `exit_code`

## Script
Execution should be driven by `./scripts/execute.sh <target_dir>`
