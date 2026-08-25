---
name: projeto_declaracao_frequencia
description: "Gerador HTML de declaração de frequência escolar (SEDUC-PA), feito originalmente numa conversa do claude.ai (não no Claude Code)"
metadata: 
  node_type: memory
  type: project
  originSessionId: 490728ca-98e7-491b-b8cc-4207fcbeb459
  modified: 2026-08-25T16:50:46.971Z
---

**Repositório GitHub:** `https://github.com/profadriano240/declaracao-frequencia`
(privado, criado em 2026-08-25).

**Origem:** o arquivo `declaracao-frequencia.html` foi gerado numa conversa do
claude.ai ("Gerador de declaração de frequência em HTML",
`claude.ai/chat/5cfbb0ce-1685-49c9-a765-2d9239f8b9f4`), não no Claude Code —
é um HTML único, sem dependências, com formulário (nome, data de nascimento,
documento RG/CPF, natural de, pai, mãe, turma, turno, ano letivo) que gera o
texto da declaração para impressão. Frequência é fixa em 96% no texto (por
pedido do usuário, não é editável no formulário). Baixado do chat e versionado
por pedido do usuário em 2026-08-25 — só o HTML foi trazido, o usuário optou
por **não** trazer o CLAUDE.md que a Claude do site também tinha gerado
(explicava o padrão do código da turma/SEDUC e um roteiro para reproduzir
declarações semelhantes).

**Pendência identificada, não decidida ainda:** existe outro arquivo parecido
em `~/Downloads/diploma-ensino-medio-janelas.html` (e pasta `~/Downloads/diploma/`),
provavelmente outro projeto feito no claude.ai no mesmo estilo (gerador de
diploma). Não foi perguntado ao usuário se esse também deve virar repositório
— perguntar antes de agir nele.

**Why:** usuário está migrando para o GitHub os projetos que foram feitos na
interface web do claude.ai (fora do Claude Code), para terem histórico/versionamento
como os outros projetos (ver [[projeto_automacoes_whatsapp]],
[[projeto_revista_bolso_esperto]]).
**How to apply:** ao encontrar outros arquivos baixados de conversas do
claude.ai (HTML/scripts standalone), seguir o mesmo fluxo: perguntar permissão
para baixar, copiar para `~/projetos/<nome>/`, `git init` + commit, e
`gh repo create --private --source=. --push`.
