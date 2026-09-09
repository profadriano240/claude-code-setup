---
name: projeto_auditoria_planilha_mercado_financeiro
description: "Auditoria e correção da planilha Google Sheets \"Mercado Financeiro\" (controle de investimentos pessoais) — trabalho em andamento numa cópia"
metadata: 
  node_type: memory
  type: project
  originSessionId: c22a4ac6-15b6-47d8-a03d-2d3b6edd91d2
  modified: 2026-09-09T12:23:41.338Z
---

Planilha original (intocada): `https://docs.google.com/spreadsheets/d/1Hbrt-zJaFxpFIGyg-w8XhCJN8EUqkhPE6S_dRsupbdM/edit`

Cópia de trabalho onde as correções são aplicadas: `https://docs.google.com/spreadsheets/d/1RhQkxPFBIMRbAtimcuqHsXpYdcVcMa0Bo3rsPH0clmM/edit` ("Cópia de Mercado Financeiro").

## Inconsistências identificadas na auditoria (6 no total; TODAS ENCERRADAS)
1. **Renda Fixa sem rentabilidade real** — `Visão Geral!C2` e `C3` (Atual e Aportado) apontam para a mesma célula (`=D16`, valor de mercado atual), fazendo a rentabilidade de Renda Fixa sempre exibir 0,00%. **ENCERRADA por decisão do usuário (2026-09-09): ele NÃO quer rastrear custo de aquisição da RF — a área de Renda Fixa deve mostrar só o valor atual, sem rentabilidade.** Nenhuma edição necessária; o comportamento atual (`C2`=`C3`=`D16`, 0,00%) já é o desejado. Não reabrir isso sem o usuário pedir explicitamente.
2. **Câmbio cancelado no cálculo de rentabilidade em USD** (Stock e Reat & ETF & USD) — o "Capital Aportado" usava a cotação atual do dólar em vez da cotação média histórica de compra. **✅ CORRIGIDA** na cópia: `Visão Geral!F3` e `G3` agora usam `'Avenue "EUA"'!B8` (preço médio do dólar = D43/E42) em vez de `B9` (cotação atual).
3. **Soma total exclui a coluna Opções** — `Visão Geral!B2`/`B3` usam `=SOMA(C2:H2)`, não incluem a coluna I. **✅ CORRIGIDA em 2026-09-09**: `B2`=`=SOMA(C2:I2)` e `B3`=`=SOMA(C3:I3)`. Antes disso foi preciso limpar `I3` (tinha `='XP "Opções"'!B1*0` → #REF!, resíduo da aba excluída) e `I4`; sem isso a soma estendida quebraria `B3`.
4. **Referências quebradas (#REF!) na aba XP "Opções"** — célula I12 e cascata (Caixa Bruto/Líquido). **✅ RESOLVIDA** pela exclusão da aba (item abaixo).
5. **Possível erro de escala 1000x em preços de ações europeias** (SRG e INGA, aba IBKR "Europa"). **✅ INVESTIGADA — FALSO ALARME.** Preços corretos: SRG Qtd 5 × Preço Médio €5,926 = Aportado €29,63; × Preço Mercado €5,54 = Atual €27,70. INGA Qtd 0,35 × €24,14 = €8,449; × €32,24 = €11,284. Tudo fecha internamente. A impressão de "1000x" veio de ler errado a vírgula decimal (€5,926 = 5 casas decimais, não 5 mil) na auditoria visual. Nada a corrigir.
6. **Câmbio EUR→BRL da carteira Europa — fórmula tautológica, mas número correto.** `IBKR "Europa"!D32 = 300` (literal, rótulo "Cambiado"); `B9 = D32/E31` (rotulado "Preço Médio", mas é taxa resolvida de trás pra frente ≈ 6,96); `E34 (Cap. Aportado R$) = E31*B9` → sempre colapsa em `D32` = R$ 300. `Visão Geral!H3` puxa E34; gera o −15,29% exibido para Europa (`H4 = (D34−E34)/E34`, com `D34` = valor atual já com desconto de −2,38% spread+IOF de repatriação). **RESOLVIDA: usuário confirmou que os R$ 300 são o valor que ele realmente transferiu para a IBKR.** Logo o −15,29% é legítimo (posição minúscula de R$ 254 = 0,12% da carteira; perda real por spread de câmbio + ~€5 parados em caixa + EUR/BRL contra). Sem bug de número. Ajuste cosmético **✅ APLICADO em 2026-09-09**: `E34` agora é `=D32` (número inalterado, R$ 300; rentabilidade segue −15,26%). **Item 6 encerrado.**

## Ações já aplicadas na cópia
- Correção da inconsistência 2 (câmbio) em F3/G3 da Visão Geral.
- Exclusão da aba XP "Opções" (dados de opções quebrados com #REF!).
- Exclusão de 8 abas de IR não referenciadas por nenhuma fórmula (confirmado via Localizar-e-substituir com "pesquisar dentro de fórmulas"): (IR) Cripto, (IR) Elétrica, (IR) Bancário, (IR) Seguro, (IR) Varejo, (IR) Saúde, (IR) TOTS3, (IR) WEGE3. Essas abas guardavam histórico de compra/venda de ativos que ele já não possui mais (usado no passado para apuração de IR), mas não alimentavam a consolidação atual.
- Abas remanescentes na cópia: Visão Geral, Inter "Brasil", Avenue "EUA", IBKR "Europa", (IR) FIIs, (IR) Ações, (IR) EUA, (IR) Europa, Preços Google — todas confirmadas como efetivamente usadas na consolidação.

## Pendente para a próxima sessão
- **Inconsistência 1 (Renda Fixa)** — ÚNICO item aberto. Precisa que o usuário informe o valor de custo (quanto investiu) de cada posição de RF. Confirmado por leitura completa do .xlsx: **não existe registro de aporte de RF em nenhuma aba** (a RF só aparece na Visão Geral como valor de mercado). Layout atual da área de RF na Visão Geral: `C8:C14` = % dentro da RF, `D8:D14` = valor atual, `E8:E14` = nome, coluna `F` livre. Valores hoje: `D11` CDB = `=2104.25+321.07+2253+269.94+335.23+2476.37` = 7.759,86 (6 CDBs somados numa célula só); `D12` LCA DI = 328,09; `D13` Debênture 07/2026 = vazio; `D14` Debênture 12/2030 = 2.408,73; `D16` total = 10.496,68. Plano: criar coluna de "Aportado" (F8:F14 ou nova), somar em algum `F16`, e apontar `Visão Geral!C3` para essa soma (hoje `C3`=`=D16`, igual a `C2`).
- **Ponto novo levantado (aguardando decisão do usuário): a Reserva de Emergência não entra no patrimônio.** `H8:H14` (Tesouro: IPCA+ 2050/2040/2029, IPCA EDUCA+ 2040, Prefixado 2032, CDB Itaú, CDB Bradesco), total `H16` = 7.848,49, NÃO é somada em `B2`. Só aparece como `G7 = H16/B2` (3,79%). Pode ser intencional (reserva ≠ carteira) — confirmar antes de mexer.

## Nota técnica: como ler a planilha sem o navegador
Extensão Claude in Chrome pode estar desconectada. Alternativa: `mcp__claude_ai_Google_Drive__download_file_content` com `exportMimeType: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` baixa a cópia como .xlsx (base64). Decodificar e ler `xl/worksheets/sheetN.xml` com Python/zipfile expõe TODAS as fórmulas e valores. Mapa abas→sheet: Visão Geral=sheet1, Inter "Brasil"=sheet2, Avenue "EUA"=sheet3, IBKR "Europa"=sheet4, (IR) FIISs=sheet5, (IR) Ações=sheet6, (IR) EUA=sheet7, (IR) Europa=sheet8, Preços Google=sheet9. Só edição continua exigindo navegador.

## Notas técnicas do ambiente
- CUIDADO: `Ctrl+Shift+H` no Google Sheets insere a HORA ATUAL na célula selecionada (não é "Localizar e substituir" — isso é `Ctrl+H`). Já causei um incidente sobrescrevendo `Avenue "EUA"!E42` com timestamp; revertido com Ctrl+Z. Sempre usar `Ctrl+H` para abrir "Localizar e substituir".
- Ao editar fórmulas que contêm nomes de aba com aspas duplas dentro de aspas simples (ex: `'Avenue "EUA"'!B9`), digitar a fórmula inteira do zero via automação de teclado pode corromper as aspas e gerar erro "Nome de página não resolvido". Solução: editar cirurgicamente só o trecho necessário (F2 para entrar em edição, navegar com End/Home/setas, `shift+Left` para selecionar só o último caractere, substituir), nunca redigitar a fórmula inteira.
