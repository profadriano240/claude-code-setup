---
name: projeto-limite-vendas-acoes
description: "App web limite-vendas-acoes (index.html único, Netlify, login/sincronização) — repo GitHub privado criado em 2026-09-21"
metadata:
  type: project
---

App de página única (`~/projetos/limite-vendas-acoes/index.html`, criado em 2026-09-21) publicado no Netlify, com login por e-mail/senha e sincronização (mensagens de erro no estilo Supabase). Relacionado ao tema de investimentos/ações, ver [[projeto_auditoria_planilha_mercado_financeiro]].

**Repo GitHub:** privado `profadriano240/limite-vendas-acoes` (branch main, criado 2026-09-21; `.netlify/` no .gitignore). Não havia versionamento antes disso.

**Why:** em 2026-09-21 uma verificação achou este projeto e o [[projeto_site_projetar_solucoes]] sem backup no GitHub; usuário pediu para subir os dois.
**How to apply:** ao alterar o app, commitar e dar push; ao criar projeto novo em `~/projetos/`, já criar o repo GitHub privado (git init + `gh repo create --private`), sem segredos no código. Conferir periodicamente se todos os projetos estão sincronizados (ver [[referencia_backup_claude_code_setup]]).

**É o "painel de swing trade mensal"** do usuário: https://limite-vendas-acoes.netlify.app (Supabase `qrbfgvkxgokydjdpmwvy`, pausado por inatividade em 2026-09-30). Para atualizar: vendas vêm da planilha original, aba `(IR) Ações` (linhas com Qt. negativa; Valores = total bruto; col. "Valor para IR" = PM). Em 2026-09-30 o histórico completo (138 vendas, 2020-06 a 2026-09, das abas (IR) Ações + abas setoriais antigas + (IR) FIISs como tipo "outros") foi gravado no localStorage do Chrome do notebook via JS; PM inválido na planilha (#DIV/0!, 0, negativo ou absurdo) → pm=0 (39 vendas). Lucro também aparece em % (lucro/custo).
