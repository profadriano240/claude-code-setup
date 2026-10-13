---
name: projeto-gerador-questoes-cursinho
description: Listas de questões ENEM (Matemática) para o Curso Preparatório ENEM 2026 em ~/Documentos/Gerador de questões Cursinho
metadata:
  type: project
---
Pasta ~/Documentos/Gerador de questões Cursinho: provas+gabaritos ENEM CN-MT Caderno 7 de 2020–2025 (Regular, PPL/Reaplicação, Digital, Belém 2025) em pastas por ano.
Listas/<Tema>/ guarda o PDF da lista + PDF do gabarito; fonte/ tem lista.html, gabarito.html, logo.png e recortes das figuras (qANO.png).
Feita até 2026-09-28: Geometria Espacial (6 questões, 1 por ano 2020–2025, só prova Regular, 2 por página A4).
Layout segue a "Folha Matriz (1).docx": cabeçalho com borda verde e logo, "Curso Preparatório ENEM 2026 / Matemática/Prof. Adriano Freire / Cursista:", rodapé com endereço Parauapebas.

Aula interativa (2026-10-05): "Listas/Geometria Espacial/Aula interativa - Geometria Espacial.html" (arquivo único, abre offline) + artifact https://claude.ai/artifact/XyDH4Ei78sifiZ7p8bEhoo; molde em fonte/aula-interativa.template.html (dados no array QS: enunciado, alternativas, porquê de cada distrator, dica, resolução em passos; imagens via {{qANO}} embutidas em base64 por script Python).
Variação (2026-10-05, números novos + alternativas embaralhadas, gabarito A E D B C D): "Aula interativa - Geometria Espacial (Variação).html" + artifact https://claude.ai/artifact/8QAxaanXqtKRqd3gN5o3hH; molde fonte/aula-interativa-variacao.template.html (Q3 e Q5 com figuras SVG próprias). Cuidado: não nomear função JS como `top` (colide com window.top → tela branca).

**How to apply:** para uma nova lista, copie a estrutura de Listas/Geometria Espacial/fonte e gere o PDF a partir do HTML.
