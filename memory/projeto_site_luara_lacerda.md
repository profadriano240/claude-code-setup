---
name: projeto-site-luara-lacerda
description: "Site institucional estático para Luara Lacerda (@luaralacerdaa), advogada criminalista em Parauapebas/PA — projeto pessoal/parceria, não é cliente pago, construído por agentes (diretor-luara + social-luara) em paralelo"
metadata: 
  node_type: memory
  type: project
  modified: 2026-10-14T04:28:53.543Z
  originSessionId: 94cc56e2-a488-408c-a1d2-b59db15e47ec
---

**Pedido original do usuário (2026-10-14):** "chame a equipe de social media para trabalhar em cima do perfil instagram.com/luaralacerdaa/ e crie um site". Ela é parceria pessoal do Adriano (não cliente formal), já sabe do projeto e topou. Trabalho parado em ~98% de uso do plano Claude — retomar daqui.

**Dados reais confirmados:** Luara Lacerda, OAB 32830/PA, Parauapebas/PA, WhatsApp +5594984501566, Instagram @luaralacerdaa. Endereço do escritório, e-mail e horário: NÃO confirmados ainda (placeholder no site).

**Repo:** `/home/adriano/projetos/luara-lacerda-advocacia` (git local, branch master, **NADA publicado/pushed** — ainda não existe remoto no GitHub, precisa de OK do usuário antes). Stack: HTML/CSS/JS estático + `gerar.py`, mesmo padrão de `imposto-da-bolsa`/`solar-offgrid`. Spec em `docs/superpowers/specs/2026-10-14-site-luara-lacerda-design.md`.

**Assets reais (extraídos do Instagram dela, não inventados):** logo "LL" hexagonal em `assets/logo-luara-lacerda.png` + `assets/logo-icone-variacoes.png` (criada por @othiagodesigner, paleta laranja/preto). Fotos em `assets/fotos/`: `forum.png` (BAIXA RESOLUÇÃO, 350x350, capturada por engano da miniatura do grid em vez do post aberto — **PENDENTE recaptura em ≥1080px**, é a foto do hero da home), `sao-luis.png` (boa, 828x828), `juri-equipe.png` e `bancada-juri.png` (ok mas moles em retina, 575x758, melhoria desejável não urgente), `perfil-redondo.png` (baixa res, só emergência).

**Dois agentes em background quando a sessão parou:**
- `diretor-luara` (diretor-portfolio): construiu o site completo (8 páginas: Início, Sobre, Áreas de Atuação por FASE do processo, Blog+3 artigos, Contato, Dúvidas Frequentes com FAQPage JSON-LD, Privacidade). Pesquisou referências BR/EUA/Argentina (BR tem modelo sóbrio vs agressivo-vedado-pela-OAB; EUA permite depoimento/resultado, regra lá é outra; Argentina foca em urgência 24h). Registrou no CLAUDE.md do repo o que descartou de propósito por compliance (contador de casos, estrelas, depoimento, resultado, selo, "24h", "fale agora", pop-up) — não reintroduzir sem repensar o Provimento 205/2021. Recusou usar a legenda "elogiados pela magistrada" na foto do júri por soar como depoimento de autoridade sobre o desempenho dela (mesma régua de compliance). Commits locais: 30a340e (site), 05bd7ce (FAQ+privacidade), 5a13ec2 (ajuste de imagem do hero pra não esticar o forum.png de baixa res). PENDENTE dele: recapturar forum.png em alta resolução (ele não tem acesso ao browser/Instagram, só eu/sessão principal tenho), e relatório final consolidado.
- `social-luara` (social-instagram): analisou o perfil, propôs pauta de 7 temas de conteúdo (ver abaixo), está OCIOSO/em espera — orientado a NÃO produzir nada ainda, só retomar quando o site estiver pronto.

**Pauta de conteúdo proposta pelo social-luara (aprovar antes de produzir):** 1) "Crimes que você pode cometer sem saber" (série, já é o formato de melhor desempenho dela — Reel com 2.815 views); 2) "Fui intimado à delegacia, e agora?"; 3) "Flagrante: as primeiras 24h"; 4) "Visita a pessoa presa: documentos e regras"; 5) "Audiência de custódia explicada"; 6) "Mitos e verdades do direito penal"; 7) "Glossário rápido" (flagrante, fiança, preventiva, indiciamento). Sugestão extra: criar destaque "Dúvidas"/"Direito Penal" no Instagram dela (hoje só existe o destaque "Advocacia", vazio de conteúdo educativo).

**Decisões já tomadas com o usuário:**
- Reaproveitar identidade visual REAL dela (não criar nova) — aprovado.
- Site estático (não React/scaffold antigo abandonado que existia em `~/Documentos/site-advogada-criminalista`, projeto genérico não relacionado a ela — não usar, não mexer).
- "Flagrante 24h" como selo/badge: usuário decidiu MANTER CORTADO (lado conservador), mesmo eu achando que não seria promessa de resultado — respeitar a decisão dele.
- Casamentos (destaques "Religioso"/"Civil" do Instagram dela) são vida pessoal, NÃO entram no site.
- Monetização (AdSense/afiliado): usuário perguntou se dava pra fazer, recomendei que NÃO (site institucional profissional não combina com anúncio, baixo tráfego não compensa, risco de imagem/compliance) — ele não decidiu nada ainda, mas diretor-luara já deixou escrito no CLAUDE.md do repo que é fora de escopo.
- Artigos do blog devem linkar notícias/fontes reais como referência ilustrativa (pedido do usuário) — já feito em 2 dos 3 artigos (STF, CPP, CNJ, Conjur), falta o 3º (inquérito x ação penal).

**Próximos passos ao retomar:**
1. Recapturar `forum.png` em alta resolução (abrir o post dela no Instagram, não a miniatura do grid — mesma técnica que funcionou pra `sao-luis.png`: `mcp__claude-in-chrome__computer` ação `zoom` na região do lightbox do post aberto, salvar com `save_to_disk`, copiar pro repo, `git add`+commit).
2. Checar se diretor-luara terminou o 3º artigo com fontes e o relatório final.
3. Revisar o site gerado (`gerar.py`) antes de qualquer deploy — NADA foi publicado ainda, precisa de OK explícito do usuário pra criar repo remoto no GitHub e conectar Netlify.
4. Decidir quando liberar o social-luara pra produção de conteúdo (hoje só tem pauta aprovada).

**Why:** projeto de baixo envolvimento pra Luara ganhar presença profissional online; Adriano trata como parceria, não trabalho pago — ver [[feedback_baixo_envolvimento_redes_sociais]] pro padrão geral de como ele prefere esse tipo de trabalho (Claude produz/publica, ele aparece o mínimo).
**How to apply:** manter tom sóbrio institucional, nunca adicionar de volta os elementos que o diretor-luara descartou por compliance OAB sem repensar o Provimento 205/2021 primeiro.

**Versão do notebook DESCARTADA (decisão do usuário, 14/10):** seguir só com a do desktop (`~/projetos/luara-lacerda-advocacia`). Pasta do notebook movida para ~/.cache/claude-temporario (some em 7 dias); repo GitHub profadriano240/site-luara-lacerda ainda existe — apagar só com o usuário rodando `gh repo delete` (classificador bloqueou). Usuário pediu para pôr no ar o site do desktop: ele NÃO está no GitHub; no desktop, criar repo privado + push, depois deploy Netlify (resolver antes: forum.png em alta, endereço/e-mail, 3º artigo).
