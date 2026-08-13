---
name: diario-classe-seduc-pa
description: Como usar o Diário de Classe Digital do Portal SEDUC-PA (www4.seduc.pa.gov.br) para registrar frequência de alunos
metadata: 
  node_type: memory
  type: reference
  originSessionId: 0901cc2a-1da3-4cd7-ad85-763655b010b8
  modified: 2026-08-13T20:39:20.116Z
---

Sistema: Portal SEDUC-PA — "Consultar Professor/Servidor" — Diário de Classe Digital.

## Acesso
- URL do diário: `https://www4.seduc.pa.gov.br/diario_classe/frmDiarioDeClasse.php?cd_escola=<ID_ESCOLA>&cd_turma=<ID_TURMA>&cd_disciplina=<ID_DISCIPLINA>`
- A sessão de login já fica salva no Chrome do usuário (adrianofreire240@gmail.com) — abrir a URL direto costuma já entrar logado, sem precisar autenticar.
- Turma/disciplina já conhecida do usuário (professor Adriano Freire Rodrigues):
  - Escola: ESCOLA ESTADUAL JANELAS PARA O MUNDO — `cd_escola=826`
  - Turma: 2ª série, turno tarde, M2TNM01 — `cd_turma=1173857`
  - Disciplina: Matemática — `cd_disciplina=2006`

## Passo a passo para registrar Frequência
Na aba "Frequência" (aberta por padrão):
1. Selecionar **Período** (combobox de bimestre: 1º/2º/3º/4º Bimestre) — isso reseta o campo Mês, então selecionar Período **antes** do Mês.
2. Selecionar **Mês**. Depois de escolher, a página mostra um overlay "Aguarde..." — esperar carregar.
3. Clicar no botão "..." ao lado do campo **Dia** (é um botão, não o input de texto) — abre um calendário popup (mês/ano já vem preenchido). Clicar no dia desejado no calendário. Preferir clicar via `ref` do elemento (read_page) em vez de coordenadas fixas, pois a página pode rolar/mudar de layout entre screenshots.
4. Depois de escolher o dia, selecionar **Qtd. de Aulas** (1 a 4). Isso faz aparecer a tabela de chamada com colunas por aula: **P** (presença), **F** (falta), **FJ** (falta justificada), um rádio por aluno.
5. Para marcar todos os alunos como presentes de uma vez, existe um ícone/imagem com texto acessível **"Todos"** no cabeçalho da coluna P de cada aula — clicar nele marca automaticamente todos os alunos como P, em vez de clicar aluno por aluno.
6. Clicar em **"Salvar Frequencia"** (botão submit) para gravar. A confirmação aparece na seção "Dias Cadastrados" (ex.: "04 de Maio de 2026") e a tabela de alunos passa a mostrar "P" para cada um na coluna do dia.

## Cuidados / comportamento observado
- O grupo de abas do Chrome (`tabs_context_mcp`) pode ser perdido no meio da tarefa (ex.: se o usuário fechar algo) — nesse caso `tabs_context_mcp` retorna "No tab group exists"; basta recriar com `createIfEmpty: true` e renavegar para a mesma URL — a sessão de login persiste.
- Ações de submit/navegação no site podem travar screenshots por alguns segundos ("Script injection timed out... page is busy") — normal, só esperar (`computer wait`) e tentar screenshot de novo.
- "1º dia útil do mês" deve considerar feriados nacionais conhecidos (ex.: 1º de maio é feriado — Dia do Trabalho), não só fins de semana.

Ver também [[feedback-economia-tokens]] para o estilo de execução preferido ao automatizar esse fluxo (usar `browser_batch`, evitar screenshots redundantes).
