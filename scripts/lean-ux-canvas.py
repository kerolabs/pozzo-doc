#!/usr/bin/env python3
"""Dibuja el Lean UX Canvas de Pozzo con la plantilla de Jeff Gothelf (v2).

El canvas se arma aqui, y no a mano, para que el contenido viva junto al informe
y la lamina se pueda regenerar cuando cambie:

    python scripts/lean-ux-canvas.py

La salida es docs/images/chapter_1/lean_ux_canvas.png.
"""
import textwrap
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle

SALIDA = Path(__file__).resolve().parent.parent / 'docs/images/chapter_1/lean_ux_canvas.png'

AZUL, ROSA, VERDE = '#CFE8F3', '#F2D9F0', '#D8EDC9'
NUMERO, TITULO, CUERPO = '#5B6670', '#1F2933', '#2E3A45'

# (numero, titulo, descripcion, contenido, color, x, y, ancho, alto)
CAJAS = [
    (1, 'Problemas del negocio',
     'Problema o necesidad que el negocio intenta resolver.',
     'Muchas juntas informales se administran a mano, con el dinero moviéndose por Yape pero '
     'las cuentas en un cuaderno y en capturas de WhatsApp. Esto genera errores de conteo, '
     'falta de prueba de pago y poca visibilidad sobre cuánto falta para el pozo.\n\n'
     'En ese contexto, Pozzo busca responder: ¿cómo administrar una junta que ya existe, '
     'validando los aportes y mostrando el avance en tiempo real, sin mover el dinero por '
     'la plataforma?',
     AZUL, 0.00, 0.62, 0.34, 0.38),

    (5, 'Soluciones propuestas',
     'Cómo resolver los problemas del negocio satisfaciendo a los usuarios.',
     '• Lector de vouchers de Yape que valida monto, fecha y destinatario.\n'
     '• Calendario de turnos con el estado de los aportes en tiempo real.\n'
     '• Recordatorios automáticos que suben de tono.\n'
     '• Asignación de turnos por sorteo, orden acordado o subasta.\n'
     '• Historial de cumplimiento portable entre juntas.\n'
     '• Incorporación por enlace de invitación o desde la propia aplicación.',
     VERDE, 0.345, 0.32, 0.31, 0.68),

    (2, 'Resultados comerciales',
     'Beneficios para el negocio al resolver los problemas.',
     '• Todas las juntas piloto terminan su ciclo en la aplicación sin volver al cuaderno.\n'
     '• Al menos el 80 % de los aportes se validan sin revisión manual de la cabeza.\n'
     '• Cero recordatorios de cobranza enviados a mano por la cabeza durante el ciclo.\n'
     '• Ninguna discrepancia sin comprobante localizable en la aplicación.\n'
     '• Al menos una de cada tres juntas nuevas llega por integrantes que ya usaron Pozzo.',
     AZUL, 0.66, 0.62, 0.34, 0.38),

    (3, 'Usuarios & Clientes',
     'Tipos de usuarios y clientes en los que nos enfocamos.',
     'La cabeza de junta arma el grupo y hoy lleva las cuentas a mano. Los participantes '
     'aportan con la periodicidad que el grupo haya pactado y esperan su turno para cobrar. '
     'El participante al que le toca cobrar necesita ver quién ya depositó y quién falta. '
     'Todos ya usan Yape y WhatsApp.',
     ROSA, 0.00, 0.32, 0.34, 0.29),

    (4, 'Beneficios para el usuario',
     'Beneficios que busca el usuario y sus motivantes.',
     '• La cabeza deja de perseguir gente y de equivocarse en el conteo.\n'
     '• El participante tiene una prueba clara de su aporte.\n'
     '• El que va a cobrar sabe en tiempo real cuánto falta para el pozo.\n'
     '• Los recordatorios evitan que alguien haga de cobrador.\n'
     '• El historial de cumplimiento abre la puerta a nuevas juntas.',
     ROSA, 0.66, 0.32, 0.34, 0.29),

    (6, 'Hipótesis',
     'Creemos que [resultado] se logrará si [usuario] obtiene [beneficio] con [solución].',
     '• La validación automática del voucher reduce el tiempo que la cabeza dedica a administrar la junta.\n'
     '• El calendario en tiempo real traslada a la aplicación las discrepancias sobre un aporte.\n'
     '• Los recordatorios automáticos evitan que el organizador tenga que cobrar uno por uno.\n'
     '• El reparto por sorteo, orden acordado o subasta permite adoptar Pozzo sin cambiar la costumbre del grupo.\n'
     '• El historial de cumplimiento lleva participantes hacia juntas nuevas.\n'
     '• La invitación desde la aplicación permite registrar el primer aporte sin configurar nada.',
     VERDE, 0.00, 0.00, 0.34, 0.305),

    (7, '¿Qué es lo más importante que necesitamos aprender primero?',
     'La suposición más riesgosa, la que podría llevar el proyecto al fracaso.',
     'Si las cabezas y los participantes confían en que la validación del voucher de Yape '
     'basta para dar por registrado un aporte, sin revisarlo a mano. Toda la propuesta de '
     'valor depende de esa confianza.',
     VERDE, 0.345, 0.00, 0.31, 0.305),

    (8, '¿Cuál es la menor cantidad de trabajo para aprenderlo?',
     'El experimento más pequeño que valida o descarta ese riesgo.',
     'Un experimento sin código: acompañar 2 o 3 juntas reales durante un ciclo, recibiendo '
     'las capturas de Yape por WhatsApp y respondiendo a cada participante «aporte '
     'registrado» tras validarlas a mano, como si lo hiciera el sistema.\n\n'
     'Al cierre, medir si la cabeza dejó de revisar sus movimientos por su cuenta y cuántos '
     'reclamos surgieron. Si la confianza se sostiene, recién entonces construir el lector '
     'de vouchers, el calendario y los recordatorios.',
     VERDE, 0.66, 0.00, 0.34, 0.305),
]


def envolver(texto, ancho):
    """Envuelve respetando los saltos de linea y las vinetas ya escritas."""
    salida = []
    for parrafo in texto.split('\n'):
        if not parrafo.strip():
            salida.append('')
            continue
        sangria = '   ' if parrafo.startswith('•') else ''
        salida.extend(textwrap.wrap(parrafo, ancho, subsequent_indent=sangria) or [''])
    return '\n'.join(salida)


def main():
    fig = plt.figure(figsize=(19, 11), dpi=170)
    ax = fig.add_axes([0.012, 0.012, 0.976, 0.976])
    ax.set_xlim(0, 1); ax.set_ylim(0, 1); ax.axis('off')

    for num, titulo, desc, cuerpo, color, x, y, w, h in CAJAS:
        ax.add_patch(Rectangle((x, y), w, h, facecolor=color,
                               edgecolor='white', linewidth=3, zorder=1))
        # numero grande a la izquierda
        ax.text(x + 0.012, y + h - 0.018, str(num), ha='left', va='top',
                fontsize=30, fontweight='bold', color=NUMERO, zorder=2)
        # titulo y descripcion, desplazados para dejar sitio al numero
        tx = x + 0.047
        # El titulo se envuelve dentro de la caja; si ocupa dos lineas, todo lo
        # que va debajo baja otro renglon para que nada se superponga.
        tit = envolver(titulo, max(22, int(w * 118)))
        lineas_tit = tit.count(chr(10)) + 1
        ax.text(tx, y + h - 0.020, tit, ha='left', va='top',
                fontsize=12.5, fontweight='bold', color=TITULO,
                linespacing=1.25, zorder=2)
        y_desc = y + h - 0.047 - 0.028 * (lineas_tit - 1)
        ancho_desc = max(40, int(w * 190))
        d = envolver(desc, ancho_desc)
        ax.text(tx, y_desc, d, ha='left', va='top',
                fontsize=7.6, color=NUMERO, style='italic', linespacing=1.35, zorder=2)
        # contenido
        y_cuerpo = y_desc - 0.034 - 0.020 * d.count(chr(10))
        ancho_cuerpo = max(42, int(w * 196))
        ax.text(x + 0.012, y_cuerpo, envolver(cuerpo, ancho_cuerpo), ha='left', va='top',
                fontsize=9.1, color=CUERPO, linespacing=1.55, zorder=2)

    SALIDA.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(SALIDA, facecolor='white', bbox_inches='tight', pad_inches=0.12)
    print(f'escrito {SALIDA.relative_to(SALIDA.parents[3])}')


if __name__ == '__main__':
    main()
