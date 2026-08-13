#!/usr/bin/env bash
set -uo pipefail

REPO_DIR="$HOME/claude-code-setup"
payload="$(cat)"
event="$(jq -r '.hook_event_name // empty' <<<"$payload")"
tool_name="$(jq -r '.tool_name // empty' <<<"$payload")"

do_sync() {
  mkdir -p "$REPO_DIR/config" "$REPO_DIR/packages"
  cp "$HOME/.claude/settings.json" "$REPO_DIR/config/settings.json" 2>/dev/null
  cp "$HOME/.claude/plugins/known_marketplaces.json" "$REPO_DIR/config/known_marketplaces.json" 2>/dev/null
  LC_ALL=C apt-mark showmanual 2>/dev/null | LC_ALL=C sort > "$REPO_DIR/packages/apt-manual.txt"
  npm ls -g --depth=0 > "$REPO_DIR/packages/npm-global.txt" 2>/dev/null

  cd "$REPO_DIR" || return 0
  git add config/ packages/
  git diff --cached --quiet && return 0
  git commit -q -m "Auto-sync config/packages ($(date -Iseconds))"
  git push -q
}

case "$event" in
  ConfigChange|SessionStart)
    do_sync
    ;;
  PostToolUse)
    if [ "$tool_name" = "Bash" ]; then
      cmd="$(jq -r '.tool_input.command // empty' <<<"$payload")"
      case "$cmd" in
        *apt-get\ install*|*apt\ install*|*apt-get\ remove*|*apt-get\ purge*|*apt\ remove*|*apt-mark*|*npm\ install\ -g*|*npm\ i\ -g*|*npm\ uninstall\ -g*|*npm\ rm\ -g*|*pip\ install*--user*|*pipx\ install*|*pipx\ uninstall*)
          do_sync
          ;;
      esac
    fi
    ;;
esac
