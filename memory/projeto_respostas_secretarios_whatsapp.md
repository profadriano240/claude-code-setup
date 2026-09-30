---
name: projeto-respostas-secretarios-whatsapp
description: "Tarefa em andamento (2026-09-30) de responder secretários do Censo no WhatsApp Web — o que já foi enviado, rascunhos pendentes de aprovação, e como ler/baixar/transcrever áudios"
metadata:
  node_type: memory
  type: project
  originSessionId: 5f9721d7-fa6c-4553-8fc7-7e59949efe48
  modified: 2026-09-30T15:26:59.787Z
---

Em 2026-09-30 o usuário pediu para responder os secretários (ver [[projeto-painel-censo-2026]]) que mandaram mensagem em 29–30/09 sem resposta.

**Já enviado (12:02–12:03, aprovado pelo usuário):** Ana Célia (Sandra Maria), Thays (Pequeno Príncipe), Giovane (Santa Rita), Sinara (Dona Rosa), Bianca (Faruk Salmen), Simone (Pingo de Gente).

**Pendente — rascunhos mostrados ao usuário, aguardando OK para enviar:**
- Adriana (Antonio Vilhena): já resolveu a dúvida dos "contemplados"; lança as pós de 2 professores amanhã; sexta a escola fecha (urnas). Rascunho: "Beleza, Adriana! Lança as pós amanhã e depois é só aguardar nosso comando para todo mundo fechar junto."
- Bel (José Rodrigues): alunos com cor/raça "não declarada" no relatório; pergunta se apaga e relança só os pendentes. Rascunho: sim, só os pendentes, reinformar cor/raça no Educacenso; foi problema da migração do i-Educar, não falha dela. (orientação técnica — usuário deve confirmar)
- Daniele (Joseane Silva): baixou o relatório e não vê pendência; também fez 2 ligações perdidas. Rascunho: pedir print.
- Alyne (Ruth Rocha): aluno com erro "não vinculado à turma AEE" mas não é PCD. Rascunho: conferir se ficou marcada deficiência/transtorno por engano e desmarcar. (orientação técnica — usuário deve confirmar)

Já respondidos pelo próprio usuário: Francisco, Herculano, Maria Eduarda, Natielly, Adriano (Maria Josélia). +55 94 8135-7846 = propaganda.

**Como fazer (WhatsApp Web no Chrome, conta Business):**
- Abrir conversa: clicar na busca (270,86), ctrl+a, digitar "Nome - Escola", Enter; conferir o cabeçalho `#main header` antes de digitar; caixa de mensagem em (900,520).
- Mensagens: `#main [data-testid^="conv-msg-"]`; enviada por mim = tem `[data-icon*="check"]` (aria-label "Você" nem sempre aparece).
- Áudio: sobrescrever `HTMLMediaElement.prototype.play` para `muted=true` e capturar `this.src` (blob), clicar em `button[aria-label*="Reproduzir"]`, depois baixar o blob com `<a download>` → cai em ~/Downloads. Se a conversa mostrar poucas mensagens, clicar no aviso "carregar mensagens mais antigas do seu celular".
- Transcrição: comando `transcrever arquivo.ogg ...` (~/.local/bin, faster-whisper modelo small int8 em ~/.local/share/whisper-venv; exige `av<14` — av 13.1.0 instalado). Áudios desta tarefa em ~/.cache/claude-temporario/audios.
- Saída do javascript_tool é truncada (~1000 caracteres) e bloqueia texto com `=?&%`/URLs: resumir e limpar antes de retornar.

**Why:** o usuário auxilia esses secretários na retificação do Censo e tem pouco tempo.
**How to apply:** ao retomar, pedir o OK para os 4 rascunhos pendentes (ou ajustes), enviar e depois checar se chegaram respostas novas (ex.: CSV do Giovane, print da Bianca).
