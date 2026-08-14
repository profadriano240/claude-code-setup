---
name: referencia-backup-claude-code-setup
description: "Repositório GitHub profadriano240/claude-code-setup guarda backup pessoal da config Claude Code (settings, hooks, memory, dotfiles), sincronizado automaticamente via hooks"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 4648e32c-e38b-4607-8a62-727c268cecb8
  modified: 2026-08-14T15:16:57.537Z
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

**Nota (2026-08-14):** pasta local `~/.claude/projects/-home-adriano/memory/` está vazia, mas repo
tem 5 arquivos de memória (whatsapp, máquina debian, economia tokens, SEDUC diário, SEDUC notas).
Se usuário perguntar por essas memórias e elas não aparecerem localmente, provável causa: máquina
nova ainda não rodou `restore.sh`, ou pasta local foi limpa. Conteúdo recuperável do repo via
`curl -s https://raw.githubusercontent.com/profadriano240/claude-code-setup/master/memory/<arquivo>`.

**Como usar:** se usuário mencionar "backup", "restore.sh", "claude-code-setup", ou perguntar por
memórias antigas que não batem com o que está local, checar este repo primeiro.
