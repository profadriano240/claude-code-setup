---
name: maquina-debian-home
description: Hardware e estado de configuração do notebook Debian pessoal do Adriano
metadata: 
  node_type: memory
  type: project
  originSessionId: 2824c6e8-f4b4-4389-a776-3869d680b7c8
  modified: 2026-08-12T19:37:53.292Z
---

Notebook pessoal do Adriano: Debian 13 (trixie), instalação limpa feita em
2026-08-11. Hardware modesto — Intel Celeron N4020 (2 núcleos), 3,6 GB RAM,
SSD NVMe 128 GB, GNOME, locale pt_BR, fuso America/Sao_Paulo.

Estado no fim da sessão de 2026-08-12: git, VS Code, Node/npm, pip/pipx, gh CLI
e zram-tools instalados e configurados; tlp e unattended-upgrades ativos;
chave SSH ed25519 gerada em `~/.ssh/id_ed25519`. Ainda pendentes: backup
automático (deja-dup instalado mas sem destino configurado) e confirmação do
`ufw` (precisa de senha sudo interativa, que não é possível fornecer via
ferramenta não-interativa).

Intenção manifestada em 2026-08-12: criar um repositório no GitHub pessoal do
Adriano com uma cópia/backup das configurações do Claude Code e do estado de
tudo que foi instalado nesta máquina, para que uma reinstalação futura não
precise partir do zero (ao final da instalação, já viria configurado como
está hoje). Ainda não criado — só a intenção registrada até o momento; sem
nome de repositório definido.

**Why:** Hardware fraco (RAM/CPU) — relevante para não recomendar ferramentas
pesadas (ex.: evitar várias apps Electron simultâneas) e para preferir
automações que rodam na nuvem (GitHub Actions) em vez de localmente, já que a
máquina não fica ligada o tempo todo. Ver [[projeto-automacoes-whatsapp]].

**How to apply:** `sudo` nesta máquina sempre falha em ferramentas
não-interativas (pede senha, sem TTY) — para qualquer ação que precise de
root, pedir ao usuário para rodar num terminal aberto na tela dele (ou via
prefixo `!` no chat, que também não passa senha). Preferir soluções leves e
gratuitas por padrão.
