---
name: referencia-tts-voz
description: "TTS automático (Piper, voz pt-BR) lê toda resposta em voz alta via hook de Stop; ditado por voz (tap) também ligado"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 6592ff61-e8d0-46d3-95cf-03480da371b4
  modified: 2026-10-15T17:04:57.508Z
---

Ligado em 2026-10-15 a pedido do usuário ("quero poder só falar com você, sem precisar digitar toda vez, fluido como conversa real").

**TTS automático (saída de voz):** hook `Stop` em `~/.claude/settings.json` roda `~/.claude/hooks/tts-response.sh` (`async: true`, não trava a resposta) toda vez que o assistente termina de responder. Usa Piper TTS (`~/.local/bin/piper`, modelo `pt_BR-faber-medium.onnx`) + `aplay` pelas caixas de som do desktop (placa `ALC1220 Analog`, via pipewire-pulse).

**Bug corrigido 2026-10-15:** a versão original do script tentava extrair o texto reparseando o arquivo de transcript inteiro (`.transcript_path` + jq complexo filtrando `type==assistant`), e sempre retornava vazio — o evento Stop já manda o campo pronto `.last_assistant_message` direto no JSON do stdin. Script agora só usa `jq -r '.last_assistant_message // empty'`. Script simplificado em `~/.claude/hooks/tts-response.sh` (e já sincronizado pro backup em `~/claude-code-setup/hooks/tts-response.sh`, ver [[referencia_backup_claude_code_setup]]).

**Ditado por voz (entrada):** `voice.enabled: true`, `mode: "tap"`, `autoSubmit: true` no settings.json — toca uma vez pra começar a falar, toca de novo e já envia. Não existe modo 100% sem teclado/toque no Claude Code atual.

**Como depurar se parar de funcionar:** trocar temporariamente o comando do hook por algo que salve o stdin bruto em arquivo (`cat >> /tmp/algumlog.log`), forçar o Stop disparar (terminar uma resposta), conferir o log. Mudança em `settings.json` só é recarregada pela sessão ativa depois de `/hooks` ou reiniciar — não é instantânea.

**Bug corrigido 2026-10-15 (2º, mesma sessão) — cortava a 1ª palavra:** não era problema de ALSA/dispositivo frio (padding de silêncio com `ffmpeg -af adelay` não resolveu). É o Piper cortando o ataque do primeiro fonema na própria síntese. Fix: prefixar o texto com `". "` (ponto+espaço) descartável antes de mandar pro Piper (`printf '. %s' "$clean" | piper ...`) — o corte cai nesse ponto sacrificial, não na palavra real. `ffmpeg` não é mais necessário no script, só `piper` + `aplay` num arquivo wav temporário (evita também a corrida de stream direto que existia antes).
