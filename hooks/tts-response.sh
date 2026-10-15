#!/bin/bash
# Lê a última resposta do assistant no transcript e fala em voz alta via Piper TTS.
PIPER_BIN="$HOME/.local/bin/piper"
PIPER_MODEL="$HOME/.local/share/piper-voices/pt_BR-faber-medium.onnx"
LOCKFILE="/tmp/tts-response.pid"

# Corta qualquer fala anterior ainda em andamento (síntese ou reprodução) antes de começar a nova.
if [ -f "$LOCKFILE" ]; then
  old_pid=$(cat "$LOCKFILE" 2>/dev/null)
  if [ -n "$old_pid" ] && kill -0 "$old_pid" 2>/dev/null; then
    pkill -P "$old_pid" 2>/dev/null
    kill "$old_pid" 2>/dev/null
  fi
fi
echo $$ > "$LOCKFILE"

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

raw="$(mktemp --suffix=.wav)"
trap 'rm -f "$raw"' EXIT
printf '. %s' "$clean" | "$PIPER_BIN" -m "$PIPER_MODEL" --output_file "$raw" 2>/dev/null
aplay "$raw" >/dev/null 2>&1
exit 0
