---
name: feedback-respostas-diretas-voz
description: "Com TTS automático ligado, respostas devem ser curtas e diretas, como conversa humana falada"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 6592ff61-e8d0-46d3-95cf-03480da371b4
  modified: 2026-10-15T17:42:20.230Z
---

Usuário pediu em 2026-10-15 (logo após ligar o TTS automático, ver [[referencia_tts_voz]]): respostas mais diretas e resumidas, parecido com conversa humana.

**Why:** toda resposta agora é lida em voz alta (hook de Stop). Texto longo/técnico demais vira um monólogo chato de ouvir — conversa falada é curta, direto ao ponto, sem listas longas nem detalhamento técnico desnecessário.

**How to apply:** priorizar frases curtas, ir direto à conclusão/pergunta, evitar enumerar passos técnicos em voz a menos que perguntado. Detalhe técnico extenso (logs, código, specs) pode ficar só no texto/arquivo, mas a resposta falada deve resumir em 1-3 frases. Nunca ditar caminho de arquivo/path em voz (ex: "claude-code-setup/docs/superpowers/specs/...") — só dizer "a spec" ou "o arquivo", o caminho completo é informação visual, não falada. Combina com [[feedback_economia_tokens]] (ambos pedem menos volume, mas este é especificamente sobre tom de conversa falada).
