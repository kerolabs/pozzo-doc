-- Permite que el README tenga contenido distinto en GitHub y en el PDF.
--
--   <!-- pdf:omit-start -->  ... <!-- pdf:omit-end -->
--        Se ve en GitHub, se descarta del PDF.
--
--   <!-- pdf:only
--        \clearpage
--   -->
--        No se ve en GitHub (es un comentario HTML), se inyecta como LaTeX
--        en el PDF.

-- Los <br> dentro de una celda de tabla se pierden al pasar a LaTeX, y el
-- contenido de la celda queda todo pegado. Convertirlos en saltos de linea de
-- verdad deja que pandoc elija como representarlos en cada contexto.
function RawInline(el)
  if el.format == 'html' and el.text:match('^<br%s*/?>$') then
    return pandoc.LineBreak()
  end
end

-- Una imagen en LaTeX se apoya sobre la linea base, igual que una letra, asi que
-- crece hacia arriba. Las columnas que genera pandoc son \parbox[t], que alinean
-- las celdas de una fila por la linea base de su primera linea. Con una foto en
-- la primera celda esa linea base cae en el borde inferior de la foto, y el texto
-- de la celda vecina arranca ahi, dejando en blanco todo el alto de la imagen.
--
-- Bajar la imagen hasta que su borde superior quede a la altura de una linea
-- normal alinea ambas celdas por arriba. Solo se toca lo que esta dentro de una
-- tabla: las figuras del resto del documento se siguen componiendo como siempre.
local function alinearArriba(inlines)
  local salida = pandoc.List()
  for _, el in ipairs(inlines) do
    if el.t == 'Image' then
      salida:insert(pandoc.RawInline('latex', '\\raisebox{\\dimexpr-\\height+\\ht\\strutbox\\relax}{'))
      salida:insert(el)
      salida:insert(pandoc.RawInline('latex', '}'))
    else
      salida:insert(el)
    end
  end
  return salida
end

function Table(tbl)
  if not FORMAT:match('latex') then return nil end
  return pandoc.walk_block(tbl, { Inlines = alinearArriba })
end

function Pandoc(doc)
  local out = {}
  local omit = false

  for _, block in ipairs(doc.blocks) do
    local raw = nil
    if block.t == 'RawBlock' and block.format == 'html' then
      raw = block.text
    end

    if raw and raw:match('pdf:omit%-start') then
      omit = true
    elseif raw and raw:match('pdf:omit%-end') then
      omit = false
    elseif raw and raw:match('pdf:only') then
      local body = raw:match('pdf:only%s*(.-)%s*%-%->')
      if body and body ~= '' then
        -- Se interpreta como Markdown, no como LaTeX crudo, para que funcionen
        -- tanto los comandos (\tableofcontents) como los div (::: {#refs}).
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
