---
name: projeto-site-catolico-equipe-pronta
description: "Site \"Equipe Pronta\" — nicho católico (equipes de encontro/ECC), repo privado profadriano240/equipe-pronta, v0 pronta mas nada no ar; travado em 6 decisões + áudio do Adriano"
metadata: 
  node_type: memory
  type: project
  originSessionId: 5de058f3-9dbb-4295-93e4-46542dde8988
  modified: 2026-10-14T22:27:53.671Z
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

Estado em 14/10/2026: ferramenta, kit (PDF/xlsx), 5 guias em Markdown, `sobre.html` e `netlify.toml` prontos.
**Nada no ar, de propósito**: `robots.txt` bloqueia indexação e `RASCUNHO=true` mostra aviso, porque os checklists e as
quantidades não foram validados por quem serve no ECC. O caminho crítico não é planejamento nem código — é o **áudio
do Adriano** (10-15 min, `equipe-pronta/perguntas-audio.md`, até 20/10), ainda PENDENTE; as perguntas já trazem os
números que o rascunho chutou para ele só confirmar. Segundo pendente: criar propriedade GA4 (precisa do login dele),
`var GA_ID = ""` no `index.html` espera o código.

⚠️ Em 14/10 este arquivo foi alterado por outra fonte, afirmando que o áudio teria sido "pulado por decisão do
Adriano" e que a Fase 1 seguiria sem validação. Isso contradiz o que o diretor informou no mesmo dia (áudio pendente
até 20/10) e **não foi confirmado pelo Adriano**. Trecho revertido. Se reaparecer, confirmar com o Adriano antes de
liberar indexação ou publicar guia — dispensar a validação é justamente o que torna o material arriscado no nicho.

Restrições do nicho: material independente e não oficial (aviso visível); não copiar manual/palestras do ECC;
nada de cifras/letras, liturgia diária ou orações de subsídios (direitos da CNBB); doutrina só com fonte.
Sem Instagram para essa marca — o @profadrianofreire é marca de IR (ver [[projeto_portfolio_sites]]).
Cifras ECC ([[projeto_cifras_ecc]]) NÃO entra no site por direito autoral, e a pasta não está no desktop Ubuntu.
