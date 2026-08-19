---
name: projeto-automacoes-whatsapp
description: "Automações pessoais de cotações e notícias via WhatsApp, rodando no GitHub Actions"
metadata: 
  node_type: memory
  type: project
  originSessionId: 2824c6e8-f4b4-4389-a776-3869d680b7c8
  modified: 2026-08-19T14:31:28.934Z
---

Adriano (usuário GitHub @profadriano240) tem um repositório privado **cotacoes-b3**
(https://github.com/profadriano240/cotacoes-b3) com duas automações rodando via
GitHub Actions (não dependem do notebook estar ligado):

- **cotacoes_whatsapp.py**: envia cotações de VALE3, BBAS3, ITUB4 (ações) e RBVA11,
  GTWR11, LVBI11, HSML11, GGRC11 (FIIs) via brapi.dev (plano free, 1 ativo por
  requisição) — roda 07:15 e 17:30 (seg-sex, horário de Brasília).
- **noticias_whatsapp.py**: busca as 2 notícias mais recentes (MAX_NOTICIAS, antes era 5)
  do feed `https://www.moneytimes.com.br/mercados/feed/` publicadas até 18h do próprio
  dia, sem IA (apenas RSS + filtro de horário) — roda às 18:30 (seg-sex).

**Atualizado em 2026-08-14:** usuário pediu para adiantar os três horários em
30 minutos (eram 07:45/18:00/19:00). Editado direto em
`.github/workflows/cotacoes.yml` e `.github/workflows/noticias.yml` (cron em
UTC, Brasília é UTC-3 fixo, sem horário de verão) — commit `9bb255b`,
clonado temporariamente em scratchpad só para essa edição (repo não tem
clone permanente nesta máquina, roda 100% via Actions). O filtro de corte
"notícias até 18h" do `noticias_whatsapp.py` não precisou mudar, pois
18:30 continua depois do corte.

Entrega via **CallMeBot** (API gratuita de WhatsApp) — número do usuário é
**+559491184178** (note: sem o "9" extra que ele mesmo informou verbalmente;
o CallMeBot amarra o apikey ao número exato usado no opt-in). Credenciais
(BRAPI_TOKEN, CALLMEBOT_PHONE, CALLMEBOT_APIKEY) ficam como GitHub Actions
secrets no repositório, nunca hardcoded no código versionado.

**Why:** Adriano optou explicitamente por não gastar com API (recusou usar a API da
Anthropic para escolher/resumir notícias com IA, mesmo sendo a opção de melhor
qualidade) — prefere soluções 100% gratuitas mesmo que tecnicamente mais simples
(RSS cru + filtro de categoria/horário em vez de sumarização por IA).

**How to apply:** Em futuras automações para este usuário, priorizar sempre a opção
gratuita/sem custo de API por padrão, e só sugerir serviços pagos (mesmo que baratos)
como alternativa opcional, deixando claro o trade-off de qualidade. Ver também
[[maquina-debian-home]] para o contexto de hardware modesto que motivou essa
preferência por soluções leves e gratuitas.
