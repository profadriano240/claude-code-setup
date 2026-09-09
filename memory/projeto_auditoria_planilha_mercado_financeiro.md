---
name: projeto_auditoria_planilha_mercado_financeiro
description: "Auditoria e correção da planilha Google Sheets \"Mercado Financeiro\" (controle de investimentos pessoais) — trabalho em andamento numa cópia"
metadata: 
  node_type: memory
  type: project
  originSessionId: c22a4ac6-15b6-47d8-a03d-2d3b6edd91d2
  modified: 2026-09-09T13:15:32.090Z
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
Nenhum item aberto da auditoria original. Dois pontos levantados durante o trabalho já foram decididos pelo usuário e ficam fechados, registrados aqui só como histórico:
- **Renda Fixa sem rentabilidade** — decisão: manter assim, só valor atual (ver item 1 acima).
- **Reserva de Emergência fora do patrimônio** — `H8:H14` (Tesouro: IPCA+ 2050/2040/2029, IPCA EDUCA+ 2040, Prefixado 2032, CDB Itaú, CDB Bradesco), total `H16` = 7.848,49, não entra em `B2`/`B3`; só aparece como percentual em `G7 = H16/B2` (3,79%). **Decisão do usuário (2026-09-09): manter fora, é intencional** (reserva ≠ carteira).

Se o usuário quiser retomar o projeto, é para revisão geral/nova rodada de auditoria, não para reabrir estes pontos.

## Fase 2: Redesenho visual do layout (2026-09-09)
Depois da auditoria, o usuário pediu melhoria de layout — escopo: "Redesenho visual completo" + aplicar nas 4 abas ativas (Visão Geral, Inter "Brasil", Avenue "EUA", IBKR "Europa"). **Concluído e aplicado na cópia.**

**Abordagem:** em vez de formatar célula por célula pelo navegador (lento, caro em tokens), foi escrito um script de Google Apps Script (arquivo `Redesign.gs`, novo, dentro do projeto Apps Script já existente chamado "cotação dólar" vinculado à planilha — **não tocar/apagar o `Código.gs` original**, que tem a função `obterCotacaoDolar()` do usuário) e executado via `runFullRedesign()`.

**Paleta categórica usada (skill dataviz, ordem fixa validada, aplicada 1:1 nas colunas C:I da Visão Geral):** Renda Fixa=azul `#2a78d6`, Fundos Imobiliários=laranja `#eb6834`, Ações=aqua `#1baf7a`, Reat & ETF & USD=amarelo `#eda100`, Stock=magenta `#e87ba4`, Europa=verde `#008300`, Opções=violeta `#4a3aa7`, Total/neutro=`#0b0b0b`. Cada aba de carteira herda a cor da categoria que alimenta (Inter "Brasil": bloco Imóveis+Dívidas=laranja, Empresas=aqua; Avenue "EUA": Outros+Imóveis=amarelo, Empresas=magenta; IBKR "Europa": Outros+Empresas=verde) — link visual entre a Visão Geral e o detalhe de cada corretora.

**O que foi feito:**
- Visão Geral: cabeçalho de categorias colorido, linha de rótulos com fundo cinza-claro, valores Atual/Aportado com tinta leve da cor da categoria (linha de Rentabilidade não foi tocada — já tem formatação condicional própria), bordas em caixa, largura de colunas ajustada (resolve os textos cortados "RESERVA DE EMERGÊNCIA" e nomes de renda fixa), zebra striping nas mini-tabelas de Renda Fixa e Reserva de Emergência, linha 1 congelada. Gráfico de pizza principal recolorido para bater com o cabeçalho e reposicionado para `K2` (antes flutuava por cima das tabelas) — confirmado visualmente correto, todas as 7 fatias com a cor certa.
- Inter "Brasil": bandas coloridas nos blocos Imóveis/Dívidas/Empresas/Resultado, zebra striping, bordas, lista "Ativos Brasileiros" e tabela Ano×Proventos com cabeçalho escuro. 4 gráficos (2 pizzas "Distribuição na bolsa brasileira"/"Distribuição em FII's"/"Distribuição em Ações" + 1 barra "Proventos versus Ano") repaginados lado a lado sem sobreposição, recoloridos com rampas de tom único por categoria (laranja p/ FIIs, aqua p/ Ações). **Imperfeição cosmética conhecida e não resolvida:** no gráfico "Distribuição em Ações", 2 das 9 fatias (SAPR4 e ITUB4) não pegaram a cor da rampa (saíram com cores default do Sheets) — depuração via Apps Script mostrou `getOptions().get('colors')` retornando `null` para esse gráfico especificamente mesmo após `chart.modify().setOption('colors',...).build()` + `updateChart()` sem erro. Causa não identificada; não vale a pena investigar mais (script de produção). Se quiser perfeição, corrigir manualmente no editor de gráfico do Sheets (clique no gráfico → Editar gráfico → Personalizar → Série/Fatias).
- Avenue "EUA" e IBKR "Europa": mesmo padrão (bandas por bloco, zebra, bordas, largura de coluna) aplicado; sem gráficos nessas duas abas (confirmado via inspeção do .xlsx — só Visão Geral e Inter "Brasil" têm gráficos).
- Cor de aba (tab color) definida para as 4 abas, batendo com a categoria dominante de cada uma.
- **Nota:** existem faixas coloridas pré-existentes (não criadas por este redesenho) que ultrapassam as colunas de dados em algumas linhas de cabeçalho (ex.: Inter "Brasil" linha 1 colunas H em diante ficam azul/dourado; Avenue "EUA" e IBKR "Europa" linha 1 colunas E em diante ficam verde) — resíduo de formatação anterior do próprio usuário, fora do escopo tocado pelo script, deixado como estava.

**Restam no projeto Apps Script (arquivo `Redesign.gs`) algumas funções de depuração** (`debugCheck`, `debugChartTitles`, `debugChartColors`, `debugChartColors2`) criadas durante a investigação da imperfeição acima — inofensivas (não são executadas automaticamente), podem ser apagadas numa limpeza futura se quiser deixar o projeto arrumado.

**Lição para a próxima vez que precisar editar Apps Script via automação de navegador:** o editor (Monaco) tem auto-fechamento de colchetes/aspas que DUPLICA caracteres quando se digita código com quebras de linha reais (Enter no meio de `{...}` expande em 3 linhas e a chave de fechamento digitada depois vira duplicada). Solução que funcionou: minificar o código inteiro numa ÚNICA linha (sem `\n`, comentários `//` removidos antes) e digitar em blocos de até ~4-5 mil caracteres via `computer.type`, sempre com `ctrl+End` antes de cada bloco. Colar via clipboard NÃO funcionou nesta máquina (extensão Chrome travou esperando permissão nativa de colar que nunca apareceu visível — precisou o usuário fechar a aba manualmente para recuperar). Depois de rodar `runFullRedesign` pela primeira vez, o seletor de função do Apps Script **volta para a primeira função em ordem alfabética** depois do fluxo de autorização OAuth — sempre reselecionar a função certa no dropdown antes de clicar Executar de novo.

## Nota técnica: como ler a planilha sem o navegador
Extensão Claude in Chrome pode estar desconectada. Alternativa: `mcp__claude_ai_Google_Drive__download_file_content` com `exportMimeType: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` baixa a cópia como .xlsx (base64). Decodificar e ler `xl/worksheets/sheetN.xml` com Python/zipfile expõe TODAS as fórmulas e valores. Mapa abas→sheet: Visão Geral=sheet1, Inter "Brasil"=sheet2, Avenue "EUA"=sheet3, IBKR "Europa"=sheet4, (IR) FIISs=sheet5, (IR) Ações=sheet6, (IR) EUA=sheet7, (IR) Europa=sheet8, Preços Google=sheet9. Só edição continua exigindo navegador.

## Notas técnicas do ambiente
- CUIDADO: `Ctrl+Shift+H` no Google Sheets insere a HORA ATUAL na célula selecionada (não é "Localizar e substituir" — isso é `Ctrl+H`). Já causei um incidente sobrescrevendo `Avenue "EUA"!E42` com timestamp; revertido com Ctrl+Z. Sempre usar `Ctrl+H` para abrir "Localizar e substituir".
- Ao editar fórmulas que contêm nomes de aba com aspas duplas dentro de aspas simples (ex: `'Avenue "EUA"'!B9`), digitar a fórmula inteira do zero via automação de teclado pode corromper as aspas e gerar erro "Nome de página não resolvido". Solução: editar cirurgicamente só o trecho necessário (F2 para entrar em edição, navegar com End/Home/setas, `shift+Left` para selecionar só o último caractere, substituir), nunca redigitar a fórmula inteira.
