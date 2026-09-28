---
name: projeto-digitalizacao-cartoes-ave
description: Digitalização dos cartões-resposta AVE Pará (SOMOS, 2ª série Matemática) para o DataEduc — progresso em 2026-09-24
metadata:
  type: project
---
Digitalizando cartões-resposta SOMOS "2ª série - Matemática - AVE - Pará" (Eeem Janelas Para O Mundo) para envio no DataEduc, no padrão do tutorial em ~/Downloads/configurações (ver [[referencia-scanner-kyocera]]).

Progresso em 2026-09-24:
- Turma M2mnm01: 7 folhas já movidas pelo usuário para ~/Documentos/Digitalizacoes/enviados (Maria Clara Melo Porto, Rikely Silva Ferreira, Luis Felipe Silva Xaxa, Maria Clara Sousa Martins, Pamela Raissa Silva Freitas, Priscila Silva De Macedo, Raul Vinicius Xavier Fernandes). Renan dos Santos Nascimento (código em branco) foi digitalizado antes pelo ADF mas o arquivo está na lixeira — confirmar se precisa refazer.
- Turma M2mnm03 (em ~/Documentos/Digitalizacoes, 0001–0005): Izabela Camile Farias De Queiroz, Jhesse Winny Silva Carneiro, Victor Emanuel Quinto Correia (sem data), Samuel Borges Lima, Joao Vitor Silva Clementino (sem data).
- Usuário vai continuar sozinho com o comando `digitalizar`.
- 2026-09-24 noite: cartões de **Português** da turma 201 tarde (M2tnm01) digitalizados pelo ADF da Kyocera (scanimage --source ADF --batch, 300dpi cinza, pad 2481x3506) em ~/Documentos/Digitalizacoes/"201 tarde" — 4 folhas (0001 é cartão genérico preenchido à mão, sem QR/código). ADF funcionou após 2-3 tentativas (erros Out of memory/Device busy do ipp-usb). HP E42540 recusa scan pelo computador (eSCL 409) — precisa login admin no EWS.

**Why:** usuário quer economizar tokens; a automação foi aprovada.
**How to apply:** NÃO alterar ~/.local/bin/digitalizar (usuário disse que não mexeremos mais nela). Novas necessidades → criar outra automação separada. Ao retomar, perguntar quais folhas faltam em vez de supor.
- 2026-09-24 20:24: lote de 12 cartões de **Português** pelo ADF (1ª tentativa OK) em ~/Documentos/Digitalizacoes/"lote 20260924_2024" (0001–0012.jpg, todos válidos). Script: scanimage ADF --batch PNG → PIL pad 2481x3506 JPEG.
- 2026-09-24 20:35: lote de 4 cartões de **Matemática** (questões 41–80) pelo ADF em ~/Documentos/Digitalizacoes/"lote 20260924_2035"; 0001 é cartão genérico preenchido à mão (sem QR/código). Usuário chama o ADF de "bandeja multiuso" — nesse contexto é o alimentador de cima.
- 2026-09-24 20:40: lote de 7 cartões de **Matemática** (41–80) em ~/Documentos/Digitalizacoes/"lote 20260924_2040"; 0001 genérico à mão (sem QR, sem assinatura).
- 2026-09-24 20:50: lote de 6 cartões Matemática em "lote 20260924_2050"; 0001–0003 (códigos 3080441, 3139817, 3139897) REPETEM 0002–0004 do lote 20260924_2035.
- 2026-09-24 20:56: 13 cartões finais da **202 tarde** pelo ADF (1ª tentativa OK) em ~/Documentos/Digitalizacoes/"202 tarde" (0001–0013.jpg).
- 2026-09-24 (depois): todas as digitalizações separadas em ~/Documentos/Digitalizacoes/"Gabaritos Portugues" (86) e "Gabaritos Matematica" (113), nomes prefixados com a pasta de origem; log em movimentos_separacao.log. Sem duplicatas por código. Diferença = 18 cartões da manhã (M2mnm01/03) só em Mat + alunos da tarde que só têm uma das provas.
