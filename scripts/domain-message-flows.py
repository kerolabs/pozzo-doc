#!/usr/bin/env python3
"""Dibuja los Domain Message Flow de Pozzo con la notacion de DDD Crew.

Un Domain Message Flow Diagram muestra el flujo de mensajes (comandos, eventos y
consultas) entre actores, bounded contexts y sistemas, para un solo escenario.
Cada mensaje lleva su nombre, los datos relevantes y su numero de orden, y el
repositorio oficial recomienda entre cinco y nueve mensajes por diagrama.
Ver github.com/ddd-crew/domain-message-flow-modelling.

    python scripts/domain-message-flows.py

La salida son docs/images/chapter_2/dmf_historia{1,2,3}.png.
"""
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, Ellipse, FancyBboxPatch, Polygon

RAIZ = Path(__file__).resolve().parent.parent
SALIDA = RAIZ / 'docs/images/chapter_2'

# Colores de la notacion oficial
CTX_RELLENO, CTX_BORDE = '#E4DCF7', '#6B4FBB'
TIPO = {
    'comando':  ('#CFE3FA', '#2A6CB0'),
    'evento':   ('#FBDFC2', '#C4700F'),
    'consulta': ('#DDEFC6', '#4F8A21'),
}
GRIS, TEXTO = '#6B7580', '#1F2933'


def actor(ax, x, y, nombre):
    ax.add_patch(Circle((x, y + 0.028), 0.014, facecolor='#3A4149', edgecolor='none', zorder=4))
    ax.add_patch(Polygon([[x - 0.026, y - 0.030], [x + 0.026, y - 0.030],
                          [x + 0.019, y + 0.012], [x - 0.019, y + 0.012]],
                         closed=True, facecolor='#3A4149', edgecolor='none', zorder=4))
    ax.text(x, y - 0.055, nombre, ha='center', va='top', fontsize=9,
            fontweight='bold', color=TEXTO, zorder=5)


def contexto(ax, x, y, nombre):
    ax.add_patch(Ellipse((x, y), 0.20, 0.105, facecolor=CTX_RELLENO,
                         edgecolor=CTX_BORDE, linewidth=1.8, zorder=4))
    ax.text(x, y, nombre, ha='center', va='center', fontsize=9,
            fontweight='bold', color=CTX_BORDE, zorder=5)


def sistema(ax, x, y, nombre):
    ax.add_patch(FancyBboxPatch((x - 0.085, y - 0.040), 0.17, 0.080,
                                boxstyle='round,pad=0.006,rounding_size=0.01',
                                facecolor='#F2F3F4', edgecolor=GRIS,
                                linewidth=1.6, linestyle='--', zorder=4))
    ax.text(x, y, nombre, ha='center', va='center', fontsize=8.6,
            color=GRIS, fontweight='bold', zorder=5)


FORMAS = {'actor': actor, 'contexto': contexto, 'sistema': sistema}


def mensaje(ax, n, nombre, datos, tipo, x, y):
    relleno, borde = TIPO[tipo]
    ancho = max(0.145, 0.0105 * len(nombre))
    ax.add_patch(FancyBboxPatch((x - ancho / 2, y - 0.019), ancho, 0.038,
                                boxstyle='round,pad=0.005,rounding_size=0.008',
                                facecolor=relleno, edgecolor=borde, linewidth=1.3, zorder=6))
    ax.add_patch(Circle((x - ancho / 2, y + 0.019), 0.0125,
                        facecolor='white', edgecolor=borde, linewidth=1.3, zorder=7))
    ax.text(x - ancho / 2, y + 0.019, str(n), ha='center', va='center',
            fontsize=7.6, fontweight='bold', color=borde, zorder=8)
    ax.text(x, y, nombre, ha='center', va='center', fontsize=8.3,
            color=TEXTO, zorder=7)
    if datos:
        ax.text(x, y - 0.026, datos, ha='center', va='top', fontsize=6.9,
                color=GRIS, style='italic', zorder=7,
                bbox=dict(boxstyle='round,pad=0.22', facecolor='#FFFDF2',
                          edgecolor='#E2D9A8', linewidth=0.6))


def leyenda(ax):
    x0, y0 = 0.012, 0.975
    ax.text(x0, y0, 'Notación', fontsize=8.6, fontweight='bold', color=TEXTO, va='top')
    y = y0 - 0.040
    # actor
    ax.add_patch(Circle((x0 + 0.014, y + 0.008), 0.005, facecolor='#3A4149', edgecolor='none'))
    ax.add_patch(Polygon([[x0 + 0.005, y - 0.011], [x0 + 0.023, y - 0.011],
                          [x0 + 0.020, y + 0.003], [x0 + 0.008, y + 0.003]],
                         closed=True, facecolor='#3A4149', edgecolor='none'))
    ax.text(x0 + 0.030, y, 'Actor', fontsize=7.6, color=GRIS, va='center')
    y -= 0.034
    # bounded context
    ax.add_patch(Ellipse((x0 + 0.014, y), 0.026, 0.020, facecolor=CTX_RELLENO,
                         edgecolor=CTX_BORDE, linewidth=1.2))
    ax.text(x0 + 0.030, y, 'Bounded Context', fontsize=7.6, color=GRIS, va='center')
    y -= 0.034
    # sistema externo
    ax.add_patch(FancyBboxPatch((x0 + 0.002, y - 0.010), 0.024, 0.020,
                                boxstyle='round,pad=0.002,rounding_size=0.004',
                                facecolor='#F2F3F4', edgecolor=GRIS,
                                linewidth=1.2, linestyle='--'))
    ax.text(x0 + 0.030, y, 'Sistema externo', fontsize=7.6, color=GRIS, va='center')
    y -= 0.034
    ax.plot([x0 + 0.004, x0 + 0.024], [y, y], linestyle=(0, (3, 3)), color=GRIS, linewidth=1.2)
    ax.text(x0 + 0.030, y, 'Dirección del mensaje', fontsize=7.6, color=GRIS, va='center')
    y -= 0.040
    for etiqueta, t in (('Comando', 'comando'), ('Evento', 'evento'), ('Consulta', 'consulta')):
        relleno, borde = TIPO[t]
        ax.add_patch(FancyBboxPatch((x0 + 0.004, y - 0.012), 0.020, 0.024,
                                    boxstyle='round,pad=0.003,rounding_size=0.005',
                                    facecolor=relleno, edgecolor=borde, linewidth=1.1))
        ax.text(x0 + 0.030, y, etiqueta, fontsize=7.6, color=GRIS, va='center')
        y -= 0.034


def dibujar(nombre_archivo, titulo, nodos, mensajes):
    fig = plt.figure(figsize=(15, 8.6), dpi=170)
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_xlim(0, 1); ax.set_ylim(0, 1); ax.axis('off')
    ax.text(0.5, 0.965, titulo, ha='center', va='top', fontsize=13,
            fontweight='bold', color=TEXTO)
    leyenda(ax)

    for clave, (x, y, forma, etiqueta) in nodos.items():
        FORMAS[forma](ax, x, y, etiqueta)

    for n, (origen, destino, nombre, datos, tipo, mx, my) in enumerate(mensajes, 1):
        x1, y1 = nodos[origen][0], nodos[origen][1]
        x2, y2 = nodos[destino][0], nodos[destino][1]
        ax.annotate('', xy=(x2, y2), xytext=(x1, y1),
                    arrowprops=dict(arrowstyle='-|>', color='#8A94A0', linewidth=1.3,
                                    linestyle=(0, (4, 3)), shrinkA=34, shrinkB=34),
                    zorder=2)
        mensaje(ax, n, nombre, datos, tipo, mx, my)

    SALIDA.mkdir(parents=True, exist_ok=True)
    destino = SALIDA / nombre_archivo
    fig.savefig(destino, facecolor='white', bbox_inches='tight', pad_inches=0.1)
    plt.close(fig)
    print(f'escrito {destino.name}')


# ---------------------------------------------------------------- Historia 1
NODOS1 = {
    'cabeza':     (0.18, 0.72, 'actor',    'Cabeza de junta'),
    'participante': (0.18, 0.28, 'actor',  'Participante'),
    'savings':    (0.52, 0.50, 'contexto', 'Savings Groups'),
    'identity':   (0.52, 0.18, 'contexto', 'Identity &\nAccess'),
    'compliance': (0.85, 0.30, 'contexto', 'Compliance\nHistory'),
    'notif':      (0.85, 0.70, 'contexto', 'Notifications'),
}
MENSAJES1 = [
    ('cabeza', 'savings', 'Crear junta', 'aporte, periodicidad,\ncupos, fecha de corte', 'comando', 0.345, 0.655),
    ('cabeza', 'savings', 'Generar invitación', 'junta', 'comando', 0.300, 0.540),
    ('participante', 'identity', 'Verificar celular', 'número, código SMS', 'comando', 0.315, 0.195),
    ('participante', 'savings', 'Unirse a la junta', 'código de invitación', 'comando', 0.325, 0.375),
    ('savings', 'compliance', 'Historial del integrante', 'id del integrante', 'consulta', 0.690, 0.385),
    ('cabeza', 'savings', 'Iniciar junta', 'turnos asignados', 'comando', 0.300, 0.805),
    ('savings', 'notif', 'Junta iniciada', 'junta, integrantes,\nfecha de corte', 'evento', 0.700, 0.620),
]

# ---------------------------------------------------------------- Historia 2
NODOS2 = {
    'participante': (0.17, 0.30, 'actor',    'Participante'),
    'cabeza':       (0.17, 0.76, 'actor',    'Cabeza de junta'),
    'contrib':      (0.52, 0.52, 'contexto', 'Contributions'),
    'notif':        (0.85, 0.24, 'contexto', 'Notifications'),
    'compliance':   (0.85, 0.74, 'contexto', 'Compliance\nHistory'),
}
MENSAJES2 = [
    ('contrib', 'notif', 'Programar recordatorio', 'integrante, fecha de corte', 'comando', 0.700, 0.330),
    ('notif', 'participante', 'Recordatorio de aporte', 'monto esperado', 'evento', 0.545, 0.205),
    ('participante', 'contrib', 'Registrar aporte', 'monto, fecha, destinatario,\nn.º de operación, comprobante', 'comando', 0.315, 0.420),
    ('contrib', 'compliance', 'Aporte validado', 'integrante, monto, período', 'evento', 0.700, 0.660),
    ('contrib', 'notif', 'Aporte validado', 'integrante, estado del pozo', 'evento', 0.640, 0.420),
    ('cabeza', 'contrib', 'Estado del pozo', 'período vigente', 'consulta', 0.330, 0.680),
]

# ---------------------------------------------------------------- Historia 3
NODOS3 = {
    'cabeza':     (0.17, 0.52, 'actor',    'Cabeza de junta'),
    'contrib':    (0.50, 0.52, 'contexto', 'Contributions'),
    'savings':    (0.50, 0.17, 'contexto', 'Savings Groups'),
    'notif':      (0.84, 0.24, 'contexto', 'Notifications'),
    'compliance': (0.84, 0.78, 'contexto', 'Compliance\nHistory'),
}
MENSAJES3 = [
    ('contrib', 'notif', 'Pozo completo', 'período, monto reunido', 'evento', 0.690, 0.340),
    ('cabeza', 'contrib', 'Registrar entrega del pozo', 'integrante que cobra, monto', 'comando', 0.330, 0.600),
    ('contrib', 'savings', 'Calendario de turnos', 'junta', 'consulta', 0.520, 0.350),
    ('contrib', 'notif', 'Pozo entregado', 'turno, siguiente período', 'evento', 0.660, 0.430),
    ('cabeza', 'contrib', 'Cerrar junta', 'último turno entregado', 'comando', 0.330, 0.455),
    ('contrib', 'compliance', 'Ciclo cerrado', 'cumplimiento de cada integrante', 'evento', 0.690, 0.680),
]


def main():
    dibujar('dmf_historia1.png',
            'Escenario 1: la cabeza crea la junta e incorpora a los integrantes',
            NODOS1, MENSAJES1)
    dibujar('dmf_historia2.png',
            'Escenario 2: el participante registra su aporte y Pozzo lo valida',
            NODOS2, MENSAJES2)
    dibujar('dmf_historia3.png',
            'Escenario 3: la cabeza entrega el pozo y cierra el ciclo',
            NODOS3, MENSAJES3)


if __name__ == '__main__':
    main()
