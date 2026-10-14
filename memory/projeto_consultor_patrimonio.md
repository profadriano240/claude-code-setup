---
name: projeto_consultor_patrimonio
description: "Agente consultor-patrimonio (finanças/investimentos pessoais) criado em 2026-10-13, ligado à planilha Mercado Financeiro"
metadata: 
  node_type: memory
  type: project
  originSessionId: 9cfb4456-e0ac-4ec5-9155-e5101dfaadd2
  modified: 2026-10-13T03:48:47.046Z
---

Agente custom `consultor-patrimonio` criado em 2026-10-13 em `/home/adriano/.claude/agents/consultor-patrimonio.md` (arquivo solto, sem repo git — diferente dos agentes do portfólio que são symlinks pro repo portfolio-sites).

**Objetivo**: ajudar o Adriano a preservar patrimônio e crescer renda passiva pelo mercado financeiro.

**Decisões do design (brainstorming 2026-10-13)**:
- Modo: só sob demanda (sem relatório periódico automático, diferente do [[projeto_painel_planejamento_financeiro_2026]] ou do analista-dados).
- Dados: só a planilha "Mercado Financeiro" (fileId `1Hbrt-zJaFxpFIGyg-w8XhCJN8EUqkhPE6S_dRsupbdM`, a ORIGINAL — ver [[projeto_auditoria_planilha_mercado_financeiro]]). Web/cotações explicitamente FORA por enquanto — Adriano disse "depois veremos".
- Perfil de risco do Adriano: moderado-conservador. Horizonte 5-15 anos até precisar de renda desses investimentos; dependência de renda hoje é só complemento pequeno (não essencial no orçamento).
- Funções: diagnóstico de alocação/concentração, perguntas pontuais (comprar/vender/aportar), acompanhamento de renda passiva (dividendos BR/EUA), checagem de inconsistências na planilha.
- Só leitura — nunca edita a planilha diretamente, só sugere. Edição fica manual com o Adriano.

**Como aplicar**: se o Adriano pedir pra "adicionar cotações/web" ao agente, ou mudar o perfil de risco, ou transformar em relatório periódico, é uma extensão do design acima — atualizar o arquivo do agente e esta memória junto.
