---
name: projeto-cifras-ecc
description: "PDFs de cifras dos repertórios do ECC (Cifra Club) para imprimir em pasta; Sexta e Sábado prontos, falta Domingo"
metadata:
  node_type: memory
  type: project
  originSessionId: 18a2b180-55db-48e8-9f58-a2b2f01d0e4e
  modified: 2026-09-24T15:24:44.031Z
---

Usuário monta pasta impressa com cifras do ECC a partir de repertórios no Cifra Club (perfil musico/1042029).
- Sexta: repertorio/56774988 → ~/Documentos/Cifras-Sexta-ECC/ (4 músicas, 4 pág) — PRONTO
- Sábado: repertorio/56775722 → ~/Documentos/Cifras-Sabado-ECC/ (9 músicas, 18 pág) — PRONTO
- Domingo: próximo passo (2026-09-24), usuário vai mandar o link.

Scripts permanentes em ~/projetos/cifras-ecc/: build.py (limpeza) e gerar.sh (baixa `imprimir.html#key=TOM` via Chrome headless --dump-dom, limpa, imprime PDF, junta com pdfunite). Lista de músicas/tons: dump-dom da página do repertório e grep dos href `#key=`.

Formato aprovado pelo usuário (tudo já no build.py):
- só título + letra cifrada (sem artista, compositor, tom, afinação, logo Cifra Club, diagramas de acordes, "Página x/y")
- sem tablaturas e sem acordes de intro/solo/partes sem letra (linha de acordes só fica se a próxima for letra)
- fonte 1,925rem (1,4 × 1,25 × 1,10)
- margens @page 18/12/15/20mm com !important (o site força @page{margin:0}); zerar padding lateral das section senão linhas quebram
- 1 coluna; 2 colunas (arg `2 force`) só se couber sem quebrar linha — ex.: Lenta e Calma Sobre a Terra
- conferir via miniatura pdftoppm, sem expor letra no chat

**Why:** usuário imprime e arquiva em pasta; quer leitura limpa e grande.
**How to apply:** no Domingo, rodar gerar.sh na pasta ~/Documentos/Cifras-Domingo-ECC e verificar páginas/tablatura restante.
