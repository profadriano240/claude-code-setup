#!/usr/bin/env bash
set -uo pipefail

REPO_DIR="$HOME/claude-code-setup"
payload="$(cat)"
event="$(jq -r '.hook_event_name // empty' <<<"$payload")"
tool_name="$(jq -r '.tool_name // empty' <<<"$payload")"

do_sync() {
  mkdir -p "$REPO_DIR/config" "$REPO_DIR/packages" "$REPO_DIR/system" "$REPO_DIR/desktop" "$REPO_DIR/dotfiles"
  cp "$HOME/.claude/settings.json" "$REPO_DIR/config/settings.json" 2>/dev/null
  cp "$HOME/.claude/plugins/known_marketplaces.json" "$REPO_DIR/config/known_marketplaces.json" 2>/dev/null
  LC_ALL=C apt-mark showmanual 2>/dev/null | LC_ALL=C sort > "$REPO_DIR/packages/apt-manual.txt"
  npm ls -g --depth=0 > "$REPO_DIR/packages/npm-global.txt" 2>/dev/null

  cp /etc/default/zramswap "$REPO_DIR/system/zramswap" 2>/dev/null
  cp /etc/apt/apt.conf.d/20auto-upgrades "$REPO_DIR/system/20auto-upgrades" 2>/dev/null

  # dconf precisa de sessao grafica; nao sobrescreve com vazio se falhar (ex.: sessao SSH)
  dump="$(dconf dump / 2>/dev/null)"
  [ -n "$dump" ] && printf '%s\n' "$dump" > "$REPO_DIR/desktop/gnome-settings.dconf"

  cp "$HOME/.bashrc" "$REPO_DIR/dotfiles/bashrc" 2>/dev/null
  cp "$HOME/.gitconfig" "$REPO_DIR/dotfiles/gitconfig" 2>/dev/null
  cp "$HOME/.profile" "$REPO_DIR/dotfiles/profile" 2>/dev/null

  cd "$REPO_DIR" || return 0
  git add config/ packages/ system/ desktop/ dotfiles/
  git diff --cached --quiet && return 0
  git commit -q -m "Auto-sync config/packages/system/desktop/dotfiles ($(date -Iseconds))"
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
