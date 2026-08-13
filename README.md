# claude-code-setup

Backup pessoal da configuração do [Claude Code](https://claude.com/claude-code) usada por
Adriano no notebook Debian (Celeron N4020, 3,6 GB RAM). Objetivo: numa reinstalação
futura (ou máquina nova), restaurar o Claude Code já configurado do jeito que é usado hoje,
sem começar do zero.

**Não contém credenciais, tokens ou histórico de conversas** — apenas configuração e
memória de longo prazo (arquivos de texto sem segredos).

## Conteúdo

- `config/settings.json` — configurações do Claude Code (idioma, tema, modo de voz, hooks).
- `config/known_marketplaces.json` — marketplaces de plugins instaladas.
- `memory/` — memória de longo prazo do Claude Code (`~/.claude/projects/-home-adriano/memory/`):
  preferências do usuário, contexto de projetos e feedback acumulado.
- `hooks/sync-memory-repo.sh` — script do hook `PostToolUse` que mantém `memory/` sincronizada.
- `packages/apt-manual.txt` — pacotes apt instalados manualmente (`apt-mark showmanual`).
- `packages/npm-global.txt` — pacotes npm globais.
- `packages/pip-user.txt` / `packages/pipx.txt` — pacotes Python (vazios no snapshot atual).
- `restore.sh` — script de restauração.

## Como restaurar numa máquina nova

```bash
git clone https://github.com/profadriano240/claude-code-setup.git
cd claude-code-setup
./restore.sh
```

**Importante:** clone exatamente em `~/claude-code-setup` (como no comando acima, rodado a
partir do `$HOME`) — o hook de auto-sync (abaixo) espera o repositório nesse caminho.

O script:
1. Reinstala os pacotes apt listados em `packages/apt-manual.txt` (pede sudo interativo).
2. Instala o Claude Code via instalador nativo (`curl -fsSL https://claude.ai/install.sh | bash`).
3. Copia `config/settings.json` e `config/known_marketplaces.json` para `~/.claude/`.
4. Copia `memory/` para `~/.claude/projects/-home-adriano/memory/`.
5. Copia `hooks/sync-memory-repo.sh` para `~/.claude/hooks/`.

Depois disso, faça login (`claude` → `/login`) e gere uma nova chave SSH se necessário —
essas partes são intencionalmente manuais por envolverem segredos.

## Auto-sync da memória

Um hook `PostToolUse` (matcher `Write|Edit`), configurado em `config/settings.json` e
restaurado por `restore.sh`, roda `hooks/sync-memory-repo.sh` sempre que o Claude Code
escreve num arquivo de memória. O script copia `~/.claude/projects/-home-adriano/memory/`
para este repositório (clonado em `~/claude-code-setup`) e faz `commit`+`push` automático
quando há mudança. Ou seja, `memory/` neste repositório fica sempre atualizada sozinha —
não precisa pedir para sincronizar manualmente.

## Atualizar o backup

`memory/` sincroniza sozinha (ver acima). Para `config/` e `packages/` (que mudam com
menos frequência — configurações gerais, pacotes instalados), peça para o Claude Code
regenerar esses arquivos e commitar quando fizer sentido.
