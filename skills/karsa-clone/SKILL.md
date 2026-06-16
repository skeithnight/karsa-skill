---
name: karsa-clone
version: 1.0.0
description: Clones a repository and verifies its integrity.
category: operational
owner: karsa-system
requires: []
produces:
  - clone-report
triggers:
  - clone repository
---

# karsa-clone

## Responsibilities
* Clone repository
* Verify repository integrity
* Verify branch
* Verify commit
* Verify working tree

## Inputs
* `repository_url`: URL of the repository to clone
* `target_directory`: Path where the repository should be cloned
* `branch`: (Optional) Specific branch to checkout

## Outputs
* `clone-report`: A JSON file documenting evidence of the clone operation.

## Execution Requirements
The skill must be fully automated. When invoked, it checks if the target directory exists, clones the repo, and logs the commit hash and branch.

## Evidence Collection
Produces evidence file `clone-evidence.json` with keys:
- `repository_url`
- `commit_sha`
- `branch`

## Script
Execution should be driven by `./scripts/execute.sh <repo_url> <target_dir> [branch]`
