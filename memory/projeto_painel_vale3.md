---
name: projeto_painel_vale3
description: Painel web VALE3 (operações da planilha + cotações, Selic, IPCA, dólar, minério) em ~/projetos/vale3-analise, publicado como artifact privado
metadata:
  type: project
---
Criado em 2026-09-25. Artifact privado: https://claude.ai/artifact/Km6fnDDR4qiMnz6zK4ycMP (index.html gerado de painel.template.html).
- Atualizar: baixar a planilha de novo como xlsx via Drive MCP (id original 1Hbrt-zJ...) para `dados/mf.xlsx`, rodar `python3 gerar_dados.py --baixar` e republicar index.html no mesmo URL.
- Operações vêm de `(IR) Ações` B10:E72 (data, qtd, valor nota); proventos da planilha só têm 2 lançamentos → painel estima pelo Yahoo (bruto) × posição na data-com.
- Minério = Yahoo `TIO=F` (62% Fe COMEX); Selic SGS 11/432, IPCA 433 (mensal), dólar SGS 1.
- Usuário recusou abrir a planilha no navegador nesta sessão; ler via Drive export funcionou. Ver [[projeto_auditoria_planilha_mercado_financeiro]].
