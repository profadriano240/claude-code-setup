#!/usr/bin/env bash
set -uo pipefail

REPO_DIR="$HOME/claude-code-setup"
MEMORY_DIR="$HOME/.claude/projects/-home-adriano/memory"

cd "$REPO_DIR" || exit 0
git pull -q --ff-only 2>/dev/null || exit 0

mkdir -p "$MEMORY_DIR"
cp -r "$REPO_DIR/memory/." "$MEMORY_DIR/" 2>/dev/null
