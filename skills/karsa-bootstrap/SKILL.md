---
name: karsa-bootstrap
version: 1.0.0
description: Bootstraps new projects with standardized structure and configuration
category: bootstrap
owner: skeithnight
requires: []
produces:
  - project-structure
  - initial-config
  - bootstrap-report
triggers:
  - bootstrap project
  - initialize repository
  - scaffold new project
---

# karsa-bootstrap

## Purpose

The karsa-bootstrap skill provides a deterministic, repeatable process for initializing new project repositories with a standardized directory structure, configuration files, and documentation templates. It eliminates the inconsistency that arises when developers manually set up projects, ensuring that every new repository starts with the correct foundation for downstream skills like `karsa-environment-audit`, `karsa-governance-audit`, and `karsa-build` to operate against.

Without a standardized bootstrap process, projects accumulate structural debt from day one — missing CI configurations, inconsistent directory layouts, absent documentation templates, and misconfigured toolchains. This skill detects the project's language ecosystem and framework, then applies the appropriate scaffolding templates, dependency manifests, and configuration presets. It handles polyglot projects by layering configurations for each detected language.

The bootstrap skill also establishes the governance baseline by generating commit message templates, PR templates, branch protection recommendations, and license files. These artifacts serve as the foundation that `karsa-governance-audit` validates against in subsequent workflow phases. The skill produces a comprehensive bootstrap report documenting every decision made and file generated, providing full traceability for audit purposes.

## Execution Workflow

1. **Detect Project Context** — Analyze the target directory to determine if it is an empty directory, an existing repository, or a partially scaffolded project. Identify existing files that should be preserved versus overwritten.

2. **Identify Language and Framework** — Scan for language indicators (file extensions, manifest files like `package.json`, `pom.xml`, `go.mod`, `build.gradle`, `Cargo.toml`, `requirements.txt`). If multiple languages are detected, classify as polyglot and prepare layered scaffolding.

3. **Select Scaffolding Template** — Based on detected language and framework, select the appropriate project template. Decision point: if no language is detected, prompt the operator for the target language/framework or default to a language-agnostic skeleton.

4. **Generate Directory Structure** — Create the canonical directory layout including `src/`, `test/`, `docs/`, `config/`, `.github/`, and any language-specific directories. Preserve existing directories and merge where conflicts arise.

5. **Generate Configuration Files** — Create or update configuration files: `.editorconfig`, `.gitignore`, linter configurations, formatter configurations, and IDE workspace settings. Apply language-specific defaults.

6. **Scaffold CI Pipeline** — Generate CI configuration files (GitHub Actions workflows, Jenkinsfile, or equivalent) with stages for build, test, lint, and deploy. Configure caching strategies appropriate to the detected language ecosystem.

7. **Generate Documentation Templates** — Create `README.md`, `CONTRIBUTING.md`, `CHANGELOG.md`, `LICENSE`, and architecture documentation templates. Pre-populate README sections with project metadata.

8. **Configure Dependency Management** — Initialize the dependency manifest for the detected language, add common development dependencies (linters, formatters, test frameworks), and lock dependency versions where applicable.

9. **Validate Bootstrap Output** — Verify that all generated files are syntactically valid, directory structure matches the expected layout, and no critical files are missing. Run a dry-build if the language toolchain is available.

10. **Generate Bootstrap Report** — Produce a comprehensive report documenting: detected language/framework, files created, files preserved, configuration decisions made, and any warnings or recommendations for manual follow-up.

## Inputs

| Name | Type | Required | Description |
|------|------|----------|-------------|
| project-path | string | Yes | Absolute path to the target directory where the project will be bootstrapped |
| project-name | string | No | Human-readable project name; derived from directory name if omitted |
| language | string | No | Primary language override (e.g., java, typescript, go, python, rust); auto-detected if omitted |
| framework | string | No | Framework override (e.g., spring-boot, nextjs, gin, django); auto-detected if omitted |
| license-type | string | No | SPDX license identifier (e.g., MIT, Apache-2.0); defaults to project-level configuration or MIT |
| ci-platform | string | No | Target CI platform (github-actions, jenkins, gitlab-ci); defaults to github-actions |
| force-overwrite | boolean | No | If true, overwrite existing configuration files; defaults to false (merge mode) |

## Outputs

| Name | Format | Description |
|------|--------|-------------|
| project-structure | Directory | The fully scaffolded project directory with all generated files and directories in place |
| initial-config | JSON | Structured manifest of all configuration files generated, their paths, and the templates used |
| bootstrap-report | Markdown | Comprehensive report documenting all bootstrap decisions, generated artifacts, and follow-up recommendations |
| language-profile | JSON | Detected language and framework metadata including versions, package managers, and toolchain components |

## Success Criteria

1. The bootstrapped project directory contains all required structural directories (`src/`, `test/`, `docs/`, `config/`) and does not have any empty placeholder directories without at least a `.gitkeep` file.
2. All generated configuration files (`.editorconfig`, `.gitignore`, CI pipelines, linter configs) are syntactically valid and appropriate for the detected language ecosystem.
3. The dependency manifest is initialized with the correct package manager format and includes at minimum: a test framework, a linter, and a formatter as development dependencies.
4. Documentation templates (README, CONTRIBUTING, CHANGELOG, LICENSE) are present and pre-populated with project metadata rather than containing raw placeholder tokens.
5. The bootstrap report accurately lists every file created, every configuration decision made, and provides actionable follow-up recommendations.
6. Existing files in the target directory are preserved unless `force-overwrite` is explicitly enabled, and any merge conflicts are logged in the bootstrap report.

## Failure Handling

| Scenario | Action | Escalation |
|----------|--------|------------|
| Target directory is not writable | Verify filesystem permissions; attempt to create the directory if it does not exist; if permissions cannot be resolved, halt with a clear error message | Report the permission error to the operator with the exact path and required permissions |
| Language detection fails (no recognizable indicators) | Fall back to a language-agnostic skeleton that provides basic project structure without language-specific tooling; log a warning in the bootstrap report | Prompt the operator to manually specify the language and framework using input parameters |
| Dependency resolution fails during initialization | Generate the dependency manifest without locking versions; log the resolution failure and include manual resolution steps in the bootstrap report | Recommend that the operator run dependency resolution manually after verifying network access and registry availability |
| CI platform template is unavailable | Generate a generic CI configuration with TODO markers for platform-specific steps; document the gap in the bootstrap report | Notify the operator that manual CI configuration is required for the selected platform |
| File conflict during merge mode | Preserve the existing file, generate the new version with a `.bootstrap` suffix, and log the conflict in the bootstrap report for manual resolution | Include a diff between the existing file and the generated version in the bootstrap report |

## Evidence Requirements

1. A bootstrap report (`bootstrap-report.md`) that documents the complete scaffolding process including language detection results, template selections, files generated, and configuration decisions with their rationale.
2. A structured manifest (`bootstrap-manifest.json`) listing every file and directory created during the bootstrap process, including file paths, template sources, and generation timestamps.
3. A language profile document (`language-profile.json`) capturing the detected language ecosystem, framework, package manager, runtime version requirements, and toolchain components.
4. Git-trackable evidence that all generated files have been staged (or committed) with a standardized bootstrap commit message following the project's commit message convention.
