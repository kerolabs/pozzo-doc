-- Ajusta el documento para Word (scripts/build.ps1 -Word). Hace en el .docx lo
-- que en el PDF hacen apa7.tex, cover.tex y pdf-only.lua; los estilos (fuente,
-- interlineado, sangrias, margenes, numero de pagina) vienen de
-- config/reference.docx, que genera scripts/reference-docx.py.
--
--   - Antepone la caratula, en una seccion propia sin numero de pagina.
--   - Cambia \tableofcontents por un indice de Word y \newpage por un salto.
--   - Numera tablas y figuras en el orden en que aparecen y les pone el rotulo
--     APA arriba: "Tabla N" en negrita y el titulo en cursiva debajo.
--   - Limita el tamano de cada figura para que entre en la pagina con su rotulo.
--   - Pone en linea los encabezados de cuarto y quinto nivel (#### y #####),
--     seguidos de punto, como pide APA.
--   - Da a las notas (*Nota.*) un parrafo sin sangria.
--
-- Va despues de --citeproc y de bib-categories.lua.

if not FORMAT:match('docx') then return {} end

-- Caratula. Los mismos datos que config/cover.tex.
local CARATULA = {
  logo = 'docs/images/upc_logo.png',
  logoAncho = '0.8731in',
  lineas = {
    { 'Universidad Peruana de Ciencias Aplicadas', 12 },
    { 'Carrera de Ingeniería de Software', 12 },
    { '' },
    { '1ACC0238', 14, true },
    { 'Aplicaciones para Dispositivos Móviles', 14, true },
    { '' },
    { 'NRC', 12 },
    { '13980', 14, true },
    { '' },
    { 'Informe del Trabajo Final', 16, true },
    { '' },
    { 'Docente', 12 },
    { 'Mayta Guillermo, Jorge Luis', 14, true },
    { '' },
    { 'Equipo', 12 },
    { 'Kerolabs', 14, true },
    { '' },
    { 'Proyecto', 12 },
    { 'Pozzo', 14, true },
    { '' },
    { 'Integrantes', 12, true },
    { '' },
  },
  integrantes = {
    { 'Camargo Briceño, Joseph Julius', 'u20241d992' },
    { 'Flores Pinchi, José Fernando', 'u20241a290' },
    { 'Sanchez Benavente, Leonardo Matias', 'u20241b184' },
    { 'Solís Campos, Estefano Sebastián', 'u202314354' },
    { 'Tirado Carrera, Gabriela Luciana', 'u202419592' },
  },
  cierre = {
    { '' },
    { 'Período 202620', 12, true },
    { 'Octubre 2026', 12, true },
  },
}

-- Area de texto en pulgadas: carta con margenes de 1 in.
local ANCHO_TEXTO = 6.5
-- Alto maximo de una figura. Deja sitio en la pagina para "Figura N", el titulo
-- y una nota corta debajo.
local ALTO_MAXIMO = 7.0

local function xml(texto)
  return (texto:gsub('&', '&amp;'):gsub('<', '&lt;'):gsub('>', '&gt;'))
end

local function raw(texto)
  return pandoc.RawBlock('openxml', texto)
end

local function lineaDeCaratula(texto, tamano, negrita)
  if texto == '' then
    return raw('<w:p><w:pPr><w:pStyle w:val="Cover"/></w:pPr></w:p>')
  end
  local rpr = string.format('<w:sz w:val="%d"/><w:szCs w:val="%d"/>', tamano * 2, tamano * 2)
  if negrita then rpr = '<w:b/><w:bCs/>' .. rpr end
  return raw(string.format(
    '<w:p><w:pPr><w:pStyle w:val="Cover"/></w:pPr><w:r><w:rPr>%s</w:rPr><w:t xml:space="preserve">%s</w:t></w:r></w:p>',
    rpr, xml(texto)))
end

-- Nombre y codigo separados por puntos, en una franja de 4 in centrada.
local function integrante(nombre, codigo)
  return raw(string.format(
    '<w:p><w:pPr><w:pStyle w:val="Cover"/>' ..
    '<w:tabs><w:tab w:val="right" w:leader="dot" w:pos="7920"/></w:tabs>' ..
    '<w:spacing w:after="80"/><w:ind w:left="1800"/><w:jc w:val="left"/></w:pPr>' ..
    '<w:r><w:rPr><w:sz w:val="22"/><w:szCs w:val="22"/></w:rPr><w:t xml:space="preserve">%s</w:t></w:r>' ..
    '<w:r><w:rPr><w:sz w:val="22"/><w:szCs w:val="22"/></w:rPr><w:tab/><w:t>%s</w:t></w:r></w:p>',
    xml(nombre), xml(codigo)))
end

-- Cierra la seccion de la caratula. Sin headerReference, Word no le pone
-- encabezado; la seccion siguiente trae el suyo desde reference.docx y empieza
-- a contar desde 1, como el PDF.
local FIN_DE_CARATULA = raw(
  '<w:p><w:pPr><w:sectPr>' ..
  '<w:pgSz w:w="12240" w:h="15840"/>' ..
  '<w:pgMar w:top="1440" w:right="1440" w:bottom="1440" w:left="1440" w:header="720" w:footer="720" w:gutter="0"/>' ..
  '<w:cols w:space="720"/>' ..
  '</w:sectPr></w:pPr></w:p>')

local function caratula()
  local bloques = pandoc.List()
  local logo = pandoc.Image({}, CARATULA.logo, '', { width = CARATULA.logoAncho })
  bloques:insert(pandoc.Div({ pandoc.Para({ logo }) }, { ['custom-style'] = 'Cover' }))
  bloques:insert(lineaDeCaratula('', 12))
  for _, l in ipairs(CARATULA.lineas) do bloques:insert(lineaDeCaratula(l[1], l[2], l[3])) end
  for _, i in ipairs(CARATULA.integrantes) do bloques:insert(integrante(i[1], i[2])) end
  for _, l in ipairs(CARATULA.cierre) do bloques:insert(lineaDeCaratula(l[1], l[2], l[3])) end
  bloques:insert(FIN_DE_CARATULA)
  return bloques
end

-- Indice de Word. Se llena al actualizar los campos: el build lo hace con Word
-- antes de exportar el PDF.
local INDICE = {
  raw('<w:p><w:pPr><w:pStyle w:val="TOCHeading"/></w:pPr><w:r><w:t>Contenido</w:t></w:r></w:p>'),
  raw('<w:p>' ..
      '<w:r><w:fldChar w:fldCharType="begin" w:dirty="true"/></w:r>' ..
      '<w:r><w:instrText xml:space="preserve"> TOC \\o "1-3" \\h \\z \\u </w:instrText></w:r>' ..
      '<w:r><w:fldChar w:fldCharType="separate"/></w:r>' ..
      '<w:r><w:t>Right-click and choose Update Field to build the table of contents.</w:t></w:r>' ..
      '<w:r><w:fldChar w:fldCharType="end"/></w:r>' ..
      '</w:p>'),
}

local SALTO_DE_PAGINA = raw('<w:p><w:r><w:br w:type="page"/></w:r></w:p>')

local function latexCrudo(b)
  if b.t ~= 'RawBlock' or not (b.format == 'latex' or b.format == 'tex') then return nil end
  local texto = b.text
  if texto:match('\\tableofcontents') then return INDICE end
  if texto:match('\\newpage') or texto:match('\\clearpage') then return { SALTO_DE_PAGINA } end
  return {}
end

local function esNota(b)
  return b and b.t == 'Para' and #b.content > 0 and b.content[1].t == 'Emph'
    and pandoc.utils.stringify(b.content[1]) == 'Nota.'
end

local function conEstilo(estilo, bloques)
  return pandoc.Div(bloques, { ['custom-style'] = estilo })
end

local function rotulo(nombre, numero, titulo)
  return {
    conEstilo('Caption Label', { pandoc.Para({ pandoc.Str(nombre .. ' ' .. numero) }) }),
    conEstilo('Caption Title', { pandoc.Para(titulo) }),
  }
end

-- Ancho pedido en el Markdown ({width=55%}, {width=3in}) pasado a pulgadas.
local function anchoPedido(valor)
  if not valor then return nil end
  local n, unidad = valor:match('^([%d%.]+)%s*(%%?%a*)$')
  n = tonumber(n)
  if not n then return nil end
  if unidad == '%' then return ANCHO_TEXTO * n / 100 end
  if unidad == 'in' then return n end
  if unidad == 'cm' then return n / 2.54 end
  if unidad == 'px' or unidad == '' then return n / 96 end
  return nil
end

local function leerImagen(src)
  for _, ruta in ipairs({ src, 'docs/' .. src }) do
    local ok, _, contenido = pcall(pandoc.mediabag.fetch, ruta)
    if ok and contenido then
      local ok2, medida = pcall(pandoc.image.size, contenido)
      if ok2 and medida then return medida end
    end
  end
  return nil
end

-- Fija el ancho de la imagen para que no pase del ancho de texto ni del alto
-- maximo, conservando su proporcion.
local function ajustarImagen(img)
  local medida = leerImagen(img.src)
  if not medida or medida.width == 0 then return img end
  local dpi = (medida.dpi_horz and medida.dpi_horz > 0) and medida.dpi_horz or 96
  local proporcion = medida.height / medida.width
  local ancho = anchoPedido(img.attributes.width) or (medida.width / dpi)
  ancho = math.min(ancho, ANCHO_TEXTO)
  if ancho * proporcion > ALTO_MAXIMO then ancho = ALTO_MAXIMO / proporcion end
  img.attributes.width = string.format('%.3fin', ancho)
  img.attributes.height = nil
  return img
end

-- Encabezado de cuarto o quinto nivel en linea con el parrafo siguiente. El
-- parrafo del titulo lleva la marca de parrafo oculta (el "separador de
-- estilo" de Word): Word lo dibuja en la misma linea que el parrafo que sigue,
-- y el titulo conserva su estilo y su nivel de esquema.
local function tituloEnLinea(h)
  local texto = pandoc.utils.stringify(h.content)
  if not texto:match('[%.%?!:]$') then texto = texto .. '.' end
  return raw(string.format(
    '<w:p><w:pPr><w:pStyle w:val="Heading%d"/><w:rPr><w:vanish/><w:specVanish/></w:rPr></w:pPr>' ..
    '<w:r><w:t xml:space="preserve">%s </w:t></w:r></w:p>',
    h.level, xml(texto)))
end

local tablas, figuras = 0, 0

-- Un identificador largo (AuthenticationCommandServiceImpl, /api/v1/periods)
-- no tiene espacios donde Word pueda cortar, y en una columna angosta Word lo
-- parte en cualquier letra. Un espacio de ancho cero entre una minuscula y una
-- mayuscula, y despues de una barra, un punto o un guion bajo, le da los mismos
-- puntos de corte que pdf-only.lua le da a LaTeX.
local LARGO_MINIMO = 14
local CORTE = '\u{200B}'

local function conCortes(texto)
  if utf8.len(texto) == nil or #texto < LARGO_MINIMO then return nil end
  local salida = {}
  local previo = ''
  for _, cp in utf8.codes(texto) do
    local c = utf8.char(cp)
    if c:match('^%u$') and previo:match('^[%l%d]$') then table.insert(salida, CORTE) end
    table.insert(salida, c)
    if c == '/' or c == '.' or c == '_' then table.insert(salida, CORTE) end
    previo = c
  end
  return table.concat(salida)
end

-- Las tablas en Word:
--   - cada celda va con el estilo Table Text (espacio simple, sin sangria y
--     con particion de palabras);
--   - la fila de cabecera pasa al cuerpo con el estilo Table Header (negrita,
--     unida a la fila siguiente), para que no se repita en cada pagina, igual
--     que en el PDF (REPETIR_CABECERA en table-grid.lua);
--   - las palabras largas reciben puntos de corte.
local function prepararTabla(tbl)
  -- Pandoc escribe todo Plain de una celda con el estilo Compact, sin mirar el
  -- custom-style del Div que lo envuelve; un Para si toma ese estilo.
  tbl = pandoc.walk_block(tbl, {
    Plain = function(p) return pandoc.Para(p.content) end,
    Str = function(s)
      local t = conCortes(s.text)
      if t then return pandoc.Str(t) end
    end,
    Code = function(c)
      local t = conCortes(c.text)
      if t then c.text = t; return c end
    end,
  })
  local function enEstilo(celda, cabecera)
    celda.contents = { conEstilo(cabecera and 'Table Header' or 'Table Text', celda.contents) }
  end
  local cabecera = tbl.head.rows
  for _, fila in ipairs(cabecera) do
    for _, celda in ipairs(fila.cells) do enEstilo(celda, true) end
  end
  for _, cuerpo in ipairs(tbl.bodies) do
    for _, fila in ipairs(cuerpo.body) do
      for _, celda in ipairs(fila.cells) do enEstilo(celda, false) end
    end
  end
  if #cabecera > 0 and #tbl.bodies > 0 then
    local filas = pandoc.List(cabecera)
    filas:extend(tbl.bodies[1].body)
    tbl.bodies[1].body = filas
    tbl.head.rows = {}
  end
  return tbl
end

-- Word pega el parrafo siguiente al borde inferior de la tabla. Un parrafo vacio
-- de una linea los separa, como el espacio que deja LaTeX.
local DESPUES_DE_TABLA = raw('<w:p><w:pPr><w:spacing w:before="0" w:after="0" w:line="240" w:lineRule="auto"/><w:ind w:firstLine="0"/></w:pPr></w:p>')

local procesar

local function figura(fig, nota)
  local titulo = pandoc.utils.blocks_to_inlines(fig.caption.long)
  if #titulo == 0 then return nil end
  figuras = figuras + 1
  local salida = pandoc.List(rotulo('Figura', figuras, titulo))
  local estilo = nota and 'Figure Image With Note' or 'Figure Image'
  for _, b in ipairs(fig.content) do
    if b.t == 'Plain' or b.t == 'Para' then
      local inlines = pandoc.walk_block(pandoc.Para(b.content), { Image = ajustarImagen }).content
      salida:insert(conEstilo(estilo, { pandoc.Para(inlines) }))
    else
      salida:insert(b)
    end
  end
  if nota then salida:insert(conEstilo('Note', { nota })) end
  return salida
end

local function tabla(tbl)
  tbl = prepararTabla(tbl)
  local salida = pandoc.List()
  local titulo = pandoc.utils.blocks_to_inlines(tbl.caption.long)
  if #titulo > 0 then
    tablas = tablas + 1
    tbl.caption = { long = {} }
    salida:extend(rotulo('Tabla', tablas, titulo))
  end
  salida:insert(tbl)
  salida:insert(DESPUES_DE_TABLA)
  return salida
end

-- Recorre los bloques en el orden del documento, entrando en los Div, para que
-- la numeracion de tablas y figuras coincida con la del PDF.
procesar = function(bloques)
  local salida = pandoc.List()
  local saltar = nil
  for i, b in ipairs(bloques) do
    local siguiente = bloques[i + 1]
    if b == saltar then
      saltar = nil
    elseif latexCrudo(b) then
      salida:extend(latexCrudo(b))
    elseif b.t == 'Div' then
      b.content = procesar(b.content)
      salida:insert(b)
    elseif b.t == 'Figure' then
      local nota = esNota(siguiente) and siguiente or nil
      local hecha = figura(b, nota)
      if hecha then
        salida:extend(hecha)
        saltar = nota
      else
        salida:insert(b)
      end
    elseif b.t == 'Table' then
      salida:extend(tabla(b))
    elseif b.t == 'Header' and b.level >= 4 and b.level <= 5 then
      if siguiente and siguiente.t == 'Para' and not esNota(siguiente) then
        salida:insert(tituloEnLinea(b))
      else
        local texto = pandoc.utils.stringify(b.content)
        if not texto:match('[%.%?!:]$') then b.content:insert(pandoc.Str('.')) end
        salida:insert(b)
      end
    elseif esNota(b) then
      salida:insert(conEstilo('Note', { b }))
    else
      salida:insert(b)
    end
  end
  return salida
end

function Pandoc(doc)
  -- Word solo parte palabras si el idioma lleva region: con "es" a secas no
  -- encuentra el diccionario de particion. Las citas ya se resolvieron, asi que
  -- cambiarlo aqui no afecta a citeproc.
  doc.meta.lang = 'es-PE'
  local bloques = caratula()
  bloques:extend(procesar(doc.blocks))
  doc.blocks = bloques
  return doc
end
