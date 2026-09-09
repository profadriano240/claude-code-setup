---
name: projeto_auditoria_planilha_mercado_financeiro
description: "Planilha Google Sheets \"Mercado Financeiro\" (controle de investimentos pessoais) — auditoria e redesenho antigos DESCARTADOS; cópia de trabalho recomeçada do zero em 2026-09-09"
metadata:
  node_type: memory
  type: project
  originSessionId: c22a4ac6-15b6-47d8-a03d-2d3b6edd91d2
  modified: 2026-09-09T17:52:46.187Z
---

Planilha original (intocada): `https://docs.google.com/spreadsheets/d/1Hbrt-zJaFxpFIGyg-w8XhCJN8EUqkhPE6S_dRsupbdM/edit` (título "Mercado Financeiro").

## Estado atual (2026-09-09)
O usuário decidiu **jogar fora todo o trabalho anterior** (auditoria Fase 1 + redesenho dark Fase 2) e **recomeçar de uma cópia limpa, idêntica à original**.
- Cópia de trabalho antiga (`1RhQkxPFBIMRbAtimcuqHsXpYdcVcMa0Bo3rsPH0clmM`) → **movida para a lixeira do Drive** (recuperável ~30 dias se precisar consultar o que foi feito).
- **Cópia de trabalho vigente (nova, sem nenhuma alteração):** `https://docs.google.com/spreadsheets/d/1z23SvIfsPe-6BiMB52XvmtSgnCvZCW18uFpYu1HrAlE/edit` (título "Cópia de Mercado Financeiro", criada 2026-09-09T17:51Z como cópia direta da original).
- A nova cópia carrega o Apps Script vinculado da original, incluindo a função do usuário `obterCotacaoDolar()` em `Código.gs` — **não apagar/quebrar essa função**.

Nenhuma tarefa em andamento na nova cópia. Aguardando o usuário dizer o que quer fazer nesta rodada.

## Histórico — auditoria anterior (DESCARTADA, mantida só para referência se houver nova rodada)
6 inconsistências foram levantadas na 1ª auditoria; o usuário resolveu/decidiu todas e depois descartou as correções. Se ele pedir nova auditoria, estes são os pontos já analisados:
1. **Renda Fixa sem rentabilidade** (`Visão Geral!C2`=`C3`=`D16`, 0,00%) — decisão do usuário: **manter assim**, ele não quer rastrear custo de aquisição da RF, só valor atual. Não reabrir sem ele pedir.
2. **Câmbio cancelado na rentabilidade em USD** (Stock e Reat & ETF & USD) — "Capital Aportado" usava cotação atual do dólar em vez da média histórica. Correção que foi aplicada: `Visão Geral!F3`/`G3` usando `'Avenue "EUA"'!B8` (preço médio, D43/E42) em vez de `B9` (cotação atual). **Vale reaplicar se o usuário quiser corrigir de novo.**
3. **Soma total excluía a coluna Opções** — `Visão Geral!B2`/`B3` eram `=SOMA(C2:H2)`. Correção aplicada: `=SOMA(C2:I2)`/`=SOMA(C3:I3)`, depois de limpar resíduos `#REF!` em `I3`/`I4` (sobra da aba XP "Opções" excluída).
4. **`#REF!` na aba XP "Opções"** (I12 e cascata Caixa Bruto/Líquido) — resolvido antes pela exclusão da aba.
5. **"Erro de escala 1000x" em ações europeias (SRG, INGA na IBKR "Europa")** — **FALSO ALARME**, erro de leitura da vírgula decimal na auditoria visual. Tudo fecha internamente. Nada a corrigir.
6. **Câmbio EUR→BRL da Europa — fórmula tautológica mas número correto.** `IBKR "Europa"!D32 = 300` literal; `E34 = E31*B9` colapsa em R$ 300; `Visão Geral!H3` puxa E34; gera −15,29% para Europa. Usuário **confirmou que R$ 300 é o que ele realmente transferiu para a IBKR** → a perda é legítima (posição minúscula ~R$ 254, 0,12% da carteira; spread de câmbio + ~€5 em caixa + EUR/BRL contra). Ajuste cosmético que chegou a ser aplicado: `E34 = =D32`.

Outras ações que foram feitas na cópia antiga e **NÃO estão na nova**: exclusão da aba XP "Opções"; exclusão de 8 abas de IR não referenciadas por fórmula ((IR) Cripto, Elétrica, Bancário, Seguro, Varejo, Saúde, TOTS3, WEGE3 — histórico de ativos que ele não tem mais); todo o redesenho visual "Fintech Escuro" via Apps Script (`Dark.gs`).
Decisões do usuário que continuam valendo: **Reserva de Emergência (`H8:H16`, ~7.848,49) fica fora do patrimônio `B2`/`B3` de propósito** (reserva ≠ carteira, só aparece como % em `G7`).

## Nota técnica: como ler a planilha sem o navegador
Extensão Claude in Chrome pode estar desconectada. Alternativa: `mcp__claude_ai_Google_Drive__download_file_content` com `exportMimeType: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` baixa a cópia como .xlsx (base64). Decodificar e ler `xl/worksheets/sheetN.xml` com Python/zipfile expõe TODAS as fórmulas e valores. Mapa abas→sheet (na original): Visão Geral=sheet1, Inter "Brasil"=sheet2, Avenue "EUA"=sheet3, IBKR "Europa"=sheet4, (IR) FIISs=sheet5, (IR) Ações=sheet6, (IR) EUA=sheet7, (IR) Europa=sheet8, Preços Google=sheet9 (a original ainda tem as abas XP "Opções" e as 8 de IR). Só edição continua exigindo navegador.

## Notas técnicas do ambiente
- CUIDADO: `Ctrl+Shift+H` no Google Sheets insere a HORA ATUAL na célula selecionada. "Localizar e substituir" é `Ctrl+H`. Já causei incidente sobrescrevendo `Avenue "EUA"!E42` com timestamp; revertido com Ctrl+Z.
- Ao editar fórmulas com nomes de aba entre aspas duplas dentro de aspas simples (ex: `'Avenue "EUA"'!B9`), NÃO redigitar a fórmula inteira via automação de teclado — corrompe as aspas ("Nome de página não resolvido"). Editar cirurgicamente só o trecho (F2, navegar com End/Home/setas, `shift+Left` para pegar 1 caractere, substituir).

## Lições de automação de Apps Script via navegador (se precisar de novo)
1. **Não digitar código multi-linha no editor Monaco** — Enter dentro de `{...}` recém-aberto duplica a chave de fechamento → `SyntaxError`. Minificar em uma linha reduz mas não elimina; strings com aspas duplas dentro de aspas simples ainda corrompem.
2. **Método que funcionou 100%: API do Monaco via `javascript_tool`.** `monaco.editor.getModels()` lista os arquivos (identificar pelo `.getValue().slice(0,15)`), `model.setValue(conteúdoCompleto)` substitui tudo de uma vez, depois `ctrl+s`. Usar isso desde o início.
3. **Clipboard (`navigator.clipboard.writeText`) não funciona nesta máquina** — trava esperando permissão nativa do Chrome que nunca aparece; precisou fechar a aba manualmente. Evitar.
4. **Dropdown "Executar" do Apps Script volta pra 1ª função em ordem alfabética** após qualquer reload (OAuth, `setValue`). Sempre reabrir o dropdown, escolher a função certa, confirmar no topo do toolbar, então Executar.
