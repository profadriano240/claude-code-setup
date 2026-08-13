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
# tlp e alsa-utils costumam ficar marcados como "automatico" (dependencia),
# por isso nao aparecem em apt-manual.txt - garantidos explicitamente aqui.
# alsa-utils (aplay) e necessario para o hook de leitura de respostas em voz alta.
sudo apt-get install -y tlp alsa-utils $(cat packages/apt-manual.txt)

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

echo "==> Restaurando hooks (auto-sync, leitura de respostas em voz alta, etc.)..."
mkdir -p ~/.claude/hooks
cp hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
if [ "$(pwd)" != "$HOME/claude-code-setup" ]; then
  echo "AVISO: este clone não está em ~/claude-code-setup — o hook de auto-sync"
  echo "        (referenciado em config/settings.json) espera o repo exatamente ali."
  echo "        Mova/reclone para ~/claude-code-setup para o auto-sync funcionar."
fi

if [ -s packages/pipx-list.txt ]; then
  echo "==> Reinstalando pacotes pipx ($(tr '\n' ' ' < packages/pipx-list.txt))..."
  while read -r pkg; do
    [ -n "$pkg" ] && pipx install "$pkg"
  done < packages/pipx-list.txt
fi

if command -v piper >/dev/null 2>&1 || [ -x "$HOME/.local/bin/piper" ]; then
  echo "==> Baixando modelo de voz pt_BR (Piper TTS) para leitura das respostas..."
  mkdir -p ~/.local/share/piper-voices
  PIPER_VENV="$HOME/.local/share/pipx/venvs/piper-tts"
  if [ -x "$PIPER_VENV/bin/python" ]; then
    "$PIPER_VENV/bin/python" -m piper.download_voices \
      --download-dir ~/.local/share/piper-voices pt_BR-faber-medium || \
      echo "AVISO: falha ao baixar o modelo de voz (sem internet?). Rode depois manualmente."
  fi
fi

echo "==> Concluído. Rode 'claude' e faça login com /login."
echo "    Leitura de respostas em voz alta (Piper TTS) já configurada via hook Stop."
