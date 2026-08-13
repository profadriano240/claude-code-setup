---
name: maquina-debian-home
description: Hardware e estado de configuração do notebook Debian pessoal do Adriano
metadata: 
  node_type: memory
  type: project
  originSessionId: 2824c6e8-f4b4-4389-a776-3869d680b7c8
  modified: 2026-08-13T21:15:37.457Z
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

Criado em 2026-08-13: hook `PostToolUse` (matcher `Write|Edit`) em
`~/.claude/settings.json`, rodando `~/.claude/hooks/sync-memory-repo.sh`.
Sempre que um arquivo em `~/.claude/projects/-home-adriano/memory/` é escrito,
o script copia a pasta inteira para `~/claude-code-setup/memory/` (clone local
persistente do repo, fora do scratchpad) e faz commit+push automático se
houver diferença.

`config/`, `packages/`, `system/`, `desktop/` e `dotfiles/` também sincronizam
sozinhos agora, via `~/.claude/hooks/sync-config-repo.sh`, disparado por três
hooks: `ConfigChange` (qualquer mudança em `settings.json`, por qualquer via),
`PostToolUse`/`Bash` (filtra internamente por comandos de instalação/remoção
de pacotes) e `SessionStart` (rede de segurança, ex.: `known_marketplaces.json`
atualizado sozinho pelo Claude Code). `system/` = `/etc/default/zramswap` +
`/etc/apt/apt.conf.d/20auto-upgrades`; `desktop/` = `dconf dump /` (config do
GNOME, sem senhas/tokens); `dotfiles/` = `.bashrc`/`.gitconfig`/`.profile`.
`tlp.conf` e extensões/config do VS Code ficaram de fora de propósito (o
primeiro é 100% default, o segundo estava vazio na captura). Ou seja, o
repositório `claude-code-setup` inteiro fica sempre atualizado sem pedir.

Criado em 2026-08-13: repositório público
https://github.com/profadriano240/claude-code-installer (sem nenhum dado
pessoal) com `preseed.cfg` + `late-command.sh` para instalar o Claude Code
automaticamente durante uma instalação nova do Debian 13 a partir do pendrive
oficial (sem modificar a ISO) — no boot do instalador, adicionar
`url=https://raw.githubusercontent.com/profadriano240/claude-code-installer/master/preseed.cfg ccs_token=<TOKEN>`
na linha de comando. O `late_command` roda no fim da instalação (via
`in-target`), pergunta (com timeout de 20s, padrão sim) se deve instalar, e
se um `ccs_token` (fine-grained PAT, read-only, escopo só no repo
`claude-code-setup`, expiração curta) foi passado, clona o repositório
privado e restaura tudo — não só o Claude Code (settings/memória/hooks), mas
também: repositório apt do VS Code + todos os pacotes de
`packages/apt-manual.txt` (+ `tlp` explicitamente, que fica marcado como
"automático" e por isso não entra nessa lista), `system/` (zram,
auto-upgrades, com os serviços habilitados), `dotfiles/`, e a config do GNOME
(`desktop/gnome-settings.dconf`) — essa última não dá pra aplicar dentro do
`late_command` (sem sessão gráfica/dbus no chroot), então fica agendada via
autostart para o primeiro login gráfico, e se autodestrói depois de rodar.
Sem token, instala só o binário do Claude Code. O token nunca é gravado em
nenhum arquivo/repositório, só lido de `/proc/cmdline` durante a instalação;
o `README.md` desse repositório instrui a revogar o token logo após o uso.
**Ainda não testado num boot real** (só validado sintaticamente) — pendente
validar numa VM antes de gravar num pendrive de verdade. Resumo salvo em
`~/Documentos/instalador-claude-code.docx` a pedido do usuário (docx
desatualizado desde a extensão para pacotes/system/desktop/dotfiles — se for
retomar, atualizar o docx também), que indicou que vamos retomar esse
teste/validação numa sessão futura.

**Why:** Hardware fraco (RAM/CPU) — relevante para não recomendar ferramentas
pesadas (ex.: evitar várias apps Electron simultâneas) e para preferir
automações que rodam na nuvem (GitHub Actions) em vez de localmente, já que a
máquina não fica ligada o tempo todo. Ver [[projeto-automacoes-whatsapp]].

**How to apply:** `sudo` nesta máquina sempre falha em ferramentas
não-interativas (pede senha, sem TTY) — para qualquer ação que precise de
root, pedir ao usuário para rodar num terminal aberto na tela dele (ou via
prefixo `!` no chat, que também não passa senha). Preferir soluções leves e
gratuitas por padrão.

Nesta máquina o usuário não digita `sudo` diretamente — o comando que ele usa
no dia a dia é `r -` (alias/wrapper próprio). Ao sugerir comandos com
privilégio de root para ele copiar e colar, considerar mencionar `r -` como
alternativa ao `sudo` explícito, já que é o que ele realmente usa no
terminal.

Criado em 2026-08-13: leitura das respostas do Claude em voz alta, via hook
`Stop` (`~/.claude/hooks/tts-response.sh`, `async: true`) configurado em
`~/.claude/settings.json`. O script extrai o texto da última resposta do
assistant do `transcript_path` recebido no stdin, limpa marcações markdown
básicas e sintetiza com **Piper TTS** (voz neural `pt_BR-faber-medium`,
instalada via `pipx install piper-tts`, modelo em
`~/.local/share/piper-voices/`), tocando com `aplay` (pacote `alsa-utils`).
Testamos primeiro `espeak-ng` (robótico demais, rejeitado pelo usuário) antes
de trocar para o Piper (aprovado — "ficou bem melhor").

**Why:** usuário pediu uma forma de ouvir as respostas em voz alta, já que
está acostumado a interagir por voz (ver `voiceEnabled`/`voice.mode: hold` já
existentes em `settings.json`, que são para ditado de entrada, não leitura de
saída — funcionalidade complementar e distinta).

**How to apply:** se o usuário pedir para desativar/pausar a leitura em voz
alta, remover ou comentar o hook `Stop` em `settings.json` (não precisa
desinstalar Piper/alsa-utils). Se pedir para trocar a voz, há outros modelos
`pt_BR-*` em https://github.com/rhasspy/piper — basta baixar com
`python -m piper.download_voices` e trocar o caminho `PIPER_MODEL` no script.

Todo o setup (hook, pacote pipx, instruções de reinstalação do modelo de voz)
já foi propagado para os repositórios `claude-code-setup` (auto-sync captura
`hooks/*.sh` e `packages/pipx-list.txt` automaticamente agora — o script de
sync foi generalizado para copiar qualquer `.sh` novo em `~/.claude/hooks/`,
não só os dois hooks de auto-sync originais) e `claude-code-installer`
(`late-command.sh` atualizado para reinstalar pacotes pipx e baixar o modelo
de voz no primeiro boot). O modelo de voz (~60 MB, binário) não é versionado
no git — é sempre baixado de novo pelo `restore.sh`/`late-command.sh`.
