---
name: maquina-desktop-ubuntu
description: Hardware e estado de configuração do desktop Ubuntu do Adriano (máquina diferente do notebook Debian)
metadata: 
  node_type: memory
  type: project
  originSessionId: 6294ac78-f5ce-4dc7-891b-993eca50c92a
  modified: 2026-09-02T02:10:38.669Z
---

Desktop do Adriano, hostname `adriano-B550M-DS3H-AC-R2`: Ubuntu 24.04.4 LTS
(Noble Numbat), placa B550M-DS3H, AMD Ryzen 5 5600GT (6 núcleos/12 threads),
14 GiB RAM, discos `sda` (HDD 465,8G ST500LM012) + `nvme0n1` (SSD 465,8G WD
Green SN350). Máquina bem mais forte que o notebook Debian (Celeron N4020,
3,6GB) — ver [[maquina-debian-home]]. Não aplicar aqui as restrições de
hardware fraco (pode rodar várias apps Electron, builds pesados, etc. sem
preocupação de recurso).

Constatado em 2026-09-01: repositório `~/claude-code-setup` já clonado
nesta máquina (config/desktop/dotfiles/hooks/memory/packages/system +
`restore.sh`), e a memória de longo prazo já carrega normalmente — ou seja,
essa máquina já passou por `restore.sh` ou clone manual do backup em algum
momento anterior a esta sessão. Hooks de auto-sync (`sync-memory-repo.sh`,
`sync-config-repo.sh`) presumivelmente ativos aqui também, já que vieram
junto no restore — não confirmado individualmente ainda.

**Why:** usuário perguntou se havia atualização de memória "neste
computador" — sinal de que ele alterna entre pelo menos duas máquinas
(notebook Debian fraco + este desktop Ubuntu) e quer que a memória
identifique em qual delas está.

**How to apply:** ao dar sugestões de performance/ferramentas pesadas,
verificar hostname (`hostname`) pra saber se está no notebook fraco ou
neste desktop antes de aplicar as restrições do notebook.
