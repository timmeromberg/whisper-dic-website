#!/usr/bin/env bash
# Sync VERSION file → package.json
set -euo pipefail

cd "$(dirname "$0")/.."

VERSION=$(cat VERSION | tr -d '[:space:]')

if [ -z "$VERSION" ]; then
    echo "ERROR: VERSION file is empty" >&2
    exit 1
fi

echo "Syncing version: $VERSION"

# package.json
sed -i '' "s/\"version\": \"[^\"]*\"/\"version\": \"$VERSION\"/" package.json

echo "Done — all files updated to $VERSION"
