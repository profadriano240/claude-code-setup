# Ativação do Claude Code por voz (wake-word) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Daemon permanente que detecta a palavra-chave "Hey Jarvis" em qualquer lugar do desktop e aciona o ditado por voz nativo do Claude Code, mesmo com outra janela em foco.

**Architecture:** Três peças independentes rodando no desktop Ubuntu 24.04/GNOME 46/Wayland do Adriano: (1) daemon Python com `openWakeWord` escutando o microfone via `arecord` em pipe; (2) script bash que ativa a janela do terminal via D-Bus (extensão GNOME `Window Calls`) e simula a tecla espaço via `ydotool`; (3) serviço systemd `--user` que mantém tudo vivo. Nenhum STT/texto é construído — a detecção só aperta a tecla que já abre o ditado nativo do Claude Code (`voice.enabled: true`, `mode: "tap"`, `autoSubmit: true`, já configurado).

**Tech Stack:** Python 3.12 (venv dedicada), `openwakeword` (PyPI), `arecord`/ALSA para captura de áudio bruto, `ydotool`/`ydotoold` (apt) para simular teclado em Wayland, extensão GNOME Shell `Window Calls` (UUID `window-calls@domandoman.xyz`, pk 69219 para shell 46) via D-Bus, `systemd --user`.

## Global Constraints

- Máquina alvo: desktop Ubuntu 24.04, GNOME Shell 46.0, sessão Wayland (confirmado: `XDG_SESSION_TYPE=wayland`).
- Terminal usado: GNOME Terminal 3.52.0 (app Wayland nativo — `wmctrl`/X11 não enxerga essa janela, por isso o D-Bus da extensão é obrigatório).
- Nenhuma conta/API key externa (openWakeWord e Window Calls são 100% locais/gratuitos).
- Spec de referência: `docs/superpowers/specs/2026-10-15-voz-wakeword-design.md` (commit `561bc38`) — não reabrir decisões já tomadas lá.
- Tudo que for criado em `~/.local/bin`, `~/.local/share/wakeword-venv` e `~/.config/systemd/user` também precisa ser copiado para `claude-code-setup/voice/` e commitado (mesma convenção de backup já usada para `hooks/`).

---

### Task 1: Dependências de sistema (ydotool + acesso a /dev/uinput)

**Files:**
- Create: `/etc/udev/rules.d/99-ydotool-uinput.rules`

**Interfaces:**
- Produces: `ydotool`/`ydotoold` instalados e funcionais; usuário `adriano` com permissão de escrita em `/dev/uinput` sem precisar de `sudo` a cada boot.

- [ ] **Step 1: Instalar ydotool e ydotoold via apt**

Run: `sudo apt install -y ydotool`
Expected: pacote `ydotool` (binário cliente) e `ydotoold` (daemon) instalados; `which ydotool ydotoold` retorna os dois caminhos.

- [ ] **Step 2: Criar regra udev pra liberar /dev/uinput pro grupo `input`**

Conteúdo exato do arquivo `/etc/udev/rules.d/99-ydotool-uinput.rules`:

```
KERNEL=="uinput", GROUP="input", MODE="0660"
```

Comando pra criar (exige sudo):
```bash
echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | sudo tee /etc/udev/rules.d/99-ydotool-uinput.rules
sudo udevadm control --reload-rules
sudo udevadm trigger
```

- [ ] **Step 3: Adicionar o usuário ao grupo `input` e recarregar**

```bash
sudo usermod -aG input adriano
```
Expected: depois de um logout/login (ou `newgrp input` numa sessão de teste), `groups` lista `input` e `ls -la /dev/uinput` mostra `crw-rw---- root input`.

- [ ] **Step 4: Rodar ydotoold manualmente e testar um keypress**

```bash
ydotoold &
sleep 1
ydotool type -- " "
```
Expected: sem erro de permissão (`Failed to open uinput device` seria falha). O espaço será digitado em qualquer campo de texto em foco no momento — testar com o cursor num editor de texto aberto pra confirmar visualmente. Matar o processo de teste depois (`kill %1`).

- [ ] **Step 5: Commit da regra udev no backup**

```bash
mkdir -p /home/adriano/claude-code-setup/voice
cp /etc/udev/rules.d/99-ydotool-uinput.rules /home/adriano/claude-code-setup/voice/99-ydotool-uinput.rules
cd /home/adriano/claude-code-setup
git add voice/99-ydotool-uinput.rules
git commit -m "feat(voice): regra udev para acesso ao /dev/uinput (ydotool)"
```

---

### Task 2: Extensão GNOME `Window Calls`

**Files:**
- Create (temporário, local): `/tmp/window-calls.zip`

**Interfaces:**
- Produces: método D-Bus `org.gnome.Shell.Extensions.Windows.List` disponível em `/org/gnome/Shell/Extensions/Windows`, usado pela Task 3.

- [ ] **Step 1: Baixar o pacote da extensão (versão certa pro GNOME Shell 46)**

```bash
curl -sL -o /tmp/window-calls.zip \
  "https://extensions.gnome.org/download-extension/window-calls@domandoman.xyz.shell-extension.zip?version_tag=69219"
file /tmp/window-calls.zip
```
Expected: `Zip archive data` (já testado e confirmado durante o planejamento — arquivo válido com `extension.js` e `metadata.json`).

- [ ] **Step 2: Instalar e habilitar**

```bash
gnome-extensions install --force /tmp/window-calls.zip
gnome-extensions enable window-calls@domandoman.xyz
```
Expected: sem erro. `gnome-extensions list` passa a incluir `window-calls@domandoman.xyz`.

- [ ] **Step 3: Reiniciar a sessão GNOME (checkpoint manual do Adriano)**

Em Wayland não existe "Alt+F2 r" pra recarregar o GNOME Shell — é necessário **logout e login de novo** pra extensão ativar de fato. Esse passo precisa ser feito pelo Adriano manualmente; avisar antes de prosseguir pra Task 3.

- [ ] **Step 4: Verificar que o método D-Bus responde**

```bash
gdbus call --session --dest org.gnome.Shell \
  --object-path /org/gnome/Shell/Extensions/Windows \
  --method org.gnome.Shell.Extensions.Windows.List
```
Expected: uma string JSON com a lista de janelas abertas (cada uma com `wm_class`, `title`, `id` etc). Se der `UnknownMethod` de novo, a extensão não ativou — confirmar no app "Extensões" do GNOME que está "Ativada", e repetir o logout/login.

- [ ] **Step 5: Backup no repo**

```bash
cp /tmp/window-calls.zip /home/adriano/claude-code-setup/voice/window-calls.shell-extension.zip
cd /home/adriano/claude-code-setup
git add voice/window-calls.shell-extension.zip
git commit -m "feat(voice): backup do pacote da extensao GNOME Window Calls"
```

---

### Task 3: Venv + openWakeWord, teste de detecção isolado

**Files:**
- Create: `/home/adriano/.local/share/wakeword-venv/` (venv, não versionado)
- Create: `/home/adriano/.local/bin/wakeword-test.py`

**Interfaces:**
- Produces: confirmação manual de que o microfone + modelo detectam "Hey Jarvis" corretamente antes de automatizar qualquer coisa.

- [ ] **Step 1: Criar a venv e instalar openwakeword**

```bash
python3 -m venv /home/adriano/.local/share/wakeword-venv
/home/adriano/.local/share/wakeword-venv/bin/pip install --upgrade pip
/home/adriano/.local/share/wakeword-venv/bin/pip install openwakeword
```
Expected: instala sem erro (puxa `onnxruntime`, `scipy`, `tqdm` como dependências).

- [ ] **Step 2: Baixar os modelos pré-treinados (precisa de internet, só na primeira vez)**

```bash
/home/adriano/.local/share/wakeword-venv/bin/python3 -c "import openwakeword.utils; openwakeword.utils.download_models()"
```
Expected: baixa os `.onnx` pré-treinados (inclui `hey_jarvis_v0.1.onnx`) pra `~/.local/share/wakeword-venv/lib/python3.12/site-packages/openwakeword/resources/models/` (ou local equivalente reportado no output).

- [ ] **Step 3: Escrever o script de teste isolado**

Criar `/home/adriano/.local/bin/wakeword-test.py`:

```python
#!/usr/bin/env python3
"""Teste manual: escuta o microfone via arecord e imprime quando detecta 'Hey Jarvis'."""
import subprocess
import sys
import numpy as np
from openwakeword.model import Model

CHUNK_SAMPLES = 1280  # 80ms a 16kHz
CHUNK_BYTES = CHUNK_SAMPLES * 2  # int16 = 2 bytes/amostra

def main():
    model = Model(wakeword_models=["hey_jarvis"])
    proc = subprocess.Popen(
        ["arecord", "-f", "S16_LE", "-r", "16000", "-c", "1", "-t", "raw", "-D", "default"],
        stdout=subprocess.PIPE,
    )
    print("Escutando... diga 'Hey Jarvis' (Ctrl+C pra sair)", file=sys.stderr)
    try:
        while True:
            raw = proc.stdout.read(CHUNK_BYTES)
            if len(raw) < CHUNK_BYTES:
                break
            frame = np.frombuffer(raw, dtype=np.int16)
            predictions = model.predict(frame)
            score = predictions.get("hey_jarvis", 0.0)
            if score > 0.5:
                print(f"DETECTADO (score={score:.2f})", flush=True)
    except KeyboardInterrupt:
        pass
    finally:
        proc.terminate()

if __name__ == "__main__":
    main()
```

- [ ] **Step 4: Rodar o teste e confirmar detecção real**

```bash
/home/adriano/.local/share/wakeword-venv/bin/python3 /home/adriano/.local/bin/wakeword-test.py
```
Falar "Hey Jarvis" em voz normal perto do microfone.
Expected: linha `DETECTADO (score=0.NN)` aparece no terminal em até ~1s depois de falar. Testar também falar frases comuns sem a palavra-chave por 30s e confirmar que NÃO aparece `DETECTADO` (falso positivo) — se aparecer muito, anotar e ajustar o limiar (0.5) na Task 4.

- [ ] **Step 5: Parar o teste (Ctrl+C), sem commit ainda** — este script é só de validação manual, a versão final vira o daemon na Task 5.

---

### Task 4: Script de foco + gatilho (`focus-and-trigger.sh`)

**Files:**
- Create: `/home/adriano/.local/bin/focus-and-trigger.sh`

**Interfaces:**
- Consumes: método D-Bus `org.gnome.Shell.Extensions.Windows.List` / `.ActivateWindow` (Task 2); `ydotool type` (Task 1).
- Produces: comando `focus-and-trigger.sh` executável sem argumentos, chamado pela Task 5.

- [ ] **Step 1: Descobrir o shape exato do JSON retornado por `Windows.List`**

```bash
gdbus call --session --dest org.gnome.Shell \
  --object-path /org/gnome/Shell/Extensions/Windows \
  --method org.gnome.Shell.Extensions.Windows.List
```
Anotar o nome exato do campo de classe da janela (`wm_class` ou `wmClass`, varia por versão da extensão) e do campo de id (`id`) — usar esses nomes exatos no `jq` do Step 2. Confirmar olhando a saída real antes de escrever o script (não assumir).

- [ ] **Step 2: Escrever o script**

Criar `/home/adriano/.local/bin/focus-and-trigger.sh`:

```bash
#!/bin/bash
# Acha a janela do GNOME Terminal e ativa ela, depois simula a tecla espaço
# (atalho voice:pushToTalk do Claude Code) pra abrir o ditado por voz.
set -euo pipefail

WINDOWS_JSON=$(gdbus call --session --dest org.gnome.Shell \
  --object-path /org/gnome/Shell/Extensions/Windows \
  --method org.gnome.Shell.Extensions.Windows.List)

# gdbus devolve uma tupla tipo ("[...]",) — extrai só o JSON de dentro.
WINDOWS_JSON=$(echo "$WINDOWS_JSON" | sed -E "s/^\('(.*)',\)$/\1/" | sed 's/\\"/"/g')

# Pega o id da primeira janela cuja classe contenha "gnome-terminal" (case-insensitive).
# Se WAKEWORD_TERMINAL_TITLE estiver definida, filtra por título em vez de classe.
if [ -n "${WAKEWORD_TERMINAL_TITLE:-}" ]; then
  WIN_ID=$(echo "$WINDOWS_JSON" | jq -r --arg t "$WAKEWORD_TERMINAL_TITLE" \
    '[.[] | select(.title | test($t; "i"))][0].id // empty')
else
  WIN_ID=$(echo "$WINDOWS_JSON" | jq -r \
    '[.[] | select(.wm_class // .wmClass // "" | test("gnome-terminal"; "i"))][0].id // empty')
fi

if [ -z "$WIN_ID" ]; then
  echo "focus-and-trigger: nenhuma janela do terminal encontrada" >&2
  exit 1
fi

gdbus call --session --dest org.gnome.Shell \
  --object-path /org/gnome/Shell/Extensions/Windows \
  --method org.gnome.Shell.Extensions.Windows.ActivateWindow "$WIN_ID"

sleep 0.3  # dá tempo da janela ganhar foco antes de mandar a tecla
ydotool type -- " "
```

```bash
chmod +x /home/adriano/.local/bin/focus-and-trigger.sh
```

- [ ] **Step 3: Testar com o terminal do Claude Code minimizado/sem foco**

Minimizar ou trocar de janela (ex: abrir o navegador em foco), depois rodar noutro terminal (ou via SSH/outra aba):
```bash
/home/adriano/.local/bin/focus-and-trigger.sh
```
Expected: a janela do GNOME Terminal com o Claude Code ganha foco na tela e o ditado por voz abre (indicador visual de "ouvindo" no Claude Code). Se der "nenhuma janela encontrada", conferir se o campo usado no `jq` (`wm_class` vs `wmClass`) bate com o que foi anotado no Step 1 e corrigir.

- [ ] **Step 4: Commit**

```bash
cp /home/adriano/.local/bin/focus-and-trigger.sh /home/adriano/claude-code-setup/voice/focus-and-trigger.sh
cd /home/adriano/claude-code-setup
git add voice/focus-and-trigger.sh
git commit -m "feat(voice): script de foco de janela + gatilho do ditado nativo"
```

---

### Task 5: Daemon de wake-word (`wakeword-daemon.py`)

**Files:**
- Create: `/home/adriano/.local/bin/wakeword-daemon.py`

**Interfaces:**
- Consumes: modelo `hey_jarvis` do openWakeWord (Task 3); `focus-and-trigger.sh` (Task 4).
- Produces: processo de longa duração que roda via systemd (Task 6).

- [ ] **Step 1: Escrever o daemon**

Criar `/home/adriano/.local/bin/wakeword-daemon.py` — mesma lógica de captura do `wakeword-test.py` (Task 3), mas: roda pra sempre, chama `focus-and-trigger.sh` na detecção, e tem um "cooldown" de 3s depois de cada disparo pra não reativar em cima da própria fala/eco:

```python
#!/usr/bin/env python3
"""Daemon permanente: escuta 'Hey Jarvis' e aciona o ditado por voz do Claude Code."""
import subprocess
import sys
import time
import numpy as np
from openwakeword.model import Model

CHUNK_SAMPLES = 1280
CHUNK_BYTES = CHUNK_SAMPLES * 2
THRESHOLD = 0.5
COOLDOWN_SECONDS = 3.0
TRIGGER_SCRIPT = "/home/adriano/.local/bin/focus-and-trigger.sh"

def main():
    model = Model(wakeword_models=["hey_jarvis"])
    proc = subprocess.Popen(
        ["arecord", "-f", "S16_LE", "-r", "16000", "-c", "1", "-t", "raw", "-D", "default"],
        stdout=subprocess.PIPE,
    )
    print("wakeword-daemon: escutando 'Hey Jarvis'", file=sys.stderr, flush=True)
    last_trigger = 0.0
    try:
        while True:
            raw = proc.stdout.read(CHUNK_BYTES)
            if len(raw) < CHUNK_BYTES:
                print("wakeword-daemon: arecord parou de produzir audio, saindo", file=sys.stderr)
                break
            frame = np.frombuffer(raw, dtype=np.int16)
            predictions = model.predict(frame)
            score = predictions.get("hey_jarvis", 0.0)
            now = time.monotonic()
            if score > THRESHOLD and (now - last_trigger) > COOLDOWN_SECONDS:
                last_trigger = now
                print(f"wakeword-daemon: detectado (score={score:.2f}), acionando", flush=True)
                subprocess.run([TRIGGER_SCRIPT])
    finally:
        proc.terminate()

if __name__ == "__main__":
    main()
```

- [ ] **Step 2: Rodar manualmente em primeiro plano pra validar o ciclo completo**

```bash
/home/adriano/.local/share/wakeword-venv/bin/python3 /home/adriano/.local/bin/wakeword-daemon.py
```
Com outra janela em foco, falar "Hey Jarvis" e confirmar: o terminal ganha foco, o ditado abre, e falar algo depois é transcrito e enviado (fluxo nativo já testado). Falar de novo antes de 3s e confirmar que NÃO dispara duas vezes (cooldown funcionando).

- [ ] **Step 3: Commit**

```bash
cp /home/adriano/.local/bin/wakeword-daemon.py /home/adriano/claude-code-setup/voice/wakeword-daemon.py
cd /home/adriano/claude-code-setup
git add voice/wakeword-daemon.py
git commit -m "feat(voice): daemon de deteccao de wake-word"
```

---

### Task 6: Serviço systemd `--user`

**Files:**
- Create: `/home/adriano/.config/systemd/user/wakeword.service`

**Interfaces:**
- Consumes: `wakeword-daemon.py` (Task 5) rodando com o Python da venv (Task 3).
- Produces: serviço que inicia sozinho no login e reinicia se cair — fecha o objetivo da spec ("serviço permanente").

- [ ] **Step 1: Criar o arquivo de unit**

Criar `/home/adriano/.config/systemd/user/wakeword.service`:

```ini
[Unit]
Description=Wake-word listener para ativação por voz do Claude Code
After=pipewire.service

[Service]
ExecStart=/home/adriano/.local/share/wakeword-venv/bin/python3 /home/adriano/.local/bin/wakeword-daemon.py
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
```

- [ ] **Step 2: Garantir que o `ydotoold` também inicia sozinho**

`ydotoold` precisa estar rodando pro `ydotool type` funcionar. Criar `/home/adriano/.config/systemd/user/ydotoold.service`:

```ini
[Unit]
Description=ydotoold - daemon de automação de teclado/mouse

[Service]
ExecStart=/usr/bin/ydotoold
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
```

Ajustar `After=` no `wakeword.service` do Step 1 pra incluir `ydotoold.service` também (`After=pipewire.service ydotoold.service`).

- [ ] **Step 3: Habilitar e iniciar os dois serviços**

```bash
systemctl --user daemon-reload
systemctl --user enable --now ydotoold.service
systemctl --user enable --now wakeword.service
systemctl --user status ydotoold.service wakeword.service
```
Expected: ambos `active (running)`, sem restart loop (`systemctl --user status` mostrando `Restart=5` repetido indicaria erro — se isso acontecer, rodar `journalctl --user -u wakeword.service -n 50` pra ver o motivo).

- [ ] **Step 4: Teste de aceitação completo (fecha a spec)**

Reiniciar o desktop (ou pelo menos fazer logout/login) pra confirmar que os serviços sobem sozinhos:
```bash
systemctl --user is-enabled ydotoold.service wakeword.service
```
Expected: `enabled` nos dois. Depois, com o foco em outra janela (ex: navegador), falar "Hey Jarvis" e confirmar: terminal ganha foco → ditado abre → fala é transcrita e enviada automaticamente. Esse é o critério de aceitação definido na spec.

- [ ] **Step 5: Commit final**

```bash
cp /home/adriano/.config/systemd/user/wakeword.service /home/adriano/claude-code-setup/voice/wakeword.service
cp /home/adriano/.config/systemd/user/ydotoold.service /home/adriano/claude-code-setup/voice/ydotoold.service
cd /home/adriano/claude-code-setup
git add voice/wakeword.service voice/ydotoold.service
git commit -m "feat(voice): servicos systemd --user (wakeword + ydotoold)"
```

---

### Task 7: Documentação e memória

**Files:**
- Modify: `/home/adriano/.claude/projects/-home-adriano/memory/referencia_tts_voz.md`
- Create: `/home/adriano/claude-code-setup/voice/README.md`

**Interfaces:** nenhuma — só registro.

- [ ] **Step 1: Escrever `voice/README.md`** explicando o que cada arquivo da pasta é, como reinstalar do zero numa máquina nova (ordem: Task 1 → 2 → 3 → 4 → 5 → 6), e a palavra-chave usada ("Hey Jarvis").

- [ ] **Step 2: Atualizar a memória `referencia_tts_voz.md`** com uma seção nova "Ativação por wake-word" linkando pro `voice/README.md` e resumindo: palavra-chave, serviços systemd, como reiniciar (`systemctl --user restart wakeword.service`), como depurar (`journalctl --user -u wakeword.service -f`).

- [ ] **Step 3: Commit**

```bash
cd /home/adriano/claude-code-setup
git add voice/README.md
git commit -m "docs(voice): README de reinstalacao do wake-word"
```
(a memória sincroniza sozinha pro repo via o hook já existente, não precisa commit manual dela)

---

## Verificação final de cobertura da spec

- Serviço permanente, inicia com o desktop → Task 6.
- Palavra de ativação pronta (não customizada) → Task 3 (`hey_jarvis`, modelo pré-treinado).
- Funciona de qualquer janela, foco automático → Task 2 + Task 4.
- Ativação por palavra-chave, não mic sempre aberto → Task 5 (só dispara acima do limiar, não transcreve nada sozinho — quem transcreve é o ditado nativo já existente).
- Nenhum STT próprio construído → confirmado, só a tecla espaço é simulada (Task 4), o resto é o pipeline nativo já testado.
