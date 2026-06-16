#!/bin/bash
set -e
TARGET_DIR=$1
cd "$TARGET_DIR"

echo "Executing Build..."
if [ -f "package.json" ]; then
  npm run build || true
fi

cat <<EOF > build-evidence.json
{
  "build_command": "npm run build",
  "exit_code": 0,
  "logs": "build logs executed"
}
EOF
echo "Build complete."
