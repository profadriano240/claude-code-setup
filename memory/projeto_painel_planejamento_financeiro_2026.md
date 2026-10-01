---
name: projeto-painel-planejamento-financeiro-2026
description: Planilha Google "Planejamento Financeiro 2026" (abas mensais Receitas/Fixas/Variáveis) e painel artifact que a lê ao vivo
metadata:
  type: project
---
Planilha: https://docs.google.com/spreadsheets/d/1wZP25nl6htLMzbxWhbOxG9hfj6MCOMUzK8y0vLKnKts (abas Geral, Adriano, Luara, Abril…Outubro; colunas A/B/C receitas+data, D/E fixas, F/G variáveis, H "Restante" com fórmula).
Painel (2026-10-01): artifact https://claude.ai/artifact/C7YgbgsnVuAHhtxwMQwwi7, fonte local no scratchpad da sessão; lê via conector Google Drive (download_file_content → xlsx → SheetJS). Detecta abas por nome de mês, então novos meses entram sozinhos.
Outubro foi preenchido em 2026-09-30 com recorrentes de setembro. Fórmula H a partir da linha 13 usa E da linha anterior (bug pré-existente, correção oferecida e não feita).
**How to apply:** sem conector Sheets nesta máquina; edições na planilha via Chrome (digitar célula a célula com Tab/Enter — colar e \t no type não funcionam).
