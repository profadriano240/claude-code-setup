---
name: projeto_revista_bolso_esperto
description: "Projeto de revista semanal (ebook) de educação financeira \"Bolso Esperto\" para venda em sites de ebooks"
metadata: 
  node_type: memory
  type: project
  originSessionId: db22fb26-9784-46ba-ba2c-b8c68c787ce7
  modified: 2026-08-25T17:21:06.316Z
---

**Repositório GitHub:** `https://github.com/profadriano240/revista-bolso-esperto`
(privado, criado em 2026-08-25 a partir de `~/projetos/bolso-esperto/`).
Lembrar de commitar/dar push quando novos arquivos forem gerados (edições
novas, materiais de marketing etc.) — o diretório não tem sync automático
como o [[referencia_backup_claude_code_setup]].

Usuário está criando uma coleção de ebooks de educação financeira que vai
evoluir para uma **publicação semanal estilo revista simples** (inspirada
na Recreio: o gancho é o conhecimento adquirido, não brindes/jogos), para
venda em sites de ebooks (Amazon KDP, Hotmart, etc.).

**Marca definida:** "Bolso Esperto" — tom leve/motivacional, público
18-37 anos. Tagline: "Menos susto, mais estratégia." Identidade visual:
raposa geométrica minimalista, paleta laranja queimado (#C1502E) + grafite
(#2B2B2B). Briefing completo em `~/projetos/bolso-esperto/marca/identidade-visual.md`.

**Estrutura de cada edição** (template reutilizável em
`~/projetos/bolso-esperto/templates/estrutura-edicao.md`): capa, editorial
curto, 1 tema central por edição, seção fixa "O Golpe da Semana", seção
fixa "Na Prática" (checklist), seção fixa "Em Números" (infográfico),
"Termo da Semana", teaser da próxima edição, contracapa/CTA. Conteúdo
raso em profundidade mas denso em valor prático — cada edição é fechada
em si mesma.

**Decisões de produção:**
- Texto: escrito no Claude Code (acesso a filesystem, permite gerar
  PDF/EPUB prontos para venda via Pandoc — ainda não instalado na máquina,
  ver [[maquina_debian_home]]).
- Imagens/ilustrações: geradas via ferramenta de imagem do Gamma (MCP
  `mcp__claude_ai_Gamma__generate_image`), já que Claude Code não gera
  imagens diretamente.
- Projeto em `~/projetos/bolso-esperto/`, edições em `edicoes/edicao-XX/`.

**Edição #1 (piloto):** tema "Por que seu dinheiro some antes do fim do
mês" (regra 50-30-20). Outline aprovado pelo usuário em 2026-08-18.
Conteúdo completo (todas as 9 seções do template) escrito em
`~/projetos/bolso-esperto/edicoes/edicao-01/conteudo.md`. Imagens
geradas via Gamma e salvas em
`~/projetos/bolso-esperto/edicoes/edicao-01/imagens/` (capa.png,
infografico.png, icones-secao.png) — texto+imagens prontos. Único
passo pendente: montar o PDF/EPUB final (Pandoc ainda não instalado na
máquina, ver [[maquina_debian_home]]).

**Créditos do Gamma:** ficaram baixos após a edição-01 (19 restantes,
cada `generate_image` consome ~70). Provavelmente será necessário
comprar mais créditos antes de gerar imagens da edição-02. Nota de
qualidade: usar `type: "illustration"` para infográficos com
texto/números — `type: "abstract"` ignora o conteúdo pedido e gera arte
genérica (aconteceu na primeira tentativa desta edição).

**Edição #1 — CONCLUÍDA (2026-08-21):** PDF (A5, 10 páginas) e EPUB
gerados em `~/projetos/bolso-esperto/edicoes/edicao-01/` —
`bolso-esperto-01.pdf` e `bolso-esperto-01.epub`. Pandoc já estava
instalado (resolvido sem ação extra). Processo usado (repetir em
próximas edições):
- HTML customizado (`edicao-01.html`) com CSS de marca (fontes já no
  sistema: Quicksand para títulos, Liberation Sans para corpo,
  Bitstream Charter itálico para tagline/citações — sem precisar de
  internet/Google Fonts) → PDF via `google-chrome --headless
  --print-to-pdf` (wkhtmltopdf/weasyprint/LaTeX não instalados; Chrome
  headless funcionou bem e é o que já está disponível).
- EPUB via `pandoc conteudo-epub.md -o saida.epub --css=epub.css
  --epub-cover-image=...` a partir de um markdown derivado do
  conteúdo original com imagens embutidas.
- Capa completa (proporção 2:3, com título/tagline) precisa ser
  gerada à parte via screenshot de HTML standalone
  (`capa-standalone.html` + `chrome --headless --screenshot`) — as
  imagens do Gamma são só o ícone da raposa isolado, não uma capa
  pronta.
- Imagens do Gamma vêm em alta resolução (~3-4 MB cada) — sempre
  redimensionar/otimizar com PIL antes de embutir (reduziu o PDF de
  9,8 MB para 1,7 MB).
- Ícone da raposa tem fundo branco opaco (sem alpha): para fundo
  escuro, ou usar fundo claro na peça, ou colocar a logo dentro de um
  selo/card branco — transparência direta do PNG deixa o contorno
  escuro quase invisível contra grafite.
- Ao cortar `icones-secao.png` (3 ícones lado a lado) em peças
  separadas, NÃO dividir em terços fixos — os ícones não estão
  perfeitamente centralizados e isso vaza pixels do ícone vizinho.
  Detectar as colunas de conteúdo real via numpy (limiar de
  não-brancura) e cortar pelos grupos encontrados.
- CSS de impressão: usar `break-inside: avoid` em cards/caixinhas
  (senão quebram feio entre páginas do PDF) e evitar `page-break-after:
  always` forçado entre subseções curtas relacionadas (desperdiça
  página em branco) — deixar o fluxo natural quebrar quando possível.

**Estratégia de lançamento (marketing) — EM EXECUÇÃO, adaptada
(2026-08-24).** Definida originalmente em artifact "Lançamento Bolso
Esperto" (https://claude.ai/code/artifact/54b1bb84-77bc-42c7-a324-4e426a4b94e0):
edição #1 é **grátis**, objetivo é capturar contato (e-mail), não vender.
Funil: Instagram → landing page de captura → entrega automática por
e-mail → oferta paga só depois de 3-4 edições prontas. Decisão: nem KDP
nem Hotmart agora (nenhuma resolve captura de contato bem) — usar
**MailerLite** (plano free, até 1.000 contatos, sem cartão) para landing
page + entrega + boas-vindas. Hotmart entra quando existir produto pago
(Pix/boleto/afiliados, público BR); KDP fica para quando houver um
"volume" compilado de várias edições. Cronograma de lançamento de 7 dias
(setup → teaser → lançamento → reel de valor → prova social → lembrete
final) e todos os textos prontos (bio, legenda, stories, roteiro de
reel, e-mail de entrega) já estão escritos no artifact. Métricas a
acompanhar: downloads, cliques no link da bio, taxa de abertura do
e-mail, reações no reel.

**Status do setup técnico de marketing (2026-08-21):**
1. ✅ Conta MailerLite criada (login via Google, e-mail
   adrianofreire240@gmail.com), trial de 14 dias de recursos Advanced.
2. ✅ Landing page de captura criada e **publicada**:
   `https://adrianofreire-h5hnp5.subscribepage.io`. Gerada via "Build with
   AI" do MailerLite (goal "Capture subscribers", estilo Friendly +
   Minimalist) e depois editada manualmente: título "Cadê meu dinheiro?",
   subtítulo com a regra 50-30-20, checklist ("Sem enrolação, direto ao
   ponto" / "Sem planilha complicada") e um bloco de formulário
   (Signup form) com campo de e-mail + botão "Quero minha edição" — tudo
   em português, cores da marca preservadas. O botão estático original
   gerado pela IA foi removido (não tinha ação; um "Redirect to Pop-up"
   exigiria criar um pop-up à parte, então optei por um formulário
   embutido na própria página, mais simples). Formulário associado ao
   grupo de assinantes "Assinantes Bolso Esperto" (grupo do site, 0
   assinantes até agora). Double opt-in está ativado (padrão do
   MailerLite).
   - Pendência cosmética: o nome da marca no cabeçalho ainda está como
     "Company" (texto genérico do template) em vez de "Bolso Esperto" —
     tentativas de editar via automação de browser não colaram (o campo
     não aceitou digitação após seleção); precisa correção manual no
     editor (Sites → Bolso Esperto - Captura Edição 1 → Edit design). O
     menu de navegação (Home/About/Publishers/Contact) também ficou no
     template, é inofensivo mas não faz sentido para uma página de
     captura única — pode ser removido depois.
3. ✅ CONCLUÍDO (2026-08-22) — automação de entrega configurada e
   ativada. Workflow "Bolso Esperto - Captura Edição 1 Workflow"
   (`dashboard.mailerlite.com/automations/196444252032468090/edit`):
   trigger "Completes a form 1" → ação "Email 1" ("Entrega - Edição 1",
   assunto "Sua edição #1 do Bolso Esperto chegou 🦊", sender
   adrianofreire240@gmail.com). Corpo do e-mail com dois botões
   linkados via URL type "File" (upload direto no editor do e-mail,
   ícone de link 🔗 → File → Upload): "Baixar PDF" →
   bolso-esperto-01.pdf (1.66 MB) e "Baixar EPUB" →
   bolso-esperto-01.epub (1.51 MB), ambos abrindo em nova aba. Workflow
   **ativado** (botão "Activate" clicado, confirmado pelo usuário antes).
   Teste ponta a ponta feito: preenchido o formulário da landing page
   com o e-mail do próprio usuário → assinante entrou como "Active"
   direto (sem etapa de double opt-in bloqueando) → Activity hub do
   workflow confirmou "Started: 1, Completed: 1, Total emails sent: 1,
   Failed: 0". Setup técnico de captura+entrega está 100% funcional.
4. ✅ Bio do Instagram atualizada (2026-08-24) — login já resolvido pelo
   usuário. Texto novo salvo com sucesso via `instagram.com/accounts/edit/`
   no Chrome desktop: "Educação financeira sem enrolação 🦊 / Toda
   semana, 1 tema, 15 min de leitura. / Bolso Esperto #1 é grátis ↓"
   (substituiu a bio antiga de prof/consultor financeiro, por decisão do
   usuário).
   🔶 PENDENTE — o campo "Site" (link da bio) só é editável pelo **app
   mobile** do Instagram; o Instagram bloqueia essa edição especificamente
   no navegador desktop (mensagem: "Somente é possível editar os links no
   celular"). Usuário precisa colar o link
   `https://adrianofreire-h5hnp5.subscribepage.io` pelo celular.
   ✅ Link colado pelo usuário no app mobile (confirmado em 2026-08-24).
5. ✅ Bug de reentrada corrigido (2026-08-24) — usuário testou o
   formulário de novo com o mesmo e-mail (`adrianofreire240@gmail.com`)
   e não recebeu o e-mail de entrega. Causa: por padrão o MailerLite só
   deixa um assinante disparar o workflow **uma vez** por gatilho
   ("Completes a form"); como esse e-mail já tinha completado o
   formulário em 2026-08-21, o segundo teste não recriou o envio (não
   era bug de configuração de entrega, e sim da automação). Corrigido
   habilitando, nas Settings do workflow
   (`dashboard.mailerlite.com/automations/196444252032468090/edit` →
   ícone de engrenagem → Settings), a opção "Allow subscribers re-enter
   automation" com "As soon as they match the triggers" (sem delay) —
   precisou pausar a automação pra editar e depois reativar (Activate).
   Nota: o próprio MailerLite avisa que não reenvia o mesmo e-mail pro
   mesmo assinante dentro de uma janela de 24h, então testes repetidos
   muito seguidos (mesmo dia, mesmo e-mail) ainda podem não gerar novo
   envio — isso é esperado, não é bug.
   **Próximo passo ao retomar:** seguir o cronograma de lançamento de 7
   dias do artifact (teaser → post de lançamento → reel → prova social →
   lembrete final).
6. ✅ Bug do link "Baixar PDF" quebrado corrigido (2026-08-24). Usuário
   percebeu que o botão não era clicável no e-mail de entrega. Causa:
   o botão "Baixar PDF" no editor de e-mail do MailerLite
   (`Edit content` → bloco de botão) tinha o link vazio (href="#...",
   uma âncora sem destino) — só o "Baixar EPUB" estava correto. O botão
   é um "node-button" do editor rich-text (TipTap/ProseMirror); só
   clicar nele e escolher o arquivo pelo ícone de link não bastava. O
   que funcionou: **selecionar o texto do botão por clique-arrasta
   (drag) antes de abrir o painel de link** → ícone de link → File →
   File manager → clicar "Insert" no card do arquivo certo
   (`bolso-esperto-01.pdf`). Confirmado via "Send a test email" e
   inspeção do href real no Gmail (`storage.googleapis.com/mailerlite-
   uploads-prod/...pdf`). **Sempre validar links de botão em e-mails do
   MailerLite assim** — enviar teste e checar o href real no Gmail, não
   confiar só na aparência do editor.
   Nota lateral: nesse processo, sem querer, os e-mails de teste
   antigos na pasta Spam foram marcados "Não é spam" (não afeta
   produção, é só a caixa pessoal do usuário).

**Cronograma de lançamento ADAPTADO (2026-08-24)** — usuário deixou claro
que quer aparecer o mínimo possível e não tem tempo para mexer em redes
sociais (ver [[feedback_baixo_envolvimento_redes_sociais]]). Por isso o
cronograma original de 7 dias (teaser+lançamento+reel+prova social+
lembrete, cross Stories/feed/Reels) foi **reduzido a posts de feed com
imagem estática (sem vídeo, sem aparecer)**, que a Claude prepara e
publica/programa sozinha — Stories e Reels ficaram de fora (exigem app
mobile/gravação, não dá pra automatizar via browser).

**Data-alvo da edição #2: 31/08/2026** (definida pelo usuário em
2026-08-24). ⚠️ Em 24/08 a edição #2 ("O cartão de crédito não é vilão")
**ainda não tinha sido produzida** (nem texto nem imagens) — é o
principal risco pro prazo. Próxima sessão relevante deve checar se a
produção da edição #2 já começou antes de assumir que o dia 31/08 vai
ter conteúdo pra lançar.

**✅ Agendamento nativo do Instagram descoberto e em uso (2026-08-24):**
a conta @profadrianofreire já é profissional e tem acesso ao **Meta
Business Suite** (`business.facebook.com`, login "Continuar com o
Instagram"). O composer do Instagram Web (Criar → Postar) tem um toggle
**"Programar conteúdo"** que agenda o post nos servidores da Meta —
publica sozinho, sem precisar de sessão/Chrome ativos no horário. Muito
melhor que o Meta Business Suite direto (`/latest/composer/`), cujo
upload de imagem usa uma API de arquivo não convencional (sem
`<input type=file>` no DOM, `file_upload` não funciona lá — só dá pra
fazer upload pelo composer normal do instagram.com).

**⚠️ Bug crítico descoberto e corrigido: corte da imagem no post.** O
Instagram aplica por padrão um crop mais estreito que 4:5 na etapa
"Cortar", cortando a parte de cima de imagens 1080x1350 (a logo da
raposa sumia). **Sempre**, na tela "Cortar" do composer, clicar no ícone
de proporção (canto inferior esquerdo) e selecionar explicitamente
**"4:5"** antes de avançar — sem isso a prévia parece mostrar a imagem
inteira mas o post publicado vem cortado. O post 1 foi publicado sem
essa correção, teve que ser **excluído e republicado** depois de o
usuário notar o corte.

**Fluxo validado pra publicar/agendar post de imagem única:**
1. Criar → Postar → achar o `<input type=file>` via `find` (não clicar
   direto no botão "Selecionar do computador", abre picker nativo que
   trava a automação) → `file_upload`.
2. Na tela "Cortar": clicar no ícone de proporção → escolher **4:5**.
3. Avançar (Filtros) → Avançar (chega na legenda).
4. Digitar a legenda.
5. Achar o toggle "Programar conteúdo" via `find` e clicar (clique
   direto por coordenada, ref às vezes fica stale e não registra —
   confirmar com screenshot).
6. Escolher a data: o dropdown de calendário tem 42 `gridcell` sem
   texto legível por `find`; calcular o ref pela posição (agosto de
   2026 começa no sábado dia 1 → dia N = índice 6+N na grade) e clicar
   por `ref`, ou clicar direto na coordenada visível.
7. Em "Compartilhar no", desligar o toggle do Facebook pessoal (vem
   ligado por padrão e não foi pedido) → escolher "Não compartilhar
   este post" no dialog que aparece.
8. Clicar "Programar" (ou "Compartilhar" se for publicar na hora).
9. **Cuidado com scroll manual by coordinate dentro do modal** — em
   pelo menos uma tentativa isso disparou atalhos de teclado do
   Instagram por trás (abriu painel de Notificações, atalhos de
   teclado) e quase descartou o post ("Descartar post?"). Preferir
   `find` + clique por `ref`/coordenada pontual em vez de `scroll`.

**Posts do cronograma (24/08 → 30/08, todos evergreen sobre a edição
#1, sem prometer nada da #2 que ainda não existe):**
1. ✅ PUBLICADO 2026-08-24 (republicado após corrigir o corte) — "A
   regra que organiza qualquer salário em 3 números" (50-30-20).
   Imagem: `~/projetos/bolso-esperto/marketing/post-01-lancamento.png`
   + `.html`. Legenda: `post-01-legenda.txt`.
2. ✅ PROGRAMADO pra 26/08 13:10 — "O Golpe da Semana: o gastinho
   invisível" (conteúdo real tirado de
   `edicoes/edicao-01/conteudo.md`). Imagem:
   `marketing/post-03-golpe-semana.png` + `.html`. Legenda:
   `post-03-legenda.txt`.
3. ✅ PROGRAMADO pra 28/08 14:22 — "Na Prática: mapeie seus gastos em
   15 minutos" (checklist de 4 passos, também da edição #1). Imagem:
   `marketing/post-04-na-pratica.png` + `.html`. Legenda:
   `post-04-legenda.txt`.
4. ✅ PROGRAMADO pra 30/08 16:05 — "Em Números: realidade vs. ideal" +
   Termo da Semana (reserva de emergência). Imagem:
   `marketing/post-05-reserva.png` + `.html`. Legenda:
   `post-05-legenda.txt`.
5. 🔶 PENDENTE — post de lançamento da edição #2 pro dia **31/08**:
   NÃO criado ainda de propósito, porque depende do conteúdo da #2
   estar pronto (texto+imagens+PDF/EPUB+página de entrega no
   MailerLite) — não faz sentido programar um post prometendo download
   antes de a entrega existir. Existe um rascunho descartado
   (`marketing/post-02-lembrete.png/.html/.legenda.txt`) com esse
   teaser que pode servir de base quando a #2 estiver pronta, mas o
   texto "em breve"/datas precisam ser revisados pra bater com o
   status real na hora.
   **Próximo passo ao retomar:** (a) checar/produzir a edição #2
   (texto + imagens + PDF/EPUB, mesmo processo da #1) a tempo do
   31/08; (b) só depois montar e programar o post de lançamento da #2,
   reaproveitando o fluxo de agendamento validado acima.

**✅ Edição #2 — outline, conteúdo e imagens CONCLUÍDOS (2026-08-25).**
Tema: "O cartão de crédito não é vilão, você que usa errado" (juros
rotativo, fechamento x vencimento). Outline aprovado, conteúdo completo
(9 seções) em `edicoes/edicao-02/conteudo.md`. Imagens em
`edicoes/edicao-02/imagens/`:
- `capa-final.png` — mesma logo da raposa (reaproveitada, ver marca de
  consistência abaixo), só título/edição trocados.
- `icone-golpe.png`, `icone-pratica.png`, `icone-termo.png` —
  **reaproveitados 100% da edição #1** (são selo fixo de seção
  recorrente da revista, não deveriam ser regerados a cada edição —
  regra a manter daqui pra frente).
- `infografico.png` — **não gerado por IA**: construído como HTML/SVG
  (`infografico.html`, renderizado via `google-chrome --headless
  --screenshot`) seguindo a skill de dataviz (paleta
  laranja/grafite validada, legenda, marcadores com anel de superfície,
  rótulos diretos em tinta neutra). Decisão importante: **qualquer
  infográfico com números/texto específico deve ser feito assim (HTML/CSS
  + screenshot), não via gerador de imagem de IA** — texto em imagem de
  IA (Gamma ou Pollinations) não garante precisão nem legibilidade.
- Descoberto que `capa-epub.png` da edição #1 nunca foi usado de fato
  (conferido dentro do `.epub`: o cover real nas duas saídas é
  `capa-final.png`) — não vale a pena gerar esse arquivo extra nas
  próximas edições.
**✅ Edição #2 — PDF e EPUB CONCLUÍDOS (2026-08-25).**
`bolso-esperto-02.pdf` (11 páginas, A5) e `bolso-esperto-02.epub`
gerados em `edicoes/edicao-02/`, mesmo processo da edição #1 (HTML+CSS
→ Chrome headless `--print-to-pdf`; `conteudo-epub.md` + `epub.css` →
pandoc, cover `--epub-cover-image=imagens/capa-final.png`). Conferido
visualmente página a página (via `pdftoppm`) antes de dar por
concluído — vale repetir essa checagem em futuras edições.

Aprendizados novos desta edição (aplicar nas próximas):
- **Chrome headless `--print-to-pdf` com `break-inside:avoid` pode
  jogar uma caixinha inteira pra página seguinte mesmo sobrando bastante
  espaço na página atual** (comportamento não totalmente previsível/
  determinístico com margens em `mm`). Solução robusta: não confiar no
  fluxo automático pra seções com 2+ caixinhas grandes — **dividir
  manualmente em `.pagina` separadas** quando o conteúdo for longo, em
  vez de deixar tudo num único `<div class="pagina">` e torcer pra
  quebrar bem.
- Quando uma dessas páginas divididas manualmente sobra com pouco
  conteúdo (uma caixinha só), **centralizar verticalmente** (`display:
  flex; justify-content:center`) em vez de deixar o conteúdo colado no
  topo com espaço em branco embaixo — transforma "página vazia por
  acidente" em "página com respiro intencional".
- **Novo recurso editorial: página de "pull quote"** — quando uma seção
  tem uma frase-síntese forte, dar a ela uma página inteira só com a
  frase centralizada (estilo `.pullquote`, fundo `--cinza-claro`,
  Quicksand bold ~19pt) em vez de enfiá-la como mais um parágrafo. Ficou
  ótimo visualmente e é reaproveitável como recurso de design pra
  próximas edições sempre que o "Tema Central" tiver uma virada de
  chave clara.
- Confirmado de novo: **infográfico com números/texto específico deve
  ser HTML/SVG + screenshot, nunca gerador de imagem de IA** (ver nota
  anterior sobre Pollinations.ai) — deu muito mais controle e ficou
  perfeitamente legível.

**Próximo passo ao retomar:** criar o post de lançamento da edição #2
(ver pendência de marketing abaixo) e configurar a entrega no
MailerLite (novo workflow ou reaproveitar o existente trocando os links
dos arquivos pra `bolso-esperto-02.pdf`/`.epub`).

**✅ Gerador de imagem trocado para Pollinations.ai (2026-08-24, gratuito).**
Créditos do Gamma ficaram baixos (19 restantes, ~70 por imagem) e o
usuário pediu alternativa gratuita. Testado e aprovado:
**Pollinations.ai** (`image.pollinations.ai/prompt/...`, via `curl`, sem
cadastro/chave). Estilo escolhido pelo usuário: **low-poly geométrico**
(`model=flux`). Prompt-base e detalhes técnicos completos em
`~/projetos/bolso-esperto/marca/identidade-visual.md` (seção "Gerador de
imagem: Pollinations.ai"). Usar esse fluxo para as imagens da edição #2
em diante — não usar mais o Gamma para gerar imagens deste projeto
(pode continuar valendo para outros usos que não envolvam custo).

**✅ Protótipo de teaser em vídeo via Remotion (2026-08-25).** Explorado a
pedido do usuário ("quero ver essa aplicação para a Revista Bolso
Esperto") como formato adicional de marketing que a Claude produz
sozinha (sem gravação/câmera, ver
[[feedback_baixo_envolvimento_redes_sociais]]). Projeto em
`~/projetos/bolso-esperto/video/` (React + Remotion, commitado no
mesmo repo). Composição `Edicao01Teaser` (18s, 1080×1920, 4 cenas:
capa → Golpe da Semana animado → Em Números com barras animadas real
vs. ideal → CTA final), reaproveitando texto/paleta/fontes (Quicksand
via `@remotion/google-fonts`, mesma paleta laranja/grafite) e imagens
já existentes da edição #1. MP4 final baixado em
`video/out/video.mp4` (não versionado, `out/` está no `.gitignore`).

**Decisões técnicas importantes:**
- **Render roda só via GitHub Actions** (`.github/workflows/render-video.yml`,
  `workflow_dispatch`, disparado com `gh workflow run render-video.yml -f
  composition=<ID>` e baixado com `gh run download <run-id> -n <ID> -D
  out`), nunca localmente — Chrome headless do Remotion é pesado demais
  pro notebook fraco (ver [[maquina_debian_home]]; RAM já ficou abaixo de
  600Mi disponível durante o trabalho). Grátis (dentro do free tier do
  GitHub Actions).
- Instalação local do `npm install` em `video/` é só para checar tipos
  (`npx tsc --noEmit`) e gerar **frames estáticos isolados** para QA
  visual (`npx remotion still src/index.ts <ID> out/frame.png
  --frame=N`) — isso sim é leve o bastante pra rodar na máquina (abre
  Chrome headless uma vez só, não renderiza vídeo inteiro) e foi como o
  ícone do Golpe da Semana com fundo branco sobrando foi detectado e
  corrigido antes do render final.
- **Não tentar abrir o MP4 renderizado na aba do `claude-in-chrome` pra
  conferir visualmente** — a aba roda em segundo plano
  (`document.hidden = true`), o Chrome suspende o decode do `<video>` e
  `currentTime`/`play()` não avançam de verdade (trava, não é bug de
  seek). Usar `remotion still` pra extrair frames específicos é o
  caminho confiável de QA visual.
- Ícone `icone-golpe.png` (recortado da edição #1) tinha ~50% de altura
  de fundo branco sobrando (herdado do corte imperfeito documentado
  acima) — corrigido cropando pelas linhas de conteúdo real (numpy,
  mesma técnica de detecção de não-branco já usada antes).

**🔶 Pendente/não validado:** publicar um Reels pronto (arquivo de vídeo,
não gravado ao vivo) pelo composer do Instagram Web/Meta Business Suite
usando o mesmo fluxo de agendamento já validado pra imagem estática
(seção de marketing acima) — provavelmente aceita upload de vídeo do
mesmo jeito (trocar `file_upload` de imagem por vídeo), mas isso ainda
não foi testado na prática. Próxima sessão que retomar isso deve validar
esse passo antes de assumir que o teaser pode ser agendado sozinho.

**Why:** usuário quer lançar várias edições/ebooks no mesmo padrão — vale
manter marca e template consistentes entre sessões futuras.
**How to apply:** ao continuar este projeto em conversas futuras, seguir
o template de estrutura, o briefing de marca (incluindo o novo fluxo de
imagem via Pollinations.ai), o processo de montagem PDF/EPUB e o plano
de lançamento acima descritos. Preferência geral do usuário por
ferramentas gratuitas antes de considerar pagas (mesmo padrão de
[[projeto_automacoes_whatsapp]]).
