---
name: karsa-web-research
version: 1.0.0
description: Resolves missing prerequisites and dependencies via authoritative documentation search.
category: operational
owner: karsa-system
requires: []
produces:
  - research-evidence
triggers:
  - web research
---

# karsa-web-research

## Responsibilities
* Search official documentation
* Resolve missing prerequisites
* Resolve dependency issues
* Resolve runtime requirements

## Rules
* Only use authoritative sources.

## Inputs
* `query`: Issue to research

## Outputs
* `research-evidence`: A JSON file documenting the result of the web research.

## Script
Execution should be driven by `./scripts/execute.sh <query>`
