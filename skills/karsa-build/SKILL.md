---
name: karsa-build
version: 1.0.0
description: Manages build processes including compilation, bundling, and artifact generation
category: build
owner: skeithnight
requires: [karsa-environment-audit]
produces: [build-artifacts, build-report, dependency-tree]
triggers: [build project, compile code, generate artifacts]
---

# Build

## Purpose
Handles the build pipeline: dependency resolution, compilation, asset bundling, artifact generation, and build verification. Supports incremental builds, caching strategies, and build failure diagnosis.

## Execution Workflow
1. Resolve dependencies.
2. Compile source code.
3. Bundle assets.
4. Verify build success.
5. Package artifacts.

## Inputs
| Name | Type | Required | Description |
|------|------|----------|-------------|
| Source | Dir | Yes | Project code |
| Config | File | No | Custom build script |

## Outputs
| Name | Format | Description |
|------|--------|-------------|
| build-artifacts | Binary | Executables/packages |
| build-report | Markdown | Build times and sizes |

## Success Criteria
1. Compilation successful.
2. Artifacts generated.
3. No critical warnings.

## Failure Handling
| Scenario | Action | Escalation |
|----------|--------|------------|
| Dependency failure | Clear cache & retry | Alert dev |
| Compile error | Capture logs | Dev fixes code |

## Evidence Requirements
1. Build logs
2. Artifact checksums
