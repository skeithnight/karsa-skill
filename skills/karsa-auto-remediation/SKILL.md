---
name: karsa-auto-remediation
description: "Autonomously inspect failures, generate fixes, and apply them"
---

# Karsa Auto Remediation
This skill serves as the remediation worker for the orchestrator. It receives a finding ID, inspects the failure output, generates a patch, applies it, and signals readiness for revalidation.
