---
name: maquina-debian-home
description: Hardware e estado de configuração do notebook Debian pessoal do Adriano
metadata: 
  node_type: memory
  type: project
  originSessionId: 2824c6e8-f4b4-4389-a776-3869d680b7c8
  modified: 2026-08-14T17:52:07.494Z
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

Concluído em 2026-08-13: ISO remasterizada do Debian 13.6.0 (amd64 netinst)
publicada como GitHub Release em
https://github.com/profadriano240/claude-code-installer/releases/tag/debian-13.6.0-v1
(940 MB, asset `claude-code-debian-13.6.0-amd64.iso` + `.sha256`). Objetivo:
gravar num pendrive e instalar sem editar nada na tela de boot — o
`late_command` (que instala Claude Code + toda a config pessoal) já dispara
sozinho. Gerada por `claude-code-installer/iso-build/remaster.sh` (script
versionado no repo, ISO em si fica só como asset de Release, não no git —
`.gitignore` cobre isso). Duas armadilhas encontradas e corrigidas ao gerar:
(1) a entrada realmente padrão do menu isolinux é `gtk.cfg`
("Graphical install", flag `menu default`), não `txt.cfg` — o script precisa
editar todos os `isolinux/*.cfg`, não só um; (2) remapear só uma *parte* da
árvore (`-map dir /caminho` ou `-boot_image any keep/replay`) sobre a ISO
original corrompe a estrutura híbrida (perde a flag isohybrid, cabeçalho de
backup do GPT fica inconsistente) porque desloca `boot/grub/efi.img` da LBA
exata que o MBR/GPT/APM hardcodeiam — a solução robusta é extrair a ISO
inteira, editar os `.cfg`, e reconstruir do zero com
`xorriso -as mkisofs` usando os parâmetros de boot exatos obtidos via
`xorriso -indev <iso> -report_el_torito as_mkisofs` (não usar `-boot_image
... keep/replay` pra esse caso). ISO cresce de ~755MB pra ~940MB nesse
processo (extração via `-osirrox on` não preserva hardlinks internos do
ISO9660 original) — não é um problema funcional, só estético.

Validação feita: conteúdo dos `.cfg` editados confirmado (contém
`url=.../preseed.cfg`); estrutura de boot (isohybrid/GPT/El Torito)
verificada sem avisos via `xorriso -report_system_area`; boot real testado
via QEMU (kernel+initrd extraídos da ISO, `-append` simulando o parâmetro
injetado, sem KVM porque o usuário não está no grupo `kvm`) — kernel bootou,
recebeu o parâmetro `url=` corretamente, e o instalador chegou até a tela
"Select a language" (esperado, já que o preseed só configura o
`late_command`, sem automatizar idioma/partição/usuário). Não foi possível
(nem necessário) simular o `late_command` rodando de fato sem clicar
manualmente por toda a instalação.

**Decisão importante desta sessão:** `claude-code-setup` passou de privado
pra público (confirmado explicitamente pelo usuário) especificamente pra
viabilizar isso — sem token, o boot pode ser 100% automático e a ISO fica
válida pra sempre (não expira). Ver bloco acima sobre a remoção do
`ccs_token`.

**Preferência de comunicação (2026-08-13):** durante uploads/tarefas longas
em background, o usuário pediu primeiro progresso em tempo real, depois
mudou de ideia e pediu silêncio total até a conclusão ("não precisa mais me
informar o progresso"). Lição: para "avise só quando terminar", usar espera
de notificação única (`Bash` com `run_in_background` + loop `until`), não o
`Monitor` (que notifica a cada linha/iteração — bom só quando o pedido é
acompanhamento contínuo). Também pediu (mensagem separada) que eu sempre
"fale" nas respostas — já coberto pelo hook `Stop` de leitura em voz alta,
que dispara em toda resposta automaticamente, nada adicional necessário.

**Conflito de git resolvido (2026-08-14):** os hooks `sync-config-repo.sh` e
`sync-memory-repo.sh` sempre usam o caminho fixo `$HOME/claude-code-setup`
(confirmado por grep no código dos dois) — não existe clone separado por
sessão, é o mesmo diretório físico no disco pra qualquer sessão do Claude
Code nesta máquina. Mesmo assim, duas sessões rodando em paralelo (~12h20 e
~14h47) geraram commits de auto-sync divergentes (a segunda não tinha o
fetch da primeira), e o push foi rejeitado. Rebase resolveu automaticamente
a maioria dos arquivos, mas `packages/apt-manual.txt` deu conflito de
verdade porque as duas sessões capturaram `apt-mark showmanual` em momentos
diferentes.

**Como resolvi:** em vez de mesclar as duas listas manualmente (arriscado —
reintroduziria pacotes já removidos entre as duas capturas), regenerei o
arquivo direto do estado real atual da máquina (`apt-mark showmanual`), que
é exatamente o que o hook faz normalmente. Validado depois: `bash -n
restore.sh` (sintaxe OK) e conferência de que o arquivo não tinha sobrado
marcador de conflito nem linha em branco — `restore.sh` consome esse
arquivo via `$(cat packages/apt-manual.txt)` (word-split simples, funciona
porque nomes de pacote não têm espaço).

**Why:** arquivos gerados automaticamente a partir do estado real do
sistema (listas de pacotes, `dconf dump`, etc.) não devem ser resolvidos
por merge textual em caso de conflito — a fonte de verdade é sempre
"regerar do estado atual", não "unir os dois lados". A própria lista em
conflito já estava suspeita (tinha `ubuntu-desktop-minimal`,
`libreoffice26.2-*` — pacotes que não fazem sentido pra este Debian
minimal), então regenerar também corrigiu uma captura ruim anterior.

**How to apply:** se aparecer um conflito de git em `claude-code-setup`
de novo (comum quando duas sessões auto-sincronizam em paralelo), preferir
sempre regenerar o arquivo gerado (pacotes apt/npm/pipx, `dconf dump`,
etc.) a partir do comando de origem, em vez de editar manualmente os
marcadores `<<<<<<<`/`=======`/`>>>>>>>`. Atenção: comandos como
`apt-mark showmanual` batem no filtro `*apt-mark*` do hook
`PostToolUse`/Bash em `sync-config-repo.sh` — rodar esse comando dentro de
uma sessão já dispara um novo auto-commit/push sozinho.
