---
name: projeto-equipe-vendas-agentes
description: "Reorganização dos agentes do portfólio em 14/10/2026 — estratégia de vendas concentrada em 2 agentes novos (estrategia-vendas, copy-vendas), enxugando monetizacao/voz-do-cliente/arquiteto-ideias"
metadata: 
  node_type: memory
  type: project
  originSessionId: f64dd761-a5ea-4d4a-bb0a-c16e63f2d846
  modified: 2026-10-15T15:32:36.206Z
---

Decisão do Adriano (14/10/2026): "enxugar" a estratégia de vendas que estava espalhada em 3 agentes e concentrar numa equipe dedicada de 2 papéis, cobrindo os 4 sites do portfólio (Imposto da Bolsa, Solar Off-Grid, Bolso Esperto, futuro site católico).

**Agentes novos:**
- `estrategia-vendas` — decide funil, CTA, produto por contexto, e como tratar objeção de compra (lê `docs/voz-do-cliente.md` bruto + relatório do `analista-dados` + prioridade do `especialista-<site>`). Entrega brief de venda.
- `copy-vendas` — escreve o texto de venda (página, CTA de artigo, e-mail/WhatsApp) a partir do brief. Passa pela skill `humanizar`.

**O que saiu de cada agente existente:**
- `monetizacao` — perdeu decisão de CTA/funil, ficou só execução técnica (inserir link/slot, status de aprovação).
- `voz-do-cliente` — perdeu interpretação de objeção de compra (era funcionário 5 do sistema "7 funcionários"); continua só coletando citação bruta (funcionários 2 e 6).
- `arquiteto-ideias` — perdeu a peça de e-mail/WhatsApp de venda do modo 2 (cascata); fica só com cascata editorial.

**Why:** Adriano achou a responsabilidade de venda fragmentada demais entre 3 agentes; quis um dono único por papel (estratégia vs. copy) em vez de espalhar.

**How to apply:** Qualquer menção a CTA/funil/objeção de compra/copy de venda no portfólio passa a ser do `estrategia-vendas`/`copy-vendas`, não mais do `monetizacao`/`voz-do-cliente`/`arquiteto-ideias`.

**IMPLEMENTADO em 15/10/2026** (commit 72a2b0c, push feito em origin/master): as 7 tasks do plano rodaram — `agentes/estrategia-vendas.md` e `agentes/copy-vendas.md` criados; `monetizacao.md`/`voz-do-cliente.md`/`arquiteto-ideias.md`/`diretor-portfolio.md` editados; symlinks religados via `clonar.sh`; README atualizado. Os dois agentes novos já estão disponíveis e em uso (usados no mandato de autonomia de 15/10 para montar o brief de venda do plano de receita em 15 dias).

Ver também [[projeto_portfolio_sites]], [[referencia_backup_claude_code_setup]].
