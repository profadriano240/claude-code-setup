---
name: projeto-site-luara-lacerda
description: "Site institucional estático para Luara Lacerda (@luaralacerdaa), advogada criminalista em Parauapebas/PA e esposa do Adriano — projeto pessoal, não é cliente pago, 1º deploy já no ar"
metadata: 
  node_type: memory
  type: project
  modified: 2026-10-14T22:47:07.569Z
  originSessionId: current
---

**Status (2026-10-14, sessão atual):** 1º deploy feito e no ar em
`https://luara-lacerda-advocacia.netlify.app` (site Netlify "luara-lacerda-advocacia", projectId
`c237871d-d58d-4a83-b522-b3ec312297e9`, team "AdrianoFreire001's team"; CLI logada localmente,
token persistido em `~/.netlify/config.json`). Repo `~/projetos/luara-lacerda-advocacia`
(git local, branch master) **ainda sem remoto no GitHub** — só o Netlify está conectado, via
deploy manual de pasta (`netlify-cli deploy --dir=site`), não via repo.

**Confirmado nesta sessão:** Luara é esposa do Adriano (não só "parceria pessoal" — ele aparece
comentando no Instagram dela como marido e em uma foto dela dentro de um presídio, legenda
"ministrada pelo meu esposo @profadrianofreire").

**Trabalho em andamento — pendência de fotos (regra nova do usuário: "no site pode haver apenas
fotos dela", nenhuma com terceiros):**
- Técnica que funciona para extrair foto em resolução melhor do Instagram: abrir o post
  individual (não a miniatura do grid), `mcp__claude-in-chrome__computer` ação `zoom` com
  `save_to_disk:true` na região da foto dentro do modal — captura em ~1.8x a resolução de tela
  (ganho real sobre o print de grid 350x350). Clique-direito "salvar imagem" NÃO funciona (menu
  nativo do browser não aparece pro automation). Extrair a URL do CDN via JS/network tampouco
  funciona — o tool redige (`REDACTED`) os parâmetros de assinatura da URL por segurança, URL fica
  inutilizável pra download direto.
- Já trocadas e regeneradas localmente (`gerar.py` já rodado), **mas o 2º deploy ainda NÃO foi
  feito** — parar aqui por limite de tokens, retomar com o deploy:
  - `luara-forum.jpg`/`forum.png` (hero da home + sobre.html): recapturada do post real do Fórum
    "Juiz Célio Rode...", crop 700x700.
  - `luara-bancada-juri.jpg`/`bancada-juri.png` (seção "Tribunal do júri" em sobre.html):
    **trocada** — a antiga tinha 2 colegas junto (violava a regra nova). Nova foto: "Audiência
    virtual de Instrução e Julgamento Criminal, Comarca de Xinguara/PA" (post `C6aKYZpO5-4`), só
    ela, crop horizontal 1056x720. Alt/figcaption já atualizados no HTML.
  - `luara-juri.jpg`/`juri-equipe.png` (home): **trocada** — a antiga era foto de formatura em
    grupo (4 pessoas). Nova é a MESMA foto da audiência virtual de Xinguara, crop vertical
    diferente (1072x1184). Alt/figcaption já atualizados no HTML.
  - `luara-atuacao.jpg` (São Luís/viatura, sobre.html): já estava boa (828x828, só ela) — mantida
    sem alteração.
  - Descartada: foto dela numa cela de presídio dando aula — tinha o próprio Adriano junto (2ª
    pessoa), não usar.

**Próximos passos ao retomar:**
1. Conferir visualmente o site local (`site/index.html` etc, já regenerado) antes de publicar.
2. 2º deploy: `cd ~/projetos/luara-lacerda-advocacia && npx --yes netlify-cli deploy --prod --dir=site`.
3. Git: nada foi commitado nesta sessão (fotos + HTML alterados) — considerar commit local (sem
   remoto ainda, não precisa de OK extra pra commit local, só pra criar remoto/push conforme regra
   do CLAUDE.md do repo).
4. O pedido do usuário ("faça deploy, resolva as pendências, faça deploy de novo") já é o OK
   explícito que o CLAUDE.md do repo exige pra essas duas publicações — não precisa pedir de novo
   só pra terminar o 2º deploy.

**Decisões já tomadas em sessões anteriores (ainda válidas):**
- Reaproveitar identidade visual REAL dela (logo "LL" hexagonal extraída do Instagram).
- Site estático, mesmo padrão de `imposto-da-bolsa`/`solar-offgrid`.
- "Flagrante 24h" como selo: usuário decidiu manter cortado (lado conservador).
- Casamentos (destaques "Religioso"/"Civil" do Instagram dela) são vida pessoal, NÃO entram no site.
- Monetização fora de escopo (site institucional, não faz parte do portfólio de renda).
- Compliance OAB (Provimento 205/2021) rígido: sem contador de casos, estrelas, depoimento,
  resultado, selo, "24h", "fale agora", pop-up — não reintroduzir sem repensar.
- Dois agentes (`diretor-luara`, `social-luara`) trabalharam nisso em background em sessão
  anterior; pauta de conteúdo pro Instagram dela já aprovada mas `social-luara` orientado a não
  produzir nada até o site estar no ar (agora já está).

**Why:** projeto de baixo envolvimento pra Luara ganhar presença profissional online; Adriano
trata como parceria pessoal (é a esposa dele), não trabalho pago — ver
[[feedback_baixo_envolvimento_redes_sociais]].
**How to apply:** manter tom sóbrio institucional; nunca colocar foto com terceiros reconhecíveis
no site (regra nova, 2026-10-14); nunca reintroduzir elementos de marketing agressivo vedados pela
OAB sem repensar o Provimento 205/2021 primeiro.
