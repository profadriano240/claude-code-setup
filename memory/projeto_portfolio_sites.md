---
name: projeto-portfolio-sites
description: "Central do portfólio de sites SEO (AdSense + afiliados): repo privado profadriano240/portfolio-sites com README de estado, blueprint e clonar.sh"
metadata:
  node_type: memory
  type: project
  originSessionId: ccab06f8-6688-4f93-a59f-28ab7a7dc7d6
  modified: 2026-10-06T22:00:00.000Z
---

Criado em 2026-10-04 a pedido do usuário, para continuar o portfólio do desktop de casa.

- Repo privado https://github.com/profadriano240/portfolio-sites (branch master), local ~/projetos/portfolio-sites.
- README.md = estado de todos os sites + próximos passos; docs/blueprint-agentes-portfolio-sites.md = estratégia; clonar.sh clona/atualiza os repos dos sites ao lado.
- Sites: [[projeto-imposto-da-bolsa]] (Site 1) e [[projeto-solar-offgrid]] (Site 2).

**Why:** um lugar único para retomar o portfólio em qualquer máquina, sem depender da memória local.
**How to apply:** ao mudar o estado de um site (deploy, AdSense, afiliados, artigos), atualizar também o README desse repo e dar push; site novo → acrescentar no clonar.sh.

**Equipe de agentes (2026-10-05):** 5 subagentes em `portfolio-sites/agentes/` com symlink em ~/.claude/agents (diretor-portfolio, social-instagram, seo-conteudo, monetizacao, analista-dados); clonar.sh refaz os links. Instagram passou a usar a imagem do usuário (decisão dele em 2026-10-05) — blueprint ajustado. Relatórios em `portfolio-sites/relatorios/`. Agentes ficam no repo privado, não no claude-code-setup (público).

**Sessão de 2026-10-06 (resumo):**
- Imposto da Bolsa virou portal de notícias (cotações, editorias, fotos CC0) — ver [[projeto-imposto-da-bolsa]]. Netlify agora ligado ao GitHub: **deploy = git push na master** (pedir OK antes).
- Instagram @profadrianofreire: nome "Adriano Freire | IR na Bolsa" (só 2 trocas/14 dias), bio nova (opção "professor"), link da bio com `?utm_source=instagram&utm_medium=bio` (trocado pelo usuário).
- Agenda de 25 carrosséis (1 por artigo, seg/qua/sex 12h30, 09/10→11/12) em `portfolio-sites/docs/agenda-instagram.md`. 09, 14 e 16/10 AGENDADOS no Meta Business Suite por mim (passo a passo em `agentes/social-instagram.md`).
- **Próximos lotes só depois do relatório do analista-dados de sexta 09/10** — decisão do usuário.
- Sitemap reenviado (44 URLs). Ao retomar, sempre `git pull` neste repo e no do site.
