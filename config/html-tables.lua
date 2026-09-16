-- Convierte las tablas escritas en HTML (<table>) en tablas nativas de pandoc,
-- para que lleguen al PDF con sus colspan y rowspan.
--
-- Pandoc lee el Markdown y deja cada etiqueta HTML como un bloque crudo, con el
-- texto de las celdas suelto entre etiqueta y etiqueta. Al escribir LaTeX, los
-- bloques crudos se descartan y solo queda el texto, sin ninguna tabla. Este
-- filtro junta esos pedazos, los vuelve a leer como HTML (el lector de HTML si
-- entiende tablas, colspan, rowspan, <col width> y align) y devuelve la tabla
-- resultante en lugar de los bloques sueltos.
--
-- Debe correr antes que pdf-only.lua, para que el resto de ajustes de tabla
-- (imagenes alineadas arriba, \needspace tras un encabezado) se apliquen
-- tambien a estas tablas.

-- Elementos que no sobreviven el viaje Markdown -> HTML -> Markdown: las citas
-- ([@clave]) se convierten en texto y citeproc ya no las reconoce; las imagenes
-- pierden el ancho; el LaTeX crudo desaparece. Se sacan antes del viaje y se
-- vuelven a poner despues, marcando su sitio con un token.
local TOKEN = 'PHX%dXPH'
local PATRON = '^(.-)PHX(%d+)XPH(.*)$'

local function proteger(bloque, guardados)
  local function guardar(el)
    table.insert(guardados, el)
    return pandoc.Str(string.format(TOKEN, #guardados))
  end
  return pandoc.walk_block(bloque, {
    Cite = guardar,
    Image = guardar,
    Math = guardar,
    Note = guardar,
    RawInline = function(el)
      if el.format ~= 'html' then return guardar(el) end
    end,
  })
end

local function restaurar(tabla, guardados)
  return pandoc.walk_block(tabla, {
    Str = function(s)
      local antes, n, despues = s.text:match(PATRON)
      if not n then return nil end
      local salida = pandoc.List()
      if antes ~= '' then salida:insert(pandoc.Str(antes)) end
      salida:insert(guardados[tonumber(n)])
      if despues ~= '' then
        -- Puede haber otro token en el resto; se resuelve en la misma vuelta.
        local resto = restaurar(pandoc.Plain({ pandoc.Str(despues) }), guardados)
        salida:extend(resto.content)
      end
      return salida
    end,
  })
end

-- Sin <col width="..."> el lector de HTML deja las columnas sin ancho, y en
-- LaTeX eso significa "tan anchas como su contenido": una celda con un parrafo
-- se sale de la pagina. Se reparte el ancho de la pagina en proporcion al
-- contenido de cada columna, como hace pandoc con las tablas de tuberias.
-- Una linea de texto en la pagina admite unos 80 caracteres. Sirve para pasar
-- de "caracteres" a "fraccion del ancho" al fijar el minimo de cada columna.
local CARACTERES_POR_LINEA = 80

local function medir(celda)
  local texto = pandoc.utils.stringify(celda.contents)
  local palabra = 0
  for w in texto:gmatch('%S+') do
    palabra = math.max(palabra, utf8.len(w) or #w)
  end
  return utf8.len(texto) or #texto, palabra
end

local function filasDe(tabla)
  local filas = pandoc.List()
  filas:extend(tabla.head.rows)
  for _, cuerpo in ipairs(tabla.bodies) do
    filas:extend(cuerpo.head)
    filas:extend(cuerpo.body)
  end
  filas:extend(tabla.foot.rows)
  return filas
end

-- El lector de HTML tambien inventa anchos iguales cuando alguna celda tiene
-- <br> o varios parrafos, asi que no sirve mirar los colspecs para saber si
-- el autor fijo anchos: hay que mirar el HTML original.
local function autorFijoAnchos(html)
  return html:match('<[Cc][Oo][Ll][%s>]') ~= nil
      or html:match('<[Tt][DdHh][^>]-[Ww][Ii][Dd][Tt][Hh]%s*=') ~= nil
end

local function repartirAnchos(tabla, html)
  if autorFijoAnchos(html) then return tabla end

  local ncol = #tabla.colspecs
  local largo, palabra = {}, {}
  for c = 1, ncol do largo[c], palabra[c] = 0, 0 end

  -- Un rowspan ocupa sitio en las filas siguientes; hay que saltarlo al
  -- ubicar cada celda en su columna.
  local ocupada = {}
  for r, fila in ipairs(filasDe(tabla)) do
    ocupada[r] = ocupada[r] or {}
    local c = 1
    for _, celda in ipairs(fila.cells) do
      while ocupada[r][c] do c = c + 1 end
      local total, masLarga = medir(celda)
      local porColumna = total / celda.col_span
      for k = c, c + celda.col_span - 1 do
        largo[k] = math.max(largo[k], porColumna)
        if celda.col_span == 1 then
          palabra[k] = math.max(palabra[k], masLarga)
        end
        for j = r, r + celda.row_span - 1 do
          ocupada[j] = ocupada[j] or {}
          ocupada[j][k] = true
        end
      end
      c = c + celda.col_span
    end
  end

  local total = 0
  for c = 1, ncol do total = total + largo[c] end
  if total == 0 then return tabla end

  -- Cada columna recibe ancho en proporcion a su contenido, pero nunca menos
  -- de lo que ocupa su palabra mas larga: si no, LaTeX la parte con guiones o
  -- la deja salir por el borde de la celda.
  local anchos, suma = {}, 0
  for c = 1, ncol do
    local minimo = (palabra[c] + 2) / CARACTERES_POR_LINEA
    anchos[c] = math.max(largo[c] / total, minimo)
    suma = suma + anchos[c]
  end

  local specs = pandoc.List()
  for c = 1, ncol do
    specs:insert({ tabla.colspecs[c][1], anchos[c] / suma })
  end
  tabla.colspecs = specs
  return tabla
end

local function esHtml(b)
  return b.t == 'RawBlock' and b.format == 'html'
end

local function abreTabla(b)
  return esHtml(b) and b.text:match('^%s*<[Tt][Aa][Bb][Ll][Ee][%s>]') ~= nil
end

local function cierraTabla(b)
  return esHtml(b) and b.text:match('</[Tt][Aa][Bb][Ll][Ee]>%s*$') ~= nil
end

local function convertir(bloques)
  local guardados = {}
  local partes = {}
  for _, b in ipairs(bloques) do
    if esHtml(b) then
      table.insert(partes, b.text)
    else
      table.insert(partes, pandoc.write(pandoc.Pandoc({ proteger(b, guardados) }), 'html'))
    end
  end

  local html = table.concat(partes, '\n')
  for _, b in ipairs(pandoc.read(html, 'html').blocks) do
    if b.t == 'Table' then
      return repartirAnchos(restaurar(b, guardados), html)
    end
  end
  return nil
end

function Blocks(bloques)
  local salida = pandoc.List()
  local i = 1
  while i <= #bloques do
    local b = bloques[i]
    if abreTabla(b) then
      local j = i
      while j <= #bloques and not cierraTabla(bloques[j]) do j = j + 1 end
      if j <= #bloques then
        local tabla = convertir({ table.unpack(bloques, i, j) })
        if tabla then
          salida:insert(tabla)
          i = j + 1
          goto continue
        end
      end
    end
    salida:insert(b)
    i = i + 1
    ::continue::
  end
  return salida
end
