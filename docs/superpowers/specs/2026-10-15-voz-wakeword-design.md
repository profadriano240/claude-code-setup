# Ativação do Claude Code por voz (wake-word) — Design

**Status:** aprovado pelo usuário em 2026-10-15, pronto pra virar plano de implementação.

## Objetivo

Adriano quer falar com o Claude Code (nesta máquina, desktop Ubuntu) sem precisar tocar teclado/mouse. Já existe ditado por voz nativo no Claude Code (`voice.enabled: true`, `mode: "tap"`, tecla `space` no contexto `Chat`), mas ele exige 1 toque pra ativar. O que falta é a ativação por palavra-chave ("wake-word"), funcionando de qualquer lugar do desktop (não só com o terminal em foco).

## Decisões (via brainstorming com o usuário)

- **Escopo:** serviço permanente, inicia com o desktop, sobrevive a reinício, funciona em qualquer sessão futura do Claude Code.
- **Palavra de ativação:** uma já pronta/treinada (ex: "jarvis"), não precisa ser "Claude" — evita treinar modelo customizado.
- **Alcance:** funciona de qualquer janela do desktop; o sistema troca o foco pra janela do Claude Code sozinho ao detectar a palavra-chave (não exige o terminal já estar em foco).
- **Modo de escuta:** ativação por palavra-chave, não microfone sempre aberto transcrevendo tudo (decisão de privacidade/confiabilidade do usuário).

## Arquitetura

Três componentes independentes:

1. **`wakeword-daemon`** (Python) — roda `openWakeWord` continuamente sobre o microfone (`alsa_input...analog-stereo`, PipeWire), 100% local, sem conta/API key. Ao detectar a palavra-chave, invoca o componente 2.
2. **`focus-and-trigger.sh`** (bash) — ativa a janela do terminal certo via D-Bus (extensão GNOME `Window Calls`) e simula a tecla `space` (ação `voice:pushToTalk`) via `ydotool`.
3. **`wakeword.service`** (systemd `--user`) — mantém o daemon vivo, reinicia em crash, inicia no login.

## Fluxo de dados

```
microfone → openWakeWord (detecção local) → focus-and-trigger.sh
  → D-Bus/Window Calls (ativa janela) → ydotool (tecla space)
  → ditado nativo do Claude Code assume (STT + auto-envio, já testado e funcionando)
```

Nenhum STT novo é construído — o pipeline de voz nativo já ligado (`referencia_tts_voz` na memória) faz a transcrição e o envio.

## Identificação da janela certa

`Window Calls` lista janelas por título/classe via D-Bus. Abordagem: título fixo e reconhecível na aba/janela do terminal usada para o Claude Code (perfil dedicado no GNOME Terminal, ou o usuário nomeia a aba). Se só houver 1 terminal com `class=gnome-terminal-server` normalmente, usar essa como fallback direto. Múltiplos terminais simultâneos exigem a marcação por título.

## Dependências a instalar/configurar

- `openWakeWord` (Python, pip install local, sem conta).
- Extensão GNOME `Window Calls` (extensions.gnome.org) — pré-requisito manual do usuário, sem ela o foco automático não funciona.
- `ydotool` + `ydotoold` rodando com acesso a `/dev/uinput` (usuário no grupo `input` ou regra udev).

## Erros e casos de borda

- **Falso positivo do wake-word:** pior caso é um toque de espaço "perdido" se o foco não for o Chat do Claude Code — sem efeito colateral grave.
- **`Window Calls` ausente:** foco automático falha silenciosamente; preciso avisar o usuário antes de finalizar se a extensão não estiver instalada.
- **`ydotoold` sem permissão:** script de foco falha ao simular tecla; checar grupo `input`/regra udev na instalação.
- **Múltiplos terminais abertos:** sem marcação de título, pode focar o terminal errado — documentar a convenção de nomear a aba.

## Teste de aceitação

Com o foco em outra janela (ex: navegador), falar a palavra-chave e confirmar que: (1) o terminal do Claude Code ganha foco, (2) o ditado por voz abre, (3) falar algo resulta no texto sendo enviado automaticamente (como já acontece hoje com `autoSubmit: true`).

## Fora de escopo

- Microfone sempre aberto / transcrição contínua sem palavra-chave (descartado por privacidade/confiabilidade).
- Pipeline de STT próprio (Abordagem B do brainstorming, ver histórico da conversa) — só reconsiderar se o atalho `voice:pushToTalk` nativo mudar ou se `ydotool`/`Window Calls` se mostrarem inviáveis na prática.
- Palavra de ativação customizada "Claude" (exigiria treinar modelo, não é bloqueio hoje).
