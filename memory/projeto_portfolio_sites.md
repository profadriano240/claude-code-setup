---
name: projeto-portfolio-sites
description: "Portfólio de blogs SEO anônimos (AdSense + afiliados), repo central profadriano240/portfolio-sites com estado e clonar.sh"
metadata: 
  node_type: memory
  type: project
  originSessionId: 09f82023-8822-41f7-8a38-56c5d84cef41
  modified: 2026-10-08T03:59:02.600Z
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
5. ~~Se produtor Hotmart não responder até ~09/10, abandonar Hotmart nesse nicho~~ — superado:
   descoberto em 2026-10-04 que a conta já tinha 2 afiliações ativas (ver acima); link do curso
   ID 1169630 publicado no slot `curso-ir`. Ainda restam 2 pedidos pendentes desde 02/10
   (ID 1777009, ID 1202583) — acompanhar aceite do produtor.
6. Acompanhar indexação dos 9 guias novos no Search Console (Páginas → indexadas) nos próximos dias.
7. Slots "planilha" e "iniciante" ainda vazios — procurar produto Hotmart (ou Amazon, após #4) que
   encaixe pra preencher.

**Divulgação no Instagram (desde 2026-10-04):** perfil pessoal do usuário `@profadrianofreire` (856
seguidores, já é conta de finanças pessoais — bio fala de ações/análise, feed tem conteúdo de
investimento) passou a divulgar o Imposto da Bolsa. Bio tem link de captura de leads
(`adrianofreire-h5hnp5.subscribepage.io`, guia grátis) — **link da bio só edita pelo app do
celular, não pelo Chrome/web** (Instagram bloqueia essa edição no desktop); usuário decidiu trocar
esse link pelo site, mas precisa fazer manualmente no celular. Postados via Chrome logado
(`mcp__claude-in-chrome`) + upload de imagem local (`file_upload`) + `Compartilhar em: Facebook`
mantido ligado (cross-post automático pro Facebook "Adriano Freire Rodrigues"):
1. Post single-image sobre o site (guias de IR) — feito 2 vezes: 1ª versão em 4:5 cortava texto no
   grid (Instagram crop quadrado no perfil), refeita em 1:1 (1080x1080) e a antiga apagada.
2. Carrossel de 8 slides sobre "ganhar na bolsa independente da eleição" — conteúdo educativo real
   (o que move o preço de uma ação, volatilidade eleitoral ≠ veredito, 3 táticas: diversificar,
   aportar todo mês, reserva de emergência, pensar em anos) com fotos reais do Pexels (banco
   gratuito, uso comercial livre — `images.pexels.com/photos/<id>/pexels-photo-<id>.jpeg` sem
   query string; pegar o ID da URL da página do Pexels, não do `og:image`, que às vezes aponta pra
   foto promovida errada) + overlay de texto via Pillow. Fecha em loop visual (slide 6 repete a
   pose do slide 1). Script gerador: `/tmp/.../scratchpad/gerar_carrossel.py` (não versionado,
   scratchpad de sessão — recriar se precisar).
Gamma (`mcp__claude_ai_Gamma__generate_image`) ficou sem créditos (plano free, 0 restantes) —
não dá pra gerar fotos realistas por IA até o usuário fazer upgrade em
gamma.app/settings/billing.

**Como retomar em máquina nova:** clonar [[referencia_backup_claude_code_setup]] primeiro (restaura
memória), depois `gh repo clone profadriano240/portfolio-sites` + rodar `clonar.sh`. Conectores
claude.ai usados: Netlify, Gmail. Chrome de casa logado em Google/Search Console/AdSense/Hotmart.

**Checado em 2026-10-05:** nada mudou nos pontos monitorados desde 04/10 (AdSense ainda sem
resposta, 3 dias; Hotmart 2 pedidos ainda pendentes; indexação dos 9 guias ainda não confirmada).
Commits do dia foram só organizacionais: criação de equipe de 5 agentes (diretor-portfolio,
social-instagram, seo-conteudo, monetizacao, analista-dados) e ajuste do `analista-dados` pra
incluir GA4 no relatório. Primeiro relatório semanal do analista-dados previsto pra sexta 2026-10-09
em `relatorios/2026-10-09.md`. **GA4 ativado em 2026-10-05:** propriedade "Imposto da Bolsa" criada
na conta Google Analytics "Prof. Adriano Freire" (conta 324032885), stream Web
`www.impostodabolsa.com.br`, measurement ID `G-X1TB31SRTC` colado em `GA_ID` no `gerar.py`
(repo local `/home/adriano/projetos/imposto-da-bolsa`, não `/home/adriano/imposto-da-bolsa` que
está desatualizado), commit `e635200` + push + deploy Netlify feitos. Coleta de dados pode levar até
48h pra começar a aparecer nos relatórios GA4. Outras contas Analytics do usuário: "Adriano
Rodrigues" (105240587) e "IZI Semijoias" (317346258, já tem propriedade própria) — não usadas aqui.

**Indexação checada em 2026-10-05:** 8 dos 9 guias novos (04/10) já indexados no Google (opções,
fiagro, futuros/mini contratos, herança/doação, malha fina, obrigatoriedade, direito de subscrição,
ação que faliu). Só `declarar-acoes-eua-sem-bdr` (ações dos EUA sem BDR) ainda não — Search Console
mostrava "detectada, mas não indexada no momento"; solicitada indexação manual nesse dia, checar
depois se entrou.

**Decisão do usuário (2026-10-05):** por ora não mexer em Amazon Associados (item 4 da lista de
próximos passos fica parado). Usuário perguntou como trabalhar com a equipe de agentes
(diretor-portfolio, social-instagram, seo-conteudo, monetizacao, analista-dados) de forma mais
interativa — ver [[feedback_economia_tokens]] e ajustar conforme resposta dada nessa conversa.

**Why:** novo projeto não documentado em memória antes de 2026-10-04 — só descoberto ao usuário
colar a URL do repo.
**How to apply:** ao tocar qualquer site do portfólio, checar README do repo central primeiro
(estado muda rápido — AdSense/Hotmart têm prazos e respostas pendentes).

**Sessão 2026-10-07/08 (Instagram):** post "5 erros de IR" (evergreen) foi ao ar 07/10 com a foto
nova (estúdio) na capa, o Adriano achou envelhecida, pediu pra apagar e recriar. Trocada pela foto
antiga (`pessoa.png` de `2026-10-05-bbas3-eleicao`, recortada sem fundo) mantendo o fundo bege do
slide, sem a legenda "Prof. Adriano" embaixo — isso virou o padrão novo pra capa. Republicado e
turbinado: R$21 + taxas (total R$23,89) por 3 dias, objetivo "visitar perfil", no MasterCard
····8978, cobrança só após aprovação do anúncio. CSV `relatorios/instagram-posts.csv` atualizado.

**Destaques do perfil:** perfil não tinha nenhum. Preparados 4 stories em
`imposto-da-bolsa/instagram/destaques-perfil/` (Erros de IR, Calculadoras, Guias, Sobre — o Adriano
pediu pra pular o "Sobre"). **Travado:** Instagram web não deixa postar Story novo nem criar
destaque a partir de upload direto — só a partir de Stories que já existem/arquivados. Falta o
Adriano postar os 3 stories (erros-de-ir, calculadoras, guias) pelo celular; depois disso dá pra
criar os destaques (um "Novo destaque" por story, escolhendo da lista que aparece).

**Regra nova (vetada/ajustada 08/10/2026):** a foto do Adriano não precisa aparecer em todo post —
documentado em `agentes/social-instagram.md`, vale a partir do lote L3 (commit `667c18a`). Os 3
posts já agendados (irrf-dedo-duro 09/10, fii 14/10, dividendos-jcp 16/10) ficam como estão.

**Lote L3 (#4-6, agenda-instagram.md) preparado pelo agente social-instagram em 08/10/2026**
(commit `694c033`), ainda SEM aprovação do Adriano nem agendamento:
- `2026-10-19-preco-medio` — foto só na capa. OK na revisão.
- `2026-10-21-day-trade` — sem foto na capa, foto só no slide 4. **Bug achado na revisão:** a foto
  sobrepõe o texto do slide 4 — os cards "resultado do mês" / "20% de imposto" ficam vazios (sem os
  valores R$2.200/R$440 que o agente disse ter usado) e o box do IRRF/DARF fica cortado atrás da
  foto. Precisa re-renderizar esse slide antes de aprovar o lote.
- `2026-10-23-isencao-20-mil` — sem foto nenhuma. OK na revisão.

**Como retomar (inclusive de outra máquina via sync de memória):** 1) corrigir o slide 4 de
`2026-10-21-day-trade` (mover a foto ou tirar, ajustar layout pra não sobrepor os cards); 2) revisar
o lote L3 de novo com o Adriano; 3) agendar os 3 no Meta Business Suite e registrar no CSV; 4)
pedir pro Adriano postar os 3 stories de destaque pelo celular e então criar os destaques no
perfil.
