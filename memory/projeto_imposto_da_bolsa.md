---
name: projeto-imposto-da-bolsa
description: "Site de conteúdo/SEO \"Imposto da Bolsa\" (calculadora isenção R$ 20 mil + guias IR em ações), 1º site do blueprint de portfólio de sites; no ar desde 2026-10-02"
metadata:
  node_type: memory
  type: project
  originSessionId: 8ca0761d-b073-4e4f-8e70-209de6e591f3
  modified: 2026-10-02T14:19:47.402Z
---

Criado em 2026-10-02 a partir do blueprint ~/Downloads/blueprint-agentes-portfolio-sites.md (portfólio de blogs SEO anônimos, AdSense + afiliados). O usuário escolheu aproveitar o painel [[projeto-limite-vendas-acoes]] como ferramenta-âncora; o painel pessoal continua separado e intocado.

- No ar: https://impostodabolsa.netlify.app (Netlify site id 80e19e69-2fec-4ac2-a76e-a6138013dbbe, Forms ativado para /contato/)
- Código: ~/projetos/imposto-da-bolsa, repo privado profadriano240/imposto-da-bolsa (branch master). Estático: conteudo/artigos/*.html (cabeçalho JSON em comentário) → `python3 gerar.py` → site/. Netlify roda o gerador no build (netlify.toml).
- Deploy: MCP Netlify `deploy-site` → rodar o `npx @netlify/mcp ... --proxy-path` que ele devolve, dentro do repo.
- 5 artigos (isenção, vendi >20 mil, DARF 6015, preço médio, prejuízo) + sobre/privacidade/contato. Calculadora pública = versão sem login do painel, dados só em localStorage, campo de prejuízo inicial.
- Domínio sugerido impostodabolsa.com.br (livre no Registro.br em 2026-10-02). Plano combinado: comprar só quando tiver ~15 artigos; então trocar BASE_URL em gerar.py e pedir AdSense (código do bloco vai na constante ANUNCIO; marcadores <!--ANUNCIO--> já nos artigos).
- Próximos passos: mais artigos do cluster (day trade, FII, declaração anual Bens e Direitos/Renda Variável, JCP×dividendos), calculadoras de PM e DARF, Search Console, afiliados (corretoras, software de IR).

**Why:** usuário quer renda com baixo envolvimento pessoal ([[feedback-baixo-envolvimento-redes-sociais]]); site que Claude escreve e publica sozinho.
**How to apply:** manter os fatos fiscais conservadores e com data de atualização; conferir contas dos exemplos; commitar e publicar a cada leva. Cuidado: `pkill -f` com padrão que aparece no próprio comando mata o shell.
