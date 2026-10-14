---
name: prompts-briefing
description: Os 8 prompts-briefing (site que converte, ideias de negócio, conteúdo que engaja, estratégia de marketing 90 dias, marca e design, plano de automação, copy de vendas, plano de aprendizagem 30 dias). Use quando o usuário pedir uma dessas entregas, disser "prompt 1..8", "briefing" ou quiser estruturar um site, oferta, campanha, marca, automação ou estudo.
---

# 8 prompts-briefing

Origem: carrossel "Prompts para o Claude" (ivanandrade.ia, 14/10/2026). Ideia central: briefing
genérico gera resposta genérica — preencha papel + contexto + oferta + público + meta + formato de entrega + restrições.

## Como usar
1. Identifique qual dos 8 prompts serve.
2. Preencha as variáveis com o que já se sabe (memória, README do portfólio, `docs/cerebro-do-fundador.md`,
   `docs/voz-do-cliente.md`). Pergunte ao usuário **só** o que faltar e mudar o resultado — no máximo 3 perguntas.
3. Execute o briefing preenchido e entregue no formato pedido. Textos para publicar passam pela skill `humanizar`.
4. Se o usuário quiser usar no claude.ai, entregue o prompt preenchido pronto para colar.

## Contextos já conhecidos (atalhos para as variáveis)
- **Imposto da Bolsa** — impostodabolsa.com.br; oferta: guias + calculadoras grátis de IR na bolsa, eBooks/curso Hotmart; público: pessoa física que opera ações/FIIs e tem medo da Receita; meta: tráfego orgânico, AdSense, vendas Hotmart.
- **Solar Off-Grid** — solar-offgrid.netlify.app; oferta: calculadora + guias + manual; público: quem quer energia solar isolada (sítio, rural); meta: afiliados ML, Hotmart, AdSense.
- **Bolso Esperto** — app + manual de planejamento (R$ 24,90 Hotmart); público: 18–37 anos que recebe no último dia útil; meta: vendas.
- **Instagram @profadrianofreire** — "Adriano Freire | IR na Bolsa", professor explicando ações, FIIs e DARF; meta: levar à bio.
- **Clientes de site** — Luara Lacerda (advogada criminalista, Parauapebas/PA) e Projetar Soluções (engenharia); serviço local; meta: contato no WhatsApp.

## Os 8 briefings

**1. Site que converte** — Atue como estrategista digital e UX writer. Crie a estrutura de um site para [tipo de negócio],
que vende [oferta] para [público]. O objetivo do site é [meta principal]. Entregue: mapa da home page, seções, headline,
provas, CTA e sugestões visuais. Considere [diferenciais], [tom de voz] e [restrições].
*(Ao executar, cruzar com o checklist de 20 itens pré-lançamento da memória.)*

**2. Ideias de negócio** — Atue como consultor de novos negócios. Gere 10 ideias de negócio alinhadas a [mercado],
[competências], [capital disponível] e [prazo]. Para cada ideia, mostre problema, público, modelo de receita, risco,
esforço e primeiro passo de validação. Priorize ideias viáveis no Brasil.

**3. Conteúdo que engaja** — Atue como estrategista de conteúdo. Crie 10 ideias de conteúdo para [empresa] que vende
[oferta] para [público]. Quero conteúdo para [canal], com objetivo de [meta]. Para cada ideia, entregue: gancho, formato,
mensagem central, CTA e sugestão de título. Evite clichês e repetições.

**4. Estratégia de marketing** — Atue como CMO fracionado. Crie um plano de marketing de 90 dias para [empresa], que atua
em [mercado], com objetivo de [meta] e orçamento de [valor]. Estruture por canais, cronograma, KPIs e prioridades.
Considere quick wins, estrutura enxuta e foco em geração de demanda.

**5. Marca e design** — Atue como estrategista de marca. Crie um direcionamento de branding para [empresa], que vende
[oferta] para [público]. Entregue posicionamento, proposta de valor, personalidade da marca, paleta, tipografia,
referências visuais e recomendações de aplicação. Evite soluções genéricas.
*(Implementação visual: agente `designer-frontend` / skill frontend-design.)*

**6. Plano de automação** — Atue como consultor de operações com IA. Desenhe um plano de automação para o processo
[processo], hoje executado por [time]. O objetivo é reduzir [problema] e ganhar [resultado]. Mapeie etapas, ferramentas
sugeridas, integrações, riscos, pontos de aprovação humana e plano de implementação em fases.
*(Preferir soluções gratuitas; ação externa sempre com aprovação do usuário.)*

**7. Copy de vendas** — Atue como copywriter. Escreva a copy de uma landing page para [oferta], vendida para [público],
com objetivo de [conversão]. Entregue: headline, subtítulo, dores, benefícios, provas, objeções, CTA e estrutura da
página. Use tom [tom de voz]. *(Sem promessas exageradas; objeções reais vêm de `docs/voz-do-cliente.md`.)*

**8. Plano de aprendizagem** — Atue como mentor de aprendizagem aplicada. Crie um plano de 30 dias para dominar [tema]
com foco em [aplicação profissional]. Estruture por semanas, com objetivo, tópicos, exercícios, recursos e indicadores
de progresso. Considere rotina de [x] horas por semana.
