-- Permite usar HTML en el Markdown y que sobreviva al PDF:
--
--   <table> ... </table>          se convierte en una tabla nativa (colspan,
--                                 rowspan, <col style="width:NN%">, <br>, <p>,
--                                 listas, imagenes).
--   <div align="center"> ... </div>
--                                 se centra en el PDF (texto o imagenes).
--   <img src="..." width="...">    dentro de un parrafo, se vuelve una imagen.
--
-- Dentro de esos bloques se puede escribir HTML o Markdown: **negrita**,
-- *cursiva*, `codigo`, [enlace](url) e ![imagen](ruta) se traducen a sus
-- etiquetas antes de convertir, y <strong>, <em>, <br>, <img> se leen tal cual.
--
-- Pandoc trata estos bloques como HTML crudo y LaTeX los descarta. El filtro
-- junta los trozos desde la etiqueta de apertura hasta la de cierre (pandoc
-- corta el HTML crudo en las lineas en blanco), los lee con el lector de HTML de
-- pandoc y los reemplaza por bloques nativos. En GitHub el HTML ya se ve solo.

local function esHtml(b)
  return b.t == 'RawBlock' and b.format:match('html')
end

-- Etiqueta de bloque que abre el trozo, o nil.
local function apertura(b)
  if not esHtml(b) then return nil end
  local tag = b.text:match('^%s*<(%a+)')
  if tag == 'table' or tag == 'div' or tag == 'center' then return tag end
  return nil
end

local function cierra(b, tag)
  return esHtml(b) and b.text:match('</' .. tag .. '>%s*$') ~= nil
end

local function aTexto(b)
  if b.t == 'RawBlock' then return b.text end
  return pandoc.write(pandoc.Pandoc({ b }), 'html')
end

-- Markdown inline -> HTML, sin tocar el interior de las etiquetas.
local function markdownAHtml(html)
  local salida = {}
  for texto, tag in html:gmatch('([^<]*)(<?[^>]*>?)') do
    texto = texto
      :gsub('!%[(.-)%]%((.-)%)', '<img src="%2" alt="%1">')
      :gsub('%[(.-)%]%((.-)%)', '<a href="%2">%1</a>')
      :gsub('%*%*(.-)%*%*', '<strong>%1</strong>')
      :gsub('__(.-)__', '<strong>%1</strong>')
      :gsub('%f[%*]%*([^%*\n]-)%*%f[^%*]', '<em>%1</em>')
      :gsub('`(.-)`', '<code>%1</code>')
    salida[#salida + 1] = texto
    salida[#salida + 1] = tag
  end
  return table.concat(salida)
end

local function centrado(b)
  if b.t ~= 'Div' then return false end
  local align = b.attributes['align'] or ''
  local style = b.attributes['style'] or ''
  return align:lower() == 'center' or style:lower():match('text%-align:%s*center') ~= nil
end

local function convertir(html, tag)
  local bloques = pandoc.read(markdownAHtml(html), 'html').blocks
  local salida = pandoc.List()
  for _, b in ipairs(bloques) do
    if (tag == 'div' and centrado(b)) or tag == 'center' then
      salida:insert(pandoc.RawBlock('latex', '\\begin{center}'))
      local contenido = b.t == 'Div' and b.content or { b }
      for _, c in ipairs(contenido) do salida:insert(c) end
      salida:insert(pandoc.RawBlock('latex', '\\end{center}'))
    elseif b.t == 'Div' then
      for _, c in ipairs(b.content) do salida:insert(c) end
    else
      salida:insert(b)
    end
  end
  return salida
end

-- Pandoc convierte <div ...> en un Div nativo antes de llegar aqui (extension
-- native_divs), asi que el centrado tambien se aplica sobre ese Div.
function Div(el)
  if centrado(el) and FORMAT:match('latex') then
    local salida = pandoc.List({ pandoc.RawBlock('latex', '\\begin{center}') })
    for _, c in ipairs(el.content) do salida:insert(c) end
    salida:insert(pandoc.RawBlock('latex', '\\end{center}'))
    return salida
  end
end

-- Un <img> escrito en HTML dentro de un parrafo Markdown llega como HTML crudo
-- y LaTeX lo descarta; se lee con el lector de HTML y se vuelve una imagen.
function RawInline(el)
  if el.format:match('html') and el.text:match('^<img%s') then
    local bloques = pandoc.read(el.text, 'html').blocks
    if bloques[1] and bloques[1].content and bloques[1].content[1] then
      return bloques[1].content[1]
    end
  end
end

function Pandoc(doc)
  local salida = pandoc.List()
  local bloques = doc.blocks
  local i = 1
  while i <= #bloques do
    local b = bloques[i]
    local tag = apertura(b)
    if tag then
      local partes = { b.text }
      local j = i
      while not cierra(bloques[j], tag) and j < #bloques do
        j = j + 1
        partes[#partes + 1] = aTexto(bloques[j])
      end
      for _, nuevo in ipairs(convertir(table.concat(partes, '\n'), tag)) do
        salida:insert(nuevo)
      end
      i = j + 1
    else
      salida:insert(b)
      i = i + 1
    end
  end
  -- Los titulos de nivel 4 y 5 son "run-in" (el texto sigue en la misma linea).
  -- Si lo que sigue es una tabla, LaTeX imprime la cabecera de la tabla antes
  -- que el titulo. Cerrar el parrafo del titulo evita el cruce.
  if FORMAT:match('latex') then
    local conCierre = pandoc.List()
    for k, b in ipairs(salida) do
      conCierre:insert(b)
      local siguiente = salida[k + 1]
      if b.t == 'Header' and b.level >= 4 and siguiente and siguiente.t == 'Table' then
        conCierre:insert(pandoc.RawBlock('latex', '\\leavevmode\\par'))
      end
    end
    salida = conCierre
  end
  doc.blocks = salida
  return doc
end
