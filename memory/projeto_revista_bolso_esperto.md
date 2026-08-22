---
name: projeto_revista_bolso_esperto
description: "Projeto de revista semanal (ebook) de educação financeira \"Bolso Esperto\" para venda em sites de ebooks"
metadata: 
  node_type: memory
  type: project
  originSessionId: db22fb26-9784-46ba-ba2c-b8c68c787ce7
  modified: 2026-08-22T14:26:54.219Z
---

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

**Estratégia de lançamento (marketing) — definida em artifact "Lançamento
Bolso Esperto"** (https://claude.ai/code/artifact/54b1bb84-77bc-42c7-a324-4e426a4b94e0):
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
4. 🔶 EM ANDAMENTO (pausado em 2026-08-22) — colocar o link da landing
   page (`adrianofreire-h5hnp5.subscribepage.io`) na bio do Instagram.
   Bloqueio: usuário não conseguiu logar no Instagram pelo navegador
   (Chrome não estava logado na conta) — tentativa de login apresentou
   reCAPTCHA ("Não sou um robô", resolvido manualmente pelo usuário) e
   depois a mensagem "As informações de login que você inseriu estão
   incorretas". Usuário ficou de tentar recuperar a senha ("Esqueceu a
   senha?") por conta própria — login/senha e captcha são ações que a
   Claude não pode executar (credenciais e verificação anti-bot). Texto
   pronto pra colar assim que logar:
   - Bio: "Educação financeira sem enrolação 🦊 / Toda semana, 1 tema,
     15 min de leitura. / Bolso Esperto #1 é grátis ↓"
   - Link da bio: `https://adrianofreire-h5hnp5.subscribepage.io`
   **Próximo passo ao retomar:** perguntar se o usuário já conseguiu
   recuperar a senha/logar; se sim, seguir para editar a bio do
   Instagram (via `instagram.com/accounts/edit/`) com o texto acima e
   depois seguir o cronograma de lançamento de 7 dias do artifact
   (teaser → post de lançamento → reel → prova social → lembrete
   final).

**Why:** usuário quer lançar várias edições/ebooks no mesmo padrão — vale
manter marca e template consistentes entre sessões futuras.
**How to apply:** ao continuar este projeto em conversas futuras, seguir
o template de estrutura, o briefing de marca, o processo de montagem
PDF/EPUB e o plano de lançamento acima descritos. Créditos do Gamma
ficaram baixos após edição-01 (19 restantes) — confirmar com o usuário
antes de gerar imagens novas para a edição-02 ("O cartão de crédito não
é vilão"). Preferência geral do usuário por ferramentas gratuitas antes
de considerar pagas (mesmo padrão de [[projeto_automacoes_whatsapp]]).
