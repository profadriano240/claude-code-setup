---
name: projeto_produto_planejamento_financeiro
description: "Produto Bolso Esperto \"Todo Real Tem Destino\" (manual PDF + app Distribuidor do Salário) p/ vender na Hotmart; app e divulgação no ar 2026-10-09, falta cadastro Hotmart"
metadata:
  node_type: memory
  type: project
  originSessionId: fe8bcce3-9a9b-42da-96e8-efc4b4ce3629
  modified: 2026-10-09T14:15:42.017Z
---

Decidido 2026-10-09: vender pacote **manual + app** de planejamento financeiro na **Hotmart**, marca **Bolso Esperto** ([[projeto_revista_bolso_esperto]]), preço sugerido **R$ 24,90** (faixa R$ 19–29), garantia 7 dias. Sem login: app em link não divulgado (aceito o risco de repasse).

**Peças**
- Manual PDF → [[projeto_manual_todo_real_tem_destino]] (~/projetos/bolso-esperto/manual/). v1 ainda sem feedback do usuário.
- App completo NO AR: https://bolsoesperto-distribuidor.netlify.app (Netlify site id d7e6239f-95b2-4550-96f4-06cdcf1faf61, noindex). Fonte: ~/projetos/bolso-esperto/produto/app/index.html (cópia standalone do artifact 1xfCck9TDnDzS1rxj9AYcc, download .xlsx via Blob em vez de window.claude). Botão da planilha ainda não testado no site publicado.
- Textos da página de vendas: ~/projetos/bolso-esperto/produto/hotmart.md (nome, descrições, para quem é, FAQ). Commit ac4d1a3 no repo bolso-esperto, NÃO pushado.
- Deploy do app: conector Netlify `deploy-site` → rodar o `npx @netlify/mcp --proxy-path ...` devolvido, de dentro de produto/app (funcionou). netlify-cli via npx dá timeout; não há token em ~/.config/netlify.

**Divulgação no impostodabolsa.com.br** ([[projeto_imposto_da_bolsa]]) — NO AR 2026-10-09 (merge 5824e2a na master): calculadora grátis simplificada /calculadora-distribuicao-salario/ (assets/calc-salario.js), guia /como-organizar-salario-antes-de-investir/ (editoria "Finanças pessoais"), CTA_SAL, e caixa AFILIADOS["todo-real"] no gerar.py com `url` vazia (invisível). O app completo NÃO vai para o site (perderia valor).

**Próximos passos (ao retomar)**
1. Cadastro na Hotmart — perguntar se Claude faz pelo Chrome (com usuário vendo) ou o usuário.
2. Capa 600×600 do produto (oferecida, no padrão da capa do manual) — aguardando resposta.
3. Feedback/ajustes do manual v1 antes de subir o PDF.
4. Com o link Hotmart: preencher AFILIADOS["todo-real"]["url"] no gerar.py e publicar (git push = produção, pedir OK).
5. Opcional oferecido: pedir indexação das 2 páginas novas no Search Console.

Ideias adiadas: importação de extrato OFX/CSV; Open Finance (só Meu Pluggy p/ uso pessoal; produto público exige intermediário pago + LGPD).

**Why:** usuário quer produto replicável/vendável de organização financeira com baixo envolvimento pessoal ([[feedback_baixo_envolvimento_redes_sociais]]).
**How to apply:** retomar pelos próximos passos acima; publicar/cadastrar/push só com OK explícito.
