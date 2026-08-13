---
name: maquina-debian-home
description: Hardware e estado de configuração do notebook Debian pessoal do Adriano
metadata: 
  node_type: memory
  type: project
  originSessionId: 2824c6e8-f4b4-4389-a776-3869d680b7c8
  modified: 2026-08-13T14:32:30.215Z
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

Criado em 2026-08-12: repositório privado
https://github.com/profadriano240/claude-code-setup com backup das
configurações do Claude Code (`settings.json`, marketplaces de plugins),
toda a memória de longo prazo e listas de pacotes (apt manual, npm global),
mais `restore.sh` para reinstalação rápida numa máquina nova. Não contém
credenciais, tokens, `.claude.json` nem histórico de conversas — só
configuração e memória, de propósito, por segurança. Login e chave SSH
continuam manuais na restauração.

**Why:** o usuário quer que uma reinstalação futura do Claude Code já venha
configurada como está hoje, sem partir do zero.

**How to apply:** ao gerar novas memórias ou mudar `settings.json`/plugins
relevantes, oferecer atualizar esse repositório (regenerar `config/`,
`memory/`, `packages/` e commitar/push).

**Why:** Hardware fraco (RAM/CPU) — relevante para não recomendar ferramentas
pesadas (ex.: evitar várias apps Electron simultâneas) e para preferir
automações que rodam na nuvem (GitHub Actions) em vez de localmente, já que a
máquina não fica ligada o tempo todo. Ver [[projeto-automacoes-whatsapp]].

**How to apply:** `sudo` nesta máquina sempre falha em ferramentas
não-interativas (pede senha, sem TTY) — para qualquer ação que precise de
root, pedir ao usuário para rodar num terminal aberto na tela dele (ou via
prefixo `!` no chat, que também não passa senha). Preferir soluções leves e
gratuitas por padrão.
