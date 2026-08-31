---
name: projeto_revista_bolso_esperto
description: "Projeto de revista semanal (ebook) de educação financeira \"Bolso Esperto\" para venda em sites de ebooks"
metadata: 
  node_type: memory
  type: project
  originSessionId: db22fb26-9784-46ba-ba2c-b8c68c787ce7
  modified: 2026-08-31T03:27:45.723Z
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

**✅ Entrega da edição #2 no MailerLite — CONFIGURADA E ATIVA (2026-08-30).**
Decisão do usuário: "follow-up no workflow + campanha p/ lista atual" —
manter a landing page prometendo a edição #1 e entregar a #2 como
2º e-mail no mesmo workflow. Feito no workflow existente
(`dashboard.mailerlite.com/automations/196444252032468090/edit`):
- Pausar → adicionar **Time delay 1 = 3 dias** após "Email 1: Entrega -
  Edição 1" → adicionar **Email 2: "Entrega - Edição 2"** (assunto "Sua
  edição #2 do Bolso Esperto chegou 🦊", sender Bolso Esperto /
  adrianofreire240@gmail.com) → reativar. Novo assinante recebe a #1 na
  hora e a #2 três dias depois.
- Email 2 criado por **Copy/Paste do bloco "Email 1"** (menu ⋮ → Copy →
  "Paste step here" após o delay) — muito mais confiável que o
  drag-and-drop da paleta "Add step", que **não funcionou** nem via
  `left_click_drag` nem via eventos HTML5/pointer sintéticos nesta
  máquina. Depois: editar textos inline (triple-click + digitar) e trocar
  o link do botão.
- Botão "Baixar PDF" religado pra `bolso-esperto-02.pdf` via link → File →
  **Replace** → File manager → **Upload** (achar `<input type=file>` com
  `find` + `file_upload`) → hover no card → **Insert**. Verificado no
  e-mail real (Gmail, `[Test]`): href =
  `storage.googleapis.com/mailerlite-uploads-prod/t2589166/…bolso-esperto-02.pdf`.
- ⚠️ **Botão "Baixar EPUB" foi REMOVIDO do Email 2** (bloco → menu ⣿ →
  Delete). Motivo: o upload de `.epub` via `file_upload` é **rejeitado
  pelo MailerLite** ("The file must be of type: jpeg, png, gif, ico, pdf,
  epub.") — a ferramenta manda o arquivo sem MIME `application/epub+zip`
  e a validação é por MIME, não extensão. O `.epub` da edição #1 entrou
  numa sessão antiga via seletor nativo do SO. **Para repor o EPUB:** o
  usuário sobe `edicoes/edicao-02/bolso-esperto-02.epub` manualmente no
  File manager do MailerLite (arrastar do explorador de arquivos), depois
  é trivial recriar o botão duplicando o "Baixar PDF" e trocando o link.
- Screenshots do `claude-in-chrome` **congelam muito** com o editor de
  e-mail do MailerLite aberto nesta máquina fraca (`Page.captureScreenshot`
  timeout 30s repetido) — `javascript_tool`/`find`/`read_page` continuam
  respondendo; dá pra navegar às cegas por `find`+ref. Ver
  [[maquina_debian_home]].

**🔶 PENDENTE da entrega #2:** campanha única da edição #2 para os
assinantes que já estão na lista ("Assinantes Bolso Esperto") — ainda
não feita. Lista hoje é ~só o próprio usuário (testes), então valor
baixo por ora; confirmar com o usuário se quer disparar mesmo assim.

**✅ Post de lançamento da edição #2 — PROGRAMADO no Instagram para
31/08/2026 12:40 (2026-08-30).** Arquivos em `marketing/`:
`post-07-lancamento-ed2.html` (+ `.png` 1080×1350, + `post-07-legenda.txt`),
commitados e no GitHub. Arte: fundo creme, logo raposa, título "O cartão
de crédito não é vilão. Você que usa errado." + 3 mini-cards (parcela sem
pensar / paga só o mínimo / trata o limite como salário) + badge "ASSINE
GRÁTIS · LINK NA BIO". Baseado no rascunho descartado `post-02-lembrete`
(que era "em breve") — agora a #2 existe, e o CTA é honesto sobre o funil
("assine, começa pela #1, a #2 chega na sequência", porque a entrega da
#2 é o 2º e-mail do workflow, 3 dias depois do cadastro). Programado via
composer do instagram.com (Criar → Postar → 4:5 explícito → legenda →
"Programar conteúdo" ON → data 31 no calendário de agosto → hora ajustada
com **seta Up no segmento de horas** do `<input type=time>` (digitar não
colou; 12 Ups de 00→12) → Facebook pessoal OFF ("Não compartilhar este
post") → Programar). Confirmado em `instagram.com/scheduled_content/`:
aparece em "Seg 31" às 12:40 com a arte e legenda certas.

**Cronograma de marketing atualizado:** posts 1–5 (feed, evergreen da #1)
publicados/programados entre 24 e 30/08; post 6 = Reel teaser em vídeo com
narração (25/08); **post 7 = lançamento da #2, programado p/ 31/08 12:40**.

**🔀 VIRADA DE POSICIONAMENTO (2026-08-30): o Bolso Esperto vira uma
progressão até análise fundamentalista.** Diante de 0 assinantes reais
após ~1 semana de posts (conta @profadrianofreire é pequena, alcance
orgânico ~nulo), o usuário decidiu **subir o nível da revista** em vez de
só empurrar mais tráfego: de "organizar o salário" (defesa) para
"analisar uma empresa como sócio" (ataque). Não é rebrand nem produto
separado — é a mesma revista progredindo. Usuário tem **formação em
matemática + pós em finanças** (bagagem intermediária no tema) — isso
passa a ser argumento de marca ("quem ensina tem formação, não é palpite
de influencer"). Público-alvo sobe junto: de 18-37 "pouco dinheiro
sobrando" para quem já investe / quer investir — mais velho, renda maior,
**disposição a pagar alta** (nicho de curso/newsletter). Concorrência é
feroz (Suno, Primo Rico etc.), então conteúdo raso não serve neste nicho.

**Escada editorial definida:** #1 regra 50-30-20 ✅ · #2 cartão/rotativo
✅ · #3 reserva de emergência (ponte) · #4 renda fixa sem mistério · #5
comprar a 1ª ação · #6 como ler o balanço (início da análise
fundamentalista) · #7 múltiplos (P/L, P/VP, EV/EBITDA, DY) · #8 qualidade
(ROE, ROIC, margem, moat, endividamento) · #9 valuation (comparáveis +
noção de fluxo de caixa descontado) · #10 montar a tese (checklist).
Edições #6-10 são o núcleo de análise fundamentalista; #3-5 são ponte.

**Cuidado regulatório (CVM):** ensinar a *metodologia* de análise é
conteúdo educacional, ok. Publicar *análises de empresas específicas* com
viés de compra/venda entra em recomendação (exige CNPI). Todo o material
deve ficar no lado educacional — exemplos com empresas fictícias, sem
ticker real. Incluir sempre disclaimer: educacional, autor com formação
em finanças mas não analista credenciado (CNPI), decisão é do leitor.

**✅ Isca #1 de captação PRODUZIDA (2026-08-30):
`iscas/7-numeros-acao/`.** Guia rápido gratuito (não é edição numerada),
15 páginas A5, mesmo pipeline/CSS das edições (HTML → Chrome headless
`--print-to-pdf`; markdown → pandoc → EPUB com `--epub-cover-image`).
Arquivos: `guia.html` (build), `capa-standalone.html` (+ `capa.png` 2:3 e
`capa-thumb.png`), `conteudo-epub.md` + `epub.css`,
`bolso-esperto-guia-7-numeros.pdf` (280 KB) e `.epub` (144 KB),
`imagens/capa-transparente.png` (logo raposa reaproveitada). Commitados e
no GitHub (commit `560ccb7`). Conteúdo: os 7 números pré-compra de ação —
P/L, P/VP, ROE, margem líquida/operacional, dívida líquida/EBITDA,
dividend yield, payout — cada um com "o que é / como ler (faixa) / a
armadilha (o que esconde)"; página "juntando tudo" com exemplo fictício
("Varejista A") passando pelos 7 na ordem preço→qualidade→risco→retorno;
pull quote; teaser do 8º número (ROIC) puxando pra fase de análise
fundamentalista; página de disclaimer. Serve como **novo ímã de
captação** (promessa mais forte que "reserva de emergência").

**✅ Entrega da isca no MailerLite — FEITA E ATIVA (2026-08-31).** A isca
virou o **1º e-mail do workflow** de captação existente (mesmo form/
landing page), antes das edições. Estrutura final do workflow
(`automations/196444252032468090`):
1. **Email 1: "Entrega - Guia 7 números"** (imediato) — assunto "Seu
   guia: 7 números pra olhar antes de comprar uma ação", botão "Baixar
   PDF" → `bolso-esperto-guia-7-numeros.pdf` (subido no file manager;
   href real conferido no Gmail teste). Botão EPUB removido (upload de
   .epub no MailerLite falha, ver acima).
2. **Email 2: "Entrega - Edição 1"** (imediato depois) — cópia intacta.
3. **Time delay 3 dias**.
4. **Email 3: "Entrega - Edição 2"**.
Feito por Copy/Paste do bloco "Email 1" original → colar antes dele →
editar. ⚠️ O "Paste step here" do MailerLite **cola em duplicidade se
clicado 2x** (colou 3 cópias sem querer; deletei 2 via bloco → ⋮ →
Delete → "Permanently delete"). Workflow reativado e testado ponta a
ponta (Gmail).

**❌ Reposicionamento da landing page — NÃO FEITO (bloqueado pelo
editor).** A página `adrianofreire-h5hnp5.subscribepage.io` (editor
"Nebula" / drag-and-drop do MailerLite, `pages/196432003810199271`)
**perde toda a formatação do bloco quando o texto é substituído via
teclado sintético** (ctrl+a + digitar, ou ctrl+a + Delete + digitar):
o H1 laranja grande virou texto de corpo minúsculo. Mesmo problema já
documentado em sessões antigas. Desfiz tudo (undo), nada foi salvo, a
página live segue intacta ("Cadê meu dinheiro?"). **Precisa ser editada
à mão pelo usuário.** Dados da página: 10 views / 1 assinante / 10%
conversão — o gargalo é tráfego, não conversão, mas o texto ainda
precisa casar com a promessa nova.

**Copy nova pra landing page (usuário cola à mão):**
- H1: "7 números antes de comprar uma ação"
- Sub: "Guia gratuito: o que cada número diz sobre uma empresa — se ela
  está cara, se é um bom negócio, se paga bem o sócio — e o que cada um
  esconde. 15 minutos de leitura."
- Bullet 1: "Sem economês, com exemplos práticos"
- Bullet 2: "Escrito por quem tem formação em matemática e pós em
  finanças"
- Botão: "Quero o guia grátis"
- (conferir se há "Company" em algum cabeçalho/nav e trocar por "Bolso
  Esperto")
- Bio do Instagram (texto editável no desktop; só o link exige app):
  trocar "Bolso Esperto #1 é grátis ↓" por algo como "Guia grátis:
  aprenda a analisar uma ação ↓".

**Próximos passos ao retomar:** (1) usuário cola a copy nova na landing
page + bio; (2) **série de posts no Threads** puxando o guia (próxima
tarefa combinada — Claude escreve e publica/programa, conta já linkada,
Threads entrega bem conta pequena); (3) escrever a edição #3 (reserva de
emergência) pra manter cadência. Campanha da #2 pra lista atual segue
**não disparada** — grupo "Assinantes Bolso Esperto" tem só 1 assinante
(e-mail de teste do usuário, confirmado em Groups), adiada até ter
público real.

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

**❌ REJEITADO (2026-08-25): vídeo com personagem-mascote (raposa 3D
fofa) explicando a regra 50-30-20.** Segundo vídeo da série teaser,
gerado com o mesmo pipeline Remotion+GitHub Actions do primeiro, mas
com a raposa da marca em corpo inteiro (estilo "3D fofo/pixar", gerada
via Pollinations.ai `model=turbo` + fundo removido com `rembg`
`u2netp`) reagindo a cada fatia da regra. Usuário assistiu e respondeu
direto: **"não gostei. Não vamos mais fazer vídeos assim."** Não pediu
ajuste — foi rejeição do formato inteiro, não do texto/tema.
**Não propor de novo vídeos com esse personagem-mascote 3D** (nem essa
raposa fofa específica, nem variações do mesmo conceito) neste projeto,
a menos que o usuário peça isso explicitamente de novo. Motivo exato da
rejeição não foi detalhado pelo usuário — pode ser o estilo visual (foge
do flat-geométrico da marca, ver nota de brand-mismatch acima), pode ser
o conceito de mascote em si. Se retomar vídeo no futuro, perguntar antes
de já default de novo pra um personagem — o teaser original (edição #1,
sem personagem, só texto/tipografia animada) **não** foi rejeitado, só
esse segundo formato com mascote.
Código da composição (`video/src/Regra502030.tsx` + imagens em
`video/public/raposa/`) foi **removido do repo a pedido do usuário**
logo depois (commit `afa7cf3`) — só existe no histórico do git, não no
working tree. Não recriar sem o usuário pedir de novo.

**Ajustes de feedback do usuário (2026-08-25), aplicados antes do
publish:** duração 18s → ~22,7s (achou rápido demais) e depois fontes/
ícone/barras aumentadas em duas rodadas (achou letras difíceis de ler)
— versão final bem maior/mais ousada que o primeiro rascunho. Lição:
**não economizar no tamanho de fonte em vídeo vertical pra Reels** —
o que parece "ok" olhando frame a frame num preview de desktop ainda
pode estar pequeno demais no contexto real (tela cheia de celular,
concorrendo com UI do Instagram por cima). Calibrar mais generoso da
próxima vez, direto na primeira versão.

**✅ Publicação de vídeo/Reels pelo Instagram Web — VALIDADO E
FUNCIONANDO (2026-08-25).** Ao contrário do que a nota anterior temia,
o upload de vídeo pelo composer funciona sim, mas com comportamento
diferente da imagem estática:
- O mesmo fluxo "Criar → Postar" (`find` pro `<input type=file>` →
  `file_upload`) funciona pra vídeo também, mas o **processamento
  inicial demora bem mais que uma foto** (thumbnail/preview do vídeo
  leva vários segundos, ao contrário do quase-instantâneo da imagem) —
  não julgar "não funcionou" só porque a tela "Arraste as fotos e os
  vídeos aqui" ainda está visível 3s depois; esperar mais e reconferir.
- Qualquer vídeo enviado por esse fluxo vira automaticamente um
  **"Novo reel"** (não um post de feed comum) — a etapa de corte tem
  opções "Original / 1:1 / 9:16 / 16:9" (sem 4:5 como nas fotos); pra
  vídeo já nativamente 9:16 (1080×1920), escolher **"Original"** evita
  qualquer corte. Depois da etapa de corte vem uma etapa extra que as
  fotos não têm ("Editar": aparar duração, escolher capa, som) — só
  clicar "Avançar" de novo se não precisar mexer nisso.
- **A aba trava pra `screenshot` (CDP `Page.captureScreenshot` estoura
  timeout) enquanto o preview de vídeo está ativo/decodificando** —
  isso é sobrecarga de CPU/compositor do notebook fraco, não a
  extensão caindo de verdade. Nessas horas, `javascript_tool` continua
  respondendo normalmente (`document.title`, `innerText` etc.) — dá
  pra navegar o fluxo "às cegas" (achar botões via `find`/`innerText`
  e clicar por `ref`) até chegar numa tela sem vídeo tocando, onde o
  screenshot volta a funcionar. Rodar `v.pause()` num `<video>` via JS
  antes de tentar screenshot também ajuda.
- A extensão do `claude-in-chrome` **caiu de vez uma vez** no meio do
  fluxo (`tabs_context_mcp` retornou "Browser extension is not
  connected"), mesmo com o Chrome ainda rodando — a recuperação
  documentada em [[maquina_debian_home]] (`nohup google-chrome
  --remote-debugging-port=9222 about:blank &` + `tabs_context_mcp`)
  funcionou e o estado do modal (já com vídeo carregado) sobreviveu à
  reconexão.
- Upload de vídeo por essa via **não pode vir de `fetch()`/blob**
  (tentei simular um `drop` real com `DataTransfer` a partir de um
  blob buscado num servidor HTTP local — bloqueado pelo CSP do próprio
  instagram.com, `Failed to fetch`). O que funcionou de verdade foi só
  reesperar mais tempo pelo `file_upload` original via `<input
  type=file>` mesmo — não precisou de drag-and-drop simulado no fim.
- Antes de publicar: desmarcar "Adicionar rótulo de IA" (o conteúdo é
  motion graphics/tipografia, não mídia fotorrealista — não se
  enquadra na exigência de rotulagem de IA da Meta) e desligar o
  toggle de compartilhamento automático no Facebook pessoal (mesmo
  passo documentado acima pra fotos: toggle → dialog → "Não
  compartilhar este reel").
- Resultado confirmado publicado (não é só a UI dizendo "sucesso"):
  conferido abrindo `instagram.com/profadrianofreire/reel/DcecbegRA8l/`
  direto e validando timestamp ("4 min") + legenda batendo. Legenda
  usada salva em
  `marketing/post-06-video-teaser-legenda.txt`.

**✅ Novo formato validado e PUBLICADO (2026-08-26): carrossel
"panorâmico"/conectado.** A pedido do usuário (formato onde cada slide
se conecta visualmente com o anterior, dando impressão de uma arte só
ao arrastar). Técnica: uma arte HTML única e larga (5400×1080 = 5
slides de 1080×1080), renderizada via `google-chrome --headless
--window-size=5400,1080 --screenshot=...`, depois cortada em 5
quadrados iguais com PIL (`im.crop((i*1080, 0, (i+1)*1080, 1080))`).
Como é literalmente uma imagem só cortada, qualquer elemento decorativo
que atravesse a largura toda (usei uma trilha pontilhada SVG com 5
"paradas" numeradas, uma por seção) fica perfeitamente contínuo entre
os slides sem esforço extra. Arquivos em
`marketing/carrossel-01/` (`panorama.html` fonte reaproveitável como
template, `panorama.png` render completo, `slide-1..5.png` finais,
`legenda.txt`). Conteúdo: as 5 seções-chave da edição #1 (hook →
regra 50-30-20 → golpe da semana → reserva de emergência → CTA),
reaproveitando ícones já aprovados (`icone-golpe.png`,
`icone-termo.png`) e a logo flat da raposa (`capa-transparente.png`) —
sem gerar imagem nova, sem personagem 3D (ver rejeição acima).
**Publicado com sucesso**: `instagram.com/profadrianofreire/p/DcgR5a-lTLg/`.

**Armadilhas técnicas encontradas e corrigidas (aplicar de novo no
próximo carrossel):**
- Os ícones reaproveitados de `edicoes/edicao-01/imagens/` (fundo RGB
  branco, sem alpha) deixam um retângulo branco visível contra o fundo
  creme do carrossel — **sempre rodar a mesma conversão de
  branco-pra-transparente** (threshold ≥245 em RGB → alpha 0, via PIL/
  numpy) antes de usar esses ícones em uma peça nova com fundo diferente
  de branco puro.
- A logo da raposa (`capa-transparente.png`, contorno grafite escuro)
  fica quase invisível sobre fundo escuro (grafite) — mesmo problema já
  documentado antes para a capa. Solução aplicada: colocar a logo dentro
  de um círculo/selo claro (`background:#F4F1EE`, `border-radius:50%`)
  quando a peça tiver fundo escuro.
- No upload de carrossel (múltiplos arquivos de uma vez via
  `file_upload` no mesmo `<input type=file>`), a tela de "Cortar" tem
  um ícone de proporção que só aparece depois de clicar no ícone de
  "expandir/encaixar" (canto inferior esquerdo) — dá as opções
  Original/1:1/4:5/16:9. Selecionar **1:1** explicitamente (imagens já
  são quadradas 1080×1080, então não corta nada, mas evita qualquer
  crop-padrão inesperado). Existe também um ícone de "quadrados
  empilhados" que abre um painel de reordenar/remover slides — útil pra
  conferir a ordem antes de publicar.
- Extensão do `claude-in-chrome` caiu de novo nessa sessão (2ª vez,
  mesma máquina) — recuperação de sempre funcionou: `nohup
  google-chrome --remote-debugging-port=9222 about:blank &` +
  `tabs_context_mcp{createIfEmpty:true}` (só precisou de ~4s de espera
  extra dessa vez).

**✅ PADRÃO CONFIRMADO (2026-08-26): narração em áudio nos vídeos, via
Piper TTS.** Testado adicionando narração ao teaser já publicado
(`Edicao01Teaser`) e usuário aprovou explicitamente: **"gostei. Quando
formos fazer os próximos vídeos iremos utilizar essa estrutura."** —
ou seja, **todo vídeo novo da Bolso Esperto daqui pra frente deve
incluir narração em áudio** por padrão, não só sob pedido.

**Como fazer (processo validado, repetir nos próximos vídeos):**
1. Escrever um roteiro de narração curto por cena (não é o texto da
   tela lido literalmente — reescrever pra soar natural falado, ex.:
   números por extenso).
2. Gerar cada trecho com o Piper já instalado na máquina:
   `~/.local/bin/piper -m
   ~/.local/share/piper-voices/pt_BR-faber-medium.onnx --output_file
   <nome>.wav` (mesma voz do hook de leitura em voz alta, ver
   [[maquina_debian_home]]), salvando em `video/public/audio/`.
3. Medir a duração de cada `.wav` com Python (`wave.open` +
   `getnframes()/getframerate()`) — **não estimar de ouvido**.
4. Calibrar a duração de cada cena/`Sequence` do Remotion pra caber o
   áudio + ~15-20 frames de folga (aprendizado: a narração quase sempre
   é mais longa que a duração "visual" que pareceria suficiente só
   olhando o texto na tela — a cena "Em Números" original de 230 frames
   precisou virar 375 pra caber 11,75s de fala).
5. Se a cena tem elementos que revelam em sequência (ex.: 3 barras),
   **reescalonar os delays de entrada proporcionalmente ao ritmo da
   fala** (calculado por proporção de caracteres de cada trecho do
   texto), não deixar tudo aparecer nos primeiros 2s enquanto a
   narração ainda está no primeiro item.
6. `<Audio src={staticFile("audio/<nome>.wav")} />` dentro de cada
   `<Sequence>` (um áudio por cena, não um arquivo único pro vídeo
   inteiro — mais fácil de recalibrar se uma cena mudar depois).
7. Testar só via render completo (`gh workflow run` + download) — **não
   dá pra validar áudio com `remotion still`** (só gera frame estático,
   sem som), diferente do fluxo de QA visual que já usávamos.

**Why:** usuário quer lançar várias edições/ebooks no mesmo padrão — vale
manter marca e template consistentes entre sessões futuras.
**How to apply:** ao continuar este projeto em conversas futuras, seguir
o template de estrutura, o briefing de marca (incluindo o novo fluxo de
imagem via Pollinations.ai), o processo de montagem PDF/EPUB e o plano
de lançamento acima descritos. Preferência geral do usuário por
ferramentas gratuitas antes de considerar pagas (mesmo padrão de
[[projeto_automacoes_whatsapp]]). Pra próximas edições, o carrossel
panorâmico (`marketing/carrossel-01/panorama.html`) é um bom formato
padrão a oferecer de novo — reaproveitar a estrutura HTML como template,
só trocando conteúdo/ícones por seção.
