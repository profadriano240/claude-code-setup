---
name: projeto_certificado_conclusao_ensino_medio
description: "Gerador HTML do Certificado de Conclusão do Ensino Médio (EEEM Janelas para o Mundo), arquivo único, frente + verso A4 paisagem"
metadata: 
  node_type: memory
  type: project
  originSessionId: 217b5fa7-805b-4e0b-8d8e-bbfbf2557fa3
  modified: 2026-09-08T17:19:59.909Z
---

**Arquivo:** `~/projetos/certificado-conclusao/certificado-conclusao-ensino-medio.html`
(cópia também em `~/Downloads/`). Criado no Claude Code em 2026-09-08.

**Base:** partiu de `~/Downloads/diploma-ensino-medio-janelas.html` (gerador
antigo feito no claude.ai) e foi ajustado para bater **exatamente** com o
modelo oficial em `~/Downloads/certificado de conclusão/` (1.jpg = frente,
2.jpg = verso; também tem `cert.pptx` e `cert (44).pdf`). Segue o padrão do
`~/Downloads/CLAUDE.md` (arquivo único, sem dependências, sem storage, JS
baunilha, pt-BR).

**Estrutura:** formulário sticky (360px) + duas folhas A4 paisagem
(29,7×21cm) — frente (certificado) e verso (observações/registro). Brasão da
República em base64 no canto superior esquerdo; brasão do Pará como marca
d'água central (`.brasao-para`, ~10,6cm, opacity .5). Imagens são SVG base64
herdadas do arquivo diploma — daí o HTML ter ~305 KB.

**Decisões de fidelidade ao modelo (diferem da declaração de frequência):**
- Linha de data: `Parauapebas, 01 de setembro de 2026.` — cidade **sem
  "-PA"**, dia **com zero à esquerda**, **com "de"** antes do ano. (Na
  declaração de frequência é o contrário: com "-PA", dia sem zero, sem "de".)
- Corpo em fonte **sans** (Verdana/Arial), justificado, 1ª linha com recuo.
- Filiação sai **pai E mãe** (nessa ordem), em maiúsculas.
- No verso, "Registro na escola sob o nº / Livro / Na folha" saem em negrito
  na linha inteira; "Em dd/mm/aaaa" em peso normal.
- Trechos variáveis em negrito no corpo: nome, filiação, nacionalidade,
  naturalidade, "RG/CPF nº órgão", data de nascimento, ano (negrito itálico)
  e "o Ensino Médio".

**Campos digitados:** nome, nascimento, mãe, pai, nacionalidade (BRASILEIRA),
naturalidade (PARAUAPEBAS - PA), tipo+número+órgão do documento (RG/CPF),
ano letivo de conclusão, data de emissão, e p/ o verso: registro nº, livro,
folha, observações. Botões Limpar e Imprimir. Campos vazios viram `____`.

**Pendências:** não versionado no GitHub ainda (usuário costuma pedir
`gh repo create --private` — ver fluxo em [[projeto_declaracao_frequencia]]);
título "CERTIFICADO DO ENSINO MÉDIO" está em Times bold, não na fonte display
pesada do modelo (nenhuma fonte é embutida, por causa do padrão arquivo-único).
