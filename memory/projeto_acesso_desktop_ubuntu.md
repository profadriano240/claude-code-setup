---
name: projeto-acesso-desktop-ubuntu
description: "Plano de acesso SSH do notebook ao computador de mesa Ubuntu, só na rede Wi-Fi de casa (sem Tailscale)"
metadata:
  node_type: memory
  type: project
  originSessionId: 12504590-c475-430e-aced-fae8336421b4
  modified: 2026-09-28T21:01:46.404Z
---

Usuário quer que eu acesse o computador de mesa (Ubuntu) a partir do notebook, APENAS quando estiver em casa (mesmo Wi-Fi). Decidido em 2026-09-28: sem Tailscale, só SSH na rede local.

**Why:** não precisa de acesso remoto fora de casa.
**How to apply:** quando o usuário estiver em casa: no Ubuntu `sudo apt install -y openssh-server` e `hostname -I`/`whoami`; no notebook `ssh-copy-id usuario@IP` (chave ~/.ssh/id_ed25519 já existe), depois criar alias em ~/.ssh/config. Fora de casa o notebook costuma usar o hotspot do celular (172.20.10.x), onde o desktop não é visível. Status: ainda não configurado. Ver [[maquina_debian_home]].
