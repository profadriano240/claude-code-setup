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

Progresso em 2026-09-30: O-1 concluída (14 alunos, E4:E17); P-1 com 58 alunos (E4:E61; E35 "PABLINE THIARA MORAIS SANTOS" não foi gravado pela Claude). 2026-10-01: P-2 com 56 alunos (E4:E59) após lotes 1 (27 folhas) e 2 (33 folhas). Usuário levou p/ caixa P-1 e tirou da P-2: P.H. SILVA ALVES, PAULO SIDNEY, PATRICK NERES. Lote 2 tem 3 que também estão na P-1 (P.H. CAVALCANTE MELO, P.H. PEREIRA LIMA, PRISCILA ARAUJO DE OLIVEIRA) — usuário decidiu manter. P-2 encerrada em 56. P-3 (2026-10-01): lote 1 = 37 folhas, 32 alunos E4:E35; 5 também em outras abas (PAULINA CANDIDO, PABLINE, PAULA EDUARDA, PAULLO MATHEUS BARBOSA na P-1; P.H. SILVA CARDOSO na P-2) — usuário decidiu manter. Lote 2 (18 folhas): +15 alunos → P-3 com 47 (E4:E50). Próximo lote em E51 (sessão encerrada 2026-10-01). R-1 (2026-10-08; aba criada pelo usuário, vazia): lote 1 = 26 folhas + reenvio de 2 → 26 alunos E4:E29 (RAQUEL FERREIRA DE SOUZA veio pela CNH da mãe Sandra; RAWANDERSON SILVA SANTOS pelo RG). Lote 3 (5 folhas): +5 → 31 (E4:E34). Lote 4 (5 folhas): +5 → 36 (E4:E39). Lote 5 (24 folhas): +20 → 56 (E4:E59); GRAZIELLA também incluída (gêmea de GRAZIELLE, confirmado) → 58; pulados: RAYANE repetida, RODRIGGO depois incluído (gêmeo de RAFHAEL, confirmado pelo usuário) → 57; CPF EMILLY VITORIA MARTINS MACHADO. Próximo em E62. R-2 (2026-10-08, criada pela Claude copiando R-1): lote 1 = 22 folhas, 22 alunos E4:E25; lote 2 = 15 folhas → 37; lote 3 = 20 folhas → 55 (E4:E58); próximo E59. Nomes quase iguais com mesmos pais/nascimento podem ser gêmeos — perguntar antes de descartar. ATENÇÃO: antes de criar aba, verificar se o usuário já criou (openpyxl renomeia duplicada p/ 'R-11').

**Regra do usuário (2026-10-01):** nome que já aparece em outra aba pode ficar nas duas — não precisa perguntar, só gravar (no máximo citar de passagem). Duplicado dentro da mesma aba continua sendo gravado uma vez só.

Método e script em ~/projetos/passivo-scan/ (LEIA-ME.md + escl_lote.py + backup da planilha). Ver [[referencia-scanner-kyocera]] para a HP.

**Why:** usuário cobrou várias vezes nomes faltando; a causa era o scanimage perder páginas, não folhas grudadas (o usuário acertou).
**How to apply:** usar escl_lote.py (nunca scanimage para ADF); pedir folha de controle já gravada no fim da pilha; ao terminar, informar quantas folhas foram lidas para o usuário bater com a contagem dele. Ser ágil e econômico em tokens ([[feedback-economia-tokens]]): grades de 2 páginas, gravar em lote numa só abertura do xlsx (cada abertura leva ~15s).

Painel (2026-10-01): artifact privado https://claude.ai/artifact/7Mvos9eG9V6rPXHwe6uFk3 . Atualizar: `python3 ~/projetos/passivo-scan/painel/gerar_painel.py` e republicar painel.html com a mesma URL.
