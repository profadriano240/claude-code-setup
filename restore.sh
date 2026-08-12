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

echo "==> Concluído. Rode 'claude' e faça login com /login."
