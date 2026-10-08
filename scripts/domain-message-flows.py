#!/usr/bin/env python3
"""Dibuja los Domain Message Flow de Pozzo con la notacion de DDD Crew.

Un Domain Message Flow Diagram muestra el flujo de mensajes (comandos, eventos
y consultas) entre actores y bounded contexts para un solo escenario. Cada caja
lleva su numero de orden, el nombre del mensaje y los datos que transporta, y el
repositorio oficial recomienda entre cinco y nueve mensajes por diagrama.
Ver github.com/ddd-crew/domain-message-flow-modelling.

Las coordenadas son las del tablero de Miro del equipo: el marco mide
2800x1381 y el eje y crece hacia abajo, igual que alli, para que la figura del
informe y el tablero se puedan comparar lado a lado.

    python scripts/domain-message-flows.py

La salida son docs/images/chapter_2/dmf_historia{1,2,3}.png.
"""
import math
import textwrap
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Circle, FancyBboxPatch, Polygon

RAIZ = Path(__file__).resolve().parent.parent
SALIDA = RAIZ / 'docs/images/chapter_2'

ANCHO, ALTO = 2800, 1381

# Colores de la notacion oficial
ACTOR_RELLENO, ACTOR_BORDE, ACTOR_TEXTO = '#E9ECEF', '#495057', '#313131'
CTX_RELLENO, CTX_BORDE = '#E4DCF7', '#6B4FBB'
TIPO = {
    'comando':  ('#CFE3FA', '#2A6CB0'),
    'evento':   ('#FBDFC2', '#C4700F'),
    'consulta': ('#DDEFC6', '#4F8A21'),
}
GRIS, TENUE, TEXTO, FLECHA = '#595959', '#C9CCD1', '#1F2933', '#8A94A0'

# Tamanos de letra: el ancho de la figura es de 12.4 pulgadas, asi que un punto
# tipografico equivale a unas 18 unidades del marco.
T_TITULO, T_PIE = 15, 7.5
T_ACTOR, T_CTX = 8.5, 12
T_MSG, T_DATO = 9, 8
T_LEY_TITULO, T_LEY, T_LEY_PARRAFO = 10.5, 8.5, 7.5

ANCHO_MSG = 400                  # ancho de cada caja de mensaje
CORTE_MSG, CORTE_DATO = 22, 28   # caracteres por linea
PASO_MSG, PASO_DATO = 35, 30     # alto de cada linea
MARGEN_MSG = 34                  # relleno vertical de la caja


# --------------------------------------------------------------------- formas
def actor(ax, cx, cy, etiqueta, r=78):
    ax.add_patch(Circle((cx, cy), r, facecolor=ACTOR_RELLENO, edgecolor=ACTOR_BORDE,
                        linewidth=2.0, zorder=4))
    ax.text(cx, cy, etiqueta, ha='center', va='center', fontsize=T_ACTOR,
            fontweight='bold', color=ACTOR_TEXTO, linespacing=1.4, zorder=5)


def _bultos(cx, cy, w, h):
    """Circulos cuya union forma la nube."""
    return [
        (cx, cy - 0.07 * h, 0.46 * h),
        (cx - 0.30 * w, cy + 0.02 * h, 0.36 * h),
        (cx + 0.30 * w, cy + 0.02 * h, 0.36 * h),
        (cx - 0.36 * w, cy + 0.12 * h, 0.28 * h),
        (cx + 0.36 * w, cy + 0.12 * h, 0.28 * h),
        (cx - 0.14 * w, cy + 0.22 * h, 0.28 * h),
        (cx + 0.14 * w, cy + 0.22 * h, 0.28 * h),
    ]


def nube(ax, cx, cy, w, h, relleno=CTX_RELLENO, borde=CTX_BORDE, grosor=2.2, z=4):
    """Dibuja la union de los circulos como un solo contorno.

    Para cada direccion desde el centro se busca el circulo que llega mas
    lejos; el poligono resultante tiene el perfil de la nube sin que se vean
    las lineas interiores de cada circulo.
    """
    bultos = _bultos(cx, cy, w, h)
    puntos = []
    for a in np.linspace(0, 2 * math.pi, 540, endpoint=False):
        ux, uy = math.cos(a), math.sin(a)
        mejor = 0.0
        for bx, by, r in bultos:
            dx, dy = bx - cx, by - cy
            proy = dx * ux + dy * uy
            disc = r * r - (dx * dx + dy * dy) + proy * proy
            if disc > 0:
                mejor = max(mejor, proy + math.sqrt(disc))
        puntos.append((cx + mejor * ux, cy + mejor * uy))
    ax.add_patch(Polygon(puntos, closed=True, facecolor=relleno, edgecolor=borde,
                         linewidth=grosor, joinstyle='round', zorder=z))


def contexto(ax, cx, cy, w, h, etiqueta):
    nube(ax, cx, cy, w, h)
    ax.text(cx, cy, etiqueta, ha='center', va='center', fontsize=T_CTX,
            fontweight='bold', color=CTX_BORDE, linespacing=1.3, zorder=5)


def mensaje(ax, n, nombre, datos, tipo, cx, cy, w=ANCHO_MSG):
    relleno, borde = TIPO[tipo]
    titulo = textwrap.wrap(f'{n}. {nombre}', CORTE_MSG)
    cuerpo = textwrap.wrap(datos, CORTE_DATO) if datos else []
    h = MARGEN_MSG + PASO_MSG * len(titulo) + PASO_DATO * len(cuerpo)
    ax.add_patch(FancyBboxPatch((cx - w / 2, cy - h / 2), w, h,
                                boxstyle='round,pad=0,rounding_size=14',
                                facecolor=relleno, edgecolor=borde,
                                linewidth=1.8, zorder=6))
    x = cx - w / 2 + 17
    y = cy - h / 2 + MARGEN_MSG / 2
    for linea in titulo:
        ax.text(x, y + PASO_MSG / 2, linea, ha='left', va='center',
                fontsize=T_MSG, fontweight='bold', color=TEXTO, zorder=7)
        y += PASO_MSG
    for linea in cuerpo:
        ax.text(x, y + PASO_DATO / 2, linea, ha='left', va='center',
                fontsize=T_DATO, color=TEXTO, zorder=7)
        y += PASO_DATO


# -------------------------------------------------------------------- flechas
def borde_nodo(nodo, hacia, giro=0.0):
    """Punto del contorno del nodo en la direccion del otro nodo.

    El giro, en grados, separa los arranques de los mensajes que unen el mismo
    par de nodos para que no salgan todos del mismo punto.
    """
    forma, cx, cy, w, h = nodo[0], nodo[1], nodo[2], nodo[3], nodo[4]
    dx, dy = hacia[0] - cx, hacia[1] - cy
    largo = math.hypot(dx, dy) or 1.0
    ux, uy = dx / largo, dy / largo
    if giro:
        g = math.radians(giro)
        ux, uy = ux * math.cos(g) - uy * math.sin(g), ux * math.sin(g) + uy * math.cos(g)
    if forma == 'actor':
        t = w / 2
    else:
        a, b = w / 2 * 0.96, h / 2 * 0.86
        t = 1.0 / math.hypot(ux / a, uy / b)
    return cx + (t + 8) * ux, cy + (t + 8) * uy


def flecha(ax, origen, destino, curva=0.0, giro=0.0):
    p1 = borde_nodo(origen, (destino[1], destino[2]), giro)
    p2 = borde_nodo(destino, (origen[1], origen[2]), -giro)
    ax.annotate('', xy=p2, xytext=p1,
                arrowprops=dict(arrowstyle='-|>,head_length=0.7,head_width=0.32',
                                color=FLECHA, linewidth=2.0,
                                linestyle=(0, (4, 3)), shrinkA=0, shrinkB=0,
                                connectionstyle=f'arc3,rad={curva}'),
                zorder=2)


# -------------------------------------------------------------------- leyenda
PARRAFOS = [
    'La flecha punteada indica la dirección del mensaje.',
    'Cada caja lleva el número de orden, el nombre del mensaje y los datos '
    'relevantes que transporta.',
    'Una consulta representa la pregunta y su respuesta como una sola unidad.',
]


def leyenda(ax):
    ax.add_patch(FancyBboxPatch((40, 86), 360, 790,
                                boxstyle='round,pad=0,rounding_size=16',
                                facecolor='#FAFAFA', edgecolor=TENUE,
                                linewidth=1.6, zorder=3))
    ax.text(70, 122, 'Notación', ha='left', va='center', fontsize=T_LEY_TITULO,
            fontweight='bold', color='#1A1A1A', zorder=5)

    ax.add_patch(Circle((100, 185), 24, facecolor=ACTOR_RELLENO,
                        edgecolor=ACTOR_BORDE, linewidth=1.6, zorder=4))
    ax.text(145, 185, 'Actor', ha='left', va='center', fontsize=T_LEY,
            color=GRIS, zorder=5)

    nube(ax, 100, 265, 80, 50, grosor=1.6)
    ax.text(145, 265, 'Bounded Context', ha='left', va='center', fontsize=T_LEY,
            color=GRIS, zorder=5)

    for etiqueta, clave, y in (('Comando', 'comando', 351),
                               ('Evento', 'evento', 416),
                               ('Consulta', 'consulta', 481)):
        relleno, borde = TIPO[clave]
        ax.add_patch(FancyBboxPatch((66, y - 20), 72, 40,
                                    boxstyle='round,pad=0,rounding_size=10',
                                    facecolor=relleno, edgecolor=borde,
                                    linewidth=1.5, zorder=4))
        ax.text(145, y, etiqueta, ha='left', va='center', fontsize=T_LEY,
                color=GRIS, zorder=5)

    y = 540
    for parrafo in PARRAFOS:
        for linea in textwrap.wrap(parrafo, 23):
            ax.text(70, y, linea, ha='left', va='center',
                    fontsize=T_LEY_PARRAFO, color=GRIS, zorder=5)
            y += 26
        y += 13


PIE = ('Domain Message Flow Diagram según github.com/ddd-crew/domain-message-flow-'
       'modelling: los mensajes que viajan entre actores y bounded contexts '
       'para un solo escenario.')


def dibujar(archivo, titulo, nodos, mensajes, flechas):
    fig = plt.figure(figsize=(12.4, 6.12), dpi=200)
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_xlim(0, ANCHO)
    ax.set_ylim(ALTO, 0)          # el eje y crece hacia abajo, como en Miro
    ax.set_aspect('equal')
    ax.axis('off')

    ax.text(440, 42, titulo, ha='left', va='center', fontsize=T_TITULO,
            fontweight='bold', color='#1A1A1A')
    ax.text(440, 1340, PIE, ha='left', va='center', fontsize=T_PIE, color=GRIS)
    leyenda(ax)

    for origen, destino, curva, giro in flechas:
        flecha(ax, nodos[origen], nodos[destino], curva, giro)

    for forma, cx, cy, w, h, etiqueta in nodos.values():
        if forma == 'actor':
            actor(ax, cx, cy, etiqueta, w / 2)
        else:
            contexto(ax, cx, cy, w, h, etiqueta)

    for n, nombre, datos, tipo, cx, cy in mensajes:
        mensaje(ax, n, nombre, datos, tipo, cx, cy)

    SALIDA.mkdir(parents=True, exist_ok=True)
    destino = SALIDA / archivo
    fig.savefig(destino, facecolor='white')
    plt.close(fig)
    print(f'escrito {destino.name}')


# ---------------------------------------------------------------- Escenario 1
NODOS1 = {
    'cabeza':       ('actor', 560, 281, 250, 250, 'Cabeza\nde junta'),
    'participante': ('actor', 560, 1061, 250, 250, 'Participante'),
    'savings':      ('contexto', 1450, 630, 430, 237, 'Savings Groups'),
    'identity':     ('contexto', 1450, 1165, 400, 207, 'Identity\n& Access'),
    'notif':        ('contexto', 2420, 300, 400, 207, 'Notifications'),
    'compliance':   ('contexto', 2420, 1030, 420, 207, 'Compliance\nHistory'),
}
MENSAJES1 = [
    (1, 'Crear junta', 'aporte, periodicidad, cupos, fecha de corte', 'comando', 930, 345),
    (2, 'Generar invitación', 'junta', 'comando', 930, 480),
    (6, 'Iniciar junta', 'turnos asignados', 'comando', 930, 610),
    (4, 'Unirse a la junta', 'código de invitación', 'comando', 940, 843),
    (3, 'Verificar celular', 'número, código SMS', 'comando', 965, 1153),
    (5, 'Historial del integrante', 'id del integrante', 'consulta', 1960, 823),
    (7, 'Junta iniciada', 'junta, integrantes, fecha de corte', 'evento', 1960, 428),
]
FLECHAS1 = [
    ('cabeza', 'savings', -0.10, -13),
    ('cabeza', 'savings', 0.0, 0),
    ('cabeza', 'savings', 0.10, 13),
    ('participante', 'identity', 0.0, 0),
    ('participante', 'savings', 0.0, 0),
    ('savings', 'compliance', 0.0, 0),
    ('savings', 'notif', 0.0, 0),
]

# ---------------------------------------------------------------- Escenario 2
NODOS2 = {
    'cabeza':       ('actor', 560, 281, 250, 250, 'Cabeza\nde junta'),
    'participante': ('actor', 560, 1061, 250, 250, 'Participante'),
    'contrib':      ('contexto', 1450, 630, 430, 237, 'Contributions'),
    'compliance':   ('contexto', 2420, 300, 400, 207, 'Compliance\nHistory'),
    'notif':        ('contexto', 2420, 1030, 420, 207, 'Notifications'),
}
MENSAJES2 = [
    (1, 'Programar recordatorio', 'integrante, fecha de corte', 'comando', 1960, 773),
    (2, 'Recordatorio de aporte', 'monto esperado', 'evento', 1315, 1060),
    (3, 'Registrar aporte',
     'monto, fecha, destinatario, n.º de operación, comprobante', 'comando', 940, 845),
    (4, 'Aporte validado', 'integrante, monto, período', 'evento', 1960, 403),
    (5, 'Aporte validado', 'integrante, estado del pozo', 'evento', 1960, 905),
    (6, 'Estado del pozo', 'período vigente', 'consulta', 930, 353),
]
FLECHAS2 = [
    ('contrib', 'notif', -0.10, -11),
    ('contrib', 'notif', 0.10, 11),
    ('notif', 'participante', 0.0, 0),
    ('participante', 'contrib', 0.0, 0),
    ('contrib', 'compliance', 0.0, 0),
    ('cabeza', 'contrib', 0.0, 0),
]

# ---------------------------------------------------------------- Escenario 3
NODOS3 = {
    'cabeza':     ('actor', 560, 631, 250, 250, 'Cabeza\nde junta'),
    'contrib':    ('contexto', 1450, 630, 430, 237, 'Contributions'),
    'savings':    ('contexto', 1450, 1160, 400, 207, 'Savings Groups'),
    'compliance': ('contexto', 2420, 300, 400, 207, 'Compliance\nHistory'),
    'notif':      ('contexto', 2420, 1030, 420, 207, 'Notifications'),
}
MENSAJES3 = [
    (1, 'Pozo completo', 'período, monto reunido', 'evento', 1960, 773),
    (2, 'Registrar entrega del pozo', 'integrante que cobra, monto', 'comando', 930, 505),
    (3, 'Calendario de turnos', 'junta', 'consulta', 1450, 900),
    (4, 'Pozo entregado', 'turno, siguiente período', 'evento', 1960, 905),
    (5, 'Cerrar junta', 'último turno entregado', 'comando', 930, 700),
    (6, 'Ciclo cerrado', 'cumplimiento de cada integrante', 'evento', 1960, 408),
]
FLECHAS3 = [
    ('contrib', 'notif', -0.10, -11),
    ('contrib', 'notif', 0.10, 11),
    ('cabeza', 'contrib', -0.14, -11),
    ('cabeza', 'contrib', 0.14, 11),
    ('contrib', 'savings', 0.0, 0),
    ('contrib', 'compliance', 0.0, 0),
]


def main():
    dibujar('dmf_historia1.png',
            'Escenario 1: la cabeza crea la junta e incorpora a los integrantes',
            NODOS1, MENSAJES1, FLECHAS1)
    dibujar('dmf_historia2.png',
            'Escenario 2: el participante registra su aporte y Pozzo lo valida',
            NODOS2, MENSAJES2, FLECHAS2)
    dibujar('dmf_historia3.png',
            'Escenario 3: la cabeza entrega el pozo y cierra el ciclo',
            NODOS3, MENSAJES3, FLECHAS3)


if __name__ == '__main__':
    main()
