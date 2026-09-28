---
name: projeto-cifras-ecc
description: "PDFs de cifras dos repertórios do ECC (Cifra Club) para imprimir em pasta; Sexta, Sábado e Faltantes (01–20) prontos, falta Domingo"
metadata:
  node_type: memory
  type: project
  originSessionId: 18a2b180-55db-48e8-9f58-a2b2f01d0e4e
  modified: 2026-09-24T15:24:44.031Z
---

Usuário monta pasta impressa com cifras do ECC a partir de repertórios no Cifra Club (perfil musico/1042029).
- Sexta: repertorio/56774988 → ~/Documentos/Cifras-Sexta-ECC/ (4 músicas, 4 pág) — PRONTO
- Sábado: repertorio/56775722 → ~/Documentos/Cifras-Sabado-ECC/ (9 músicas, 18 pág) — PRONTO
- Domingo: próximo passo, usuário vai mandar o link.
- Faltantes do roteiro (grifos verdes em ~/Downloads/Roteiro das Musicas ECC XXII.pdf), vindas do repertório 56034854 → ~/Documentos/Cifras-Faltantes-ECC/ (Alô Bom Dia em G (usuário corrigiu; repertório diz F), És Água Viva, Cristo é a Felicidade, Porque Ele Vive; 7 pág) — PRONTO 2026-09-24. Canto para as Refeições e cantos do cafezinho não estão no Cifra Club.
- 2026-09-25: adicionadas 05–20 na mesma pasta (links avulsos + repertório 56604289 com 8 músicas); Faltantes-ECC-completo.pdf = 46 pág (após versão minimalista; 01–04 rebaixadas via headless, 02 em 2 colunas). Headless voltou a funcionar nesse dia (gerar.sh direto).
- build.py corrigido: bloco <pre> vazio (parte só com tablatura) vira pre oculto, senão o título some em cifras divididas em várias partes. Modo 2 colunas NÃO funciona em cifras com vários <pre> (sobrepõe linhas) — usar 1 coluna.
- 2026-09-24: Cifra Club passou a dar 403 para curl/Chrome headless; contorno = ler o <pre> pela extensão Chrome (javascript_tool, trechos de ~850 caracteres, acordes como {X}), montar raw.html local (html font-size 10px, Lexend Deca/Roboto Mono via Google Fonts, acorde #FF7A00) e rodar build.py. fetch para localhost trava a aba (permissão de rede local).

Scripts permanentes em ~/projetos/cifras-ecc/: build.py (limpeza) e gerar.sh (baixa `imprimir.html#key=TOM` via Chrome headless --dump-dom, limpa, imprime PDF, junta com pdfunite). Lista de músicas/tons: dump-dom da página do repertório e grep dos href `#key=`.

Formato aprovado pelo usuário (tudo já no build.py):
- sem bloco [Ritmo Padrão]/bpm/tempos 1 2 3 4 e sem rótulos de seção ([Primeira Parte], [Refrão]...) — pedido 2026-09-25
- só título + letra cifrada (sem artista, compositor, tom, afinação, logo Cifra Club, diagramas de acordes, "Página x/y")
- sem tablaturas e sem acordes de intro/solo/partes sem letra (linha de acordes só fica se a próxima for letra)
- fonte 1,925rem (1,4 × 1,25 × 1,10)
- margens @page 18/12/15/20mm com !important (o site força @page{margin:0}); zerar padding lateral das section senão linhas quebram
- 1 coluna; 2 colunas (arg `2 force`) só se couber sem quebrar linha — ex.: Lenta e Calma Sobre a Terra
- conferir via miniatura pdftoppm, sem expor letra no chat

**Why:** usuário imprime e arquiva em pasta; quer leitura limpa e grande.
**How to apply:** no Domingo, rodar gerar.sh na pasta ~/Documentos/Cifras-Domingo-ECC e verificar páginas/tablatura restante.
