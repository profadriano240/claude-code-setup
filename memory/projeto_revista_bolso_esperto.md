---
name: projeto_revista_bolso_esperto
description: "Projeto de revista semanal (ebook) de educação financeira \"Bolso Esperto\" para venda em sites de ebooks"
metadata: 
  node_type: memory
  type: project
  originSessionId: db22fb26-9784-46ba-ba2c-b8c68c787ce7
  modified: 2026-09-03T19:01:05.180Z
---

**Repositório GitHub:** `https://github.com/profadriano240/revista-bolso-esperto`
(privado, criado em 2026-08-25 a partir de `~/projetos/bolso-esperto/`).
Lembrar de commitar/dar push quando novos arquivos forem gerados (edições
novas, materiais de marketing etc.) — o diretório não tem sync automático
como o [[referencia_backup_claude_code_setup]].

---

## ⚠️ LEIA PRIMEIRO — REDEFINIÇÃO DO PROJETO (2026-09-01)

O usuário redefiniu o foco: **o projeto agora é ensinar análise
fundamentalista de ações E FIIs (fundos imobiliários)**. Foco secundário:
**vender UM ebook único** que ensina todo esse conhecimento.

Decisões firmes desta sessão (respondidas via AskUserQuestion):
1. **Revista semanal APOSENTADA.** Sem mais edições numeradas. As edições
   #1 (50-30-20) e #2 (cartão) seguem publicadas/no funil do MailerLite,
   mas viram material de bônus/entrada — não há edição #3 em diante. (O
   outline de "edição #3 — reserva de emergência" que cheguei a escrever
   foi apagado, `edicoes/edicao-03/` não existe mais.)
2. **Conteúdo gratuito** passa a ser só posts / carrosséis / Threads de
   análise fundamentalista, funil pro ebook + a isca "7 números".
3. **Ebook pago = produto principal.** Título aprovado pelo usuário:
   **"Sócio, Não Apostador"** (subtítulo "Análise de ações e fundos
   imobiliários para quem está começando do zero"; "Um livro Bolso
   Esperto"). **V1 MONTADA (2026-09-01)** em
   `~/projetos/bolso-esperto/ebook/`:
   - `conteudo.md` — texto canônico, ~10,3 mil palavras, YAML front
     matter + Aviso + 5 partes + 4 anexos. Tom aprovado pelo usuário
     ("está bom", não engordar).
   - `socio-nao-apostador.pdf` (47 pág. A5, ~580 KB) e
     `socio-nao-apostador.epub` (~162 KB, capa embutida) gerados.
   - `estrutura.md` — o índice/escopo aprovado.
   - Pipeline num script: **`ebook/build.sh`** (capa PNG via Chrome
     screenshot 1600×2400 de `capa-standalone.html` → HTML via `pandoc`
     com `template.html`+`print-style.html`+`cover.html` → PDF via
     `google-chrome --headless --print-to-pdf` → EPUB via `pandoc
     --epub-cover-image`). Reexecutar `./build.sh` após editar
     `conteudo.md`. Fontes do sistema (Quicksand/Liberation Sans/Bitstream
     Charter), paleta laranja/grafite — mesmo padrão das edições.
   - Revisado página a página via `pdftoppm` — layout limpo, sem quebras
     feias. Sem infográficos (livro é text-forward; blockquotes fazem o
     respiro visual). Empresas fictícias: "Lojas Aurora S.A." (Parte 2),
     "Galpões do Brasil FII" (Parte 4).
   - Commitado e no GitHub (commit `57d2765`, 2026-09-01). Falta: leitura
     final do usuário; decidir isca-irmã de FII; precificar; publicar
     (Hotmart? — ver estratégia de lançamento).
   **⚠️ Nível LEIGO TOTAL** (usuário pediu explicitamente 2026-09-01:
   "deve ser mais simples, será ensinado para leigos que não sabem
   exatamente nada sobre investimentos"). Estrutura enxugada pra 5 partes:
   (1) o básico do básico — o que é ação/FII, bolsa, corretora, de onde
   vem o retorno, preço x valor; (2) ação em 5 perguntas simples (ganha
   dinheiro? bom negócio? deve demais? paga o sócio? cara ou barata?) com
   só P/L, P/VP, margem, ROE, dívida/lucro, DY; (3) qualidade/red flags
   versão leiga; (4) FII no mesmo roteiro de perguntas (tijolo x papel x
   FOF, vacância, contratos, rendimento, P/VP, gestão); (5) carteira +
   erros psicológicos + checklists. **Cortado de propósito:** EV/EBITDA,
   PSR, ROIC, FCD, Gordon, ler as 3 demonstrações linha a linha, cap
   rate, WAULT, LTV/PDD, yield-alvo vs NTN-B — reservado pra um eventual
   "volume 2 — intermediário". ~70-110 páginas A5.
4. **FIIs entram na MESMA profundidade que ações** — mas ambos no nível
   iniciante (Parte 4 espelha as Partes 2-3).
5. Regulatório: tudo educacional, **empresas e FIIs fictícios, sem ticker
   real**, disclaimer (autor com formação mas sem CNPI).

**✅ Monetização do ebook — DECIDIDA e materiais prontos (2026-09-01).**
Usuário definiu: **preço R$ 12** (entrada, impulso, público frio) e
**checkout no Hotmart**. Página de vendas fica no **MailerLite (free)**,
separada da landing da isca gratuita; botão aponta pro checkout Hotmart.
Materiais escritos e commitados em `ebook/vendas/` (commit `d314a79`, no
GitHub):
- `hotmart-cadastro.md` — passo a passo do que o **usuário** tem que fazer
  no Hotmart (criar conta produtor, cadastrar produto, subir PDF+EPUB,
  preço R$ 12, garantia 7 dias, enviar pra análise) + descrição/palavras-
  chave prontas pra colar.
- `pagina-vendas.md` — copy completa da página de vendas (9 blocos + FAQ),
  pronta pra montar bloco a bloco no MailerLite.
- `bio-e-funil.md` — recomendação de **página-hub** (link único da bio → 2
  botões: guia grátis + ebook R$ 12), 2 versões de bio nova, e Email 4 a
  adicionar no workflow (`automations/196444252032468090`) ofertando o
  ebook 2 dias após a edição #2.
**✅ PRODUTO CRIADO E APROVADO NO HOTMART (2026-09-01).** Cadastro feito
via browser automation (`claude-in-chrome`), usuário acompanhando. Produto
"Sócio, Não Apostador", **ID 8436144**, status **"Vendas ativas"**
(aprovação foi quase instantânea, não os 1-2 dias esperados). Config:
categoria Finanças e Investimentos, moeda BRL, preço **R$ 12,00**, garantia
7 dias, forma de pagamento **"Parcelado com taxas para seu cliente"**
(irreversível — permite 1x + parcelado no cartão sem custo pro produtor),
imagem de capa 600×600 (`ebook/imagens/capa-hotmart-600.png`, gerada por
PIL a partir da `capa.png`), PDF + EPUB enviados em "Conteúdo do Produto"
(o EPUB só subiu sozinho, não no upload múltiplo). Área de membros nova
**"Bolso Esperto"** criada (`hotmart.com/club/bolso-esperto`).
**🔑 LINK DE CHECKOUT: `https://pay.hotmart.com/A107424434W`**
(página do produto hospedada pelo Hotmart: `https://go.hotmart.com/A107424434W?dp=1`).
⚠️ Enviado pra venda **antes** da leitura final do usuário (usuário
autorizou: lê no meio-tempo, troca o arquivo em Conteúdo do Produto se
precisar antes de divulgar).

**✅ Decisão sobre página de vendas (2026-09-01): usar a PÁGINA DO PRÓPRIO
HOTMART**, não construir no MailerLite. `go.hotmart.com/A107424434W?dp=1`
redireciona pra listagem do marketplace
(`hotmart.com/pt-br/marketplace/produtos/socio-nao-apostador/A107424434W`) —
mostra a descrição (a que escrevi no cadastro, boa), capa, R$ 12 / 4x de
R$ 3,27, "Garantia de 7 dias", botão "Ir para o carrinho". Tem chrome do
marketplace Hotmart em volta e o `<title>` expõe o nome legal do produtor
("Adriano Freire Rodrigues"), mas é funcional e confiável. `pagina-vendas.md`
continua no repo como referência/roteiro caso um dia se queira uma página
própria.
**❌ Tentativa de página no MailerLite abandonada.** Cheguei a gerar uma via
IA do MailerLite ("Sócio Não Apostador - Vendas", page id 197439734471984430,
site 197439734388098323) — ficou **ruim**: inventou cronômetro de "oferta
por tempo limitado" (texto em inglês), uma grade de "equipe" fictícia com
um "Analista CNPI-1" (contradiz o disclaimer), imagens de banco genéricas,
textos rasos. Removi o cronômetro e a grade fake; a página está como
**rascunho não publicado** (pode deletar em Sites depois). Lição: a IA de
landing do MailerLite não presta pra página com regras/compliance —
melhor bloco a bloco ou a do Hotmart.
⚠️ MailerLite: **trial acaba em ~3 dias** (visto em 2026-09-01) — depois cai
pro plano free (até 1.000 contatos), landing pages seguem funcionando.

**✅ Decisão (2026-09-01): link da bio do Instagram FICA na landing do guia
grátis** (`adrianofreire-h5hnp5.subscribepage.io`) — topo de funil, alimenta
a lista. Ebook vendido por dentro (Email 4 + posts), não pela bio. Nenhuma
página-hub a construir.

**Próximos passos (sessão encerrada em 2026-09-01 a pedido do usuário —
NADA disso feito ainda):** (2) adicionar **Email 4** no workflow
`automations/196444252032468090` ofertando o ebook, botão → link de checkout
`pay.hotmart.com/A107424434W` (editor de e-mail do MailerLite também
congela nessa máquina — navegar por `find`); (3) ajustar legendas dos posts
agendados (carrossel 7 números, posts 08/09) pra citar o ebook; (4) trocar
texto da bio do Instagram (2 versões em `bio-e-funil.md`).

A escada editorial antiga (#3 reserva → #10 valuation) descrita mais
abaixo neste arquivo está **OBSOLETA** — virou o índice do ebook.
Aprendizados de produção (pipeline HTML→PDF via Chrome headless, EPUB via
pandoc, infográfico sempre HTML/SVG e nunca IA, imagens via
Pollinations.ai, fluxo de agendamento no Instagram, etc.) continuam
válidos e reaproveitáveis pro ebook e pro marketing.

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
**[Correção 2026-09-01: o usuário depois esclareceu que o ebook é pra
LEIGO TOTAL e deve ser "mais simples". Não é contradição — a proposta é
"premium porém do zero / acessível", não "avançado". Ver LEIA PRIMEIRO no
topo.]**

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

**✅ Reposicionamento da landing page — FEITO E PUBLICADO (2026-08-31).**
`adrianofreire-h5hnp5.subscribepage.io` (editor "Nebula" drag-and-drop,
`pages/196432003810199271`). Texto novo, já live:
- H1: "7 números antes de comprar uma ação"
- Sub: "Guia gratuito: o que cada número diz sobre uma empresa — se ela
  está cara, se é um bom negócio, se paga bem o sócio — e o que cada um
  esconde. 15 minutos de leitura."
- Item 1: "Sem economês, com exemplos práticos"
- Item 2: "Escrito por quem tem formação em matemática e pós em finanças"
- Botão: "Quero o guia grátis"
Não achei "Company" em lugar nenhum (o `get_page_text` da página live
só tem esses 5 elementos — provavelmente já tinha sido limpo).

**⚠️ TÉCNICA que funciona pra editar texto no editor Nebula sem perder a
formatação do bloco:** NÃO usar `ctrl+a` + digitar (isso zera a
formatação — o H1 laranja grande vira corpo minúsculo). O que funciona:
`double_click` numa palavra pra entrar em modo de edição de texto →
`End` → `shift+Home` (linha única) ou `ctrl+End` → `ctrl+shift+Home`
(parágrafo multi-linha) → digitar. Selecionar o *conteúdo de texto* pelo
teclado (não o elemento do bloco) preserva os marks. Depois: "Done
editing" salva rascunho → na tela Overview aparece banner "New version
available" → clicar **"Publish new version"** pra ir pro ar. Coordenadas
de `double_click` em palavras que não sejam a última do bloco às vezes
caem no fim do texto (iframe) — mirar numa palavra perto do fim e
navegar por teclado a partir daí.

**✅ Bio do Instagram atualizada (2026-08-31)** via
`instagram.com/accounts/edit/` no desktop (texto salvou de boa; toast
"Perfil salvo"). Bio nova (138/150):
> Do salário organizado à análise de ações 🦊
> Sem economês, por quem tem pós em finanças.
> Guia grátis: 7 números antes de comprar uma ação ↓

Link da bio segue `adrianofreire-h5hnp5.subscribepage.io` (não mexi,
já aponta pra landing page repositionada). Conta: 852 seguidores.

**✅ Série de posts do Instagram pra virada — PRODUZIDA (2026-08-31),
`marketing/`, commit `21e72c1`:**
- `carrossel-02-7numeros/` — carrossel panorâmico de **6 slides**
  (6480×1080 → cortado em 6 quadrados), mesma técnica do carrossel-01
  (trilha pontilhada SVG contínua + stops numerados). Slides: hook / P·L
  e P/VP / ROE e Margem / Dív.líq÷EBITDA / DY e Payout / CTA escuro
  ("cada número esconde uma armadilha — guia grátis, link na bio"). +
  `legenda.txt`.
- `post-08-barato-boa-compra` (.html/.png/.legenda) — "'Barato' ≠ boa
  compra", exemplo fictício com 3 leituras que se contradizem.
- `post-09-yield-alto` (.html/.png/.legenda) — "Dividend yield 10%+ quase
  nunca é pechincha", as 3 armadilhas.
Todos 1080×1350 (posts) / 1080×1080 (slides), evergreen, tom Bolso
Esperto, sem ticker real.

**✅ Série agendada no Instagram (2026-08-31, 2ª tentativa).** A 1ª
falhou porque a aba do `claude-in-chrome` estava com `document.hidden =
true` (screenshots com CDP timeout, composer não responde a
cliques/refs). Na 2ª tentativa a aba voltou a `visibilityState:visible`
(conferir sempre com `document.hidden` antes de começar) e deu tudo
certo. Agenda final (todos 12:40):
- **31/08 (seg)** — post-07, lançamento edição #2 ("O cartão não é vilão")
- **02/09 (qua)** — carrossel `carrossel-02-7numeros` (6 slides, 7 números)
- **04/09 (sex)** — post-08 ("Barato ≠ boa compra")
- **06/09 (dom)** — post-09 ("Dividend yield 10%+ quase nunca é pechincha")
Confirmado em `instagram.com/scheduled_content/`.

**⚠️ 2 posts dessa série SUMIRAM da fila sem publicar (descoberto 2026-09-03).**
Ao conferir em 03/09: só o post-09 (06/09 12:40) ainda estava agendado. O
carrossel `carrossel-02-7numeros` (era 02/09) e o post-08 "Barato ≠ boa
compra" (era 04/09) **não publicaram nem apareciam na fila** — o Instagram
provavelmente falhou ao autopublicar o carrossel agendado pelo web e
descartou. Publicaram de fato: post-07 (31/08) e os anteriores da edição #1.
Todos os posts Bolso Esperto seguem com **0 curtidas** (conta pequena,
alcance orgânico ~nulo).

**✅ Reagendamento feito (2026-09-03), usando a `serie-v2/` (redesign):** o
usuário escolheu publicar as artes da `marketing/serie-v2/` (6 posts avulsos
com metáfora visual, feitos em sessão anterior não registrada aqui —
commit `02d4d75`) no lugar das originais.
- **Carrossel único com os 6 slides da serie-v2** (01-hook → 06-posicionamento,
  1080×1350, recorte 4:5) — **PUBLICADO na hora** (perfil 203→204 posts).
  Legenda adaptada da `carrossel-02-7numeros/legenda.txt` (+ "arrasta pra ver
  os 6"). serie-v2 não tinha legendas — escrevi na hora.
- **`serie-v2/05-barato-boletim.png`** — **AGENDADO p/ 04/09 07:00**
  (legenda `post-08-legenda.txt`). Confirmado em `scheduled_content/`.
- Facebook OFF nos dois. Aba estava com `document.hidden=true` mas dessa vez
  o composer respondeu normal (screenshots + `find`+ref funcionaram).
- Sobram na serie-v2 sem uso: 02-pl-iceberg, 04-roe-podio (03 e 06 e 05 e
  01 já entraram no carrossel/agendamento).

**✅ Troca dos 2 posts agendados p/ a serie-v2 refinada — FEITA (2026-09-03,
sessão posterior).** O usuário pediu (via AskUserQuestion) finalizar os
slides 03/05 da serie-v2, trocar o post-09 e refazer o post-08.
- Slides `serie-v2/03-yield-retrovisor` e `05-barato-boletim` **refinados**
  (fontes maiores, metade inferior num flex `.content` centralizado, copy
  enxuta) e re-renderizados via `google-chrome --headless --screenshot`
  `--window-size=1080,1350`. Commit `2c0a55c`, no GitHub.
- **04/09 (sex) 07:00** — post-08 "Barato ≠ boa compra": excluído o
  agendamento antigo (render velho da serie-v2/05) e recriado com o
  **render refinado** `serie-v2/05-barato-boletim.png`, legenda
  `post-08-legenda.txt`.
- **06/09 (dom) 12:40** — post-09 "Dividend yield 10%+": excluído o
  agendamento com o **design original** (`post-09-yield-alto.png`) e
  recriado com `serie-v2/03-yield-retrovisor.png`, legenda
  `post-09-legenda.txt`.
- Ambos: composer instagram.com (Criar → Postar → 4:5 explícito → legenda
  → "Programar conteúdo" ON → data no calendário → hora por setas Up/Down
  nos segmentos Hours/Minutes → Facebook OFF "Não compartilhar este post"
  → Programar). Confirmado em `scheduled_content/` (miniaturas com as artes
  novas). Aba com `document.hidden=true` mas composer respondeu normal a
  screenshots e `find`+ref o tempo todo.
- O editor de post agendado do Instagram **não deixa trocar a imagem**, só
  legenda/local/colab/rótulo IA — por isso o fluxo é sempre excluir +
  recriar (o "Excluir conteúdo programado" é irreversível, mas a legenda
  fica salva nos `.txt` do repo e a arte no `serie-v2/`).
- **Threads post 3** ("Dividend yield de 12%? Desconfia.") **PUBLICADO
  2026-09-03** via composer do `threads.com` (logado; "Quais são as
  novidades?" → digitar → Postar). A URL da landing virou link clicável
  sozinha + Threads anexou um card de preview da landing (og-image da
  raposa). **PENDENTE:** posts 4–6 do Threads (1/dia); edição #3.

**Notas do fluxo de agendamento (repetir nos próximos):**
- Screenshots ainda congelam de vez em quando (máquina fraca) mas
  voltam; `find`+`ref` e `javascript_tool` seguem funcionando — dá pra
  navegar o composer por eles.
- Múltiplas fotos → recorte **1:1** (slides já quadrados); foto única
  1080×1350 → recorte **4:5**. O menu de proporção abre no ícone
  expandir (canto inf. esq., ~533,442).
- Data: abrir campo → botão "Next month" (~1017,371) → clicar o
  `[role=gridcell]` do dia (achar rect por JS; dias passados vêm
  `aria-disabled=true`).
- Hora: dois `<input>` colados (aria-label "Horas"/"Minutos", ~721 e
  ~740, y~372) — clicar e usar setas Up/Down (digitar não cola bem).
- **Facebook**: o toggle (5º `[role=switch]`, "Compartilhar no
  Facebook…") **volta ligado a cada post** — desligar sempre: clicar
  nele (~969,354 depois de `scrollIntoView`) → diálogo → "Não
  compartilhar este post". `visDialogs:2` no JS pode persistir mesmo com
  o diálogo já fechado visualmente — conferir por screenshot, não só JS.
- ⚠️ Cliques perto de (872-970, 104) antes do layout "alargar" caem no
  X e abrem "Descartar post?" → clicar **Cancelar** (~676,218), não sair.

**✅ Série do Threads — INICIADA (2026-08-31).** 6 posts de texto (<500
caract.) escritos em `marketing/threads/posts.md` (hook das 4 perguntas,
P/L baixo ≠ barato, dividend yield alto é alerta, ROE dopado por dívida,
barato ≠ boa compra, posicionamento/credibilidade). **Posts 1 e 2
publicados**; 3-6 pendentes (Threads **não tem agendamento no site** — só
"quem pode responder" e "compartilhar em outro app"; publicar ~1 por
dia, copiando do `.md` — a URL já vira link clicável no Threads).
- Login no Threads web: **estava deslogado**; entrei com "Continuar com
  o Instagram" (usuário autorizou aceitar os Termos do Threads). Conta
  agora logada.
- ⚠️ **Link da bio do Threads ≠ Instagram.** No Threads o link da bio é
  `wa.me/...` (WhatsApp). Por isso os posts do Threads **levam a URL da
  landing (`adrianofreire-h5hnp5.subscribepage.io`) escrita no texto**,
  não "link na bio". Post 1 foi publicado com "link na bio" e depois
  **editado** (Threads dá janela de edição ~15 min: post → ⋮ → Editar).
- Bio do Threads (perfil): tem formação (Licenciatura em Matemática,
  Pós em Finanças, Especialista em Educação Mat. e Financeira) — já bate
  com o posicionamento novo. Conta tem ~134 seguidores no Threads.

**Próximos passos ao retomar:** (1) publicar posts 3-6 do Threads
(1/dia); (2) escrever a edição #3 (reserva de emergência) pra manter
cadência. Campanha da #2 pra lista atual segue **não disparada** — grupo
"Assinantes Bolso Esperto" tem só 1 assinante, adiada até ter público
real. Dados da landing page antes da virada: 10 views / 1 assinante /
10% conversão — gargalo é tráfego, não conversão.

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
