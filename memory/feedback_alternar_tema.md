---
name: feedback-alternar-tema
description: toda aplicação/página HTML ou artifact deve ter botão para alternar entre tema claro e escuro
metadata:
  node_type: memory
  type: feedback
  originSessionId: cf27000a-3ca5-467e-9fa6-64cd598fa0d7
  modified: 2026-10-02T17:55:47.009Z
---

Em toda aplicação/página web (artifacts, HTMLs locais, sites) incluir um botão visível para trocar entre tema claro e escuro, além de seguir o tema do sistema por padrão.

**Why:** pedido explícito do usuário em 2026-10-02 ("para essa e as próximas aplicações"), ao receber as cruzadas de PA/PG.

**How to apply:** tokens de cor em :root + blocos dark (media query e [data-theme="dark"]); botão que define `data-theme` no `<html>` e lembra a escolha em localStorage (com try/catch). Rótulo mostra o tema para o qual vai trocar.
