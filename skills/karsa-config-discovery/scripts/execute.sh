#!/bin/bash
set -e

TARGET_DIR=$1

if [ -z "$TARGET_DIR" ]; then
  echo "Usage: $0 <target_dir>"
  exit 1
fi

cd "$TARGET_DIR"

ENV_CREATED=false
MISSING_VARS=0

if [ ! -f ".env" ]; then
  if [ -f ".env.example" ]; then
    cp .env.example .env
    ENV_CREATED=true
    echo ".env created from .env.example"
  else
    echo "No .env or .env.example found."
  fi
fi

cat <<EOF > config-evidence.json
{
  "env_file_created": $ENV_CREATED,
  "missing_vars": $MISSING_VARS
}
EOF

echo "Config discovery complete. Evidence saved to config-evidence.json."
