---
name: projeto-limite-vendas-acoes
description: "App web limite-vendas-acoes (index.html único, Netlify, login/sincronização) — repo GitHub privado criado em 2026-09-21"
metadata:
  type: project
---

App de página única (`~/projetos/limite-vendas-acoes/index.html`, criado em 2026-09-21) publicado no Netlify, com login por e-mail/senha e sincronização (mensagens de erro no estilo Supabase). Relacionado ao tema de investimentos/ações, ver [[projeto_auditoria_planilha_mercado_financeiro]].

**Repo GitHub:** privado `profadriano240/limite-vendas-acoes` (branch main, criado 2026-09-21; `.netlify/` no .gitignore). Não havia versionamento antes disso.

**Why:** em 2026-09-21 uma verificação achou este projeto e o [[projeto_site_projetar_solucoes]] sem backup no GitHub; usuário pediu para subir os dois.
**How to apply:** ao alterar o app, commitar e dar push; ao criar projeto novo em `~/projetos/`, já criar o repo GitHub privado (git init + `gh repo create --private`), sem segredos no código. Conferir periodicamente se todos os projetos estão sincronizados (ver [[referencia_backup_claude_code_setup]]).

**É o "painel de swing trade mensal"** do usuário: https://limite-vendas-acoes.netlify.app (Supabase `qrbfgvkxgokydjdpmwvy`, pausado por inatividade em 2026-09-30). Para atualizar: vendas vêm da planilha original, aba `(IR) Ações` (linhas com Qt. negativa; Valores = total bruto; col. "Valor para IR" = PM). Em 2026-09-30 o histórico completo (138 vendas, 2020-06 a 2026-09, das abas (IR) Ações + abas setoriais antigas + (IR) FIISs como tipo "outros") foi gravado no localStorage do Chrome do notebook via JS; PM inválido na planilha (#DIV/0!, 0, negativo ou absurdo) → pm=0 (39 vendas). Lucro também aparece em % (lucro/custo).

## Progresso da sessão 2026-09-30 (retomar daqui)
- Lucro: (preço venda − PM) × qtd; % = lucro ÷ (PM × qtd). Preço venda = coluna "Nota + Despesas" ÷ qtd; PM = coluna "Valor para IR" da linha da venda. PM descartado (pm=0) se inválido ou se preço/PM fora de 0,4–2,5 (critério meu, arbitrário).
- Deploy: `netlify` CLI não autenticado; publicar pelo MCP Netlify (`deploy-site` → roda `npx @netlify/mcp` com proxy). Commit "Mostra lucro também em porcentagem" enviado ao GitHub.
- Supabase: usuário pediu para NÃO reativar por enquanto.
- 2026-09-30 (2ª sessão): +3 vendas de 30/09 (SAPR4, BBAS3, ITUB4) → 141 vendas; set/2026 ficou R$ 22.355 (estourou o limite). ITUB4 07/08 corrigida para R$ 41,90 (planilha agora diz 4.190). Script de extração salvo em ~/projetos/limite-vendas-acoes/extrair_vendas.py (commitado; uso: python3 extrair_vendas.py plan.xlsx saida.json).
- Prejuízo acumulado swing (cálculo 2026-09-30, só vendas com PM válido): R$ 1.052,57 até ago/2026 (maior parte jun/2026 −938,86) → set/2026 (após +VULC3 5 ações 30/09, PM planilha 0 → usei 19,2543; 142 vendas) lucro R$ 1.355,99, base R$ 303,42, IR R$ 45,51, saldo zerado. Implementado no painel em 2026-09-30 (card "Prejuízo acumulado", função prejuizoAntes; imposto já desconta).
- 2026-09-30: 24 vendas de ações sem PM resolvidas por custo médio ponderado (script recalcular_pm.py no repo; desdobramentos MGLU3 x4 e WEGE3 x2 aplicados à mão; EGIE3 usa só bloco (IR) Ações, ignorando 3 ações de 2020). ITUB4 "2023-05-14" era erro de ano na planilha → movida p/ 2026-05-14. Backup do estado anterior no localStorage chave limite-vendas-acoes-v1-backup-2026-09-30. Resultado: prejuízo acumulado R$ 1.377,25, imposto set/2026 = R$ 0, sobra R$ 21,26.
- Depois (OK do usuário): aplicados também os PMs da planilha que divergiam >1% do custo médio (planilha recalcula PM errado após vendas parciais; JBSS3, MRVE3, RADL3, BBAS3 08/2025, TAEE4, GNDI3, BBSE3, MGLU3, TOTS3...) + nova venda SAPR4 25 @6,62 (30/09) → 143 vendas. Resultado: set/2026 vendido R$ 22.589,66, lucro R$ 1.329,68, prejuízo acumulado R$ 1.477,02, imposto R$ 0, sobra R$ 147,34. Backup anterior: chave ...-backup-2026-09-30b. Para atualizar: rodar extrair_vendas.py e recalcular_pm.py; usar pm_novo quando PM da planilha for inválido ou divergir >1%.
- Depois: PM de BBAS3 (set/2026, 20,6296) e ITUB4 30/09 (40,8064) recalculados; erro de ano também em compra BBAS3 "2026-12-12" (=2025-12-12), corrigido também na planilha em 2026-09-30 (M173 e B235 da aba (IR) Ações), FIX_DATA do recalcular_pm.py ficou redundante (uso: python3 recalcular_pm.py planilha.xlsx). Resultado final set/2026: lucro R$ 1.410,32, imposto R$ 0, sobra R$ 66,70. Venda UNH 14/09 na aba (IR) EUA fica fora do painel (exterior, apuração anual). Backup: ...-backup-2026-09-30c.
- Pendências: JBSS3 e SLCE3 vendem mais ações do que compraram (bonificação faltando?). 15 FIIs sem PM não tratados; não verificado se "Nota + Despesas" já desconta taxas nem como a planilha calcula "Valor para IR"; imposto não abate prejuízo acumulado.
- Script de extração: lê o xlsx exportado do Drive (id original 1Hbrt-...), procura em (IR) Ações/setoriais/FIISs células de data com Qt. negativa na coluna seguinte; ticker = primeira célula acima que casa com [A-Z]{4}\d{1,2}.
