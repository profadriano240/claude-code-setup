---
name: referencia-memoria-temporaria
description: Pasta ~/.cache/claude-temporario para arquivos intermediários (HTML bruto etc.), apagados automaticamente após 7 dias
metadata:
  type: reference
---

Criada em 2026-09-25 a pedido do usuário: "memória temporária de 7 dias" para guardar intermediários que antes se perdiam (ex.: HTML bruto das cifras).
- Pasta: ~/.cache/claude-temporario/<projeto>/ (ex.: cifras-ecc/ com os *.raw.html das Faltantes 01–20).
- Limpeza: systemd user timer claude-temporario.timer (diário, Persistent) roda find -mtime +7 -delete.
- gerar.sh de [[projeto-cifras-ecc]] já copia cada raw.html para lá.

**How to apply:** ao gerar intermediários caros de refazer (downloads, HTML bruto, extrações), salvar cópia aqui em vez de só /tmp ou scratchpad; ao precisar refazer algo recente, olhar aqui primeiro.
