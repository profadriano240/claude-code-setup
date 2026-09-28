---
name: referencia-scanner-kyocera
description: Kyocera ECOSYS M2640idw via USB (ipp-usb/eSCL) — como digitalizar, falhas conhecidas, padrão DataEduc
metadata:
  type: reference
---
Kyocera ECOSYS M2640idw conectada por USB (2026-09-24), exposta por ipp-usb em http://localhost:60000/eSCL.
- Vidro funciona com `scanimage -d 'escl:http://localhost:60000' --source Flatbed`.
- Alimentador (ADF): backends escl/airscan falham ("Out of memory", "Error during device I/O"); o ipp-usb embaralha respostas da USB. O que funcionou melhor: POST direto em /eSCL/ScanJobs (InputSource Feeder, image/jpeg) + GET NextDocument em sequência. Mesmo assim, em lote de 5 folhas só 2 JPEGs chegaram inteiros → validar cada imagem com PIL.
- Transferência quebrada pode deixar papel preso no ADF e a impressora responde 503 até retirar.
- Padrão DataEduc/AVE Pará (tutorial em ~/Downloads/configurações): A4, tons de cinza, 300 dpi, JPEG 2481x3506, 1 imagem por folha, sem rotação. Destino usado: ~/Documentos/Digitalizacoes.
- Automação criada (2026-09-24): comando `digitalizar [pasta]` (~/.local/bin/digitalizar) + atalho "Digitalizar folhas" no menu GNOME. ENTER digitaliza o vidro no padrão DataEduc, ignora vidro vazio/folha repetida; q sai. Usuário usa isso sozinho para economizar tokens.
- Automação ADF (2026-09-24): `digitalizar-lote [pasta]` (~/.local/bin/digitalizar-lote) + atalho "Digitalizar lote (alimentador)". Espelha `digitalizar`: loop ENTER/q (cada ENTER lê o ADF inteiro, 3 tentativas), ignora folha em branco/repetida, nomes img<data_hora>_NNNN.jpg, JPEG q92; pasta ~/Documentos/Digitalizacoes/"lote AAAAMMDD_HHMM" sem perguntar nome; abre a pasta ao sair. Usuário DESISTIU dela ("não está funcionando" — o sensor do ADF é instável): prefere pedir aqui "tente novamente" e Claude digitaliza manualmente (scanimage ADF --batch com 3 tentativas → PIL pad → JPEG em "lote AAAAMMDD_HHMM" → prancha de miniaturas para conferir).
- HP LaserJet MFP E42540 (USB, 2026-09-28): ADF funciona bem via `scanimage -d 'escl:http://localhost:60000' --source ADF --mode Gray --resolution 300 -x 210 -y 297 --batch` (35 folhas numa passada, sem falhas). hpaio dá "Error during device I/O". ADF devolve 2480x2800 → completar com branco até 2481x3506.
