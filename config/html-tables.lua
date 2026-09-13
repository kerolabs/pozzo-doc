-- Permite escribir tablas en HTML (<table>) dentro del Markdown.
--
-- Pandoc trata un <table> como HTML crudo y LaTeX lo descarta. Este filtro lo
-- intercepta, lo lee con el lector de HTML de pandoc y lo reemplaza por una
-- tabla nativa, que sale bien en el PDF. En GitHub el HTML ya se ve solo.
--
-- Soporta colspan y rowspan, <strong>/<em>/<br>, listas dentro de celdas y
-- anchos por columna con <col style="width:30%">. El contenido de las celdas
-- se interpreta como HTML, no como Markdown: usar <strong>, no **.
--
-- Un <table> puede quedar partido en varios bloques (pandoc corta el HTML
-- crudo en las lineas en blanco), asi que se juntan los trozos desde el
-- <table> hasta el </table> antes de convertir.

local function esInicio(b)
  return b.t == 'RawBlock' and b.format:match('html') and b.text:match('^%s*<table')
end

local function esFin(b)
  return b.t == 'RawBlock' and b.format:match('html') and b.text:match('</table>%s*$')
end

local function aTexto(b)
  if b.t == 'RawBlock' then return b.text end
  return pandoc.write(pandoc.Pandoc({ b }), 'html')
end

function Pandoc(doc)
  local salida = pandoc.List()
  local i = 1
  local bloques = doc.blocks
  while i <= #bloques do
    local b = bloques[i]
    if esInicio(b) then
      local partes = { b.text }
      local j = i
      while not esFin(bloques[j]) and j < #bloques do
        j = j + 1
        partes[#partes + 1] = aTexto(bloques[j])
      end
      local html = table.concat(partes, '\n')
      local tabla = pandoc.read(html, 'html').blocks
      for _, t in ipairs(tabla) do salida:insert(t) end
      i = j + 1
    else
      salida:insert(b)
      i = i + 1
    end
  end
  doc.blocks = salida
  return doc
end
