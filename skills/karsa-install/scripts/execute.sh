#!/bin/bash
set -e

TARGET_DIR=$1

if [ -z "$TARGET_DIR" ]; then
  echo "Usage: $0 <target_dir>"
  exit 1
fi

cd "$TARGET_DIR"

PKG_MGR="unknown"
if [ -f "pnpm-lock.yaml" ]; then
  PKG_MGR="pnpm"
  CMD="pnpm install"
elif [ -f "yarn.lock" ]; then
  PKG_MGR="yarn"
  CMD="yarn install"
elif [ -f "package-lock.json" ] || [ -f "package.json" ]; then
  PKG_MGR="npm"
  CMD="npm install"
else
  echo "No package manager detected."
  exit 1
fi

VERSION=$($PKG_MGR --version)
echo "Using $PKG_MGR version $VERSION"

EXIT_CODE=0
$CMD || EXIT_CODE=$?

cat <<EOF > dependency-evidence.json
{
  "package_manager": "$PKG_MGR",
  "version": "$VERSION",
  "exit_code": $EXIT_CODE
}
EOF

if [ $EXIT_CODE -ne 0 ]; then
  echo "Installation failed."
  exit $EXIT_CODE
fi

echo "Installation complete. Evidence saved to dependency-evidence.json."
