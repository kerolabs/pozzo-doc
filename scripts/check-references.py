#!/usr/bin/env python3
"""Comprueba que cada figura y tabla del informe este referenciada en el texto.

Las figuras y tablas las numera LaTeX en el orden en que aparecen. Este script
reproduce esa numeracion leyendo los archivos en el mismo orden que el build y
avisa si una referencia del texto apunta a un numero que no existe o si queda
alguna figura o tabla sin mencionar.

    python scripts/check-references.py
"""
import re
import sys
from pathlib import Path

ORDEN = ['README.md', 'docs/chapter_1.md', 'docs/chapter_2.md',
         'docs/chapter_3.md', 'docs/chapter_4.md', 'docs/closing.md']
RAIZ = Path(__file__).resolve().parent.parent


def numerar():
    """Devuelve (figuras, tablas): listas de (archivo, linea, titulo) en orden."""
    figuras, tablas = [], []
    for nombre in ORDEN:
        ruta = RAIZ / nombre
        if not ruta.exists():
            continue
        lineas = ruta.read_text(encoding='utf-8').splitlines()
        omitido = False
        for i, linea in enumerate(lineas, 1):
            texto = linea.strip()
            if 'pdf:omit-start' in texto:
                omitido = True
            if 'pdf:omit-end' in texto:
                omitido = False
                continue
            if omitido:
                continue
            if texto.startswith('!['):
                figuras.append((nombre, i, re.match(r'!\[([^\]]*)\]', texto).group(1)))
            elif texto == '<table>':
                titulo = ''
                if i < len(lineas):
                    m = re.search(r'<caption>(.*?)</caption>', lineas[i])
                    if m:
                        titulo = m.group(1)
                tablas.append((nombre, i, titulo))
    return figuras, tablas


def citadas():
    """Numeros de figura y tabla mencionados en el texto (no en los <caption>)."""
    figs, tabs = set(), set()
    for nombre in ORDEN:
        ruta = RAIZ / nombre
        if not ruta.exists():
            continue
        for linea in ruta.read_text(encoding='utf-8').splitlines():
            if '<caption>' in linea:
                continue
            for m in re.finditer(r'\b(Figuras?|Tablas?)\s+(\d+)(?:\s+(?:a|y)\s+(\d+))?', linea):
                desde, hasta = int(m.group(2)), int(m.group(3) or m.group(2))
                destino = figs if m.group(1).startswith('Figura') else tabs
                destino.update(range(desde, hasta + 1))
    return figs, tabs


def main():
    figuras, tablas = numerar()
    refs_fig, refs_tab = citadas()
    problemas = []

    for etiqueta, elementos, refs in (('Figura', figuras, refs_fig), ('Tabla', tablas, refs_tab)):
        total = len(elementos)
        sin_citar = [n for n in range(1, total + 1) if n not in refs]
        inexistentes = sorted(n for n in refs if n > total)
        print(f'{etiqueta}s: {total} en el documento, {total - len(sin_citar)} referenciadas')
        for n in sin_citar:
            archivo, linea, titulo = elementos[n - 1]
            problemas.append(f'  {etiqueta} {n} sin referencia en el texto '
                             f'({archivo}:{linea}) {titulo[:50]}')
        for n in inexistentes:
            problemas.append(f'  el texto cita la {etiqueta} {n}, pero solo hay {total}')

    # Un caracter de control invisible aborta la compilacion con el mensaje
    # "Text line contains an invalid character", que no dice en que archivo esta.
    for nombre in ORDEN:
        ruta = RAIZ / nombre
        if not ruta.exists():
            continue
        for n, linea in enumerate(ruta.read_text(encoding='utf-8').splitlines(), 1):
            sucios = [c for c in linea if ord(c) < 32 and c != '\t']
            if sucios:
                problemas.append(f'  {nombre}:{n} tiene un caracter de control '
                                 f'invisible ({ascii(sucios[0])})')

    if problemas:
        print('\nProblemas:')
        print('\n'.join(problemas))
        return 1
    print('\nTodas las figuras y tablas estan referenciadas.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
