#!/bin/bash
set -e

REPO_URL=$1
TARGET_DIR=$2

if [ -z "$REPO_URL" ] || [ -z "$TARGET_DIR" ]; then
  echo "Usage: $0 <repo_url> <target_dir>"
  exit 1
fi

echo "Triggering karsa-orchestrator for karsa-local-production preset..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
ORCHESTRATOR_EXEC="$SCRIPT_DIR/../../karsa-orchestrator/scripts/execute.sh"

if [ -f "$ORCHESTRATOR_EXEC" ]; then
  $ORCHESTRATOR_EXEC "$REPO_URL" "$TARGET_DIR"
else
  echo "Orchestrator executable not found at $ORCHESTRATOR_EXEC"
  exit 1
fi

echo "karsa-local-production complete."
