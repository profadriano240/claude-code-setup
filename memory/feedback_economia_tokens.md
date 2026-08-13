---
name: feedback-economia-tokens
description: Usuário pede para sempre economizar tokens nas interações
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 0901cc2a-1da3-4cd7-ad85-763655b010b8
  modified: 2026-08-13T20:36:53.412Z
---

O usuário pediu explicitamente para sempre tentar economizar tokens.

**Why:** Preferência geral de custo/eficiência nas interações, dita diretamente durante uma tarefa de automação de navegador (preenchimento de diário de classe) que estava gerando muitas chamadas de ferramentas (screenshots repetidos, tool calls sequenciais).

**How to apply:** Preferir `browser_batch` para agrupar múltiplas ações em uma única chamada em vez de screenshot após cada passo; evitar screenshots/confirmações redundantes quando o resultado de uma ação já é previsível ou pode ser inferido pelo `read_page`/retorno da própria ferramenta; ser conciso nas respostas em texto; evitar repetir verificações já confirmadas.
