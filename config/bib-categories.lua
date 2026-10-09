-- Reparte la bibliografia en las tres categorias que pide el enunciado: dominio
-- de negocio; metodos, tecnicas y enfoques de ingenieria de software; y
-- lenguajes, frameworks y herramientas.
--
-- Cada entrada de references.bib declara su categoria en el campo keywords. El
-- filtro corre despues de citeproc: toma la lista que este genero, ya ordenada en
-- APA 7, y la parte en una lista por categoria, cada una con su titulo. Una
-- referencia sin categoria detiene la compilacion, para que no se pierda.

local CATEGORIES = {
  { key = 'dominio', title = 'Dominio de negocio' },
  { key = 'metodos', title = 'Métodos, técnicas y enfoques de ingeniería de software' },
  { key = 'herramientas', title = 'Lenguajes, frameworks y herramientas' },
}

local BIBLIOGRAPHY = 'references.bib'

local function category_of_each_reference()
  local file = assert(io.open(BIBLIOGRAPHY, 'r'))
  local text = file:read('a')
  file:close()
  local categories = {}
  for _, reference in ipairs(pandoc.read(text, 'bibtex').meta.references or {}) do
    categories[pandoc.utils.stringify(reference.id)] = pandoc.utils.stringify(reference.keyword or '')
  end
  return categories
end

function Div(div)
  if div.identifier ~= 'refs' then
    return nil
  end
  local categories = category_of_each_reference()
  local groups, missing = {}, {}
  for _, category in ipairs(CATEGORIES) do
    groups[category.key] = {}
  end
  for _, entry in ipairs(div.content) do
    local id = (entry.identifier or ''):gsub('^ref%-', '')
    local group = groups[categories[id]]
    if group then
      table.insert(group, entry)
    else
      table.insert(missing, id)
    end
  end
  if #missing > 0 then
    error('Referencias sin categoria en ' .. BIBLIOGRAPHY .. ': ' .. table.concat(missing, ', '))
  end

  local blocks = {}
  for _, category in ipairs(CATEGORIES) do
    if #groups[category.key] > 0 then
      table.insert(blocks, pandoc.Header(2, category.title, pandoc.Attr('', { 'unnumbered', 'unlisted' })))
      -- Misma clase y atributos que la lista de citeproc, para conservar la sangria francesa
      table.insert(blocks, pandoc.Div(groups[category.key],
        pandoc.Attr('refs-' .. category.key, div.classes, div.attributes)))
    end
  end
  return blocks
end
