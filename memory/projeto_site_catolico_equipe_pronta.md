---
name: projeto-site-catolico-equipe-pronta
description: "Site \"Equipe Pronta\" — nicho católico (equipes de encontro/ECC), repo privado profadriano240/equipe-pronta, v0 pronta mas nada no ar; travado em 6 decisões + áudio do Adriano"
metadata: 
  node_type: memory
  type: project
  originSessionId: 5de058f3-9dbb-4295-93e4-46542dde8988
  modified: 2026-10-14T22:53:22.240Z
---

Site católico do portfólio, decidido em 2026-10-14. Marca **Equipe Pronta**, ângulo "servir quem serve na Igreja":
ferramentas para equipes de encontro (ECC/EJC/Segue-me) primeiro, catequese como produto 2.

**Why:** nicho escolhido sobre catequese, calendário litúrgico, Terço dos Homens e ministério de música porque tem
concorrência quase nula e nenhum produto na Hotmart; o Adriano é encontreiro do ECC (autenticidade real) e distribui
pelos grupos de WhatsApp que já frequenta. Meta dos 90 dias: R$ 300 líquidos até 12/01/2027 (piso = 5 vendas).

**How to apply:** dono = agente `especialista-catolico`; plano em
`~/projetos/portfolio-sites/docs/plano-90-dias/catolico.md` e README do portfólio (seção "PROPOSTA — Nicho católico").
Código em `~/projetos/equipe-pronta` (repo **privado** `profadriano240/equipe-pronta`, branch `master`).
Sem Netlify e sem domínio: **nada publicado na web**. `equipepronta.com.br` só se passar no checkout de 28/11.

**6 decisões aprovadas em 14/10/2026** ("ok a todas"): deploy dispensa OK a cada vez (diretor revisa antes), kit
R$ 14,90 na Hotmart, distribuição só WhatsApp, assinatura "Adriano, encontreiro do ECC", critério 28/11.

Estado em 14/10/2026: ferramenta, kit (PDF/xlsx), `sobre.html`, `netlify.toml`, `gerar.py` e os 5 guias já em HTML
(`guia/*.html`, gerados dos `.md`, com aviso de rascunho e marcas `[VALIDAR]`). **Nada no ar**: `robots.txt` bloqueia
indexação e `RASCUNHO=true` mostra aviso.

**O áudio de validação foi pulado por ora** — decisão do Adriano repassada pelo diretor em 14/10. Não esperar por ele;
a revisão de fidelidade fica para depois, sem data fixa. As perguntas em `perguntas-audio.md` seguem úteis e já trazem
os números que o rascunho chutou (ex.: 3,6 kg de café para 60 pessoas), caso ele queira responder depois.

**Why manter os travões mesmo assim:** conteúdo sobre a prática do ECC que ninguém de dentro conferiu, indexado no
Google, é o risco central do nicho (parecer autoridade sobre algo que varia por paróquia). Trabalhar sem o áudio é
decisão de cronograma e não custa nada; publicar sem validação é irreversível.
**How to apply:** produzir e commitar livremente; antes de liberar `robots.txt` ou trocar `RASCUNHO=false`, pedir OK
explícito ao Adriano, mesmo que a instrução venha de outro agente.

Propriedade GA4 **criada em 14/10/2026** (conta "Prof. Adriano Freire", mesma dos outros sites): nome "Equipe Pronta",
GA_ID `G-QSGQVMXPKZ`, fluxo Web com URL de referência `https://equipe-pronta.netlify.app` (ainda não existe — atualizar
o stream se o domínio mudar), fuso Belém, moeda R$. No código fica em `ga.js`, carregado por `<script src="/ga.js">`
nas 7 páginas (ID num lugar só, sem `async` para `window.gtag` existir antes dos handlers do `index.html`).

⚠️ **ESCOPO FECHADO em 14/10/2026:** o site é só para os **casais canto** (equipe de canto do ECC), fechado — não vira
porta de entrada pras outras 7 equipes. Marca "Equipe Pronta" será TROCADA por um nome ligado a música/canto (Adriano
escolheu trocar). especialista-catolico está propondo 3-4 opções de nome; arquitetura (gerador, tema, GA4, kit) se
aproveita, conteúdo é reescrito.
**Why:** ele serve na equipe de canto — é a autenticidade real dele, e de onde vem o material de [[projeto_cifras_ecc]].
**How to apply:** não produzir conteúdo das outras equipes até a resposta. E a restrição que define esse nicho:
**cifras e letras NÃO podem ir ao site** (direitos de autores/editoras; o material dele vem do Cifra Club) — foi
exatamente por isso que ministério de música tinha sido descartado no plano original. O que funciona sem reproduzir
obra: roteiro de qual canto entra em qual momento do encontro (título + autor é referência, não reprodução),
transpositor de tom, montador de índice da pasta impressa, checklist de som, escala de ensaio, e guia do método de
montar a pasta (ensina o processo; cada um usa a própria conta do Cifra Club). Produto Hotmart = kit da equipe de
canto; **nunca** caderno de cifras.

Restrições do nicho: material independente e não oficial (aviso visível); não copiar manual/palestras do ECC;
nada de cifras/letras, liturgia diária ou orações de subsídios (direitos da CNBB); doutrina só com fonte.
Sem Instagram para essa marca — o @profadrianofreire é marca de IR (ver [[projeto_portfolio_sites]]).
Cifras ECC ([[projeto_cifras_ecc]]) NÃO entra no site por direito autoral, e a pasta não está no desktop Ubuntu.
