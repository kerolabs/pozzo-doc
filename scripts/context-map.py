#!/usr/bin/env python3
"""Dibuja el Context Map de Pozzo con la notacion de DDD Crew.

Cada relacion se rotula en sus dos extremos: U (upstream) y D (downstream) con
los patrones que le corresponden, siguiendo github.com/ddd-crew/context-mapping.

    python scripts/context-map.py

La salida es docs/images/chapter_2/context_map.png.
"""
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch

SALIDA = Path(__file__).resolve().parent.parent / 'docs/images/chapter_2/context_map.png'

COLOR = {
    'core':       ('#FADBD8', '#C0392B'),
    'supporting': ('#D4EFDF', '#1E8449'),
    'generic':    ('#E5E7E9', '#566573'),
    'externo':    ('#FDEBD0', '#CA6F1E'),
}

# nombre: (x, y, tipo, etiqueta)
CONTEXTOS = {
    'savings':     (0.50, 0.86, 'supporting', 'Savings Groups'),
    'contrib':     (0.50, 0.54, 'core',       'Contributions'),
    'compliance':  (0.50, 0.20, 'supporting', 'Compliance History'),
    'identity':    (0.11, 0.54, 'generic',    'Identity & Access'),
    'notif':       (0.89, 0.54, 'generic',    'Notifications'),
    'sms':         (0.11, 0.14, 'externo',    'Proveedor de SMS'),
    'fcm':         (0.89, 0.14, 'externo',    'Firebase Cloud\nMessaging'),
}
ANCHO, ALTO = 0.19, 0.105

# (origen, destino, etiqueta upstream, etiqueta downstream, que se intercambia, desvio)
RELACIONES = [
    ('savings', 'contrib',    'U, S',          'D, C',   'Reglas, integrantes y turnos', 0.0),
    ('contrib', 'notif',      'U, PL',         'D, CF',  'Eventos del pozo',             0.0),
    ('contrib', 'compliance', 'U, PL',         'D, ACL', 'Eventos de aporte',            0.0),
    ('savings', 'notif',      'U, PL',         'D, CF',  'Junta iniciada, turnos',       0.20),
    ('compliance', 'savings', 'U, OHS',        'D, CF',  'Historial del integrante',    -0.95),
    ('identity', 'contrib',   'U, OHS, PL',    'D, CF',  'Identidad y token',            0.0),
    ('identity', 'savings',   'U, OHS, PL',    'D, CF',  'Identidad',                    0.22),
    ('identity', 'sms',       'U, ACL',        'D',      'Envio de SMS',                 0.0),
    ('notif',    'fcm',       'U, CF',         'D',      'Push con el SDK de FCM',       0.0),
]


def caja(ax, x, y, tipo, etiqueta):
    relleno, borde = COLOR[tipo]
    ax.add_patch(FancyBboxPatch((x - ANCHO / 2, y - ALTO / 2), ANCHO, ALTO,
                                boxstyle='round,pad=0.008,rounding_size=0.012',
                                facecolor=relleno, edgecolor=borde, linewidth=2,
                                linestyle='--' if tipo == 'externo' else '-', zorder=3))
    sub = {'core': 'Core', 'supporting': 'Supporting', 'generic': 'Generic', 'externo': 'Sistema externo'}[tipo]
    ax.text(x, y + 0.012, etiqueta, ha='center', va='center',
            fontsize=10.5, fontweight='bold', color=borde, zorder=4)
    ax.text(x, y - 0.028, sub, ha='center', va='center',
            fontsize=8, color=borde, style='italic', zorder=4)


def main():
    fig = plt.figure(figsize=(15, 9.6), dpi=170)
    ax = fig.add_axes([0.01, 0.01, 0.98, 0.95])
    ax.set_xlim(0, 1); ax.set_ylim(0, 1); ax.axis('off')

    for origen, destino, up, down, que, desvio in RELACIONES:
        x1, y1 = CONTEXTOS[origen][0], CONTEXTOS[origen][1]
        x2, y2 = CONTEXTOS[destino][0], CONTEXTOS[destino][1]
        estilo = f'arc3,rad={desvio}' if desvio else 'arc3,rad=0'
        ax.annotate('', xy=(x2, y2), xytext=(x1, y1),
                    arrowprops=dict(arrowstyle='-|>', color='#34495E', linewidth=1.6,
                                    shrinkA=42, shrinkB=42, connectionstyle=estilo),
                    zorder=2)
        # Las etiquetas se situan sobre la curva real: matplotlib dibuja un
        # Bezier cuadratico cuyo punto de control es el medio desplazado por rad
        # en la perpendicular. Evaluarlo evita que los rotulos floten sueltos.
        cx = (x1 + x2) / 2 + desvio * (y2 - y1) / 2
        cy = (y1 + y2) / 2 - desvio * (x2 - x1) / 2

        def punto(t):
            u = 1 - t
            return (u * u * x1 + 2 * u * t * cx + t * t * x2,
                    u * u * y1 + 2 * u * t * cy + t * t * y2)

        for texto, t in ((up, 0.20), (down, 0.80)):
            px, py = punto(t)
            ax.text(px, py, f'[{texto}]', ha='center', va='center',
                    fontsize=8.2, fontweight='bold', color='#1A5276',
                    bbox=dict(boxstyle='round,pad=0.25', facecolor='white',
                              edgecolor='#AEB6BF', linewidth=0.7), zorder=5)
        px, py = punto(0.34 if abs(desvio) > 0.4 else 0.5)
        ax.text(px, py, que, ha='center', va='center', fontsize=7.6, color='#566573',
                bbox=dict(boxstyle='round,pad=0.22', facecolor='white',
                          edgecolor='none', alpha=0.95), zorder=5)

    for nombre, (x, y, tipo, etiqueta) in CONTEXTOS.items():
        caja(ax, x, y, tipo, etiqueta)

    leyenda = ('U = upstream, D = downstream; la flecha va del upstream al downstream.    '
               'S = Supplier, C = Customer, OHS = Open Host Service, PL = Published Language, '
               'CF = Conformist, ACL = Anti-corruption Layer.    No se usa Shared Kernel.')
    ax.text(0.5, -0.015, leyenda, ha='center', va='top', fontsize=8, color='#566573')

    SALIDA.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(SALIDA, facecolor='white', bbox_inches='tight', pad_inches=0.15)
    print(f'escrito {SALIDA.name}')


if __name__ == '__main__':
    main()
