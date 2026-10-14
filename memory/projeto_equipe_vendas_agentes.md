---
name: projeto-equipe-vendas-agentes
description: "Reorganização dos agentes do portfólio em 14/10/2026 — estratégia de vendas concentrada em 2 agentes novos (estrategia-vendas, copy-vendas), enxugando monetizacao/voz-do-cliente/arquiteto-ideias"
metadata: 
  node_type: memory
  type: project
  originSessionId: f64dd761-a5ea-4d4a-bb0a-c16e63f2d846
  modified: 2026-10-14T22:50:01.264Z
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

**Estado em 14/10/2026 (pausado por limite de tokens):**
- Spec aprovado: `~/projetos/portfolio-sites/docs/superpowers/specs/2026-10-14-equipe-vendas-design.md`
- Plano escrito (7 tasks): `~/projetos/portfolio-sites/docs/superpowers/plans/2026-10-14-equipe-vendas.md`
- **Nada implementado ainda** — nenhum arquivo de agente foi criado/editado, só spec+plano. Próximo passo: perguntar ao Adriano se executa via subagent-driven-development ou inline, e rodar as 7 tasks (criar `agentes/estrategia-vendas.md` e `agentes/copy-vendas.md`, editar `monetizacao.md`/`voz-do-cliente.md`/`arquiteto-ideias.md`/`diretor-portfolio.md`, religar symlinks com `clonar.sh`, atualizar README, commit+push).

Ver também [[projeto_portfolio_sites]], [[referencia_backup_claude_code_setup]].
