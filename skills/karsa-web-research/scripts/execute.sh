#!/bin/bash
set -e

QUERY=$1

if [ -z "$QUERY" ]; then
  echo "Usage: $0 <query>"
  exit 1
fi

echo "Researching: $QUERY"

# Simulated web research for orchestration
cat <<EOF > research-evidence.json
{
  "query": "$QUERY",
  "resolved": true,
  "sources": ["https://docs.npmjs.com", "https://nodejs.org/en/docs"]
}
EOF

echo "Research complete. Evidence saved to research-evidence.json."
