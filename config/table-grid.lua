-- Dibuja todas las lineas de las tablas del PDF: borde exterior, una linea
-- entre cada fila y una entre cada columna.
--
-- Pandoc escribe las tablas al estilo booktabs: tres lineas horizontales y
-- ninguna vertical. Eso se decide dentro del escritor de LaTeX y no hay opcion
-- para cambiarlo, asi que este filtro escribe cada tabla a LaTeX por su cuenta,
-- retoca ese texto y lo devuelve como bloque crudo:
--
--   - la especificacion de columnas recibe un | entre columna y columna;
--   - cada \multicolumn recibe sus propias barras, porque anula las de las
--     columnas que abarca;
--   - \toprule pasa a \hline y \midrule y \bottomrule desaparecen, porque cada
--     fila ya cierra con su propia linea;
--   - tras cada fila va un \hline, salvo cuando una celda con rowspan sigue
--     hacia abajo: ahi se dibujan tramos (\cline) que la rodean sin cruzarla.
--
-- Como la tabla deja de ser una tabla para pandoc, este filtro tiene que ir
-- despues de --citeproc en la linea de comandos (las citas de las celdas ya
-- estan resueltas) y despues de pdf-only.lua (sus ajustes de tabla ya estan
-- aplicados). Por la misma razon pandoc no carga longtable ni multirow por su
-- cuenta: los carga apa7.tex.

-- Si la tabla ocupa varias paginas, repetir o no la fila de cabecera en cada una.
-- El equipo prefiere que la cabecera aparezca una sola vez, como en Word.
REPETIR_CABECERA = false

-- Devuelve la posicion del } que cierra el { situado en s[i].
local function cierreDeGrupo(s, i)
  local nivel = 0
  local j = i
  while j <= #s do
    local ch = s:sub(j, j)
    if ch == '\\' then
      j = j + 1
    elseif ch == '{' then
      nivel = nivel + 1
    elseif ch == '}' then
      nivel = nivel - 1
      if nivel == 0 then return j end
    end
    j = j + 1
  end
  return nil
end

-- Parte una especificacion de columnas ("@{}ll@{}", ">{...}p{...} >{...}p{...}")
-- en una lista con la especificacion de cada columna, sin los @{} de pandoc.
local function columnasDe(spec)
  local columnas = {}
  local prefijo = ''
  local i = 1
  while i <= #spec do
    local ch = spec:sub(i, i)
    if ch == '@' or ch == '!' then
      local fin = cierreDeGrupo(spec, i + 1)
      i = fin + 1
    elseif ch == '>' or ch == '<' then
      local fin = cierreDeGrupo(spec, i + 1)
      prefijo = prefijo .. spec:sub(i, fin)
      i = fin + 1
    elseif ch:match('[lcr]') then
      table.insert(columnas, prefijo .. ch)
      prefijo = ''
      i = i + 1
    elseif ch:match('[pmb]') then
      local fin = cierreDeGrupo(spec, i + 1)
      table.insert(columnas, prefijo .. spec:sub(i, fin))
      prefijo = ''
      i = fin + 1
    else
      i = i + 1 -- espacios, saltos de linea y barras que ya hubiera
    end
  end
  return columnas
end

local function conBarras(spec)
  return '|' .. table.concat(columnasDe(spec), '|') .. '|'
end

-- Un \multicolumn sustituye la especificacion de las columnas que abarca. La
-- barra izquierda pertenece a la columna anterior y se conserva; solo la primera
-- columna de la tabla, que pandoc marca con @{} al inicio, necesita ponerla.
local function multicolumnConBarras(spec)
  local primera = spec:match('^%s*@{}') ~= nil
  local columnas = columnasDe(spec)
  return (primera and '|' or '') .. table.concat(columnas, '|') .. '|'
end

-- Para cada fila, en el orden en que pandoc las escribe, que linea va debajo:
-- '\hline' si ninguna celda sigue hacia la fila siguiente, o los \cline que
-- rodean a las que si siguen.
local function lineasBajoFilas(tbl)
  local filas = pandoc.List()
  filas:extend(tbl.head.rows)
  for _, cuerpo in ipairs(tbl.bodies) do
    filas:extend(cuerpo.head)
    filas:extend(cuerpo.body)
  end
  filas:extend(tbl.foot.rows)

  local ncol = #tbl.colspecs
  local ocupada = {}   -- ocupada[r][c]: la celda de esa posicion viene de arriba
  local continua = {}  -- continua[r][c]: la celda de esa posicion sigue abajo
  for r = 1, #filas do ocupada[r], continua[r] = {}, {} end

  for r, fila in ipairs(filas) do
    local c = 1
    for _, celda in ipairs(fila.cells) do
      while ocupada[r][c] do c = c + 1 end
      for k = c, c + celda.col_span - 1 do
        for j = r, r + celda.row_span - 1 do
          if ocupada[j] then
            ocupada[j][k] = true
            if j < r + celda.row_span - 1 then continua[j][k] = true end
          end
        end
      end
      c = c + celda.col_span
    end
  end

  local lineas = {}
  for r = 1, #filas do
    local tramos = {}
    local inicio = nil
    for c = 1, ncol + 1 do
      local corta = c <= ncol and not continua[r][c]
      if corta and not inicio then inicio = c end
      if not corta and inicio then
        table.insert(tramos, string.format('\\cline{%d-%d}', inicio, c - 1))
        inicio = nil
      end
    end
    if #tramos == 1 and tramos[1] == string.format('\\cline{1-%d}', ncol) then
      lineas[r] = '\\hline'
    else
      lineas[r] = table.concat(tramos, ' ')
    end
  end

  -- Dentro de longtable, \hline son dos reglas superpuestas con un punto de
  -- corte de pagina entre ellas: si la pagina se corta ahi, una regla cierra la
  -- pagina y la otra abre la siguiente. Eso es lo que queremos entre filas,
  -- pero no en el borde inferior de la tabla, donde TeX prefiere ese corte
  -- (tiene penalizacion negativa) al que hay despues de la tabla y deja una
  -- regla suelta al inicio de la pagina siguiente. La ultima linea es una
  -- regla simple, sin punto de corte.
  if lineas[#filas] == '\\hline' then
    lineas[#filas] = '\\noalign{\\hrule height\\arrayrulewidth}'
  end
  return lineas
end

-- Inserta la linea que corresponde despues de cada \\ que cierra una fila. Los
-- \\ dentro de una celda (saltos de linea, minipage, multicolumn) quedan dentro
-- de llaves o de un entorno y se distinguen por eso.
local function insertarLineas(cuerpo, lineas)
  local salida = {}
  local llaves, entornos, fila = 0, 0, 0
  local i = 1
  while i <= #cuerpo do
    local ch = cuerpo:sub(i, i)
    if ch == '\\' then
      local sig = cuerpo:sub(i + 1, i + 1)
      if sig == '\\' and llaves == 0 and entornos == 0 then
        fila = fila + 1
        table.insert(salida, '\\\\ ' .. (lineas[fila] or '\\hline'))
        i = i + 2
      else
        if cuerpo:sub(i, i + 6) == '\\begin{' then entornos = entornos + 1 end
        if cuerpo:sub(i, i + 4) == '\\end{' then entornos = entornos - 1 end
        table.insert(salida, ch .. sig)
        i = i + 2
      end
    elseif ch == '%' then
      local fin = cuerpo:find('\n', i, true) or #cuerpo
      table.insert(salida, cuerpo:sub(i, fin))
      i = fin + 1
    else
      if ch == '{' then llaves = llaves + 1 end
      if ch == '}' then llaves = llaves - 1 end
      table.insert(salida, ch)
      i = i + 1
    end
  end
  return table.concat(salida)
end

local function reemplazar(s, texto, nuevo)
  local i, j = s:find(texto, 1, true)
  while i do
    s = s:sub(1, i - 1) .. nuevo .. s:sub(j + 1)
    i, j = s:find(texto, i + #nuevo, true)
  end
  return s
end

local function cuadricular(latex, tbl)
  local ini = latex:find('\\begin{longtable}', 1, true)
  local fin = latex:find('\\end{longtable}', 1, true)
  if not ini or not fin then return latex end

  -- Especificacion de columnas: el ultimo grupo de la linea \begin{longtable}[]{...}
  local abre = latex:find('{', ini + #'\\begin{longtable}[]', true)
  local cierra = cierreDeGrupo(latex, abre)
  local spec = latex:sub(abre + 1, cierra - 1)
  local cabeza = latex:sub(1, abre) .. conBarras(spec) .. '}'
  local cuerpo = latex:sub(cierra + 1, fin - 1)
  local cola = latex:sub(fin)

  -- \multicolumn{n}{spec}{...}
  local pos = 1
  while true do
    local m = cuerpo:find('\\multicolumn{', pos, true)
    if not m then break end
    local finN = cierreDeGrupo(cuerpo, m + #'\\multicolumn')
    local abreSpec = finN + 1
    local finSpec = cierreDeGrupo(cuerpo, abreSpec)
    local n = tonumber(cuerpo:sub(m + #'\\multicolumn' + 1, finN - 1)) or 1
    local nuevo = multicolumnConBarras(cuerpo:sub(abreSpec + 1, finSpec - 1))
    -- El ancho de una celda combinada suma los de sus columnas mas los
    -- rellenos intermedios; con barras, tambien las barras intermedias.
    nuevo = nuevo:gsub('%+ (%d+)\\tabcolsep',
      '+ %1\\tabcolsep + ' .. (n - 1) .. '\\arrayrulewidth')
    cuerpo = cuerpo:sub(1, abreSpec) .. nuevo .. cuerpo:sub(finSpec)
    pos = abreSpec + #nuevo + 1
  end

  -- Pandoc calcula los anchos descontando 2(n-1) rellenos, porque sus tablas
  -- empiezan y terminan con @{}, que suprime el relleno exterior. Al cambiar
  -- los @{} por barras ese relleno vuelve, y las barras verticales tambien
  -- ocupan sitio: hay que descontar 2n rellenos y n+1 barras, o la tabla se
  -- sale del margen derecho por dos \tabcolsep (unos 12 pt).
  local ncol = #tbl.colspecs
  local descuento = '(\\linewidth - ' .. (2 * ncol) .. '\\tabcolsep - ' .. (ncol + 1) .. '\\arrayrulewidth)'
  cabeza = cabeza:gsub('%(\\linewidth %- (%d+)\\tabcolsep%)', descuento)
  cuerpo = cuerpo:gsub('%(\\linewidth %- (%d+)\\tabcolsep%)', descuento)

  cuerpo = reemplazar(cuerpo, '\\toprule\\noalign{}', '\\hline')
  cuerpo = reemplazar(cuerpo, '\\midrule\\noalign{}', '\\noalign{}')
  cuerpo = reemplazar(cuerpo, '\\bottomrule\\noalign{}', '\\noalign{}')
  cuerpo = insertarLineas(cuerpo, lineasBajoFilas(tbl))

  -- Pandoc cierra la cabecera con \endhead, que la repite en cada pagina que
  -- ocupe la tabla. Pasarla a \endfirsthead la imprime solo al principio y deja
  -- vacia la cabecera de las paginas siguientes. La linea superior de esas
  -- paginas no hace falta: la pone la mitad del \hline en que se corto la
  -- pagina (ver lineasBajoFilas).
  if not REPETIR_CABECERA then
    cuerpo = reemplazar(cuerpo, '\\endhead', '\\endfirsthead\n\\endhead')
  end

  return cabeza .. cuerpo .. cola
end

-- Al generar el PDF, pandoc busca las imagenes del documento con --resource-path
-- y las copia a la carpeta temporal donde corre XeLaTeX. Solo busca las que ve
-- en el documento, y las de estas tablas ya no estan en el (van dentro del
-- LaTeX crudo), asi que se registran a mano para que las copie igual.
local function registrarImagenes(tbl)
  return pandoc.walk_block(tbl, {
    Image = function(img)
      local mime, contenido = pandoc.mediabag.fetch(img.src)
      if contenido then
        pandoc.mediabag.insert(img.src, mime, contenido)
      end
    end,
  })
end

function Table(tbl)
  if not FORMAT:match('latex') then return nil end
  registrarImagenes(tbl)
  local latex = pandoc.write(pandoc.Pandoc({ tbl }), 'latex')
  return pandoc.RawBlock('latex', cuadricular(latex, tbl))
end
