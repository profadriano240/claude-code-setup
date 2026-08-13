#!/usr/bin/env bash
set -euo pipefail

MEMORY_DIR="$HOME/.claude/projects/-home-adriano/memory"
REPO_DIR="$HOME/claude-code-setup"

file_path="$(jq -r '.tool_input.file_path // .tool_response.filePath // empty')"

case "$file_path" in
  "$MEMORY_DIR"/*) ;;
  *) exit 0 ;;
esac

cp -r "$MEMORY_DIR/." "$REPO_DIR/memory/"
cd "$REPO_DIR"
git add memory/
git diff --cached --quiet && exit 0
git commit -q -m "Auto-sync memória ($(date -Iseconds))"
git push -q
