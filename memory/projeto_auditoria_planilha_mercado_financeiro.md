---
name: projeto_auditoria_planilha_mercado_financeiro
description: "Auditoria e correção da planilha Google Sheets \"Mercado Financeiro\" (controle de investimentos pessoais) — trabalho em andamento numa cópia"
metadata: 
  node_type: memory
  type: project
  originSessionId: c22a4ac6-15b6-47d8-a03d-2d3b6edd91d2
  modified: 2026-09-04T15:58:14.495Z
---

Planilha original (intocada): `https://docs.google.com/spreadsheets/d/1Hbrt-zJaFxpFIGyg-w8XhCJN8EUqkhPE6S_dRsupbdM/edit`

Cópia de trabalho onde as correções são aplicadas: `https://docs.google.com/spreadsheets/d/1RhQkxPFBIMRbAtimcuqHsXpYdcVcMa0Bo3rsPH0clmM/edit` ("Cópia de Mercado Financeiro").

## Inconsistências identificadas na auditoria (5 no total)
1. **Renda Fixa sem rentabilidade real** — `Visão Geral!C2` e `C3` (Atual e Aportado) apontam para a mesma célula (`=D16`, valor de mercado atual), fazendo a rentabilidade de Renda Fixa sempre exibir 0,00%. **Ainda NÃO corrigida.**
2. **Câmbio cancelado no cálculo de rentabilidade em USD** (Stock e Reat & ETF & USD) — o "Capital Aportado" usava a cotação atual do dólar em vez da cotação média histórica de compra. **✅ CORRIGIDA** na cópia: `Visão Geral!F3` e `G3` agora usam `'Avenue "EUA"'!B8` (preço médio do dólar = D43/E42) em vez de `B9` (cotação atual).
3. **Soma total exclui a coluna Opções** — `Visão Geral!B2`/`B3` usam `=SOMA(C2:H2)`, não incluem a coluna I. Inofensivo hoje pois a aba de Opções foi excluída, mas se ele voltar a operar opções, precisa lembrar de ajustar o range. **Ainda NÃO corrigida.**
4. **Referências quebradas (#REF!) na aba XP "Opções"** — célula I12 e cascata (Caixa Bruto/Líquido). **✅ RESOLVIDA** pela exclusão da aba (item abaixo).
5. **Possível erro de escala 1000x em preços de ações europeias** (SRG e INGA, aba IBKR "Europa") — Preço Médio/Mercado parecem inflados 1000x em relação ao "Lucro em R$" calculado. **Ainda NÃO investigada a fundo nem corrigida.**

## Ações já aplicadas na cópia
- Correção da inconsistência 2 (câmbio) em F3/G3 da Visão Geral.
- Exclusão da aba XP "Opções" (dados de opções quebrados com #REF!).
- Exclusão de 8 abas de IR não referenciadas por nenhuma fórmula (confirmado via Localizar-e-substituir com "pesquisar dentro de fórmulas"): (IR) Cripto, (IR) Elétrica, (IR) Bancário, (IR) Seguro, (IR) Varejo, (IR) Saúde, (IR) TOTS3, (IR) WEGE3. Essas abas guardavam histórico de compra/venda de ativos que ele já não possui mais (usado no passado para apuração de IR), mas não alimentavam a consolidação atual.
- Abas remanescentes na cópia: Visão Geral, Inter "Brasil", Avenue "EUA", IBKR "Europa", (IR) FIIs, (IR) Ações, (IR) EUA, (IR) Europa, Preços Google — todas confirmadas como efetivamente usadas na consolidação.

## Pendente para a próxima sessão
- Corrigir inconsistência 1 (Renda Fixa) — precisa decidir/perguntar ao usuário como reconstituir o custo de aquisição real dos títulos (CDB/LCA/Debêntures), já que a planilha não tem esse controle histórico como tem para Ações.
- Corrigir/ajustar inconsistência 3 (range da soma B2/B3 excluindo coluna Opções) para robustez futura.
- Investigar e corrigir a inconsistência 5 (escala de preços SRG/INGA na aba IBKR "Europa").

## Notas técnicas do ambiente
- CUIDADO: `Ctrl+Shift+H` no Google Sheets insere a HORA ATUAL na célula selecionada (não é "Localizar e substituir" — isso é `Ctrl+H`). Já causei um incidente sobrescrevendo `Avenue "EUA"!E42` com timestamp; revertido com Ctrl+Z. Sempre usar `Ctrl+H` para abrir "Localizar e substituir".
- Ao editar fórmulas que contêm nomes de aba com aspas duplas dentro de aspas simples (ex: `'Avenue "EUA"'!B9`), digitar a fórmula inteira do zero via automação de teclado pode corromper as aspas e gerar erro "Nome de página não resolvido". Solução: editar cirurgicamente só o trecho necessário (F2 para entrar em edição, navegar com End/Home/setas, `shift+Left` para selecionar só o último caractere, substituir), nunca redigitar a fórmula inteira.
