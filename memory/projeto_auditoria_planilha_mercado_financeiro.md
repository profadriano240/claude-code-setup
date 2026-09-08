---
name: projeto_auditoria_planilha_mercado_financeiro
description: "Auditoria e correção da planilha Google Sheets \"Mercado Financeiro\" (controle de investimentos pessoais) — trabalho em andamento numa cópia"
metadata: 
  node_type: memory
  type: project
  originSessionId: c22a4ac6-15b6-47d8-a03d-2d3b6edd91d2
  modified: 2026-09-08T19:57:41.628Z
---

Planilha original (intocada): `https://docs.google.com/spreadsheets/d/1Hbrt-zJaFxpFIGyg-w8XhCJN8EUqkhPE6S_dRsupbdM/edit`

Cópia de trabalho onde as correções são aplicadas: `https://docs.google.com/spreadsheets/d/1RhQkxPFBIMRbAtimcuqHsXpYdcVcMa0Bo3rsPH0clmM/edit` ("Cópia de Mercado Financeiro").

## Inconsistências identificadas na auditoria (5 no total)
1. **Renda Fixa sem rentabilidade real** — `Visão Geral!C2` e `C3` (Atual e Aportado) apontam para a mesma célula (`=D16`, valor de mercado atual), fazendo a rentabilidade de Renda Fixa sempre exibir 0,00%. **Ainda NÃO corrigida.**
2. **Câmbio cancelado no cálculo de rentabilidade em USD** (Stock e Reat & ETF & USD) — o "Capital Aportado" usava a cotação atual do dólar em vez da cotação média histórica de compra. **✅ CORRIGIDA** na cópia: `Visão Geral!F3` e `G3` agora usam `'Avenue "EUA"'!B8` (preço médio do dólar = D43/E42) em vez de `B9` (cotação atual).
3. **Soma total exclui a coluna Opções** — `Visão Geral!B2`/`B3` usam `=SOMA(C2:H2)`, não incluem a coluna I. Inofensivo hoje pois a aba de Opções foi excluída, mas se ele voltar a operar opções, precisa lembrar de ajustar o range. **Ainda NÃO corrigida.**
4. **Referências quebradas (#REF!) na aba XP "Opções"** — célula I12 e cascata (Caixa Bruto/Líquido). **✅ RESOLVIDA** pela exclusão da aba (item abaixo).
5. **Possível erro de escala 1000x em preços de ações europeias** (SRG e INGA, aba IBKR "Europa"). **✅ INVESTIGADA — FALSO ALARME.** Preços corretos: SRG Qtd 5 × Preço Médio €5,926 = Aportado €29,63; × Preço Mercado €5,54 = Atual €27,70. INGA Qtd 0,35 × €24,14 = €8,449; × €32,24 = €11,284. Tudo fecha internamente. A impressão de "1000x" veio de ler errado a vírgula decimal (€5,926 = 5 casas decimais, não 5 mil) na auditoria visual. Nada a corrigir.
6. **Câmbio EUR→BRL da carteira Europa fixado em R$ 300 por fórmula circular** (mesma família da inconsistência 2, não pega naquela rodada). `IBKR "Europa"!D32 = 300` (literal, rótulo "Cambiado"); `B9 = D32/E31`; `E34 (Cap. Aportado R$) = E31*B9` → colapsa sempre em R$ 300. `Visão Geral!H3` puxa E34 e gera o −15,29% exibido para Europa. Rentabilidade real em EUR (`IBKR "Europa"!G31`) = +2,10% (€43,079→€43,984). O −15,29% é fictício. **Pendente decisão do usuário:** os R$ 300 são valor realmente transferido/convertido para a IBKR (então é base de custo legítima, só quebrar a circularidade de B9) ou chute (então precisa das conversões BRL→EUR reais — a aba '(IR) Europa' só registra a compra em euro, não a conversão de reais). Buys em 08–09/jan/2026 (serial 46030/46031).

## Ações já aplicadas na cópia
- Correção da inconsistência 2 (câmbio) em F3/G3 da Visão Geral.
- Exclusão da aba XP "Opções" (dados de opções quebrados com #REF!).
- Exclusão de 8 abas de IR não referenciadas por nenhuma fórmula (confirmado via Localizar-e-substituir com "pesquisar dentro de fórmulas"): (IR) Cripto, (IR) Elétrica, (IR) Bancário, (IR) Seguro, (IR) Varejo, (IR) Saúde, (IR) TOTS3, (IR) WEGE3. Essas abas guardavam histórico de compra/venda de ativos que ele já não possui mais (usado no passado para apuração de IR), mas não alimentavam a consolidação atual.
- Abas remanescentes na cópia: Visão Geral, Inter "Brasil", Avenue "EUA", IBKR "Europa", (IR) FIIs, (IR) Ações, (IR) EUA, (IR) Europa, Preços Google — todas confirmadas como efetivamente usadas na consolidação.

## Pendente para a próxima sessão
- Corrigir inconsistência 1 (Renda Fixa) — precisa decidir/perguntar ao usuário como reconstituir o custo de aquisição real dos títulos (CDB/LCA/Debêntures), já que a planilha não tem esse controle histórico como tem para Ações.
- Corrigir/ajustar inconsistência 3 (range da soma B2/B3 excluindo coluna Opções) para robustez futura.
- Inconsistência 6 (câmbio Europa fixo em R$ 300) — aguardando usuário confirmar se R$ 300 é valor real transferido ou chute.

## Nota técnica: como ler a planilha sem o navegador
Extensão Claude in Chrome pode estar desconectada. Alternativa: `mcp__claude_ai_Google_Drive__download_file_content` com `exportMimeType: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` baixa a cópia como .xlsx (base64). Decodificar e ler `xl/worksheets/sheetN.xml` com Python/zipfile expõe TODAS as fórmulas e valores. Mapa abas→sheet: Visão Geral=sheet1, Inter "Brasil"=sheet2, Avenue "EUA"=sheet3, IBKR "Europa"=sheet4, (IR) FIISs=sheet5, (IR) Ações=sheet6, (IR) EUA=sheet7, (IR) Europa=sheet8, Preços Google=sheet9. Só edição continua exigindo navegador.

## Notas técnicas do ambiente
- CUIDADO: `Ctrl+Shift+H` no Google Sheets insere a HORA ATUAL na célula selecionada (não é "Localizar e substituir" — isso é `Ctrl+H`). Já causei um incidente sobrescrevendo `Avenue "EUA"!E42` com timestamp; revertido com Ctrl+Z. Sempre usar `Ctrl+H` para abrir "Localizar e substituir".
- Ao editar fórmulas que contêm nomes de aba com aspas duplas dentro de aspas simples (ex: `'Avenue "EUA"'!B9`), digitar a fórmula inteira do zero via automação de teclado pode corromper as aspas e gerar erro "Nome de página não resolvido". Solução: editar cirurgicamente só o trecho necessário (F2 para entrar em edição, navegar com End/Home/setas, `shift+Left` para selecionar só o último caractere, substituir), nunca redigitar a fórmula inteira.
