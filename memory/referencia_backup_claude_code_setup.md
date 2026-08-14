---
name: referencia-backup-claude-code-setup
description: "Repositório GitHub profadriano240/claude-code-setup guarda backup pessoal da config Claude Code (settings, hooks, memory, dotfiles), sincronizado automaticamente via hooks"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 4648e32c-e38b-4607-8a62-727c268cecb8
  modified: 2026-08-14T15:40:52.359Z
---

Repositório https://github.com/profadriano240/claude-code-setup (branch `master`, público, sem
credenciais/tokens/histórico de conversa) guarda backup da config Claude Code desta máquina
(notebook Debian, Celeron N4020, 3,6GB RAM):

- `config/settings.json`, `config/known_marketplaces.json`
- `memory/` — cópia da pasta de memória de longo prazo (`~/.claude/projects/-home-adriano/memory/`)
- `hooks/sync-config-repo.sh`, `hooks/sync-memory-repo.sh`, `hooks/tts-response.sh`
- `packages/`, `system/`, `desktop/gnome-settings.dconf`, `dotfiles/`
- `restore.sh` — reinstala tudo numa máquina nova

Sync automático via hooks (`PostToolUse`, `ConfigChange`, `SessionStart`) faz commit+push sozinho
a cada escrita de memória ou instalação de pacote — não precisa pedir sync manual.

**Verificado 2026-08-14 (pós-reinício):** pasta local e repo batendo 100% — settings.json,
known_marketplaces.json, dotfiles (bashrc/gitconfig/profile), pacotes apt-manual e os 7 arquivos
de memória, todos iguais. Hooks testados manualmente (`sync-memory-repo.sh`, `sync-config-repo.sh`)
rodam sem erro. Sync bidirecional funcionando como esperado: escrita local → hook → commit+push
automático. Se um dia pasta local e repo divergirem de novo, comparar com
`curl -s https://raw.githubusercontent.com/profadriano240/claude-code-setup/master/memory/<arquivo>`
antes de assumir perda de dado.

**Como usar:** se usuário mencionar "backup", "restore.sh", "claude-code-setup", ou perguntar por
memórias antigas que não batem com o que está local, checar este repo primeiro.
