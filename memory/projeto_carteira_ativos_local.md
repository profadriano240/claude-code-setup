---
name: projeto-carteira-ativos-local
description: Banco SQLite local + página web (Python stdlib) para lançar movimentações/proventos dos ativos; substitui as abas (IR) da planilha Mercado Financeiro a partir de 2026-09-23
metadata:
  node_type: memory
  type: project
  originSessionId: 6593b599-d9b9-481d-b358-ad5c9bfce57b
  modified: 2026-09-23T17:59:17.448Z
---

Criado em 2026-09-23 em `~/projetos/carteira-ativos/` (repo privado `profadriano240/carteira-ativos`; `carteira.db` e `backups/` ficam FORA do git, de propósito — dados financeiros pessoais).

- `carteira.db` (SQLite): tabelas `ativos`, `movimentacoes` (tipo compra/venda/evento; quantidade sempre positiva, exceto evento = variação de cotas), `proventos`.
- `server.py`: servidor só com Python padrão em http://127.0.0.1:8765, backup diário automático em `backups/` (30 últimos). Abrir com `carteira` (link em ~/.local/bin) ou atalho "Minha Carteira" no menu do GNOME.
- `importar_planilha.py planilha.xlsx`: reimporta as 12 abas (IR) da planilha original ([[projeto_auditoria_planilha_mercado_financeiro]]); apaga só registros com `origem LIKE 'planilha%'`, preserva os lançamentos manuais.

Importação inicial: 856 movimentações + 216 proventos (proventos só até jan/2024 — a planilha parou de registrar). Divergências da própria planilha, não corrigidas: JBSS3 −3, SLCE3 −9 (compra de 7 com valor 0 em 13/12/2023, provável bonificação), ONL −0,041 US; posições residuais em ativos das abas de setor antigas (ABCB4 9, BBSE3 5, EGIE3 3, FLRY3 5, ITSA4 13, LREN3 3, PSSA3 3, BTC 0,00142) que o usuário provavelmente já não tem.
