#!/bin/bash
TARGET_DIR=$1
FINDINGS_FILE="$TARGET_DIR/.karsa/findings.json"
STATE_FILE="$TARGET_DIR/.karsa/workflow-state.json"

cd "$TARGET_DIR"

echo "Executing Production Audit..."

OPEN_FINDINGS=0
CLOSED_FINDINGS=0

if [ -f "$FINDINGS_FILE" ]; then
  OPEN_FINDINGS=$(grep -c '"status": "OPEN"' "$FINDINGS_FILE" || true)
  CLOSED_FINDINGS=$(grep -c '"status": "CLOSED"' "$FINDINGS_FILE" || true)
fi

IS_BLOCKED=0
if [ -f "$STATE_FILE" ]; then
  IS_BLOCKED=$(grep -c '"status": "BLOCKED"' "$STATE_FILE" || true)
fi

DECISION="PRODUCTION_READY"

if [ $IS_BLOCKED -gt 0 ]; then
  DECISION="BLOCKED"
elif [ $OPEN_FINDINGS -gt 0 ]; then
  DECISION="REMEDIATION_REQUIRED"
elif [ $CLOSED_FINDINGS -gt 0 ]; then
  DECISION="COMPLIANT_WITH_FINDINGS"
fi

cat <<EOF > production-evidence.json
{
  "final_readiness_assessment": "$DECISION",
  "audit_passed": $(if [ "$DECISION" = "PRODUCTION_READY" ] || [ "$DECISION" = "COMPLIANT_WITH_FINDINGS" ]; then echo "true"; else echo "false"; fi),
  "metrics": {
    "open_findings": $OPEN_FINDINGS,
    "closed_findings": $CLOSED_FINDINGS
  }
}
EOF
echo "Production Audit complete. Decision: $DECISION"

if [ "$DECISION" = "BLOCKED" ] || [ "$DECISION" = "REMEDIATION_REQUIRED" ]; then
  exit 1
fi
exit 0
