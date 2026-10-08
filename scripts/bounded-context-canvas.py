#!/usr/bin/env python3
"""Dibuja los Bounded Context Canvas de Pozzo con la plantilla oficial v5.

La plantilla de DDD Crew (github.com/ddd-crew/bounded-context-canvas) no es solo
una cuadricula de texto: cada colaborador se dibuja con el icono que le toca
-nube para un bounded context, engranaje para un sistema externo, silueta para
un actor y documento para el frontend- y al costado va el panel Collaborator
Types que explica esos iconos. El lenguaje ubicuo y las decisiones de negocio
van en tarjetas, no en parrafos.

    python scripts/bounded-context-canvas.py

La salida son docs/images/chapter_2/bcc_<contexto>.png.
"""
import math
import textwrap
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, FancyBboxPatch, Polygon, Rectangle

SALIDA = Path(__file__).resolve().parent.parent / 'docs/images/chapter_2'

TINTA, CUERPO, TENUE = '#1A1A1A', '#3A4149', '#7A7A7A'
NUBE, NUBE_BORDE = '#E4DCF7', '#6B4FBB'
ROJO = '#C0392B'
TARJETA = {
    'verde': ('#E6F2CF', '#9CC46A'),
    'azul': ('#D6E8FB', '#6BA4DE'),
    'ambar': ('#FBF0C9', '#D6B94A'),
    'morado': ('#E4DCF7', '#8F7FC4'),
}

# El lienzo usa unidades propias para que los iconos salgan redondos.
ANCHO, ALTO = 2000, 1150


# --------------------------------------------------------------------------
# Iconos de la plantilla
# --------------------------------------------------------------------------

def engranaje(ax, cx, cy, r, color=TINTA):
    """Engranaje de ocho dientes: el icono de sistema externo."""
    dientes, r_raiz, r_hueco = 8, r * 0.70, r * 0.36
    paso, medio_diente, media_raiz = 360 / dientes, 11, 20
    puntos = []
    for i in range(dientes):
        a = i * paso
        for radio, angulo in ((r_raiz, a - media_raiz), (r, a - medio_diente),
                              (r, a + medio_diente), (r_raiz, a + media_raiz)):
            rad = math.radians(angulo)
            puntos.append((cx + radio * math.cos(rad), cy + radio * math.sin(rad)))
    ax.add_patch(Polygon(puntos, closed=True, facecolor=color, edgecolor='none', zorder=3))
    ax.add_patch(Circle((cx, cy), r_hueco, facecolor='white', edgecolor='none', zorder=4))


def persona(ax, cx, cy, r, color=TINTA):
    """Silueta: el icono de actor."""
    ax.add_patch(Circle((cx, cy + r * 0.46), r * 0.38, facecolor=color,
                        edgecolor='none', zorder=3))
    hombros = [(cx - r * 0.80, cy - r)]
    for i in range(41):
        t = math.pi * i / 40
        hombros.append((cx - r * 0.74 * math.cos(t), cy - r + r * 0.90 * math.sin(t)))
    hombros.append((cx + r * 0.80, cy - r))
    ax.add_patch(Polygon(hombros, closed=True, facecolor=color, edgecolor='none', zorder=3))


def nube(ax, cx, cy, w, h):
    """Nube: el icono de bounded context."""
    base = max(w, h)
    for dx, dy, rr in ((-0.30, -0.06, 0.30), (-0.06, 0.16, 0.36),
                       (0.26, 0.00, 0.29), (0.10, -0.18, 0.28), (-0.20, -0.20, 0.26)):
        ax.add_patch(Circle((cx + dx * w, cy + dy * h), rr * base * 0.62,
                            facecolor=NUBE, edgecolor=NUBE_BORDE, linewidth=1.2, zorder=3))


def frontend(ax, cx, cy, w, h):
    """Documento: el icono de frontend."""
    x, y, pliegue = cx - w / 2, cy - h / 2, w * 0.32
    ax.add_patch(Polygon([(x, y), (x, y + h), (x + w - pliegue, y + h),
                          (x + w, y + h - pliegue), (x + w, y)], closed=True,
                         facecolor='white', edgecolor=ROJO, linewidth=2.0, zorder=3))
    ax.plot([x + w - pliegue, x + w - pliegue, x + w],
            [y + h, y + h - pliegue, y + h - pliegue], color=ROJO, linewidth=2.0, zorder=4)
    for i, frac in enumerate((0.28, 0.45, 0.62)):
        largo = w * (0.46 if i == 2 else 0.62)
        ax.plot([x + w * 0.18, x + w * 0.18 + largo], [y + h * frac] * 2,
                color=ROJO, linewidth=2.0, solid_capstyle='round', zorder=4)


def relacion(ax, cx, cy, w, h):
    """Caja oscura con un signo de interrogacion: Relationship Type."""
    ax.add_patch(FancyBboxPatch((cx - w / 2 + 6, cy - h / 2 + 6), w - 12, h - 12,
                                boxstyle='round,pad=6', facecolor=TINTA,
                                edgecolor=TINTA, zorder=3))
    ax.text(cx, cy, '?', ha='center', va='center', fontsize=19,
            fontweight='bold', color='white', zorder=4)


def icono(ax, tipo, cx, cy, lado):
    if tipo == 'nube':
        nube(ax, cx, cy, lado * 1.22, lado * 0.88)
    elif tipo == 'frontend':
        frontend(ax, cx, cy, lado * 0.70, lado)
    elif tipo == 'persona':
        persona(ax, cx, cy, lado / 2)
    else:
        engranaje(ax, cx, cy, lado / 2)


# --------------------------------------------------------------------------
# Piezas de dibujo
# --------------------------------------------------------------------------

def caja(ax, x, y, w, h, borde=TINTA, grosor=2.2, relleno='white', radio=0):
    if radio:
        ax.add_patch(FancyBboxPatch((x + radio, y + radio), w - 2 * radio, h - 2 * radio,
                                    boxstyle=f'round,pad={radio}', facecolor=relleno,
                                    edgecolor=borde, linewidth=grosor, zorder=2))
    else:
        ax.add_patch(Rectangle((x, y), w, h, facecolor=relleno, edgecolor=borde,
                               linewidth=grosor, zorder=2))


def titulo(ax, x, y, texto, tam=14):
    ax.text(x, y, texto, ha='left', va='top', fontsize=tam,
            fontweight='bold', color=TINTA, zorder=5)


def tarjeta(ax, x, y, w, h, texto, paleta, tam=8.0, ancho_car=32):
    relleno, borde = TARJETA[paleta]
    caja(ax, x, y, w, h, borde=borde, grosor=1.3, relleno=relleno, radio=5)
    ax.text(x + w / 2, y + h / 2, '\n'.join(textwrap.wrap(texto, ancho_car)),
            ha='center', va='center', fontsize=tam, color='#1F2933',
            linespacing=1.4, zorder=5)


def tarjeta_definicion(ax, x, y, w, h, termino, definicion, tam=6.8, ancho_car=31):
    caja(ax, x, y, w, h, borde='#B9BEC4', grosor=1.3, relleno='white', radio=5)
    ax.text(x + 11, y + h - 11, '\n'.join(textwrap.wrap(termino, 24)), ha='left',
            va='top', fontsize=tam + 0.9, fontweight='bold', color='#1F2933',
            linespacing=1.3, zorder=5)
    desplazo = 29 if len(termino) <= 24 else 46
    ax.text(x + 11, y + h - desplazo, '\n'.join(textwrap.wrap(definicion, ancho_car)),
            ha='left', va='top', fontsize=tam, color='#1F2933', linespacing=1.35, zorder=5)


def vinetas(ax, x, y, w, h, lineas, tam=8.0, color=CUERPO, ancho_car=78, interlinea=1.7):
    cuerpo = []
    for linea in lineas:
        envuelto = textwrap.wrap(linea, ancho_car) or ['']
        cuerpo.append('· ' + envuelto[0])
        cuerpo += ['   ' + resto for resto in envuelto[1:]]
    ax.text(x + w / 2, y + h / 2, '\n'.join(cuerpo), ha='center', va='center',
            fontsize=tam, color=color, linespacing=interlinea, zorder=5)


def columna_comunicacion(ax, x, filas, entrante):
    """Dibuja las filas colaborador / mensaje de una columna de comunicacion."""
    alto_fila = min(104, 450 / max(len(filas), 1))
    centro = 800 - alto_fila / 2
    for fila in filas:
        if entrante:
            tipo, etiqueta, mensaje, paleta = fila
            x_icono, x_texto, x_tarjeta = x + 62, x + 104, x + 292
        else:
            mensaje, tipo, etiqueta = fila
            paleta = 'ambar'
            x_icono, x_texto, x_tarjeta = x + 296, x + 338, x + 22
        icono(ax, tipo, x_icono, centro, 52)
        ax.text(x_texto, centro, '\n'.join(textwrap.wrap(etiqueta, 17)),
                ha='left', va='center', fontsize=8.4, color=TINTA, zorder=5)
        tarjeta(ax, x_tarjeta, centro - 37, 196, 74, mensaje, paleta, tam=7.6, ancho_car=26)
        centro -= alto_fila


def rejilla_decisiones(ax, x, w, tarjetas):
    """Coloca las decisiones de negocio en dos filas centradas."""
    for grupo, y in ((tarjetas[:3], 418), (tarjetas[3:], 306)):
        if not grupo:
            continue
        ancho, hueco = 146, 8
        total = len(grupo) * ancho + (len(grupo) - 1) * hueco
        inicio = x + (w - total) / 2
        for i, texto in enumerate(grupo):
            tarjeta(ax, inicio + i * (ancho + hueco), y, ancho, 104,
                    texto, 'morado', tam=6.4, ancho_car=24)


def panel_colaboradores(ax, x, y, w, h):
    caja(ax, x, y, w, h, borde=TINTA, grosor=2.0, relleno='white', radio=12)
    ax.text(x + w / 2, y + h - 36, 'Collaborator Types', ha='center', va='center',
            fontsize=13.5, fontweight='bold', color=TINTA, zorder=5)
    entradas = [('nube', 'Bounded Context'), ('engranaje', 'External System'),
                ('persona', 'Actor / User Persona'), ('frontend', 'Frontend')]
    cy = y + h - 104
    for tipo, etiqueta in entradas:
        icono(ax, tipo, x + 78, cy, 56)
        ax.text(x + 158, cy, etiqueta, ha='left', va='center', fontsize=10.5,
                color=TINTA, zorder=5)
        cy -= 80
    ax.text(x + w / 2, cy + 4, 'Other', ha='center', va='center', fontsize=10.5,
            fontweight='bold', color=TINTA, zorder=5)
    cy -= 54
    relacion(ax, x + 78, cy, 50, 62)
    ax.text(x + 160, cy, 'Relationship Type', ha='left', va='center', fontsize=10.5,
            color=TINTA, zorder=5)


# --------------------------------------------------------------------------
# Datos de los cinco contextos
# --------------------------------------------------------------------------

CANVASES = [
    dict(
        archivo='bcc_contributions.png', nombre='Contributions',
        proposito='Registrar y validar los aportes de cada período contra lo esperado, mantener el '
                  'estado del pozo visible para todo el grupo y registrar la entrega, las coberturas '
                  'y el cierre del ciclo.',
        dominio='core', negocio='engagement', evolucion='custom built',
        roles=['execution context', 'analysis context', 'engagement context'],
        entrante=[
            ('nube', 'BC Savings Groups', 'Reglas de la junta y turnos', 'verde'),
            ('nube', 'BC Identity & Access', 'Identidad del integrante', 'verde'),
            ('engranaje', 'ML Kit Text Recognition', 'Lectura del comprobante', 'azul'),
            ('engranaje', 'Aplicación móvil', 'Registrar aporte y confirmar datos', 'azul'),
            ('frontend', 'Frontend', 'Consultar estado del pozo', 'azul')],
        lenguaje=[
            ('Aporte', 'Pago que un integrante hace en el período, respaldado por un comprobante.'),
            ('Pozo', 'Suma de los aportes del período que recibe el integrante del turno.'),
            ('Fecha de corte', 'Límite acordado para que el aporte del período se considere a tiempo.'),
            ('Cobertura', 'Aporte que un integrante paga por otro para completar el pozo.')],
        decisiones=[
            'Un aporte es válido si coinciden monto, fecha, destinatario y n.º de operación.',
            'Un comprobante se usa una sola vez en toda la junta.',
            'Solo la cabeza resuelve inconsistencias y registra efectivo o coberturas.',
            'El pozo está completo cuando todos los aportes esperados están validados o cubiertos.',
            'La entrega del pozo abre el siguiente período; tras el último turno la junta se cierra.'],
        saliente=[
            ('Aporte validado', 'nube', 'BC Compliance History'),
            ('Pozo completo y pozo entregado', 'nube', 'BC Notifications'),
            ('Base de datos actualizada', 'engranaje', 'MySQL'),
            ('Estado del pozo mostrado', 'frontend', 'Frontend'),
            ('Consultar reglas y turnos', 'nube', 'BC Savings Groups')],
        supuestos=[
            'Las capturas de Yape y Plin tienen un formato estable que ML Kit lee con acierto suficiente.',
            'La transferencia ocurre fuera de Pozzo; la aplicación solo registra y valida la evidencia.',
            'La cabeza acepta revisar las pocas inconsistencias que la validación no resuelve.',
            'El integrante tiene el comprobante a mano al registrar el aporte.'],
        metricas=[
            'Aportes validados sin revisión de la cabeza (meta 80 %)',
            'Tiempo entre la transferencia y la validación del aporte',
            'Períodos con pozo completo antes de la fecha de corte',
            'Discrepancias resueltas en la aplicación frente a las resueltas por WhatsApp'],
        preguntas=[
            '¿Cómo tratar comprobantes de bancos distintos a Yape y Plin?',
            '¿Cuántos días de gracia antes de marcar la morosidad?',
            '¿La cobertura la registra solo la cabeza o también quien cubre?',
            '¿Se guarda la imagen del comprobante o solo los datos leídos?']),

    dict(
        archivo='bcc_savings_groups.png', nombre='Savings Groups',
        proposito='Crear y configurar la junta con sus reglas, incorporar y administrar a los '
                  'integrantes, asignar los turnos por sorteo, orden acordado o subasta, e iniciar '
                  'el ciclo.',
        dominio='supporting', negocio='adopción', evolucion='custom built',
        roles=['specification context', 'gateway context'],
        entrante=[
            ('nube', 'BC Identity & Access', 'Identidad del integrante', 'verde'),
            ('nube', 'BC Compliance History', 'Historial de quien se une', 'verde'),
            ('engranaje', 'Aplicación móvil', 'Crear junta y definir reglas', 'azul'),
            ('engranaje', 'Aplicación móvil', 'Unirse con código o enlace', 'azul'),
            ('frontend', 'Frontend', 'Consultar calendario de turnos', 'azul')],
        lenguaje=[
            ('Junta', 'Grupo cerrado que acuerda un aporte, una periodicidad y un orden de cobro.'),
            ('Turno', 'Período en el que a un integrante le toca recibir el pozo.'),
            ('Subasta', 'Mecanismo por el que un integrante ofrece un descuento para adelantar su turno.'),
            ('Invitación', 'Código y enlace con los que un participante entra a la junta.')],
        decisiones=[
            'Una junta se inicia solo con todos los cupos cubiertos y los turnos asignados.',
            'Al iniciar, las reglas quedan bloqueadas y el código de invitación caduca.',
            'A quien no usa la aplicación lo registra la cabeza, que también registra sus aportes.',
            'En la subasta gana la oferta mayor; el empate lo resuelve la cabeza.',
            'Un reemplazo hereda el turno pendiente del integrante que desertó.'],
        saliente=[
            ('Junta iniciada', 'nube', 'BC Contributions'),
            ('Turnos asignados', 'nube', 'BC Notifications'),
            ('Integrante desertó', 'nube', 'BC Compliance History'),
            ('Invitación generada', 'engranaje', 'WhatsApp'),
            ('Base de datos actualizada', 'engranaje', 'MySQL')],
        supuestos=[
            'Las juntas son de conocidos, entre 5 y 15 integrantes.',
            'El enlace de invitación se comparte por WhatsApp y abre la aplicación directamente.',
            'La cabeza define las reglas antes de invitar y rara vez las cambia después.'],
        metricas=[
            'Juntas iniciadas sobre juntas creadas',
            'Tiempo entre la creación y el inicio de la junta',
            'Integrantes incorporados por enlace frente a registro manual',
            'Juntas que usan subasta frente a sorteo u orden acordado'],
        preguntas=[
            '¿Se permite cambiar la cabeza de junta durante el ciclo?',
            '¿Puede una persona ocupar dos cupos en la misma junta?',
            '¿Cómo se verifica ante el grupo que el sorteo fue justo?']),

    dict(
        archivo='bcc_compliance_history.png', nombre='Compliance History',
        proposito='Consolidar el comportamiento de pago de cada integrante a lo largo de todas sus '
                  'juntas y ofrecerlo de forma verificable a la cabeza que lo incorpora y a quien '
                  'decida compartirlo.',
        dominio='supporting', negocio='retención', evolucion='custom built',
        roles=['analysis context'],
        entrante=[
            ('nube', 'BC Contributions', 'Aporte validado, rechazado o cubierto', 'verde'),
            ('nube', 'BC Savings Groups', 'Integrante desertó y ciclo cerrado', 'verde'),
            ('engranaje', 'Aplicación móvil', 'Compartir mi historial', 'azul'),
            ('frontend', 'Frontend', 'Consultar mi historial de cumplimiento', 'azul')],
        lenguaje=[
            ('Historial de cumplimiento', 'Resumen del comportamiento de pago de un integrante en todas sus juntas.'),
            ('Aporte puntual', 'Aporte validado antes de la fecha de corte del período.'),
            ('Aporte tardío', 'Aporte validado después de la fecha de corte del período.'),
            ('Enlace verificable', 'Dirección temporal con la que un tercero comprueba el historial.')],
        decisiones=[
            'El historial se compone solo de hechos registrados en Pozzo; no admite carga manual.',
            'Se muestra agregado: puntuales, tardíos, cubiertos, deserciones y juntas completadas.',
            'Compartir genera un enlace con vigencia limitada que cualquiera puede verificar.',
            'La cabeza ve el historial de quien se une solo mientras la junta no ha iniciado.'],
        saliente=[
            ('Historial actualizado', 'nube', 'BC Savings Groups'),
            ('Historial compartido', 'engranaje', 'Hoja de compartir del sistema'),
            ('Resumen del historial mostrado', 'frontend', 'Frontend'),
            ('Base de datos actualizada', 'engranaje', 'MySQL')],
        supuestos=[
            'Un historial visible para el grupo incentiva el cumplimiento.',
            'Los integrantes aceptan que su comportamiento de pago sea visible para la cabeza de las juntas a las que se unen.',
            'Los hechos registrados en Pozzo bastan para describir el comportamiento de pago.'],
        metricas=[
            'Cabezas que consultan el historial de un integrante antes de iniciar',
            'Participantes que comparten su historial al menos una vez',
            'Diferencia de morosidad entre integrantes con historial y sin historial'],
        preguntas=[
            '¿Cómo tratar los aportes que la cabeza registra por integrantes sin la aplicación?',
            '¿Prescriben las deserciones antiguas?',
            '¿Hace falta una puntuación numérica o basta el resumen?']),

    dict(
        archivo='bcc_notifications.png', nombre='Notifications',
        proposito='Recordar de forma escalonada a quien no ha aportado antes de la fecha de corte y '
                  'avisar a los integrantes de los hechos relevantes de la junta, para que la cabeza '
                  'no tenga que cobrar por WhatsApp.',
        dominio='generic', negocio='engagement', evolucion='product',
        roles=['execution context', 'gateway context'],
        entrante=[
            ('nube', 'BC Contributions', 'Aporte validado y pozo completo', 'verde'),
            ('nube', 'BC Savings Groups', 'Junta iniciada y turnos asignados', 'verde'),
            ('nube', 'BC Identity & Access', 'Sesión iniciada', 'verde'),
            ('engranaje', 'Aplicación móvil', 'Registrar dispositivo y configurar recordatorios', 'azul')],
        lenguaje=[
            ('Recordatorio', 'Aviso dirigido a quien aún no ha aportado en el período en curso.'),
            ('Escalonamiento', 'Secuencia de recordatorios que se acerca a la fecha de corte.'),
            ('Aviso', 'Notificación de un hecho relevante de la junta a todos los integrantes.'),
            ('Plan de recordatorios', 'Configuración por junta de cuándo y a quién recordar.')],
        decisiones=[
            'Recordatorios a 3 días, 1 día y el mismo día del corte, solo a quien tiene aporte pendiente.',
            'Los recordatorios de un integrante se detienen al validar su aporte.',
            'La cabeza ajusta el plan por junta, nunca por integrante.',
            'Un integrante no recibe dos avisos por el mismo hecho.',
            'Quien no usa la aplicación no recibe avisos; la cabeza lo ve como pendiente.'],
        saliente=[
            ('Recordatorio enviado', 'engranaje', 'Firebase Cloud Messaging'),
            ('Aviso enviado', 'frontend', 'Frontend'),
            ('Dispositivo registrado', 'nube', 'BC Identity & Access'),
            ('Base de datos actualizada', 'engranaje', 'MySQL')],
        supuestos=[
            'El plan gratuito de Firebase Cloud Messaging cubre el volumen inicial.',
            'Los integrantes aceptan el permiso de notificaciones en Android 13 o superior.',
            'Un recordatorio automático se percibe menos incómodo que el mensaje de la cabeza.'],
        metricas=[
            'Aportes registrados dentro de las 24 horas posteriores a un recordatorio',
            'Tasa de entrega de las notificaciones push',
            'Recordatorios manuales por WhatsApp que la cabeza sigue enviando'],
        preguntas=[
            '¿Recordatorio por SMS o WhatsApp a integrantes sin la aplicación?',
            '¿En qué horario se envían los recordatorios?',
            '¿Programador de tareas en el servidor o cola con retardo?']),

    dict(
        archivo='bcc_identity_access.png', nombre='Identity & Access',
        proposito='Identificar a cada integrante por su número de celular, verificado con un código '
                  'SMS y sin contraseña, mantener su sesión en el dispositivo y administrar su perfil.',
        dominio='generic', negocio='cost reduction', evolucion='commodity',
        roles=['gateway context', 'identity provider'],
        entrante=[
            ('engranaje', 'Aplicación móvil', 'Solicitar y verificar código SMS', 'azul'),
            ('engranaje', 'Aplicación móvil', 'Completar registro e iniciar sesión', 'azul'),
            ('nube', 'BC Contributions', 'Validar token de sesión', 'verde'),
            ('nube', 'BC Savings Groups', 'Validar token de sesión', 'verde'),
            ('frontend', 'Frontend', 'Administrar perfil y tema visual', 'azul')],
        lenguaje=[
            ('Cuenta', 'Identidad de un integrante en Pozzo, ligada a un número de celular.'),
            ('Código SMS', 'Clave de un solo uso que comprueba que el celular es del integrante.'),
            ('Sesión', 'Permanencia del integrante en el dispositivo hasta que la cierra.'),
            ('Token', 'Credencial que autoriza cada solicitud a los servicios de Pozzo.')],
        decisiones=[
            'Un número de celular corresponde a una sola cuenta.',
            'El código tiene 6 dígitos, vence a los 5 minutos y admite 3 intentos.',
            'La sesión persiste en el dispositivo hasta que el integrante la cierra.',
            'Los términos y la política de privacidad se aceptan al completar el registro.',
            'El perfil muestra nombre y foto; el número solo se expone dentro de la junta.'],
        saliente=[
            ('Enviar código al celular', 'engranaje', 'Proveedor de SMS'),
            ('Sesión iniciada', 'nube', 'BC Notifications'),
            ('Identidad del integrante', 'nube', 'BC Savings Groups'),
            ('Perfil mostrado', 'frontend', 'Frontend'),
            ('Base de datos actualizada', 'engranaje', 'MySQL')],
        supuestos=[
            'Todos los integrantes tienen un número peruano que recibe SMS.',
            'El costo por SMS es aceptable para el volumen del primer año.',
            'Ingresar sin contraseña reduce el abandono en el registro.'],
        metricas=[
            'Verificaciones exitosas al primer intento',
            'Tiempo desde solicitar el código hasta completar el registro',
            'Costo por cuenta creada'],
        preguntas=[
            '¿Cómo recupera su cuenta un integrante que cambia de número?',
            '¿Verificación por WhatsApp como alternativa al SMS?',
            '¿Qué proveedor de SMS: Twilio, Firebase Authentication u otro?']),
]


# --------------------------------------------------------------------------
# Trazado del canvas
# --------------------------------------------------------------------------

def dibujar(c):
    fig = plt.figure(figsize=(16.0, 9.2), dpi=170)
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_xlim(0, ANCHO)
    ax.set_ylim(0, ALTO)
    ax.set_aspect('equal')
    ax.axis('off')

    # Fila 1: nombre
    caja(ax, 10, 1072, 1050, 68)
    ax.text(38, 1106, f"Name: Bounded Context - {c['nombre']}", ha='left', va='center',
            fontsize=16, fontweight='bold', color=TINTA, zorder=5)
    caja(ax, 1062, 1072, 458, 68, relleno='#EDEDED')

    # Fila 2: proposito, clasificacion estrategica y roles del dominio
    caja(ax, 10, 880, 710, 188)
    titulo(ax, 34, 1054, 'Purpose')
    ax.text(365, 955, '\n'.join(textwrap.wrap(c['proposito'], 62)), ha='center',
            va='center', fontsize=8.6, color=TENUE, linespacing=1.6, zorder=5)

    caja(ax, 722, 880, 546, 188)
    titulo(ax, 746, 1054, 'Strategic Classification')
    for i, (rotulo, valor) in enumerate((('Domain', c['dominio']),
                                         ('Business Model', c['negocio']),
                                         ('Evolution', c['evolucion']))):
        cx = 746 + i * 180
        ax.text(cx, 992, rotulo, ha='left', va='center', fontsize=8.6,
                fontweight='bold', color=TENUE, zorder=5)
        ax.text(cx, 962, f'- {valor}', ha='left', va='center', fontsize=8.4,
                color=CUERPO, zorder=5)

    caja(ax, 1270, 880, 250, 188)
    titulo(ax, 1294, 1054, 'Domain Roles')
    ax.text(1294, 992, 'Role Types', ha='left', va='center', fontsize=8.6,
            fontweight='bold', color=TENUE, zorder=5)
    ax.text(1294, 974, '\n'.join(f'- {r}' for r in c['roles']), ha='left', va='top',
            fontsize=8.4, color=CUERPO, linespacing=1.7, zorder=5)

    # Fila 3: comunicacion entrante, lenguaje y decisiones, comunicacion saliente
    caja(ax, 10, 300, 520, 576)
    titulo(ax, 34, 852, 'Inbound Communication')
    ax.text(50, 818, 'Collaborator', ha='left', va='center', fontsize=9.2,
            color='#9AA3AD', zorder=5)
    ax.text(330, 818, 'Messages', ha='left', va='center', fontsize=9.2,
            color='#9AA3AD', zorder=5)
    columna_comunicacion(ax, 10, c['entrante'], entrante=True)

    caja(ax, 1004, 300, 516, 576)
    titulo(ax, 1028, 852, 'Outbound Communication')
    ax.text(1044, 818, 'Messages', ha='left', va='center', fontsize=9.2,
            color='#9AA3AD', zorder=5)
    ax.text(1310, 818, 'Collaborator', ha='left', va='center', fontsize=9.2,
            color='#9AA3AD', zorder=5)
    columna_comunicacion(ax, 1004, c['saliente'], entrante=False)

    caja(ax, 540, 600, 456, 276)
    ax.text(768, 852, 'Ubiquitous Language', ha='center', va='center', fontsize=13.5,
            fontweight='bold', color=TINTA, zorder=5)
    ax.text(768, 828, 'Context-specific domain terminology', ha='center', va='center',
            fontsize=8.4, fontweight='bold', color=TENUE, zorder=5)
    for i, (termino, definicion) in enumerate(c['lenguaje'][:4]):
        col, ren = i % 2, i // 2
        tarjeta_definicion(ax, 552 + col * 226, 708 - ren * 100, 212, 92,
                           termino, definicion)

    ax.text(768, 572, 'Business Decisions', ha='center', va='center', fontsize=13.5,
            fontweight='bold', color=TINTA, zorder=5)
    ax.text(768, 548, 'Key business rules, policies, and decisions', ha='center',
            va='center', fontsize=8.4, fontweight='bold', color=TENUE, zorder=5)
    rejilla_decisiones(ax, 540, 456, c['decisiones'])

    # Fila 4: supuestos, metricas y preguntas abiertas
    caja(ax, 10, 10, 660, 286)
    titulo(ax, 34, 278, 'Assumptions')
    vinetas(ax, 10, 10, 660, 220, c['supuestos'], tam=7.6, ancho_car=70, interlinea=1.6)

    caja(ax, 676, 10, 500, 286)
    titulo(ax, 700, 278, 'Verification Metrics')
    vinetas(ax, 676, 10, 500, 220, c['metricas'], tam=7.6, ancho_car=52, interlinea=1.6)

    caja(ax, 1182, 10, 338, 286)
    titulo(ax, 1206, 278, 'Open Questions')
    vinetas(ax, 1182, 10, 338, 220, c['preguntas'], tam=7.0, color=TENUE,
            ancho_car=40, interlinea=1.5)

    # Panel lateral con los tipos de colaborador
    panel_colaboradores(ax, 1560, 520, 430, 548)

    SALIDA.mkdir(parents=True, exist_ok=True)
    destino = SALIDA / c['archivo']
    fig.savefig(destino, facecolor='white')
    plt.close(fig)
    print(f'escrito {destino.name}')


if __name__ == '__main__':
    for canvas in CANVASES:
        dibujar(canvas)
