---
name: projeto-livro-registro-certificados
description: "Livro de registro de certificados do ensino médio — fluxo de escaneamento (HP pelo ADF), dados.json + gerar.py, regras definidas pelo usuário"
metadata:
  node_type: memory
  type: project
  originSessionId: 3647fad5-03f7-4822-b734-767bd36977df
  modified: 2026-10-06T23:15:30.324Z
---

Livro de registro dos certificados do Ensino Médio (Escola Janelas para o Mundo). Modelo: `~/Documentos/históricos 2026/TERMO DE REGISTRO DE CERTIFICADO       Nº.docx` (2 termos por folha A4). Gerador: `~/projetos/livro-certificados/gerar.py` + `dados.json` (ordenado por Nº); saída em `~/Documentos/históricos 2026/livro-certificados/` (DOCX + PDF). Teste de 2026-10-06 com Nºs 605–612 (folhas 299–302, Livro 009) gerado.

**Fluxo:** usuário escaneia todas as frentes e depois todos os versos na mesma ordem; scanner é a HP LaserJet MFP E42540 pelo ADF (`scanimage -d 'escl:http://localhost:60000' --source ADF --batch`), NÃO a "bandeja multiuso" (essa é de impressão). Frentes saem giradas 90°; eu leio as imagens (sem tesseract). Nº, Folha e data de registro vêm do verso ("Registro na escola sob o nº / Livro / Na folha / Em"). Parear frente↔verso pela data de emissão como conferência.

**Regras do usuário:** campo documento = "CPF nº" ou "RG nº" conforme o que o certificado traz; "Novo Ensino Médio" = "Regular"; só mãe na filiação → preencher só o nome dela; valores em MAIÚSCULAS e sublinhados.

**Why:** fonte Calibri do modelo não existe no Debian; instalei Carlito em ~/.fonts para o PDF caber (sem ela vira 8 páginas).
**How to apply:** ao receber novos lotes, ler as imagens, acrescentar em dados.json e rodar gerar.py; conferir contagem frentes×versos antes (houve 7 frentes × 8 versos no teste).
