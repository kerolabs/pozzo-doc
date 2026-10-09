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
--
--   <!-- pdf:desde av2 -->  ... <!-- pdf:desde-fin -->
--        Se ve siempre en GitHub, pero entra al PDF solo desde esa entrega.
--        Sirve para las secciones de la plantilla que todavia no tocan, como
--        las entrevistas de validacion antes de la AV2. scripts/build.ps1 pasa
--        la entrega en el metadato "entrega"; sin el, no se descarta nada.

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

-- Un identificador largo (RegisterContributionCommand, /api/v1/periods/{id})
-- no tiene guiones ni espacios donde LaTeX pueda cortar, y en una columna
-- estrecha se sale de la celda. Se le abren puntos de corte opcionales donde
-- una persona los pondria: entre una minuscula y una mayuscula (CamelCase) y
-- despues de una barra, un punto o un guion. Solo se tocan palabras largas
-- dentro de tablas; el resto del texto se compone como siempre.
local LARGO_MINIMO = 14

-- El corte va seguido de un espacio nulo: sin el, TeX no separa en silabas la
-- palabra que viene despues de la barra (feature/contributions) y, si no cabe
-- entera en la columna, se sale igual.
local CORTE = [[\allowbreak\hspace{0pt}]]

local function conCortes(str)
  local texto = str.text
  if utf8.len(texto) == nil or #texto < LARGO_MINIMO then return nil end
  local partes = {}
  local actual = ''
  local previo = ''
  for _, cp in utf8.codes(texto) do
    local c = utf8.char(cp)
    local mayuscula = c:match('^%u$')
    local minuscula = previo:match('^[%l%d]$')
    if mayuscula and minuscula and actual ~= '' then
      table.insert(partes, actual)
      actual = ''
    end
    actual = actual .. c
    if c == '/' or c == '.' or c == '-' then
      table.insert(partes, actual)
      actual = ''
    end
    previo = c
  end
  if actual ~= '' then table.insert(partes, actual) end
  -- Un hash de commit completo (40 caracteres) no tiene mayusculas ni barras:
  -- se parte en trozos fijos para que quepa en una columna de commits. Lo mismo
  -- con cualquier otro tramo que siga siendo mas largo que eso.
  local trozos = {}
  for _, parte in ipairs(partes) do
    if #parte > 20 then
      for i = 1, #parte, 10 do table.insert(trozos, parte:sub(i, i + 9)) end
    else
      table.insert(trozos, parte)
    end
  end
  partes = trozos
  if #partes < 2 then return nil end
  local salida = pandoc.List()
  for i, parte in ipairs(partes) do
    if i > 1 then salida:insert(pandoc.RawInline('latex', CORTE)) end
    salida:insert(pandoc.Str(parte))
  end
  return salida
end

-- El codigo en linea (`ContributionRepository.existsByCycleIdAndOperationNumber`)
-- tiene el mismo problema, y no solo en las tablas: en un parrafo se sale del
-- margen derecho. Se compone a mano como \texttt con los mismos puntos de corte,
-- mas el guion bajo, que separa palabras en los nombres de tablas y columnas.
local ESPECIALES_LATEX = {
  ['\\'] = '\\textbackslash{}', ['{'] = '\\{', ['}'] = '\\}', ['#'] = '\\#',
  ['$'] = '\\$', ['%'] = '\\%', ['&'] = '\\&', ['_'] = '\\_',
  ['^'] = '\\textasciicircum{}', ['~'] = '\\textasciitilde{}',
}

local function codigoConCortes(code)
  local texto = code.text
  if utf8.len(texto) == nil or #texto < LARGO_MINIMO then return nil end
  local salida = {}
  local previo = ''
  for _, cp in utf8.codes(texto) do
    local c = utf8.char(cp)
    if c:match('^%u$') and previo:match('^[%l%d]$') then
      table.insert(salida, '\\allowbreak{}')
    end
    table.insert(salida, ESPECIALES_LATEX[c] or c)
    if c == '/' or c == '.' or c == '_' or c == '-' then
      table.insert(salida, '\\allowbreak{}')
    end
    previo = c
  end
  return pandoc.RawInline('latex', '\\texttt{' .. table.concat(salida) .. '}')
end

function Code(code)
  if not FORMAT:match('latex') then return nil end
  return codigoConCortes(code)
end

-- APA 7 pone el numero y el titulo de la figura encima de la imagen, igual que
-- en las tablas, pero pandoc escribe el \caption despues de la imagen. Ademas el
-- espacio que deja caption (skip) va del lado de la imagen solo cuando el titulo
-- esta arriba; abajo, "Figura N" quedaba pegado al borde de la imagen. Se arma la
-- figura a mano con el titulo primero.
--
-- Debajo de la imagen puede ir la nota de APA 7: un parrafo que empieza con
-- *Nota.* y que en el Markdown se escribe justo despues de la imagen. Entra en
-- la figura para que no se separe de ella en otra pagina, alineado a la
-- izquierda y sin sangria, como lo pide APA.
-- Largo maximo, en caracteres, del parrafo que presenta una figura y que se
-- mantiene en la misma pagina que ella.
local FRASE_QUE_PRESENTA = 200

local function esNota(b)
  return b and b.t == 'Para' and #b.content > 0 and b.content[1].t == 'Emph'
    and pandoc.utils.stringify(b.content[1]) == 'Nota.'
end

local function figuraConTitulo(fig, nota, fija)
  local titulo = pandoc.utils.blocks_to_inlines(fig.caption.long)
  if #titulo == 0 then return nil end
  local etiqueta = fig.identifier ~= '' and ('\\label{' .. fig.identifier .. '}') or ''
  local caption = pandoc.List({ pandoc.RawInline('latex', '\\caption{') })
  caption:extend(titulo)
  caption:insert(pandoc.RawInline('latex', '}' .. etiqueta))
  local abrir = fija and '\\begin{figure}[H]\n\\centering' or '\\begin{figure}\n\\centering'
  local salida = pandoc.List({ pandoc.RawBlock('latex', abrir) })
  salida:insert(pandoc.Plain(caption))
  -- Tras el titulo la imagen abre un parrafo nuevo, que toma la sangria de 0.5 in
  -- del texto y empuja la imagen fuera del margen derecho.
  for _, bloque in ipairs(fig.content) do
    if bloque.t == 'Plain' or bloque.t == 'Para' then
      -- Con un ancho fijo ({width=85%}) pandoc limita el alto a \textheight y no
      -- usa \pandocbounded, que es el que deja sitio al titulo y a la nota; una
      -- imagen alta se salia de la pagina. Se envuelve igual que las demas.
      local contenido = pandoc.List()
      for _, el in ipairs(bloque.content) do
        if el.t == 'Image' and el.attributes.width then
          contenido:insert(pandoc.RawInline('latex', '\\pandocbounded{'))
          contenido:insert(el)
          contenido:insert(pandoc.RawInline('latex', '}'))
        else
          contenido:insert(el)
        end
      end
      bloque.content = contenido
      bloque.content:insert(1, pandoc.RawInline('latex', '\\noindent'))
    end
  end
  salida:extend(fig.content)
  if nota then
    local texto = pandoc.List({ pandoc.RawInline('latex', '\\par\\vspace{6pt}\\raggedright\\noindent ') })
    texto:extend(nota.content)
    salida:insert(pandoc.Plain(texto))
  end
  salida:insert(pandoc.RawBlock('latex', '\\end{figure}'))
  return salida
end

-- En una User Story, todos los escenarios de Acceptance Criteria van en una sola
-- celda, que puede ocupar media pagina. Una fila de tabla no se parte entre
-- paginas, asi que si esa celda no entraba la tabla dejaba su cabecera en una
-- hoja y los criterios en la siguiente, con media pagina en blanco entre ambas.
-- En el PDF cada escenario pasa a ser una fila propia, con la etiqueta
-- abarcandolas a todas, y la tabla puede cortarse entre un escenario y otro.
local function escenariosEnFilas(tbl)
  for _, cuerpo in ipairs(tbl.bodies) do
    local filas = pandoc.List()
    for _, fila in ipairs(cuerpo.body) do
      local celdas = fila.cells
      local partes = nil
      if #celdas == 2 and pandoc.utils.stringify(celdas[1].contents) == 'Acceptance Criteria'
          and #celdas[2].contents == 1 and celdas[2].contents[1].content then
        partes = pandoc.List()
        local actual = pandoc.List()
        for _, el in ipairs(celdas[2].contents[1].content) do
          if el.t == 'Strong' and pandoc.utils.stringify(el):match('^Escenario') and #actual > 0 then
            while #actual > 0 and actual[#actual].t == 'LineBreak' do actual:remove(#actual) end
            partes:insert(actual)
            actual = pandoc.List()
          end
          actual:insert(el)
        end
        partes:insert(actual)
      end
      if partes and #partes > 1 then
        local etiqueta = celdas[1]
        etiqueta.row_span = #partes
        for k, inlines in ipairs(partes) do
          local contenido = pandoc.Cell({ pandoc.Plain(inlines) }, celdas[2].alignment, 1, celdas[2].col_span)
          if k == 1 then
            filas:insert(pandoc.Row({ etiqueta, contenido }, fila.attr))
          else
            filas:insert(pandoc.Row({ contenido }, fila.attr))
          end
        end
      else
        filas:insert(fila)
      end
    end
    cuerpo.body = filas
  end
  return tbl
end

function Table(tbl)
  if not FORMAT:match('latex') then return nil end
  tbl = escenariosEnFilas(tbl)
  return pandoc.walk_block(tbl, {
    Str = conCortes,
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

-- Un parrafo que es solo una etiqueta en negrita (**Tacticas:**, **Hallazgos**)
-- hace de titulo de la lista o del bloque que le sigue, pero para LaTeX es un
-- parrafo mas: sin espacio arriba queda pegado al texto anterior, y la lista de
-- abajo si trae su propio espacio, asi que la etiqueta parece colgar del
-- parrafo equivocado. Se le da el mismo respiro que tiene una lista y se
-- prohibe el salto de pagina entre la etiqueta y lo que rotula.
local function esEtiqueta(b)
  return b.t == 'Para' and #b.content == 1 and b.content[1].t == 'Strong'
end

function Blocks(bloques)
  if not FORMAT:match('latex') then return nil end
  local salida = pandoc.List()
  local notaUsada = nil
  for i, b in ipairs(bloques) do
    if b == notaUsada then goto siguiente end
    if b.t == 'Figure' then
      local nota = esNota(bloques[i + 1]) and bloques[i + 1] or nil
      local previo = bloques[i - 1]
      local presentada = previo and previo.t == 'Para'
        and utf8.len(pandoc.utils.stringify(previo)) <= FRASE_QUE_PRESENTA
      local figura = figuraConTitulo(b, nota, presentada)
      if figura then
        if presentada then
          -- La frase corta que presenta la figura ("La Figura 20 muestra...")
          -- viaja con ella: se mide la imagen y, si la frase, el titulo, la
          -- imagen y la nota no caben en lo que queda, todo pasa a la pagina
          -- siguiente. Si no, la frase quedaba sola al pie y la figura arriba
          -- de la otra hoja.
          local imagen = pandoc.write(pandoc.Pandoc({ b.content[1] }), 'latex')
          local lineasNota = nota and (math.ceil(utf8.len(pandoc.utils.stringify(nota)) / 88) + 1) or 0
          local donde = #salida
          while donde > 1 and salida[donde] ~= previo do donde = donde - 1 end
          -- Un titulo en linea (#### y #####) se imprime recien cuando empieza
          -- el parrafo siguiente; medir entre los dos abriria un parrafo dentro
          -- de la caja de medida y el titulo se perderia en ella. La medida va
          -- antes del titulo, que asi tambien viaja con la figura.
          while salida[donde - 1] and salida[donde - 1].t == 'Header' and salida[donde - 1].level >= 4 do
            donde = donde - 1
          end
          salida:insert(donde, pandoc.RawBlock('latex', string.format(
            '\\begingroup\\setbox0=\\vbox{\\hsize=\\linewidth %s}' ..
            '\\Needspace*{\\dimexpr\\ht0+\\dp0+%d\\baselineskip\\relax}\\endgroup',
            imagen, 6 + lineasNota)))
        end
        salida:extend(figura)
        notaUsada = nota
        goto siguiente
      end
    end
    if b.t == 'Header' and bloques[i + 1] and bloques[i + 1].t == 'Table' then
      salida:insert(pandoc.RawBlock(
        'latex', '\\reservarAntesDeTabla{' .. RESERVA_ANTES_DE_TABLA .. '}'))
    end
    if esEtiqueta(b) then
      local previo = bloques[i - 1]
      if previo and previo.t ~= 'Header' then
        salida:insert(pandoc.RawBlock('latex', '\\addvspace{\\topsep}'))
      end
      salida:insert(b)
      salida:insert(pandoc.RawBlock('latex', '\\nopagebreak'))
    else
      salida:insert(b)
    end
    ::siguiente::
  end
  return salida
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
