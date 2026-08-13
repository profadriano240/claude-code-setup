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
- `memory/` — memória de longo prazo do Claude Code (`~/.claude/projects/$(echo $HOME | sed 's,/,-,g')/memory/`):
  preferências do usuário, contexto de projetos e feedback acumulado.
- `hooks/sync-memory-repo.sh` — script do hook `PostToolUse` que mantém `memory/` sincronizada.
- `hooks/sync-config-repo.sh` — script dos hooks `ConfigChange`/`SessionStart`/`PostToolUse(Bash)`
  que mantém `config/`, `packages/` e `hooks/` sincronizados (inclusive copiando qualquer novo
  script de hook criado em `~/.claude/hooks/` para este repositório).
- `hooks/tts-response.sh` — script do hook `Stop` que lê a última resposta do Claude em voz alta
  (ver seção "Leitura de respostas em voz alta" abaixo).
- `packages/apt-manual.txt` — pacotes apt instalados manualmente (`apt-mark showmanual`).
- `packages/npm-global.txt` — pacotes npm globais.
- `packages/pipx-list.txt` — pacotes pipx instalados (ex.: `piper-tts`, usado na leitura de
  respostas em voz alta).
- `system/zramswap` — config do zram (`/etc/default/zramswap`).
- `system/20auto-upgrades` — habilita atualizações automáticas (`/etc/apt/apt.conf.d/20auto-upgrades`).
- `desktop/gnome-settings.dconf` — configurações do GNOME (`dconf dump /`): teclado, touchpad,
  atalhos customizados, terminal, notificações etc. Sem senhas/tokens (Wi-Fi e afins ficam no
  keyring do sistema, não no dconf).
- `dotfiles/bashrc`, `dotfiles/gitconfig`, `dotfiles/profile` — cópias de `~/.bashrc`,
  `~/.gitconfig`, `~/.profile`.
- `restore.sh` — script de restauração.

**Não incluído de propósito:** `tlp.conf` (fica 100% no valor padrão do pacote, nada para
restaurar) e extensões/configurações do VS Code (nenhuma instalada no momento da captura).

## Como restaurar numa máquina nova

```bash
git clone https://github.com/profadriano240/claude-code-setup.git
cd claude-code-setup
./restore.sh
```

**Importante:** clone exatamente em `~/claude-code-setup` (como no comando acima, rodado a
partir do `$HOME`) — o hook de auto-sync (abaixo) espera o repositório nesse caminho.

O script:
1. Reinstala os pacotes apt listados em `packages/apt-manual.txt`, mais `tlp` e `alsa-utils`
   explicitamente (pede sudo interativo).
2. Instala o Claude Code via instalador nativo (`curl -fsSL https://claude.ai/install.sh | bash`).
3. Copia `config/settings.json` e `config/known_marketplaces.json` para `~/.claude/`.
4. Copia `memory/` para `~/.claude/projects/$(echo $HOME | sed 's,/,-,g')/memory/`.
5. Copia todos os scripts de `hooks/*.sh` para `~/.claude/hooks/`.
6. Reinstala os pacotes pipx listados em `packages/pipx-list.txt` (ex.: `piper-tts`).
7. Baixa o modelo de voz pt_BR (`pt_BR-faber-medium`) do Piper TTS para
   `~/.local/share/piper-voices/`.

Depois disso, faça login (`claude` → `/login`) e gere uma nova chave SSH se necessário —
essas partes são intencionalmente manuais por envolverem segredos.

## Auto-sync da memória

Um hook `PostToolUse` (matcher `Write|Edit`), configurado em `config/settings.json` e
restaurado por `restore.sh`, roda `hooks/sync-memory-repo.sh` sempre que o Claude Code
escreve num arquivo de memória. O script copia `~/.claude/projects/$(echo $HOME | sed 's,/,-,g')/memory/`
para este repositório (clonado em `~/claude-code-setup`) e faz `commit`+`push` automático
quando há mudança. Ou seja, `memory/` neste repositório fica sempre atualizada sozinha —
não precisa pedir para sincronizar manualmente.

## Auto-sync de config/, packages/, system/, desktop/ e dotfiles/

Três hooks, configurados em `config/settings.json` e restaurados por `restore.sh`, rodam
`hooks/sync-config-repo.sh`:

- **`ConfigChange`** — dispara sempre que `~/.claude/settings.json` muda, por qualquer via
  (edição direta, `/config`, etc.). Sincroniza na hora.
- **`PostToolUse` (matcher `Bash`)** — dispara a cada comando bash; o script filtra
  internamente por comandos de instalação/remoção (`apt-get install`, `apt-mark`,
  `npm install -g`, `pip install --user`, `pipx install`, etc.) e só sincroniza quando bate.
- **`SessionStart`** — roda no início de cada sessão, como rede de segurança para capturar
  mudanças que não passam pelos outros dois gatilhos (ex.: `known_marketplaces.json`
  atualizado automaticamente pelo próprio Claude Code na inicialização).

Em todos os casos, o script só faz `commit`+`push` se realmente houver diferença em relação
ao que já está no repositório.

## Leitura de respostas em voz alta

Um hook `Stop`, configurado em `config/settings.json`, roda `hooks/tts-response.sh` toda vez
que o Claude termina de responder (em background, via `async: true`, sem travar o chat). O
script:

1. Lê o `transcript_path` recebido no stdin do hook.
2. Extrai o texto da última mensagem do assistant no transcript (JSONL) com `jq`.
3. Remove marcações markdown básicas (`**`, `` ` ``, `#`, links).
4. Sintetiza o áudio com o [Piper TTS](https://github.com/rhasspy/piper) (voz neural
   `pt_BR-faber-medium`, instalado via `pipx install piper-tts`) e toca com `aplay` (pacote
   `alsa-utils`).

Dependências: pacote apt `alsa-utils`, pacote pipx `piper-tts` (`packages/pipx-list.txt`) e o
modelo de voz em `~/.local/share/piper-voices/pt_BR-faber-medium.{onnx,onnx.json}` (baixado
pelo `restore.sh`, não versionado no git por ser um binário de ~60 MB — é regenerável a
qualquer momento com `python -m piper.download_voices`).

## Atualizar o backup

`memory/`, `config/` e `packages/` sincronizam sozinhos (ver acima) — não precisa pedir
manualmente.
