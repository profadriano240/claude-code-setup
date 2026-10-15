#!/bin/bash
# Lê a última resposta do assistant no transcript e fala em voz alta via Piper TTS.
PIPER_BIN="$HOME/.local/bin/piper"
PIPER_MODEL="$HOME/.local/share/piper-voices/pt_BR-faber-medium.onnx"

input=$(cat)
text=$(echo "$input" | jq -r '.last_assistant_message // empty')

[ -z "$text" ] && exit 0

clean=$(echo "$text" | sed -E '
  s/```[a-zA-Z]*//g;
  s/`//g;
  s/\*\*//g;
  s/\*//g;
  s/^#+ //g;
  s/\[([^]]+)\]\([^)]+\)/\1/g
')

[ -x "$PIPER_BIN" ] && [ -f "$PIPER_MODEL" ] || exit 0
echo "$clean" | "$PIPER_BIN" -m "$PIPER_MODEL" --output-raw 2>/dev/null | aplay -r 22050 -f S16_LE -t raw - >/dev/null 2>&1
exit 0
