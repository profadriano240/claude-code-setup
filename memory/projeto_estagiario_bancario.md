---
name: projeto-estagiario-bancario
description: "Agente estagiario-bancario cuida da conta Inter (contadigital.inter.co): lê extrato via Chrome, categoriza e organiza em painel local. Só leitura por ora."
metadata: 
  node_type: memory
  type: project
  originSessionId: 64e99991-97dc-4d67-a72f-200017353fba
  modified: 2026-10-14T03:47:46.100Z
---

Criado em 2026-10-14. Agente `~/.claude/agents/estagiario-bancario.md` (precisa reiniciar sessão
para aparecer na lista, como todo agente novo — ver [[agente_designer_frontend]]).

Escopo combinado com o Adriano, em duas fases:
- **Fase 1 (ativa agora)**: ler extrato/saldo via Chrome (login manual do Adriano, agente nunca
  loga), categorizar gastos por palavra-chave, organizar num painel local dedicado.
- **Fase 2 (ainda não habilitada)**: preparar pagamento/transferência pedindo aprovação explícita
  antes de confirmar. Só implementar quando o Adriano pedir.

Dados em `~/projetos/conta-inter/` (repo git local, sem remoto ainda):
- `inter.db` (SQLite, fora do git — dados financeiros pessoais, igual padrão de
  [[projeto_carteira_ativos_local]]).
- `categorias.py`: regras de categorização por palavra-chave (editável).
- `server.py`: painel web local em http://127.0.0.1:8767 (porta livre: carteira usa 8765, censo
  usa 8766). Abrir com o comando `inter`. Tema claro/escuro incluso.
- API: `POST /api/transacoes` (lote, categoriza e ignora duplicata por hash
  data+descrição+valor), `GET /api/transacoes`, `GET /api/resumo`, `PATCH /api/transacoes/<id>`
  (corrigir categoria manualmente).

Nota: `~/projetos/carteira-ativos/` referenciado na memória antiga não existe mais nesta máquina
(desktop Ubuntu) — não investigado, fora do escopo desta tarefa.
