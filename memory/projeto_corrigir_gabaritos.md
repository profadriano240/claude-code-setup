---
name: projeto-corrigir-gabaritos
description: Correção de cartões-resposta por foto (OMR OpenCV) → PDF de notas em ordem alfabética; comando `corrigir`
metadata:
  type: project
---
Criado 2026-10-07 em ~/projetos/corrigir-gabaritos (omr.py + corrigir.py; comando `corrigir ler|pdf [PASTA]`, pasta padrão `fotos/`).
Cartão da EEEM Janelas para o Mundo: 40 questões A–E, 0,1 ponto cada (nota máx. 4,0). Gabarito = `gabarito.txt` (X = anulada) ou foto/PDF `gabarito*` na pasta. Aceita digitalizações (JPEG/PNG ou PDF multipágina, 1 folha/página; `digitalizar` serve).
Lista oficial da M2TNM01 (33 alunos, 3º Simulado 07/10/2026) em fotos/alunos.txt; nomes lidos são casados com ela (difflib) e quem não tem folha sai "ausente".
1ª correção feita 2026-10-07 (M2TNM01, 32 folhas, média 1,88; PDF copiado p/ ~/Downloads). Fotos reais exigiram: canto da moldura fora da foto (recuperado prolongando lados) e vários candidatos de moldura validados pela grade 10×5.
Produto final desejado = JPEG da folha de FREQUÊNCIA assinada (PDF escaneado) com as notas na coluna em branco entre nome e assinatura: frequencia/inserir_notas.py (detecta linhas, fonte Carlito). Saída M2TNM01 em ~/Downloads/frequencia_notas_M2TNM01.jpg.
OpenCV instalado via pip --user (opencv-python-headless 5.0). Calibrado só com o modelo em branco + marcas simuladas — limiares (MARCADA 0.18 / DUVIDA 0.11 de contraste) ainda não validados com fotos reais.

**How to apply:** ao receber as fotos: `corrigir ler`, ler os recortes em correcao/nomes/ e preencher "nome" (e "turma") no leitura.json, conferir em correcao/marcas/ as questões listadas em "duvidas" (corrigir via "ajustes": {"10":"C"}), depois `corrigir pdf`. Ver [[referencia-diario-classe-seduc-pa]] se for lançar as notas.
