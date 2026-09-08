---
name: projeto_certificado_conclusao_ensino_medio
description: "Gerador HTML do Certificado de Conclusão do Ensino Médio (EEEM Janelas para o Mundo), arquivo único, frente + verso A4 paisagem, fundo = modelo oficial rasterizado"
metadata: 
  node_type: memory
  type: project
  originSessionId: 217b5fa7-805b-4e0b-8d8e-bbfbf2557fa3
  modified: 2026-09-08T19:37:51.715Z
---

**Arquivo:** `~/projetos/certificado-conclusao/certificado-conclusao-ensino-medio.html`
(cópia também em `~/Downloads/`). Criado no Claude Code em 2026-09-08. ~250 KB.

**Modelo oficial:** pasta `~/Downloads/certificado de conclusão/` — `1.svg`/`1.png`/`1.jpg`
= frente, `2.svg`/`2.png` = verso, além de `cert.pptx` e `cert (44).pdf`. O
usuário exigiu que ficasse **exatamente igual** ao modelo (deu inclusive um link
do Canva, inacessível). A 1ª tentativa (rebuild do zero a partir do
`diploma-ensino-medio-janelas.html`) foi rejeitada por não ser fiel.

**Abordagem que funcionou (a que está no arquivo):**
1. Os `.svg` do modelo são 100% vetor: cada glifo é
   `<g fill="#000000"><g transform="translate(x, y)">…<path/>`. O `y` do
   `translate` agrupa os glifos por linha.
2. Script `blank.py` (no scratchpad da sessão, não versionado) remove os grupos
   de glifos cujo `y` cai na faixa do texto variável — frente: y∈[335,450]
   (6 linhas do corpo + linha da data); verso: y∈[220,350] (bloco de registro).
   Sobra um SVG "em branco" com moldura, brasão da República, cabeçalho, título
   na fonte display original, nome da escola + linha, base legal, brasão do Pará
   (marca d'água colorida) e rótulos CONCLUINTE/DIRETOR(A)/Secretário(a).
3. Renderizado com `google-chrome --headless ... --force-device-scale-factor=2`
   e reduzido para PNG paleta 256 cores (`frente` ~168 KB, `verso` ~11 KB),
   embutido em base64 como `background-size:100% 100%` da `.folha`
   (297mm × 210mm).
4. Sobre o fundo, `position:absolute` com texto vivo do formulário:
   - `.corpo` (frente): Arial 14.6pt, `line-height:5.82mm`, `text-align:justify`,
     `text-indent:18.2mm`, `left:22.4mm; right:25mm; top:110.9mm`.
   - `.data-local`: Arial 14.6pt, `right:23mm; top:151.8mm`, alinhada à direita.
   - `.registro` (verso): Arial **13.5pt bold**, `left:36mm; top:75.4mm`,
     3 linhas com `.ln{height:11.9mm}`; `.em` (linha "Em dd/mm/aaaa") peso normal,
     `margin-top:5.3mm`.
   - `.obs` (verso): Arial 12pt, `left:36mm; top:60mm`.
   Coordenadas derivadas medindo os baselines dos glifos no SVG
   (viewBox 841.92×595.5 → mm: ×0.35276 em x, ×0.35264 em y) e ajustadas por
   overlay 50/50 do render contra o modelo até bater <1mm.

**Conteúdo do corpo (reproduzir sem mexer; negrito nos campos):**
"O(a) Diretor(a) , no uso de suas atribuições, confere a  **NOME**, filho(a) de
**PAI E MÃE** nacionalidade **BRASILEIRA,** naturalidade **PARAUAPEBAS - PA,**
**RG/CPF NÚMERO ÓRGÃO,** nascido(a) em **DD/MM/AAAA,** por haver concluído no ano
letivo de  *__2025,__* **o Ensino Médio,** em virtude de sua aprovação no
referido nível de ensino, para que possa gozar dos direitos, e prerrogativas
concedidas aos portadores deste Título, pela Legislação de Ensino do País."
(ano em negrito+itálico; observações de fidelidade: há espaço antes da vírgula
em "Diretor(a) ," e dois espaços em "confere a  " e "letivo de  " — são do
modelo original). Data: "Parauapebas, DD de mês de AAAA." (dia com zero à
esquerda, com "de" antes do ano, cidade **sem** "-PA").

**Campos digitados:** aluno, nascimento, pai, mãe, nacionalidade (BRASILEIRA),
naturalidade (PARAUAPEBAS - PA), tipo+número+órgão do documento (RG/CPF), ano
letivo de conclusão, data de emissão; verso: registro nº, livro, folha,
observações. Botões Limpar / Imprimir. Campos vazios viram `____`.

**Impressão:** `@page{size:A4 landscape;margin:0}`, `.folha` com
`print-color-adjust:exact` (senão o brasão colorido não sai).

**Repositório GitHub:** `https://github.com/profadriano240/certificado-conclusao`
(privado, criado em 2026-09-08, branch `master`). Os SVGs "blank", os PNGs de
fundo e o `blank.py` estão versionados em `fontes/` — usar para reajustar o
layout no futuro.
