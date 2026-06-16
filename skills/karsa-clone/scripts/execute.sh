#!/bin/bash
set -e

REPO_URL=$1
TARGET_DIR=$2
BRANCH=${3:-main}

if [ -z "$REPO_URL" ] || [ -z "$TARGET_DIR" ]; then
  echo "Usage: $0 <repo_url> <target_dir> [branch]"
  exit 1
fi

echo "Cloning $REPO_URL into $TARGET_DIR (branch: $BRANCH)..."
if [ ! -d "$TARGET_DIR" ]; then
  git clone -b "$BRANCH" "$REPO_URL" "$TARGET_DIR"
else
  echo "Target directory already exists. Fetching latest..."
  cd "$TARGET_DIR"
  git fetch origin "$BRANCH"
  git checkout "$BRANCH"
  git pull origin "$BRANCH"
fi

cd "$TARGET_DIR"
COMMIT_SHA=$(git rev-parse HEAD)
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Generate evidence
cat <<EOF > clone-evidence.json
{
  "repository_url": "$REPO_URL",
  "commit_sha": "$COMMIT_SHA",
  "branch": "$CURRENT_BRANCH"
}
EOF

echo "Clone complete. Evidence saved to clone-evidence.json."
