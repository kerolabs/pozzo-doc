-- Permite que el README tenga contenido distinto en GitHub y en el documento.
--
--   <!-- pdf:omit-start -->  ... <!-- pdf:omit-end -->
--        Se ve en GitHub, se descarta del documento.
--
--   <!-- pdf:only
--        \newpage
--   -->
--        No se ve en GitHub (es un comentario HTML), entra al documento. Los
--        comandos \newpage, \clearpage y \tableofcontents los traduce docx.lua
--        a un salto de pagina y al indice de Word.
--
--   <!-- pdf:desde av2 -->  ... <!-- pdf:desde-fin -->
--        Se ve siempre en GitHub, pero entra al documento solo desde esa
--        entrega. Sirve para las secciones de la plantilla que todavia no tocan,
--        como las entrevistas de validacion antes de la AV2. scripts/build.ps1
--        pasa la entrega en el metadato "entrega"; sin el, no se descarta nada.
--
-- Los marcadores conservan el nombre "pdf" de cuando el informe se compilaba
-- con LaTeX, para no tener que tocar los capitulos.

-- Un <br> suelto fuera de una tabla quedaria como HTML crudo, que Word
-- descarta, y el texto de ambos lados saldria pegado. Convertirlo en un salto
-- de linea de verdad deja que pandoc lo escriba como tal.
function RawInline(el)
  if el.format == 'html' and el.text:match('^<br%s*/?>$') then
    return pandoc.LineBreak()
  end
end

local ORDEN_ENTREGAS = { av1 = 1, tb1 = 2, av2 = 3, tb2 = 4 }

function Pandoc(doc)
  local out = {}
  local omit = false
  local entrega = doc.meta.entrega and ORDEN_ENTREGAS[pandoc.utils.stringify(doc.meta.entrega)]
  local antesDeSuEntrega = false

  for _, block in ipairs(doc.blocks) do
    local raw = nil
    if block.t == 'RawBlock' and block.format == 'html' then
      raw = block.text
    end

    if raw and raw:match('pdf:desde%-fin') then
      antesDeSuEntrega = false
    elseif raw and raw:match('pdf:desde%s+%w+') then
      local desde = ORDEN_ENTREGAS[raw:match('pdf:desde%s+(%w+)')]
      antesDeSuEntrega = entrega ~= nil and desde ~= nil and entrega < desde
    elseif antesDeSuEntrega then
      -- La seccion todavia no corresponde a esta entrega.
    elseif raw and raw:match('pdf:omit%-start') then
      omit = true
    elseif raw and raw:match('pdf:omit%-end') then
      omit = false
    elseif raw and raw:match('pdf:only') then
      local body = raw:match('pdf:only%s*(.-)%s*%-%->')
      if body and body ~= '' then
        -- Se interpreta como Markdown, para que funcionen tanto los comandos
        -- (\tableofcontents, \newpage), que docx.lua traduce a Word, como los
        -- div (::: {#refs}).
        for _, parsed in ipairs(pandoc.read(body, 'markdown').blocks) do
          table.insert(out, parsed)
        end
      end
    elseif not omit then
      table.insert(out, block)
    end
  end

  return pandoc.Pandoc(out, doc.meta)
end
