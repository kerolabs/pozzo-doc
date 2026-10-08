#!/usr/bin/env python3
"""Dibuja los Bounded Context Canvas de Pozzo con la plantilla oficial v5.

La reticula, las medidas y el contenido son los del tablero de Miro del equipo:
el marco mide 3320x1920 y el eje y crece hacia abajo, igual que alli, para que
la figura del informe y el marco del tablero se puedan comparar lado a lado.

La plantilla de DDD Crew (github.com/ddd-crew/bounded-context-canvas) no es solo
una cuadricula de texto: cada colaborador se dibuja con el icono que le toca
-nube para un bounded context, engranaje para un sistema externo, silueta para
un actor y monitor para el frontend- y al costado va el panel Collaborator Types
que explica esos iconos. El lenguaje ubicuo y las decisiones de negocio van en
tarjetas, no en parrafos.

    python scripts/bounded-context-canvas.py

La salida son docs/images/chapter_2/bcc_<contexto>.png.
"""
import math
import textwrap
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Circle, FancyBboxPatch, Polygon, Rectangle

SALIDA = Path(__file__).resolve().parent.parent / 'docs/images/chapter_2'

ANCHO, ALTO = 3320, 1920
FIG_ANCHO = 16.6
UNIDAD = ANCHO / FIG_ANCHO        # unidades del marco por pulgada

TINTA = '#1A1A1A'
TENUE = '#7A7A7A'
CUERPO = '#404040'
COLUMNA = '#9AA3AD'
NUBE, NUBE_BORDE = '#E4DCF7', '#6B4FBB'
ROJO = '#C0392B'
TARJETA = {
    'verde': ('#E6F2CF', '#9CC46A'),
    'azul': ('#D6E8FB', '#6BA4DE'),
    'ambar': ('#FBF0C9', '#D6B94A'),
    'morado': ('#E4DCF7', '#8F7FC4'),
}

# Tamanos de letra. En Miro el marco usa 32, 26, 19, 18, 17, 16 y 15; aqui se
# mantiene esa jerarquia pero algo mas grande, porque la figura se imprime al
# ancho de la pagina y el tablero se mira con zoom.
T_NOMBRE, T_SECCION, T_COLUMNA = 13.5, 11, 8
T_ETIQUETA, T_TEXTO, T_PREGUNTA, T_TARJETA = 7.6, 7.3, 7.0, 6.6
T_PANEL_TITULO, T_PANEL = 10, 8


def corte(ancho_u, tam, factor=0.62):
    """Cuantos caracteres de ese tamano caben en ese ancho."""
    return max(6, int(ancho_u / (tam * factor / 72 * UNIDAD)))


def paso(tam, interlinea=1.42):
    """Alto de una linea de ese tamano, en unidades del marco."""
    return tam / 72 * UNIDAD * interlinea


# --------------------------------------------------------------------------
# Iconos de la plantilla
# --------------------------------------------------------------------------

def engranaje(ax, cx, cy, r, color=TINTA):
    """Engranaje de ocho dientes: el icono de sistema externo."""
    dientes, r_raiz, r_hueco = 8, r * 0.70, r * 0.36
    vuelta, medio_diente, media_raiz = 360 / dientes, 11, 20
    puntos = []
    for i in range(dientes):
        a = i * vuelta
        for radio, angulo in ((r_raiz, a - media_raiz), (r, a - medio_diente),
                              (r, a + medio_diente), (r_raiz, a + media_raiz)):
            rad = math.radians(angulo)
            puntos.append((cx + radio * math.cos(rad), cy + radio * math.sin(rad)))
    ax.add_patch(Polygon(puntos, closed=True, facecolor=color, edgecolor='none', zorder=3))
    ax.add_patch(Circle((cx, cy), r_hueco, facecolor='white', edgecolor='none', zorder=4))


def persona(ax, cx, cy, r, color=TINTA):
    """Silueta: el icono de actor."""
    ax.add_patch(Circle((cx, cy - r * 0.46), r * 0.38, facecolor=color,
                        edgecolor='none', zorder=3))
    hombros = [(cx - r * 0.80, cy + r)]
    for i in range(41):
        t = math.pi * i / 40
        hombros.append((cx - r * 0.74 * math.cos(t), cy + r - r * 0.90 * math.sin(t)))
    hombros.append((cx + r * 0.80, cy + r))
    ax.add_patch(Polygon(hombros, closed=True, facecolor=color, edgecolor='none', zorder=3))


def monitor(ax, cx, cy, r, color=ROJO):
    """Pantalla: el icono de frontend."""
    w, h = r * 1.9, r * 1.34
    ax.add_patch(Rectangle((cx - w / 2, cy - r * 0.95), w, h, facecolor='none',
                           edgecolor=color, linewidth=2.4, zorder=3))
    ax.add_patch(Rectangle((cx - w / 2 + 4, cy - r * 0.95 + 4), w - 8, h - 8,
                           facecolor=color, alpha=0.18, edgecolor='none', zorder=3))
    ax.plot([cx, cx], [cy + r * 0.39, cy + r * 0.72], color=color, linewidth=2.4, zorder=3)
    ax.plot([cx - r * 0.52, cx + r * 0.52], [cy + r * 0.72, cy + r * 0.72],
            color=color, linewidth=2.4, zorder=3)


def nube(ax, cx, cy, w, h, relleno=NUBE, borde=NUBE_BORDE, grosor=1.8):
    """Union de circulos dibujada como un solo contorno."""
    bultos = [
        (cx, cy + 0.07 * h, 0.46 * h),
        (cx - 0.30 * w, cy - 0.02 * h, 0.36 * h),
        (cx + 0.30 * w, cy - 0.02 * h, 0.36 * h),
        (cx - 0.36 * w, cy - 0.12 * h, 0.28 * h),
        (cx + 0.36 * w, cy - 0.12 * h, 0.28 * h),
        (cx - 0.14 * w, cy - 0.22 * h, 0.28 * h),
        (cx + 0.14 * w, cy - 0.22 * h, 0.28 * h),
    ]
    puntos = []
    for a in np.linspace(0, 2 * math.pi, 360, endpoint=False):
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
                         linewidth=grosor, joinstyle='round', zorder=3))


def icono(ax, tipo, x, y, w=90, h=66):
    """Dibuja el icono del colaborador dentro de la celda (x, y, w, h)."""
    cx, cy = x + w / 2, y + h / 2
    if tipo == 'bc':
        nube(ax, cx, cy, w, h)
    elif tipo == 'sistema':
        engranaje(ax, cx, cy, h * 0.48)
    elif tipo == 'actor':
        persona(ax, cx, cy, h * 0.46)
    else:
        monitor(ax, cx, cy, h * 0.46)


# --------------------------------------------------------------------------
# Piezas del lienzo
# --------------------------------------------------------------------------

def caja(ax, x, y, w, h, relleno='white', borde=TINTA, grosor=2.4, rr=0):
    if rr:
        ax.add_patch(FancyBboxPatch((x, y), w, h,
                                    boxstyle=f'round,pad=0,rounding_size={rr}',
                                    facecolor=relleno, edgecolor=borde,
                                    linewidth=grosor, zorder=2))
    else:
        ax.add_patch(Rectangle((x, y), w, h, facecolor=relleno, edgecolor=borde,
                               linewidth=grosor, zorder=2))


def seccion(ax, x, y, texto, tam=T_SECCION, color=TINTA, ha='left'):
    ax.text(x, y, texto, ha=ha, va='center', fontsize=tam, fontweight='bold',
            color=color, zorder=5)


def bloque(ax, x, centro_y, ancho, parrafos, tam, color, ha='center',
           interlinea=1.42, separacion=0.6):
    """Escribe los parrafos centrados verticalmente sobre centro_y."""
    ancho_car = corte(ancho, tam)
    alto_linea = paso(tam, interlinea)
    lineas = []
    for i, parrafo in enumerate(parrafos):
        if i:
            lineas.append(None)
        lineas.extend(textwrap.wrap(parrafo, ancho_car) or [''])
    alto = sum(alto_linea if l is not None else alto_linea * separacion for l in lineas)
    y = centro_y - alto / 2 + alto_linea / 2
    for linea in lineas:
        if linea is None:
            y += alto_linea * separacion
            continue
        ax.text(x, y, linea, ha=ha, va='center', fontsize=tam, color=color, zorder=5)
        y += alto_linea


def tarjeta(ax, x, y, w, h, texto, paleta, tam=T_TARJETA):
    """Tarjeta de mensaje o de decision.

    Crece hacia arriba y hacia abajo cuando el texto no cabe en el alto de la
    plantilla, para que nunca se salga de su recuadro.
    """
    relleno, borde = TARJETA[paleta]
    lineas = textwrap.wrap(texto, corte(w - 24, tam))
    alto = max(h, len(lineas) * paso(tam) + 22)
    centro = y + h / 2
    caja(ax, x, centro - alto / 2, w, alto, relleno=relleno, borde=borde,
         grosor=1.6, rr=6)
    bloque(ax, x + w / 2, centro, w - 24, [texto], tam, '#1F2933')


def tarjeta_termino(ax, x, y, w, h, termino, definicion, tam=T_TARJETA):
    """Tarjeta del lenguaje ubicuo: el termino en negrita y debajo su definicion."""
    caja(ax, x, y, w, h, relleno='white', borde='#B9BEC4', grosor=1.4, rr=6)
    alto_linea = paso(tam)
    lineas_t = textwrap.wrap(termino, corte(w - 28, tam))
    lineas_d = textwrap.wrap(definicion, corte(w - 28, tam))
    alto = alto_linea * (len(lineas_t) + len(lineas_d))
    yy = y + h / 2 - alto / 2 + alto_linea / 2
    for linea in lineas_t:
        ax.text(x + 14, yy, linea, ha='left', va='center', fontsize=tam,
                fontweight='bold', color='#1F2933', zorder=5)
        yy += alto_linea
    for linea in lineas_d:
        ax.text(x + 14, yy, linea, ha='left', va='center', fontsize=tam,
                color='#1F2933', zorder=5)
        yy += alto_linea


def geometria_filas(n):
    """Donde empieza cada fila de colaboradores y cuanto mide su tarjeta."""
    return (520, 200, 78) if n >= 5 else (560, 240, 88)


def columna_entrante(ax, filas):
    inicio, salto, alto = geometria_filas(len(filas))
    for i, (tipo, etiqueta, mensaje, paleta) in enumerate(filas):
        y = inicio + i * salto
        icono(ax, tipo, 70, y)
        bloque(ax, 180, y + 33, 350, [etiqueta], T_TEXTO, TINTA, ha='left')
        tarjeta(ax, 540, y - 5, 210, alto, mensaje, paleta)


def columna_saliente(ax, filas):
    inicio, salto, alto = geometria_filas(len(filas))
    for i, (mensaje, tipo, etiqueta) in enumerate(filas):
        y = inicio + i * salto
        tarjeta(ax, 1760, y - 5, 210, alto, mensaje, 'ambar')
        icono(ax, tipo, 2290, y)
        bloque(ax, 2395, y + 33, 180, [etiqueta], T_TEXTO, TINTA, ha='left')


def panel_colaboradores(ax):
    caja(ax, 2700, 150, 580, 830, relleno='white', borde=TINTA, grosor=1.6, rr=14)
    seccion(ax, 2990, 200, 'Collaborator Types', tam=T_PANEL_TITULO, ha='center')
    for tipo, etiqueta, y in (('bc', 'Bounded Context', 303),
                              ('sistema', 'External System', 413),
                              ('actor', 'Actor / User Persona', 523),
                              ('frontend', 'Frontend', 633)):
        icono(ax, tipo, 2760, y - 35, 96, 70)
        ax.text(2900, y, etiqueta, ha='left', va='center', fontsize=T_PANEL,
                color=TINTA, zorder=5)
    seccion(ax, 2990, 727, 'Other', tam=T_PANEL, ha='center')
    caja(ax, 2776, 762, 64, 80, relleno=TINTA, borde=TINTA, grosor=1.4, rr=8)
    ax.text(2808, 802, '?', ha='center', va='center', fontsize=T_PANEL_TITULO + 3,
            fontweight='bold', color='white', zorder=5)
    ax.text(2900, 802, 'Relationship Type', ha='left', va='center', fontsize=T_PANEL,
            color=TINTA, zorder=5)


# --------------------------------------------------------------------------
# El lienzo completo
# --------------------------------------------------------------------------

def dibujar(c):
    fig = plt.figure(figsize=(FIG_ANCHO, FIG_ANCHO * ALTO / ANCHO), dpi=170)
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_xlim(0, ANCHO)
    ax.set_ylim(ALTO, 0)          # el eje y crece hacia abajo, como en Miro
    ax.set_aspect('equal')
    ax.axis('off')

    # Fila 1: nombre del bounded context
    caja(ax, 20, 20, 1700, 100, grosor=3)
    seccion(ax, 55, 70, f"Name: Bounded Context - {c['nombre']}", tam=T_NOMBRE)
    caja(ax, 1720, 20, 860, 100, relleno='#EDEDED', grosor=3)

    # Fila 2: proposito, clasificacion estrategica y roles de dominio
    caja(ax, 20, 120, 1180, 270, grosor=3)
    seccion(ax, 50, 159, 'Purpose')
    bloque(ax, 610, 285, 1100, [c['proposito']], T_ETIQUETA, TENUE)

    caja(ax, 1200, 120, 900, 270, grosor=3)
    seccion(ax, 1230, 159, 'Strategic Classification')
    for x, etiqueta, valor in ((1230, 'Domain', c['dominio']),
                               (1540, 'Business Model', c['negocio']),
                               (1860, 'Evolution', c['evolucion'])):
        seccion(ax, x, 213, etiqueta, tam=T_COLUMNA, color=TENUE)
        ax.text(x, 251, f'- {valor}', ha='left', va='center', fontsize=T_TEXTO,
                color=CUERPO, zorder=5)

    caja(ax, 2100, 120, 480, 270, grosor=3)
    seccion(ax, 2130, 159, 'Domain Roles')
    seccion(ax, 2130, 213, 'Role Types', tam=T_COLUMNA, color=TENUE)
    y = 251
    for rol in c['roles']:
        ax.text(2130, y, f'- {rol}', ha='left', va='center', fontsize=T_TEXTO,
                color=CUERPO, zorder=5)
        y += paso(T_TEXTO)

    # Fila 3: comunicacion entrante, lenguaje y decisiones, comunicacion saliente
    caja(ax, 20, 390, 860, 1120, grosor=3)
    seccion(ax, 50, 431, 'Inbound Communication')
    seccion(ax, 70, 480, 'Collaborator', tam=T_COLUMNA, color=COLUMNA)
    seccion(ax, 560, 480, 'Messages', tam=T_COLUMNA, color=COLUMNA)
    columna_entrante(ax, c['entrante'])

    caja(ax, 900, 410, 800, 470, grosor=3)
    seccion(ax, 1300, 449, 'Ubiquitous Language', ha='center')
    seccion(ax, 1300, 489, 'Context-specific domain terminology',
            tam=T_TEXTO, color=TENUE, ha='center')
    for i, (termino, definicion) in enumerate(c['lenguaje']):
        tarjeta_termino(ax, 940 + (i % 2) * 380, 520 + (i // 2) * 180, 360, 160,
                        termino, definicion)

    seccion(ax, 1300, 939, 'Business Decisions', ha='center')
    seccion(ax, 1300, 979, 'Key business rules, policies, and decisions',
            tam=T_TEXTO, color=TENUE, ha='center')
    if len(c['decisiones']) >= 5:
        sitios = [(915, 1010), (1180, 1010), (1445, 1010), (1047, 1190), (1312, 1190)]
        ancho_d = 250
    else:
        sitios = [(940, 1010), (1320, 1010), (940, 1190), (1320, 1190)]
        ancho_d = 360
    for (x, y), texto in zip(sitios, c['decisiones']):
        tarjeta(ax, x, y, ancho_d, 160, texto, 'morado')

    caja(ax, 1720, 390, 860, 1120, grosor=3)
    seccion(ax, 1750, 431, 'Outbound Communication')
    seccion(ax, 1770, 480, 'Messages', tam=T_COLUMNA, color=COLUMNA)
    seccion(ax, 2290, 480, 'Collaborator', tam=T_COLUMNA, color=COLUMNA)
    columna_saliente(ax, c['saliente'])

    # Fila 4: supuestos, metricas y preguntas abiertas
    caja(ax, 20, 1510, 1180, 390, grosor=3)
    seccion(ax, 50, 1549, 'Assumptions')
    bloque(ax, 610, 1735, 1060, [f'· {s}' for s in c['supuestos']], T_TEXTO, CUERPO)

    caja(ax, 1200, 1510, 900, 390, grosor=3)
    seccion(ax, 1230, 1549, 'Verification Metrics')
    bloque(ax, 1650, 1735, 820, [f'· {m}' for m in c['metricas']], T_TEXTO, CUERPO)

    caja(ax, 2100, 1510, 480, 390, grosor=3)
    seccion(ax, 2130, 1549, 'Open Questions')
    bloque(ax, 2340, 1735, 420, c['preguntas'], T_PREGUNTA, TENUE, separacion=0.75)

    panel_colaboradores(ax)

    SALIDA.mkdir(parents=True, exist_ok=True)
    destino = SALIDA / c['archivo']
    fig.savefig(destino, facecolor='white')
    plt.close(fig)
    print(f'escrito {destino.name}')


CANVASES = [
    {
        'archivo': 'bcc_contributions.png',
        'nombre': 'Contributions',
        'proposito': 'Registrar y validar los aportes de cada período contra lo '
                     'esperado, mantener el estado del pozo visible para todo el '
                     'grupo y registrar la entrega, las coberturas y el cierre del ciclo.',
        'dominio': 'core',
        'negocio': 'engagement',
        'evolucion': 'custom built',
        'roles': ['execution context', 'analysis context', 'engagement context'],
        'entrante': [
            ('bc', 'BC Savings Groups', 'Reglas de la junta y turnos', 'verde'),
            ('bc', 'BC Identity & Access', 'Identidad del integrante', 'verde'),
            ('sistema', 'ML Kit Text Recognition', 'Lectura del comprobante', 'azul'),
            ('sistema', 'Aplicación móvil', 'Registrar aporte y confirmar datos', 'azul'),
            ('frontend', 'Frontend', 'Consultar estado del pozo', 'azul'),
        ],
        'lenguaje': [
            ('Aporte', 'Pago que un integrante hace en el período, respaldado por un comprobante.'),
            ('Pozo', 'Suma de los aportes del período que recibe el integrante del turno.'),
            ('Fecha de corte', 'Límite acordado para que el aporte del período se considere a tiempo.'),
            ('Cobertura', 'Aporte que un integrante paga por otro para completar el pozo.'),
        ],
        'decisiones': [
            'Un aporte es válido si coinciden monto, fecha, destinatario y n.º de operación.',
            'Un comprobante se usa una sola vez en toda la junta.',
            'Solo la cabeza resuelve inconsistencias y registra efectivo o coberturas.',
            'El pozo está completo cuando todos los aportes esperados están validados o cubiertos.',
            'La entrega del pozo abre el siguiente período; tras el último turno la junta se cierra.',
        ],
        'saliente': [
            ('Aporte validado', 'bc', 'BC Compliance History'),
            ('Pozo completo y pozo entregado', 'bc', 'BC Notifications'),
            ('Estado del pozo mostrado', 'frontend', 'Frontend'),
            ('Consultar reglas y turnos', 'bc', 'BC Savings Groups'),
        ],
        'supuestos': [
            'Las capturas de Yape y Plin tienen un formato estable que ML Kit lee con acierto suficiente.',
            'La transferencia ocurre fuera de Pozzo; la aplicación solo registra y valida la evidencia.',
            'La cabeza acepta revisar las pocas inconsistencias que la validación no resuelve.',
            'El integrante tiene el comprobante a mano al registrar el aporte.',
        ],
        'metricas': [
            'Aportes validados sin revisión de la cabeza (meta 80 %)',
            'Tiempo entre la transferencia y la validación del aporte',
            'Períodos con pozo completo antes de la fecha de corte',
            'Discrepancias resueltas en la aplicación frente a las resueltas por WhatsApp',
        ],
        'preguntas': [
            '¿Cómo tratar comprobantes de bancos distintos a Yape y Plin?',
            '¿Cuántos días de gracia antes de marcar la morosidad?',
            '¿La cobertura la registra solo la cabeza o también quien cubre?',
            '¿Se guarda la imagen del comprobante o solo los datos leídos?',
        ],
    },
    {
        'archivo': 'bcc_savings_groups.png',
        'nombre': 'Savings Groups',
        'proposito': 'Crear y configurar la junta con sus reglas, incorporar y '
                     'administrar a los integrantes, asignar los turnos por sorteo, '
                     'orden acordado o subasta, e iniciar el ciclo.',
        'dominio': 'supporting',
        'negocio': 'adopción',
        'evolucion': 'custom built',
        'roles': ['specification context', 'gateway context'],
        'entrante': [
            ('bc', 'BC Identity & Access', 'Identidad del integrante', 'verde'),
            ('bc', 'BC Compliance History', 'Historial de quien se une', 'verde'),
            ('sistema', 'Aplicación móvil', 'Crear junta y definir reglas', 'azul'),
            ('sistema', 'Aplicación móvil', 'Unirse con código o enlace', 'azul'),
            ('frontend', 'Frontend', 'Consultar calendario de turnos', 'azul'),
        ],
        'lenguaje': [
            ('Junta', 'Grupo cerrado que acuerda un aporte, una periodicidad y un orden de cobro.'),
            ('Turno', 'Período en el que a un integrante le toca recibir el pozo.'),
            ('Subasta', 'Mecanismo por el que un integrante ofrece un descuento para adelantar su turno.'),
            ('Invitación', 'Código y enlace con los que un participante entra a la junta.'),
        ],
        'decisiones': [
            'Una junta se inicia solo con todos los cupos cubiertos y los turnos asignados.',
            'Al iniciar, las reglas quedan bloqueadas y el código de invitación caduca.',
            'A quien no usa la aplicación lo registra la cabeza, que también registra sus aportes.',
            'En la subasta gana la oferta mayor; el empate lo resuelve la cabeza.',
            'Un reemplazo hereda el turno pendiente del integrante que desertó.',
        ],
        'saliente': [
            ('Junta iniciada', 'bc', 'BC Contributions'),
            ('Turnos asignados', 'bc', 'BC Notifications'),
            ('Integrante desertó', 'bc', 'BC Compliance History'),
            ('Invitación generada', 'sistema', 'WhatsApp'),
        ],
        'supuestos': [
            'Las juntas son de conocidos, entre 5 y 15 integrantes.',
            'El enlace de invitación se comparte por WhatsApp y abre la aplicación directamente.',
            'La cabeza define las reglas antes de invitar y rara vez las cambia después.',
        ],
        'metricas': [
            'Juntas iniciadas sobre juntas creadas',
            'Tiempo entre la creación y el inicio de la junta',
            'Integrantes incorporados por enlace frente a registro manual',
            'Juntas que usan subasta frente a sorteo u orden acordado',
        ],
        'preguntas': [
            '¿Se permite cambiar la cabeza de junta durante el ciclo?',
            '¿Puede una persona ocupar dos cupos en la misma junta?',
            '¿Cómo se verifica ante el grupo que el sorteo fue justo?',
        ],
    },
    {
        'archivo': 'bcc_compliance_history.png',
        'nombre': 'Compliance History',
        'proposito': 'Consolidar el comportamiento de pago de cada integrante a lo '
                     'largo de todas sus juntas y ofrecerlo de forma verificable a la '
                     'cabeza que lo incorpora y a quien decida compartirlo.',
        'dominio': 'supporting',
        'negocio': 'retención',
        'evolucion': 'custom built',
        'roles': ['analysis context'],
        'entrante': [
            ('bc', 'BC Contributions', 'Aporte validado, rechazado o cubierto', 'verde'),
            ('bc', 'BC Savings Groups', 'Integrante desertó y ciclo cerrado', 'verde'),
            ('sistema', 'Aplicación móvil', 'Compartir mi historial', 'azul'),
            ('frontend', 'Frontend', 'Consultar mi historial de cumplimiento', 'azul'),
        ],
        'lenguaje': [
            ('Historial de cumplimiento',
             'Resumen del comportamiento de pago de un integrante en todas sus juntas.'),
            ('Aporte puntual', 'Aporte validado antes de la fecha de corte del período.'),
            ('Aporte tardío', 'Aporte validado después de la fecha de corte del período.'),
            ('Enlace verificable', 'Dirección temporal con la que un tercero comprueba el historial.'),
        ],
        'decisiones': [
            'El historial se compone solo de hechos registrados en Pozzo; no admite carga manual.',
            'Se muestra agregado: puntuales, tardíos, cubiertos, deserciones y juntas completadas.',
            'Compartir genera un enlace con vigencia limitada que cualquiera puede verificar.',
            'La cabeza ve el historial de quien se une solo mientras la junta no ha iniciado.',
        ],
        'saliente': [
            ('Historial actualizado', 'bc', 'BC Savings Groups'),
            ('Historial compartido', 'sistema', 'Hoja de compartir del sistema'),
            ('Resumen del historial mostrado', 'frontend', 'Frontend'),
        ],
        'supuestos': [
            'Un historial visible para el grupo incentiva el cumplimiento.',
            'Los integrantes aceptan que su comportamiento de pago sea visible para la cabeza '
            'de las juntas a las que se unen.',
            'Los hechos registrados en Pozzo bastan para describir el comportamiento de pago.',
        ],
        'metricas': [
            'Cabezas que consultan el historial de un integrante antes de iniciar',
            'Participantes que comparten su historial al menos una vez',
            'Diferencia de morosidad entre integrantes con historial y sin historial',
        ],
        'preguntas': [
            '¿Cómo tratar los aportes que la cabeza registra por integrantes sin la aplicación?',
            '¿Prescriben las deserciones antiguas?',
            '¿Hace falta una puntuación numérica o basta el resumen?',
        ],
    },
    {
        'archivo': 'bcc_notifications.png',
        'nombre': 'Notifications',
        'proposito': 'Recordar de forma escalonada a quien no ha aportado antes de la '
                     'fecha de corte y avisar a los integrantes de los hechos relevantes '
                     'de la junta, para que la cabeza no tenga que cobrar por WhatsApp.',
        'dominio': 'generic',
        'negocio': 'engagement',
        'evolucion': 'product',
        'roles': ['execution context', 'gateway context'],
        'entrante': [
            ('bc', 'BC Contributions', 'Aporte validado y pozo completo', 'verde'),
            ('bc', 'BC Savings Groups', 'Junta iniciada y turnos asignados', 'verde'),
            ('bc', 'BC Identity & Access', 'Sesión iniciada', 'verde'),
            ('sistema', 'Aplicación móvil',
             'Registrar dispositivo y configurar recordatorios', 'azul'),
        ],
        'lenguaje': [
            ('Recordatorio', 'Aviso dirigido a quien aún no ha aportado en el período en curso.'),
            ('Escalonamiento', 'Secuencia de recordatorios que se acerca a la fecha de corte.'),
            ('Aviso', 'Notificación de un hecho relevante de la junta a todos los integrantes.'),
            ('Plan de recordatorios', 'Configuración por junta de cuándo y a quién recordar.'),
        ],
        'decisiones': [
            'Recordatorios a 3 días, 1 día y el mismo día del corte, solo a quien tiene '
            'aporte pendiente.',
            'Los recordatorios de un integrante se detienen al validar su aporte.',
            'La cabeza ajusta el plan por junta, nunca por integrante.',
            'Un integrante no recibe dos avisos por el mismo hecho.',
            'Quien no usa la aplicación no recibe avisos; la cabeza lo ve como pendiente.',
        ],
        'saliente': [
            ('Recordatorio enviado', 'sistema', 'Firebase Cloud Messaging'),
            ('Aviso enviado', 'frontend', 'Frontend'),
            ('Dispositivo registrado', 'bc', 'BC Identity & Access'),
        ],
        'supuestos': [
            'El plan gratuito de Firebase Cloud Messaging cubre el volumen inicial.',
            'Los integrantes aceptan el permiso de notificaciones en Android 13 o superior.',
            'Un recordatorio automático se percibe menos incómodo que el mensaje de la cabeza.',
        ],
        'metricas': [
            'Aportes registrados dentro de las 24 horas posteriores a un recordatorio',
            'Tasa de entrega de las notificaciones push',
            'Recordatorios manuales por WhatsApp que la cabeza sigue enviando',
        ],
        'preguntas': [
            '¿Recordatorio por SMS o WhatsApp a integrantes sin la aplicación?',
            '¿En qué horario se envían los recordatorios?',
            '¿Programador de tareas en el servidor o cola con retardo?',
        ],
    },
    {
        'archivo': 'bcc_identity_access.png',
        'nombre': 'Identity & Access',
        'proposito': 'Identificar a cada integrante por su número de celular, verificado '
                     'con un código SMS y sin contraseña, mantener su sesión en el '
                     'dispositivo y administrar su perfil.',
        'dominio': 'generic',
        'negocio': 'cost reduction',
        'evolucion': 'commodity',
        'roles': ['gateway context', 'identity provider'],
        'entrante': [
            ('sistema', 'Aplicación móvil', 'Solicitar y verificar código SMS', 'azul'),
            ('sistema', 'Aplicación móvil', 'Completar registro e iniciar sesión', 'azul'),
            ('bc', 'BC Contributions', 'Validar token de sesión', 'verde'),
            ('bc', 'BC Savings Groups', 'Validar token de sesión', 'verde'),
            ('frontend', 'Frontend', 'Administrar perfil y tema visual', 'azul'),
        ],
        'lenguaje': [
            ('Cuenta', 'Identidad de un integrante en Pozzo, ligada a un número de celular.'),
            ('Código SMS', 'Clave de un solo uso que comprueba que el celular es del integrante.'),
            ('Sesión', 'Permanencia del integrante en el dispositivo hasta que la cierra.'),
            ('Token', 'Credencial que autoriza cada solicitud a los servicios de Pozzo.'),
        ],
        'decisiones': [
            'Un número de celular corresponde a una sola cuenta.',
            'El código tiene 6 dígitos, vence a los 5 minutos y admite 3 intentos.',
            'La sesión persiste en el dispositivo hasta que el integrante la cierra.',
            'Los términos y la política de privacidad se aceptan al completar el registro.',
            'El perfil muestra nombre y foto; el número solo se expone dentro de la junta.',
        ],
        'saliente': [
            ('Enviar código al celular', 'sistema', 'Proveedor de SMS'),
            ('Sesión iniciada', 'bc', 'BC Notifications'),
            ('Identidad del integrante', 'bc', 'BC Savings Groups'),
            ('Perfil mostrado', 'frontend', 'Frontend'),
        ],
        'supuestos': [
            'Todos los integrantes tienen un número peruano que recibe SMS.',
            'El costo por SMS es aceptable para el volumen del primer año.',
            'Ingresar sin contraseña reduce el abandono en el registro.',
        ],
        'metricas': [
            'Verificaciones exitosas al primer intento',
            'Tiempo desde solicitar el código hasta completar el registro',
            'Costo por cuenta creada',
        ],
        'preguntas': [
            '¿Cómo recupera su cuenta un integrante que cambia de número?',
            '¿Verificación por WhatsApp como alternativa al SMS?',
            '¿Qué proveedor de SMS: Twilio, Firebase Authentication u otro?',
        ],
    },
]


def main():
    for canvas in CANVASES:
        dibujar(canvas)


if __name__ == '__main__':
    main()
