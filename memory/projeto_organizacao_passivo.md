---
name: projeto-organizacao-passivo
description: Listar nomes de alunos das folhas do passivo (via ADF da HP) nas abas da planilha ORGANIZAÇÃO GERAL _PASSIVO _ 2026.xlsx; progresso e método
metadata:
  node_type: memory
  type: project
  originSessionId: 1c23affb-4c1e-4cf0-9ac5-d656c0d30b0f
  modified: 2026-10-01T00:12:49.151Z
---

Planilha: ~/Documentos/ORGANIZAÇÃO PASSIVO/ORGANIZAÇÃO GERAL _PASSIVO _ 2026.xlsx. Cada aba = caixa (A-1…P-1). Usuário põe folhas na bandeja da HP; Claude digitaliza, lê o nome e grava na coluna E a partir de E4 (MAIÚSCULAS, ordem das folhas, sem duplicar).

Progresso em 2026-09-30: O-1 concluída (14 alunos, E4:E17); P-1 com 58 alunos (E4:E61; E35 "PABLINE THIARA MORAIS SANTOS" não foi gravado pela Claude). **Retomar em 2026-10-01 pela aba P-2** (não existe ainda: copiar P-1 com openpyxl copy_worksheet, limpar E4:E99, C4="P2").

Método e script em ~/projetos/passivo-scan/ (LEIA-ME.md + escl_lote.py + backup da planilha). Ver [[referencia-scanner-kyocera]] para a HP.

**Why:** usuário cobrou várias vezes nomes faltando; a causa era o scanimage perder páginas, não folhas grudadas (o usuário acertou).
**How to apply:** usar escl_lote.py (nunca scanimage para ADF); pedir folha de controle já gravada no fim da pilha; ao terminar, informar quantas folhas foram lidas para o usuário bater com a contagem dele. Ser ágil e econômico em tokens ([[feedback-economia-tokens]]): grades de 2 páginas, gravar em lote numa só abertura do xlsx (cada abertura leva ~15s).

Painel (2026-10-01): artifact privado https://claude.ai/artifact/7Mvos9eG9V6rPXHwe6uFk3 . Atualizar: `python3 ~/projetos/passivo-scan/painel/gerar_painel.py` e republicar painel.html com a mesma URL.
