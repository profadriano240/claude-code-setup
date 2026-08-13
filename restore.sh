#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "==> Configurando repositório do VS Code (necessário para o pacote 'code')..."
sudo apt-get install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null
sudo tee /etc/apt/sources.list.d/vscode.sources > /dev/null << 'VSCODE_EOF'
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/microsoft.gpg
VSCODE_EOF

echo "==> Reinstalando pacotes apt manuais (pede senha sudo)..."
sudo apt-get update
# tlp costuma ficar marcado como "automatico" (dependencia), por isso nao
# aparece em apt-manual.txt - garantido explicitamente aqui.
sudo apt-get install -y tlp $(cat packages/apt-manual.txt)

echo "==> Restaurando configurações de sistema (zram, auto-upgrades)..."
sudo cp system/zramswap /etc/default/zramswap
sudo cp system/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades
sudo systemctl enable --now tlp unattended-upgrades zramswap.service 2>/dev/null || true

echo "==> Restaurando dotfiles..."
cp dotfiles/bashrc ~/.bashrc
cp dotfiles/gitconfig ~/.gitconfig
cp dotfiles/profile ~/.profile

if command -v dconf >/dev/null 2>&1 && [ -f desktop/gnome-settings.dconf ]; then
  echo "==> Restaurando configurações do GNOME (dconf)..."
  dconf load / < desktop/gnome-settings.dconf || echo "AVISO: dconf load falhou (sem sessão gráfica ativa?)."
fi

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
