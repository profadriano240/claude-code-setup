---
name: referencia-tts-voz
description: "TTS automático de saída DESLIGADO (2026-10-15, pedido do usuário); ditado por voz (tap) continua ligado"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 6592ff61-e8d0-46d3-95cf-03480da371b4
  modified: 2026-10-15T18:02:38.445Z
---

**DESLIGADO em 2026-10-15** — usuário pediu pra parar ("acabo de ouvir você"). Hook `Stop` removido de `~/.claude/settings.json` (era o bloco que rodava `tts-response.sh`). Script `~/.claude/hooks/tts-response.sh` continua no disco, só não é mais chamado. Ditado por voz (entrada, `voice.mode: tap`) NÃO foi mexido, continua ligado. Pra reativar: adicionar de volta o bloco `"Stop"` em settings.json chamando `tts-response.sh` (ver git history do repo claude-code-setup ou histórico desta sessão).

Ligado em 2026-10-15 a pedido do usuário ("quero poder só falar com você, sem precisar digitar toda vez, fluido como conversa real").

**TTS automático (saída de voz):** hook `Stop` em `~/.claude/settings.json` roda `~/.claude/hooks/tts-response.sh` (`async: true`, não trava a resposta) toda vez que o assistente termina de responder. Usa Piper TTS (`~/.local/bin/piper`, modelo `pt_BR-faber-medium.onnx`) + `aplay` pelas caixas de som do desktop (placa `ALC1220 Analog`, via pipewire-pulse).

**Bug corrigido 2026-10-15:** a versão original do script tentava extrair o texto reparseando o arquivo de transcript inteiro (`.transcript_path` + jq complexo filtrando `type==assistant`), e sempre retornava vazio — o evento Stop já manda o campo pronto `.last_assistant_message` direto no JSON do stdin. Script agora só usa `jq -r '.last_assistant_message // empty'`. Script simplificado em `~/.claude/hooks/tts-response.sh` (e já sincronizado pro backup em `~/claude-code-setup/hooks/tts-response.sh`, ver [[referencia_backup_claude_code_setup]]).

**Ditado por voz (entrada):** `voice.enabled: true`, `mode: "tap"`, `autoSubmit: true` no settings.json — toca uma vez pra começar a falar, toca de novo e já envia. Não existe modo 100% sem teclado/toque no Claude Code atual.

**Ativação por wake-word (PAUSADA em 2026-10-15):** projeto de falar com o Claude Code sem tocar teclado, ativado por "Hey Jarvis" de qualquer lugar do desktop. Spec e plano aprovados e commitados em `claude-code-setup` (`docs/superpowers/specs/2026-10-15-voz-wakeword-design.md`, `docs/superpowers/plans/2026-10-15-voz-wakeword.md`). Execução começou (Task 1 do plano) mas o usuário pediu pra pausar tudo e ficar em standby — **não retomar sozinho, só se o usuário pedir explicitamente**. Estado exato onde parou: comandos sudo da Task 1 (instalar ydotool, regra udev, grupo input) foram passados pro usuário rodar manualmente em `~/comandos-sudo-wakeword.txt`, não há confirmação de que ele rodou. Tasks 2-7 do plano nem começaram. Ao retomar: ler o plano, conferir se os comandos sudo já foram rodados (`which ydotool`, `groups` deve ter `input`), seguir da Task 1 Step 4 em diante.

**Como depurar se parar de funcionar:** trocar temporariamente o comando do hook por algo que salve o stdin bruto em arquivo (`cat >> /tmp/algumlog.log`), forçar o Stop disparar (terminar uma resposta), conferir o log. Mudança em `settings.json` só é recarregada pela sessão ativa depois de `/hooks` ou reiniciar — não é instantânea.

**Bug corrigido 2026-10-15 (2º, mesma sessão) — cortava a 1ª palavra:** não era problema de ALSA/dispositivo frio (padding de silêncio com `ffmpeg -af adelay` não resolveu). É o Piper cortando o ataque do primeiro fonema na própria síntese. Fix: prefixar o texto com `". "` (ponto+espaço) descartável antes de mandar pro Piper (`printf '. %s' "$clean" | piper ...`) — o corte cai nesse ponto sacrificial, não na palavra real. `ffmpeg` não é mais necessário no script, só `piper` + `aplay` num arquivo wav temporário (evita também a corrida de stream direto que existia antes).
