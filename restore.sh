#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "==> Reinstalando pacotes apt manuais (pede senha sudo)..."
sudo apt-get update
xargs -a packages/apt-manual.txt sudo apt-get install -y

echo "==> Instalando Claude Code (instalador nativo)..."
curl -fsSL https://claude.ai/install.sh | bash

echo "==> Restaurando configurações do Claude Code..."
mkdir -p ~/.claude/plugins
cp config/settings.json ~/.claude/settings.json
cp config/known_marketplaces.json ~/.claude/plugins/known_marketplaces.json

echo "==> Restaurando memória de longo prazo..."
mkdir -p ~/.claude/projects/-home-adriano/memory
cp -r memory/* ~/.claude/projects/-home-adriano/memory/

echo "==> Restaurando hooks de auto-sync (memória e config/packages)..."
mkdir -p ~/.claude/hooks
cp hooks/sync-memory-repo.sh ~/.claude/hooks/sync-memory-repo.sh
cp hooks/sync-config-repo.sh ~/.claude/hooks/sync-config-repo.sh
chmod +x ~/.claude/hooks/sync-memory-repo.sh ~/.claude/hooks/sync-config-repo.sh
if [ "$(pwd)" != "$HOME/claude-code-setup" ]; then
  echo "AVISO: este clone não está em ~/claude-code-setup — o hook de auto-sync"
  echo "        (referenciado em config/settings.json) espera o repo exatamente ali."
  echo "        Mova/reclone para ~/claude-code-setup para o auto-sync funcionar."
fi

echo "==> Concluído. Rode 'claude' e faça login com /login."
