---
name: projeto-chrome-extensao-logout
description: "Extensão Claude in Chrome pedia login a cada boot; serviço fechar-chrome.service criado em 2026-09-24, aguardando confirmação"
metadata:
  node_type: memory
  type: project
  originSessionId: 7796749c-8eec-429b-82ed-ff65688c8590
  modified: 2026-09-24T13:23:05.940Z
---

Problema: após cada reinício, só a extensão Claude in Chrome pedia login (outros sites seguiam logados). O chaveiro GNOME estava ok; o `exit_type` do Chrome era "Crashed", ou seja, o Chrome era derrubado no desligamento.

Correção aplicada em 2026-09-24: serviço de usuário `~/.config/systemd/user/fechar-chrome.service` (ExecStop → `~/.local/bin/fechar-chrome.sh`, que envia SIGTERM ao Chrome e espera até 20s).

**Why:** hipótese de que a extensão não termina de gravar a sessão quando o Chrome é morto.
**How to apply:** se o usuário voltar a relatar o problema, verificar `exit_type` em `~/.config/google-chrome/Default/Preferences`. Se o valor for "Normal" e o problema continuar, a causa é outra (provável expiração de sessão da própria extensão). Ver também [[maquina-debian-home]].
