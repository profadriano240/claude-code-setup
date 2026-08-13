---
name: maquina-debian-home
description: Hardware e estado de configuração do notebook Debian pessoal do Adriano
metadata: 
  node_type: memory
  type: project
  originSessionId: 2824c6e8-f4b4-4389-a776-3869d680b7c8
  modified: 2026-08-13T21:47:16.802Z
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
pessoal sensível) com `preseed.cfg` + `late-command.sh` para instalar o
Claude Code automaticamente durante uma instalação nova do Debian 13 a
partir do pendrive oficial (sem modificar a ISO) — no boot do instalador,
adicionar `url=https://raw.githubusercontent.com/profadriano240/claude-code-installer/master/preseed.cfg`
na linha de comando. O `late_command` roda no fim da instalação (via
`in-target`) e, sem perguntar nada (100% automático), clona
`claude-code-setup` e restaura tudo — Claude Code (settings/memória/hooks,
inclusive leitura de voz), pacotes apt/pipx, `system/`, `dotfiles/`, GNOME
(agendado pro primeiro login gráfico). Resumo salvo em
`~/Documentos/instalador-claude-code.docx` (desatualizado desde então — se
for retomar, atualizar o docx).

**Atualizado em 2026-08-13 (mesma sessão que a leitura de voz):** o usuário
pediu para eliminar completamente a edição manual da linha de boot também.
Decisão tomada com confirmação explícita do usuário: `claude-code-setup`
**passou de privado para público** (github repo edit --visibility public) —
o README dele já garantia "sem credenciais/tokens", então isso elimina de
vez o mecanismo de `ccs_token` (removido do `late-command.sh`/`preseed.cfg`,
inclusive o prompt "Instalar agora? [S/n]", que virou automático sem
perguntar). Consequência aceita pelo usuário: memória/preferências/hooks
ficam publicamente legíveis por qualquer pessoa (não é credencial, mas é
informação pessoal). Em andamento: remasterizar a ISO oficial do Debian
13.6 netinst (scripts em `claude-code-installer/iso-build/`, usando
`xorriso ... -boot_image any replay` para reaproveitar o boot BIOS+UEFI da
ISO original) para publicar como GitHub Release — assim o usuário só baixa
a ISO pronta e grava no pendrive, sem editar nada no boot.
**Ainda não testado num boot real** (nem a versão anterior com token nem
esta). Recomendado validar antes de gravar num pendrive de verdade.

**Why:** Hardware fraco (RAM/CPU) — relevante para não recomendar ferramentas
pesadas (ex.: evitar várias apps Electron simultâneas) e para preferir
automações que rodam na nuvem (GitHub Actions) em vez de localmente, já que a
máquina não fica ligada o tempo todo. Ver [[projeto-automacoes-whatsapp]].

**How to apply:** `sudo` nesta máquina sempre falha em ferramentas
não-interativas (pede senha, sem TTY) — para qualquer ação que precise de
root, pedir ao usuário para rodar num terminal aberto na tela dele (ou via
prefixo `!` no chat, que também não passa senha). Preferir soluções leves e
gratuitas por padrão.

**Correção (2026-08-13):** o usuário disse por voz/áudio "não rodo sudo, rodo
`r -`" — isso foi mal-entendido (provavelmente erro de transcrição de voz).
Na prática ele digita `su -` (troca pra shell de root) e depois roda os
comandos direto, sem prefixo. Confirmado ao vivo: pedi pra ele rodar
`r - apt install ...` e o `r` expandiu (alias real dele, motivo/origem
desconhecidos) para `rm -f packages.microsoft.gpg`, quase apagando esse
arquivo sem querer — o comando falhou por sorte (erro de opção inválida do
`rm` antes de tocar em arquivos). **Nunca mais sugerir `r -` como
equivalente de sudo.** Ao pedir para o usuário rodar algo como root, pedir
para ele usar `su -` e então colar o comando sem prefixo (ou `sudo`
diretamente, que também funciona quando ele digita a senha interativamente
no terminal dele). Vale sugerir a ele investigar/remover esse alias `r`
perigoso do shell interativo (não achei a definição em `~/.bashrc`,
`~/.bash_aliases`, `~/.profile`, `~/.zshrc` nem em `/etc/bash.bashrc` —
pode estar em dotfiles de root, já que ele estava com `su -` ativo quando
o alias disparou).

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
