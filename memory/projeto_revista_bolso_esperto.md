---
name: projeto_revista_bolso_esperto
description: "Projeto de revista semanal (ebook) de educação financeira \"Bolso Esperto\" para venda em sites de ebooks"
metadata: 
  node_type: memory
  type: project
  originSessionId: db22fb26-9784-46ba-ba2c-b8c68c787ce7
  modified: 2026-08-19T00:03:32.414Z
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

**Why:** usuário quer lançar várias edições/ebooks no mesmo padrão — vale
manter marca e template consistentes entre sessões futuras.
**How to apply:** ao continuar este projeto em conversas futuras, seguir
o template de estrutura e o briefing de marca já definidos, sem redefinir
do zero. Edição-01 já tem texto pronto — próximo passo é imagens (Gamma)
e depois montagem do arquivo final (Pandoc). Confirmar se usuário já fez
isso manualmente antes de assumir onde o projeto parou.
