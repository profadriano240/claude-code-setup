---
name: projeto-painel-censo-2026
description: Painel local (comando `censo`, Node+Baileys, porta 8766) e artifact antigo com os 24 secretários escolares da retificação da 1ª etapa do Censo Escolar 2026 — números, situação, mensagem em massa via wa.me
metadata:
  type: project
---
Painel publicado em 2026-09-28: https://claude.ai/artifact/Qjn1c28wRDYrBR9YJSeqcK (fonte ~/projetos/painel-censo/painel.html).
- Contatos (nome, escola, número) estão fixos no HTML (array CONTATOS). Situação/anotação de cada escola ficam no db do artifact, coleção `escolas`, doc id = slug da escola (ex.: `jose-rodrigues`), campos status (pend|and|ok), nota.
- Mensagem em massa = links wa.me com texto preenchido; o usuário aperta enviar em cada um (sem API paga, ver [[projeto_automacoes_whatsapp]]).
- Números coletados pelo WhatsApp Web (conta Business). Contatos Business mostram o número mais abaixo no painel "Dados do contato".
- No contato salvo o nome era "Rosimeire" (Monteiro Lobato); o usuário digitou "Rpsimeire".


ATUALIZAÇÃO 2026-09-28: usuário quis envio com 1 clique → virou painel LOCAL em ~/projetos/painel-censo (server.js Node + Baileys 6.7 como aparelho vinculado do WhatsApp Business; index.html; contatos.json; estado.json guarda situação/nota/ultimoEnvio; envios.log; auth/ = sessão). Abrir com `censo` (link em ~/.local/bin) ou atalho "Painel do Censo" no menu do GNOME, http://127.0.0.1:8766. Envio sequencial com intervalo aleatório de 5–12 s. O artifact acima ficou obsoleto (o usuário decide se apaga).

**Why:** usuário auxilia esses secretários na retificação do Censo e quer acesso rápido e envio em massa sem clicar em cada conversa.
**How to apply:** contatos novos → editar contatos.json e reiniciar o servidor; situação fica em estado.json (não no db do artifact).
