---
name: karsa-config-discovery
version: 1.0.0
description: Discovers missing configuration and copies from examples.
category: operational
owner: karsa-system
requires: [karsa-clone]
produces:
  - config-report
triggers:
  - discover config
---

# karsa-config-discovery

## Responsibilities
* Locate environment files
* Detect missing variables
* Compare against examples
* Generate configuration report

## Inputs
* `target_directory`: Directory of the project

## Outputs
* `config-report`: A JSON file documenting evidence of config resolution.

## Evidence Collection
Produces `config-evidence.json` with:
- `env_file_created`
- `missing_vars`

## Script
Execution should be driven by `./scripts/execute.sh <target_dir>`
