---
name: projeto-solar-offgrid
description: "App web offline curso+calculadora de energia solar off-grid, hospedado em solar-offgrid.netlify.app; estado, deploy e monetização AdSense (pendente)"
metadata: 
  node_type: memory
  type: project
  originSessionId: 771f1d29-2638-4af3-9c96-d7d0fba20c90
  modified: 2026-09-22T14:07:17.565Z
---

Criado em 2026-09-21 a partir de ~/Downloads/PROMPT_curso_solar_offgrid.md em ~/projetos/solar-offgrid. Leia o CLAUDE.md do próprio projeto para arquitetura e convenções.

**Hospedagem (2026-09-22):** repo GitHub privado `profadriano240/solar-offgrid` (branch master, `.netlify/` no .gitignore) + Netlify, site id `8eafdcbe-66cb-4d80-91db-7026561929eb`, team `adrianofreire001`, URL pública **https://solar-offgrid.netlify.app**. Deploy via Netlify MCP (`netlify-project-services-updater` → `create-new-project`, depois `netlify-deploy-services-updater` → `deploy-site`, que devolve um comando `npx @netlify/mcp@latest --site-id ... --proxy-path ...` a rodar localmente).

**Monetização Google AdSense (pendente, 2026-09-22):** usuário ainda não tem conta AdSense. Preparado no código: página `privacidade.html` (política de privacidade, cookies/anúncios, link em "Sobre" e no menu lateral) e `robots.txt`. Faltam depois que o usuário criar a conta em https://adsense.google.com: (1) adicionar o site solar-offgrid.netlify.app na conta AdSense para verificação, (2) criar `ads.txt` na raiz com a linha exata que o AdSense fornecer (contém o pub-ID — não adicionar antes de ter o valor real), (3) inserir o script de Auto ads (`<script async src="...adsbygoogle.js?client=ca-pub-XXXX">`) no `<head>` do `index.html`, (4) aguardar aprovação do Google (pode levar dias e exige tráfego/conteúdo original, que o site já tem).

**Why:** pedido do usuário em 2026-09-22 foi "hospedar e configurar para monetizar com AdSense"; escolheu o padrão GitHub+Netlify já usado em outros projetos (ver [[projeto_limite_vendas_acoes]]) e disse que ainda não tem conta AdSense.
**How to apply:** quando o usuário tiver o pub-ID do AdSense, inserir o script no `<head>` de `index.html` e de `privacidade.html`, criar `ads.txt`, commitar, dar push e rodar novo deploy Netlify (mesmo fluxo acima).

Estado: todos os itens do prompt implementados (13 módulos + quizzes, calculadora 4.1–4.11, simulação SOC, custos/LCOE/VPL/payback, relatório, export/import JSON, tema, testes.html com 69 asserções passando via `node js/testes.js`).

**Why:** usuário é professor de Matemática e quer entender as fórmulas; pediu offline total, sem CDN/framework.

**How to apply:** layout dá para ver em navegador real com `google-chrome --headless=new --no-sandbox --screenshot=arq.png --virtual-time-budget=4000 file://.../index.html#/curso/N` (chrome-devtools MCP não conecta). Em 2026-09-21 foram vistas só as figuras novas (~10, módulos 1,3,5–9,11,12); responsividade/impressão e figuras antigas seguem sem conferência visual. Figuras SVG em `js/figuras.js`, inseridas por `{{fig:nome}}` em `conteudo.js`. Bitola final agora = max(queda, ampacidade, fusível ≤ cabo) — decisão do usuário em 2026-09-21. jsdom 24 está em scratchpad da sessão (não persiste). Valores de preço/HSP/ciclos são exemplos.
