#!/usr/bin/env bash
# Builds smart-suggestion from a pinned upstream commit with enable-thinking.patch
# applied, into the directory zsh/.config/zsh/smart-suggestion.zsh loads it from.
set -euo pipefail

REV=741a74f9e0491ae1a7b9a3beb14f03fefa9a12b3
DEST="$HOME/.config/smart-suggestion"
PATCH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/enable-thinking.patch"

command -v go >/dev/null || { echo "go is required" >&2; exit 1; }

src=$(mktemp -d)
trap 'rm -rf "$src"' EXIT

git clone -q https://github.com/yetone/smart-suggestion "$src"
git -C "$src" checkout -q "$REV"
git -C "$src" apply "$PATCH"
go -C "$src" build -o smart-suggestion ./cmd/smart-suggestion

mkdir -p "$DEST"
cp "$src/smart-suggestion" "$src/smart-suggestion.plugin.zsh" "$DEST/"
echo "installed into $DEST"
