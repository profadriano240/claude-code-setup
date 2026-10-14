---
name: feedback-parar-em-97-porcento-uso
description: "Ao chegar perto do limite de uso do plano Claude, parar trabalho e sincronizar memória pro GitHub antes de continuar em outra máquina"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 94cc56e2-a488-408c-a1d2-b59db15e47ec
  modified: 2026-10-14T04:28:11.263Z
---

Regra permanente (vale em toda sessão, automática): ao perceber que o uso do plano Claude está chegando em ~97%, parar o trabalho em andamento e garantir que a memória (`~/.claude/projects/-home-adriano/memory/`) está atualizada e sincronizada no GitHub (repo `profadriano240/claude-code-setup`), para o usuário continuar depois em outra máquina sem perder contexto.

**Limitação técnica importante:** não existe ferramenta disponível pra Claude observar a porcentagem de uso do plano (billing/5h/semanal) — só dá pra ver tokens restantes *da conversa atual* (contexto), que é uma métrica diferente. Não há hook ou evento do harness pra esse limite de plano. Então essa regra NÃO pode ser cumprida de forma autônoma/proativa por mim — depende do usuário avisar quando perceber o uso chegando perto do limite (ex. pela interface do Claude Code), e aí sim eu paro e sincronizo na hora.

**Why:** usuário trabalha em mais de uma máquina (desktop Ubuntu + notebook Debian, ver [[maquina_desktop_ubuntu]] e [[maquina_debian_home]]) e quer poder trocar de máquina sem perder o fio do que estava em andamento.
**How to apply:** se o usuário disser algo como "tá chegando no limite" ou "vou trocar de máquina", tratar como o gatilho real: parar a tarefa no ponto atual, escrever/atualizar memórias relevantes do que estava em andamento (projeto, próximos passos, estado dos agentes em background), e confirmar que o hook `sync-memory-repo.sh` rodou (qualquer Write/Edit já dispara isso automaticamente via PostToolUse).
