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

-- Un <br> al final de una celda no separa nada: solo deja una linea vacia
-- pegada al borde inferior, que con la cuadricula se nota.
local function sinSaltosFinales(inlines)
  while #inlines > 0 and inlines[#inlines].t == 'LineBreak' do
    inlines:remove(#inlines)
  end
  return inlines
end

function Table(tbl)
  if not FORMAT:match('latex') then return nil end
  return pandoc.walk_block(tbl, {
    Inlines = function(inlines)
      return alinearArriba(sinSaltosFinales(inlines))
    end,
  })
end

-- Un encabezado seguido de una tabla necesita mas holgura que uno seguido de
-- texto. El \needspace de apa7.tex reserva unas pocas lineas, suficientes para
-- un parrafo; pero un longtable mide su primera fila por su cuenta y, si no le
-- entra, salta de pagina y deja el titulo solo al pie. Reservando el alto de una
-- fila completa, el titulo se va con su tabla en lugar de quedarse atras.
--
-- Tiene que ser \Needspace* (con asterisco), que mide el hueco y salta de pagina
-- ahi mismo si no alcanza. El \needspace normal reserva con goma elastica y deja
-- que TeX elija despues donde cortar; cuando el corte cae dentro del longtable,
-- este ya ha tomado el control de la salida de pagina, retrocede hasta la goma
-- y vuelve a imprimir la cabecera de la tabla en la pagina nueva, antes del
-- titulo de la seccion.
--
-- Va envuelto en \reservarAntesDeTabla (apa7.tex), que lo omite cuando el
-- encabezado viene justo detras de otro encabezado, por la misma razon que los
-- \needspace de los titulos: no abrir un punto de corte entre dos titulos.
local RESERVA_ANTES_DE_TABLA = 12

function Blocks(bloques)
  if not FORMAT:match('latex') then return nil end
  local salida = pandoc.List()
  for i, b in ipairs(bloques) do
    if b.t == 'Header' and bloques[i + 1] and bloques[i + 1].t == 'Table' then
      salida:insert(pandoc.RawBlock(
        'latex', '\\reservarAntesDeTabla{' .. RESERVA_ANTES_DE_TABLA .. '}'))
    end
    salida:insert(b)
  end
  return salida
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
