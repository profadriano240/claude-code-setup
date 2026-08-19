---
name: projeto-automacoes-whatsapp
description: "Automações pessoais de cotações e notícias via WhatsApp, rodando no GitHub Actions"
metadata: 
  node_type: memory
  type: project
  originSessionId: 2824c6e8-f4b4-4389-a776-3869d680b7c8
  modified: 2026-08-19T14:37:02.572Z
---

Adriano (usuário GitHub @profadriano240) tem um repositório privado **cotacoes-b3**
(https://github.com/profadriano240/cotacoes-b3) com duas automações rodando via
GitHub Actions (não dependem do notebook estar ligado):

- **cotacoes_whatsapp.py**: envia cotações apenas de VALE3, BBAS3 e PETR4 (ações;
  antes era VALE3/BBAS3/ITUB4 + 5 FIIs, removidos em 2026-08-19) via brapi.dev
  (plano free, 1 ativo por requisição) — roda 07:15 e 17:30 (seg-sex, horário de
  Brasília).
- **noticias_whatsapp.py**: busca as 2 notícias mais recentes (MAX_NOTICIAS) do feed
  `https://www.moneytimes.com.br/mercados/feed/`, sem IA (apenas RSS + filtro de
  janela de horário) — roda duas vezes (seg-sex): 06:30 (turno "manha", pega notícias
  publicadas desde as 18h de ontem até agora — cobre noticiário internacional
  overnight) e 18:30 (turno "tarde", pega notícias de hoje publicadas até 18h,
  comportamento original). O turno é passado via env var `TURNO` pelo workflow,
  que o determina a partir do horário do cron que disparou o job.

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

**Atualizado em 2026-08-19:** o CallMeBot estava truncando a mensagem de notícias
a partir da 3ª (2 primeiras chegavam certas, a 3ª incompleta, a 4ª só aparecia "4."
e a 5ª nem chegava) — limite de tamanho de mensagem/URL do CallMeBot. Reduzido
`MAX_NOTICIAS` de 5 para 2 em `noticias_whatsapp.py`, commit `8fbb5fd`
(mesmo fluxo: clone temporário no scratchpad, sem clone permanente na máquina).

**Atualizado em 2026-08-19 (2):** usuário pediu para receber cotações apenas de
VALE3, BBAS3 e PETR4 — removidos ITUB4 e todos os FIIs (RBVA11, GTWR11, LVBI11,
HSML11, GGRC11) de `cotacoes_whatsapp.py` (confirmado explicitamente que os FIIs
deveriam sair também). Commit `8fc7943`.

**Why:** Adriano optou explicitamente por não gastar com API (recusou usar a API da
Anthropic para escolher/resumir notícias com IA, mesmo sendo a opção de melhor
qualidade) — prefere soluções 100% gratuitas mesmo que tecnicamente mais simples
(RSS cru + filtro de categoria/horário em vez de sumarização por IA).

**How to apply:** Em futuras automações para este usuário, priorizar sempre a opção
gratuita/sem custo de API por padrão, e só sugerir serviços pagos (mesmo que baratos)
como alternativa opcional, deixando claro o trade-off de qualidade. Ver também
[[maquina-debian-home]] para o contexto de hardware modesto que motivou essa
preferência por soluções leves e gratuitas.
