#!/usr/bin/env python3
"""Genera config/reference.docx, la plantilla de estilos APA 7 del informe en Word.

Pandoc copia de este archivo los estilos, el encabezado con el numero de pagina
y el tamano de pagina y los margenes; el contenido del documento lo ignora. Se
parte de la plantilla que trae pandoc y se reemplazan los estilos que usa el
informe, para que cada regla APA quede escrita aqui y se pueda revisar en una
Pull Request en lugar de vivir escondida dentro de un binario.

    python scripts/reference-docx.py

Se vuelve a correr solo cuando cambia este script. El build usa el
config/reference.docx que ya esta en el repositorio, asi que no hace falta
Python para compilar.
"""
import re
import subprocess
import sys
import zipfile
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
SALIDA = RAIZ / 'config' / 'reference.docx'

# Medidas en vigesimos de punto (twips): 1 in = 1440, 0.5 in = 720.
# Interlineado en 240avos de linea: 1.5 = 360.
LINEA = 360
SANGRIA = 720
ANCHO_TEXTO = 9360  # 8.5 in de carta menos dos margenes de 1 in

FUENTE = '<w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman" w:eastAsia="Times New Roman" w:cs="Times New Roman" />'

DOC_DEFAULTS = f'''<w:docDefaults>
    <w:rPrDefault>
      <w:rPr>
        {FUENTE}
        <w:sz w:val="24" />
        <w:szCs w:val="24" />
        <w:lang w:val="es-PE" w:eastAsia="es-PE" w:bidi="ar-SA" />
      </w:rPr>
    </w:rPrDefault>
    <w:pPrDefault>
      <w:pPr>
        <w:widowControl />
        <w:spacing w:before="0" w:after="0" w:line="{LINEA}" w:lineRule="auto" />
      </w:pPr>
    </w:pPrDefault>
  </w:docDefaults>'''


def parrafo(style_id, nombre, ppr='', rpr='', basado='Normal', siguiente=None, extra=''):
    siguiente = f'<w:next w:val="{siguiente}" />' if siguiente else ''
    basado = f'<w:basedOn w:val="{basado}" />' if basado else ''
    return f'''<w:style w:type="paragraph" w:customStyle="1" w:styleId="{style_id}">
    <w:name w:val="{nombre}" />
    {basado}{siguiente}{extra}
    <w:qFormat />
    <w:pPr>{ppr}</w:pPr>
    <w:rPr>{rpr}</w:rPr>
  </w:style>'''


def titulo(nivel, ppr, rpr):
    """Estilo de encabezado sin la fuente ni el color del tema de pandoc."""
    return f'''<w:style w:type="paragraph" w:styleId="Heading{nivel}">
    <w:name w:val="heading {nivel}" />
    <w:basedOn w:val="Normal" />
    <w:next w:val="BodyText" />
    <w:link w:val="Heading{nivel}Char" />
    <w:uiPriority w:val="9" />
    <w:unhideWhenUsed />
    <w:qFormat />
    <w:pPr>
      <w:keepNext />
      <w:keepLines />
      {ppr}
      <w:outlineLvl w:val="{nivel - 1}" />
    </w:pPr>
    <w:rPr>
      <w:color w:val="000000" />
      <w:sz w:val="24" />
      <w:szCs w:val="24" />
      {rpr}
    </w:rPr>
  </w:style>'''


def titulo_char(nivel, rpr):
    return f'''<w:style w:type="character" w:customStyle="1" w:styleId="Heading{nivel}Char">
    <w:name w:val="Heading {nivel} Char" />
    <w:basedOn w:val="DefaultParagraphFont" />
    <w:link w:val="Heading{nivel}" />
    <w:uiPriority w:val="9" />
    <w:rPr>
      <w:color w:val="000000" />
      <w:sz w:val="24" />
      <w:szCs w:val="24" />
      {rpr}
    </w:rPr>
  </w:style>'''


NEGRITA = '<w:b /><w:bCs />'
CURSIVA = '<w:i /><w:iCs />'
SIN_SANGRIA = '<w:ind w:left="0" w:firstLine="0" />'
IZQUIERDA = '<w:jc w:val="left" />'

ESTILOS = {
    # APA no parte palabras al final de la linea. La particion automatica esta
    # activa en el documento (settings.xml) solo para las celdas de tabla, que
    # en columnas angostas no tienen otra forma de cortar una palabra larga;
    # todo lo que hereda de Normal la suprime.
    'Normal': '''<w:style w:type="paragraph" w:default="1" w:styleId="Normal">
    <w:name w:val="Normal" />
    <w:qFormat />
    <w:pPr><w:widowControl /><w:suppressAutoHyphens /></w:pPr>
  </w:style>''',

    # Texto de las celdas: espacio simple, sin sangria y con particion.
    'TableText': parrafo('TableText', 'Table Text',
                         ppr=f'<w:suppressAutoHyphens w:val="0" /><w:spacing w:line="240" w:lineRule="auto" />{SIN_SANGRIA}'),
    # Cabecera de tabla: negrita y unida a la fila siguiente, para que no quede
    # sola al pie de una pagina. config/docx.lua la pasa al cuerpo de la tabla
    # para que Word no la repita en cada pagina.
    'TableHeader': parrafo('TableHeader', 'Table Header', basado='TableText',
                           ppr='<w:keepNext />', rpr=NEGRITA),

    # Texto: alineado a la izquierda, interlineado 1.5 (heredado), sangria de
    # 0.5 in en la primera linea y sin espacio entre parrafos.
    'BodyText': f'''<w:style w:type="paragraph" w:styleId="BodyText">
    <w:name w:val="Body Text" />
    <w:basedOn w:val="Normal" />
    <w:link w:val="BodyTextChar" />
    <w:qFormat />
    <w:pPr>
      <w:widowControl />
      <w:ind w:firstLine="{SANGRIA}" />
      {IZQUIERDA}
    </w:pPr>
  </w:style>''',

    # Pandoc usa este estilo para el primer parrafo despues de un titulo. APA
    # sangra todos los parrafos, asi que es igual al texto normal.
    'FirstParagraph': '''<w:style w:type="paragraph" w:customStyle="1" w:styleId="FirstParagraph">
    <w:name w:val="First Paragraph" />
    <w:basedOn w:val="BodyText" />
    <w:next w:val="BodyText" />
    <w:qFormat />
  </w:style>''',

    # Celdas de tabla y listas compactas: sin sangria de primera linea.
    'Compact': parrafo('Compact', 'Compact', ppr=f'{SIN_SANGRIA}{IZQUIERDA}'),

    # Los cinco niveles de APA 7. El cuarto y el quinto van en linea con el
    # parrafo que les sigue; eso lo arma config/docx.lua con el separador de
    # estilo de Word, porque un estilo de parrafo no puede hacerlo solo.
    'Heading1': titulo(1, '<w:pageBreakBefore /><w:spacing w:before="0" w:after="240" /><w:jc w:val="center" />', NEGRITA),
    'Heading2': titulo(2, f'<w:spacing w:before="240" w:after="120" />{IZQUIERDA}', NEGRITA),
    'Heading3': titulo(3, f'<w:spacing w:before="240" w:after="120" />{IZQUIERDA}', NEGRITA + CURSIVA),
    'Heading4': titulo(4, f'<w:spacing w:before="120" w:after="0" /><w:ind w:firstLine="{SANGRIA}" />{IZQUIERDA}', NEGRITA),
    'Heading5': titulo(5, f'<w:spacing w:before="120" w:after="0" /><w:ind w:firstLine="{SANGRIA}" />{IZQUIERDA}', NEGRITA + CURSIVA),
    'Heading1Char': titulo_char(1, NEGRITA),
    'Heading2Char': titulo_char(2, NEGRITA),
    'Heading3Char': titulo_char(3, NEGRITA + CURSIVA),
    'Heading4Char': titulo_char(4, NEGRITA),
    'Heading5Char': titulo_char(5, NEGRITA + CURSIVA),

    # Titulo del indice: como un titulo de primer nivel, pero fuera del indice.
    'TOCHeading': f'''<w:style w:type="paragraph" w:styleId="TOCHeading">
    <w:name w:val="TOC Heading" />
    <w:basedOn w:val="Normal" />
    <w:next w:val="BodyText" />
    <w:uiPriority w:val="39" />
    <w:unhideWhenUsed />
    <w:qFormat />
    <w:pPr>
      <w:keepNext />
      <w:pageBreakBefore />
      <w:spacing w:before="0" w:after="240" />
      <w:jc w:val="center" />
    </w:pPr>
    <w:rPr>{NEGRITA}<w:color w:val="000000" /></w:rPr>
  </w:style>''',

    # Referencias: sangria francesa de 0.5 in.
    'Bibliography': f'''<w:style w:type="paragraph" w:styleId="Bibliography">
    <w:name w:val="Bibliography" />
    <w:basedOn w:val="Normal" />
    <w:next w:val="Bibliography" />
    <w:qFormat />
    <w:pPr>
      <w:ind w:left="{SANGRIA}" w:hanging="{SANGRIA}" />
      {IZQUIERDA}
    </w:pPr>
  </w:style>''',

    # Tablas con todas sus lineas, como en el PDF.
    'Table': '''<w:style w:type="table" w:default="1" w:styleId="Table">
    <w:name w:val="Table" />
    <w:basedOn w:val="TableNormal" />
    <w:qFormat />
    <w:pPr><w:spacing w:line="240" w:lineRule="auto" /></w:pPr>
    <w:tblPr>
      <w:tblInd w:w="0" w:type="dxa" />
      <w:tblBorders>
        <w:top w:val="single" w:sz="4" w:space="0" w:color="000000" />
        <w:left w:val="single" w:sz="4" w:space="0" w:color="000000" />
        <w:bottom w:val="single" w:sz="4" w:space="0" w:color="000000" />
        <w:right w:val="single" w:sz="4" w:space="0" w:color="000000" />
        <w:insideH w:val="single" w:sz="4" w:space="0" w:color="000000" />
        <w:insideV w:val="single" w:sz="4" w:space="0" w:color="000000" />
      </w:tblBorders>
      <w:tblCellMar>
        <w:top w:w="40" w:type="dxa" />
        <w:left w:w="72" w:type="dxa" />
        <w:bottom w:w="40" w:type="dxa" />
        <w:right w:w="72" w:type="dxa" />
      </w:tblCellMar>
    </w:tblPr>
    <w:tcPr><w:vAlign w:val="top" /></w:tcPr>
  </w:style>''',

    # Rotulo APA de tablas y figuras: "Tabla N" en negrita y, en la linea
    # siguiente, el titulo en cursiva. Los dos viajan con lo que rotulan.
    'CaptionLabel': parrafo('CaptionLabel', 'Caption Label',
                            ppr=f'<w:keepNext /><w:keepLines /><w:spacing w:before="240" />{SIN_SANGRIA}{IZQUIERDA}',
                            rpr=NEGRITA, siguiente='CaptionTitle'),
    'CaptionTitle': parrafo('CaptionTitle', 'Caption Title',
                            ppr=f'<w:keepNext /><w:keepLines /><w:spacing w:after="120" />{SIN_SANGRIA}{IZQUIERDA}',
                            rpr=CURSIVA),

    # Parrafo que contiene la imagen de una figura. La variante con nota se
    # mantiene en la misma pagina que la nota que la sigue.
    'FigureImage': parrafo('FigureImage', 'Figure Image',
                           ppr=f'<w:keepLines /><w:spacing w:after="120" w:line="240" w:lineRule="auto" />{SIN_SANGRIA}<w:jc w:val="center" />'),
    'FigureImageWithNote': parrafo('FigureImageWithNote', 'Figure Image With Note', basado='FigureImage',
                                   ppr='<w:keepNext />'),

    # Nota APA debajo de una figura o tabla: sin sangria.
    'Note': parrafo('Note', 'Note', ppr=f'<w:spacing w:after="240" />{SIN_SANGRIA}{IZQUIERDA}'),

    # Caratula: centrada, a espacio simple.
    'Cover': parrafo('Cover', 'Cover',
                     ppr=f'<w:spacing w:line="240" w:lineRule="auto" />{SIN_SANGRIA}<w:jc w:val="center" />'),

    # Entradas del indice.
    'TOC1': parrafo('TOC1', 'toc 1', ppr=f'<w:tabs><w:tab w:val="right" w:leader="dot" w:pos="{ANCHO_TEXTO}" /></w:tabs>{SIN_SANGRIA}',
                    extra='<w:uiPriority w:val="39" /><w:unhideWhenUsed />'),
    'TOC2': parrafo('TOC2', 'toc 2', ppr=f'<w:tabs><w:tab w:val="right" w:leader="dot" w:pos="{ANCHO_TEXTO}" /></w:tabs><w:ind w:left="240" w:firstLine="0" />',
                    extra='<w:uiPriority w:val="39" /><w:unhideWhenUsed />'),
    'TOC3': parrafo('TOC3', 'toc 3', ppr=f'<w:tabs><w:tab w:val="right" w:leader="dot" w:pos="{ANCHO_TEXTO}" /></w:tabs><w:ind w:left="480" w:firstLine="0" />',
                    extra='<w:uiPriority w:val="39" /><w:unhideWhenUsed />'),
}

# Los estilos de indice son estilos integrados de Word, no personalizados.
for clave in ('TOC1', 'TOC2', 'TOC3'):
    ESTILOS[clave] = ESTILOS[clave].replace(' w:customStyle="1"', '')

# Numero de pagina arriba a la derecha.
ENCABEZADO = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:hdr xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:p>
    <w:pPr><w:jc w:val="right" /><w:spacing w:line="240" w:lineRule="auto" /></w:pPr>
    <w:r><w:fldChar w:fldCharType="begin" /></w:r>
    <w:r><w:instrText xml:space="preserve"> PAGE </w:instrText></w:r>
    <w:r><w:fldChar w:fldCharType="separate" /></w:r>
    <w:r><w:t>1</w:t></w:r>
    <w:r><w:fldChar w:fldCharType="end" /></w:r>
  </w:p>
</w:hdr>'''

ID_ENCABEZADO = 'rIdApaHeader'

# Carta, margenes de 1 in y la numeracion empezando en 1. La caratula va en una
# seccion propia sin encabezado; la cierra config/docx.lua.
SECCION = f'''<w:sectPr>
      <w:headerReference w:type="default" r:id="{ID_ENCABEZADO}" />
      <w:pgSz w:w="12240" w:h="15840" />
      <w:pgMar w:top="1440" w:right="1440" w:bottom="1440" w:left="1440" w:header="720" w:footer="720" w:gutter="0" />
      <w:pgNumType w:start="1" />
      <w:cols w:space="720" />
    </w:sectPr>'''


def poner_estilo(styles, style_id, bloque):
    patron = re.compile(r'<w:style [^>]*w:styleId="%s"[^>]*>.*?</w:style>' % re.escape(style_id), re.S)
    if patron.search(styles):
        return patron.sub(lambda _: bloque, styles, count=1)
    return styles.replace('</w:styles>', f'  {bloque}\n</w:styles>')


def plantilla_de_pandoc():
    try:
        return subprocess.run(['pandoc', '--print-default-data-file', 'reference.docx'],
                              check=True, capture_output=True).stdout
    except (OSError, subprocess.CalledProcessError) as error:
        sys.exit(f'ERROR: could not read the default pandoc reference.docx ({error})')


def main():
    import io
    origen = zipfile.ZipFile(io.BytesIO(plantilla_de_pandoc()))
    partes = {nombre: origen.read(nombre) for nombre in origen.namelist()}

    styles = partes['word/styles.xml'].decode('utf-8')
    styles = re.sub(r'<w:docDefaults>.*?</w:docDefaults>', lambda _: DOC_DEFAULTS, styles, count=1, flags=re.S)
    for style_id, bloque in ESTILOS.items():
        styles = poner_estilo(styles, style_id, bloque)
    partes['word/styles.xml'] = styles.encode('utf-8')

    documento = partes['word/document.xml'].decode('utf-8')
    documento = re.sub(r'<w:sectPr.*?</w:sectPr>', '', documento, flags=re.S)
    documento = documento.replace('</w:body>', f'{SECCION}\n  </w:body>')
    partes['word/document.xml'] = documento.encode('utf-8')

    partes['word/header1.xml'] = ENCABEZADO.encode('utf-8')

    ajustes = partes['word/settings.xml'].decode('utf-8')
    if '<w:autoHyphenation' not in ajustes:
        ajustes = re.sub(r'(<w:settings[^>]*>)', r'\1<w:autoHyphenation />', ajustes, count=1)
    partes['word/settings.xml'] = ajustes.encode('utf-8')

    rels = partes['word/_rels/document.xml.rels'].decode('utf-8')
    if ID_ENCABEZADO not in rels:
        rels = rels.replace('</Relationships>',
                            f'<Relationship Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/header" '
                            f'Id="{ID_ENCABEZADO}" Target="header1.xml" /></Relationships>')
    partes['word/_rels/document.xml.rels'] = rels.encode('utf-8')

    tipos = partes['[Content_Types].xml'].decode('utf-8')
    if '/word/header1.xml' not in tipos:
        tipos = tipos.replace('</Types>',
                              '<Override PartName="/word/header1.xml" ContentType="application/'
                              'vnd.openxmlformats-officedocument.wordprocessingml.header+xml" /></Types>')
    partes['[Content_Types].xml'] = tipos.encode('utf-8')

    with zipfile.ZipFile(SALIDA, 'w', zipfile.ZIP_DEFLATED) as destino:
        for nombre, datos in partes.items():
            destino.writestr(nombre, datos)
    print(f'Wrote {SALIDA.relative_to(RAIZ)}')


if __name__ == '__main__':
    main()
