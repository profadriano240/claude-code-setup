---
name: projeto-portfolio-sites
description: "Portfólio de blogs SEO anônimos (AdSense + afiliados), repo central profadriano240/portfolio-sites com estado e clonar.sh"
metadata: 
  node_type: memory
  type: project
  originSessionId: 09f82023-8822-41f7-8a38-56c5d84cef41
  modified: 2026-10-05T01:46:37.013Z
---

Repo central privado https://github.com/profadriano240/portfolio-sites (branch `master`) guarda
README com estado atual + `docs/blueprint-agentes-portfolio-sites.md` (estratégia: blogs SEO
anônimos, AdSense + afiliados, baixo envolvimento pessoal) + `clonar.sh` (clona/atualiza cada site
repo ao lado: `imposto-da-bolsa`, `solar-offgrid`).

**Site 1 — Imposto da Bolsa**: produção https://www.impostodabolsa.com.br (Netlify, site id
`80e19e69-2fec-4ac2-a76e-a6138013dbbe`). Fluxo: editar `conteudo/artigos/*.html` → `python3 gerar.py`
→ `site/`, commit+push, deploy via MCP Netlify (`netlify-deploy-services-updater` operation
`deploy-site`, pedir OK antes de publicar — o comando `npx @netlify/mcp` retornado tem token longo
no `--proxy-path` e o classificador do Bash costuma bloquear por parecer suspeito; precisa
`dangerouslyDisableSandbox: true` com autorização explícita do usuário). 25 guias + calculadoras
(isenção, preço médio, DARF), 31 URLs no sitemap (reenviado e processado no Search Console em
2026-10-04). AdSense conta `pub-6370131226236609`, revisão pedida 2026-10-02, sem resposta até
2026-10-04.

Afiliados (dicionário `AFILIADOS` em `gerar.py`, marcador `<!--AFILIADO:id-->` nos artigos, slot
só mostra caixa se `url` não vazio): checado em 2026-10-04 o painel Hotmart (Produtos → Sou
Afiliado(a) → Afiliações confirmadas, em app.hotmart.com/products/affiliations) e a conta JÁ TINHA
2 afiliações ativas no nicho de IR/bolsa (o pedido antigo ID 1325746 "Declaração de IR em Ações"
sumiu do painel — provavelmente recusado/expirado, não aparece mais nem em confirmadas nem em
solicitadas):
- ID 368472 "Curso Online: Imposto de Renda na Bolsa de Valores" — hotlink
  `https://go.hotmart.com/V107892369K`, oferta única R$197 (não usado ainda).
- ID 1169630 "Imposto de Renda sobre Operações em Bolsa de Valores" — hotlink
  `https://go.hotmart.com/O107892367N`, produto mais maduro (cupom sindicalizados, múltiplas
  ofertas/checkout). **Escolhido pelo usuário** e ativo no slot `curso-ir` (9 artigos) desde
  2026-10-04, deploy feito.
- 2 pedidos pendentes desde 02/10/2026 (aba "Solicitadas"): ID 1777009 "Curso Imposto de Renda da
  Bolsa" e ID 1202583 "Treinamento Imposto Sobre Renda Variável" — aguardando aceite do produtor.

Slots "planilha" (6 artigos) e "iniciante" (2 artigos) continuam vazios — nenhum produto afiliado
ainda se encaixa neles.
**Nota:** hoplink próprio redireciona pro painel Hotmart ao abrir logado (antifraude anti-self-click)
— não dá pra visualizar a sales page dos próprios produtos afiliados assim, precisa visitar sem
sessão ou pedir pro usuário.
Em 2026-10-04 foram adicionados 9 guias novos (opções, direito de subscrição, obrigatoriedade de
declarar, herança/doação, malha fina, Fiagro, futuros/mini contratos, ações dos EUA sem BDR, ação
que faliu/saiu da bolsa) — commitados, deploy feito, sitemap reenviado no mesmo dia.

**Site 2 — Solar Off-Grid**: produção https://solar-offgrid.netlify.app (site id
`8eafdcbe-66cb-4d80-91db-7026561929eb`). App offline (curso+calculadora), AdSense script + `ads.txt`
já publicados. Falta adicionar em AdSense → Sites e pedir revisão.
**Em pausa a pedido do usuário desde 2026-10-04 — não mexer até ele pedir.**

**Próximos passos (ordem, conforme README em 2026-10-04):**
1. ~~AdSense → Sites → adicionar solar-offgrid.netlify.app~~ — adiado (ver pausa acima).
2. ~~Search Console → reenviar sitemap.xml~~ — feito em 2026-10-04 (31 URLs).
3. ~~Leva de 8–10 guias novos~~ — feito em 2026-10-04 (9 guias, ver acima).
4. Criar conta Amazon Associados (só dono pode) → caixa "iniciante".
5. Se produtor Hotmart não responder até ~09/10, abandonar Hotmart nesse nicho, avaliar programas
   de indicação de corretoras.
6. Acompanhar indexação dos 9 guias novos no Search Console (Páginas → indexadas) nos próximos dias.

**Como retomar em máquina nova:** clonar [[referencia_backup_claude_code_setup]] primeiro (restaura
memória), depois `gh repo clone profadriano240/portfolio-sites` + rodar `clonar.sh`. Conectores
claude.ai usados: Netlify, Gmail. Chrome de casa logado em Google/Search Console/AdSense/Hotmart.

**Why:** novo projeto não documentado em memória antes de 2026-10-04 — só descoberto ao usuário
colar a URL do repo.
**How to apply:** ao tocar qualquer site do portfólio, checar README do repo central primeiro
(estado muda rápido — AdSense/Hotmart têm prazos e respostas pendentes).
