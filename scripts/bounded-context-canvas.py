#!/usr/bin/env python3
"""Dibuja los Bounded Context Canvas de Pozzo con la plantilla oficial v5.

El canvas de DDD Crew (github.com/ddd-crew/bounded-context-canvas) coloca once
secciones en una cuadricula fija. Importa respetarla: Ubiquitous Language y
Business Decisions son dos casillas distintas, no una sola.

    python scripts/bounded-context-canvas.py

La salida son docs/images/chapter_2/bcc_<contexto>.png.
"""
import textwrap
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle

SALIDA = Path(__file__).resolve().parent.parent / 'docs/images/chapter_2'
TITULO, CUERPO, ETIQUETA = '#1F2933', '#3A4149', '#5B6670'

CANVASES = [
    dict(
        archivo='bcc_contributions.png', nombre='Contributions', tipo='core',
        color='#FDECEC', acento='#BD0A0A',
        proposito='Registrar y validar los aportes de cada período contra lo esperado, mantener el '
                  'estado del pozo visible para todo el grupo y registrar la entrega del pozo, las '
                  'coberturas y el cierre del ciclo. Es el contexto que sostiene la hipótesis '
                  'principal de Pozzo: la validación automática de aportes a partir del comprobante.',
        clasificacion='Dominio: Core. Es lo que diferencia a Pozzo de Tandapp, Moneypool o Splitwise.\n'
                      'Modelo de negocio: Engagement. Si la validación funciona, la junta completa su ciclo en Pozzo.\n'
                      'Evolución: Custom built. No existe un producto que valide aportes de juntas peruanas contra capturas de Yape y Plin.',
        roles='Execution context: ejecuta el proceso de aporte, validación, entrega y cierre.\n'
              'Analysis context: calcula el estado y la proyección del pozo para el grupo.\n'
              'Engagement context: es la pantalla que la cabeza y el participante consultan cada período.',
        entrante='Comandos (Participante): Registrar aporte con comprobante, Confirmar datos leídos.\n'
                 'Comandos (Cabeza): Aprobar o rechazar aporte, Registrar aporte en efectivo, Registrar cobertura, Entregar pozo, Cerrar junta.\n'
                 'Consultas: Estado del pozo, Mis aportes, Períodos anteriores, Proyección del pozo, Aportes pendientes de revisión.\n'
                 'Eventos que consume: Junta iniciada, Turnos asignados, Integrante desertó, Reemplazo incorporado.\n'
                 'Colaboradores: Aplicación móvil, Savings Groups, ML Kit (lectura en el dispositivo).',
        lenguaje='Aporte, Comprobante, Aporte esperado, Período, Fecha de corte, Pozo, Validación, '
                 'Inconsistencia, Cobertura, Entrega, Ciclo.',
        decisiones='1. Un aporte es válido si el monto es el acordado, la fecha no supera la fecha de corte, el destinatario es el destino de aportes y el número de operación no se repite en la junta.\n'
                   '2. Un comprobante se usa una sola vez.\n'
                   '3. Solo la cabeza resuelve inconsistencias y registra efectivo o coberturas.\n'
                   '4. El pozo está completo cuando todos los aportes esperados están validados o cubiertos.\n'
                   '5. La entrega del pozo abre el siguiente período; tras el último turno la junta se cierra.',
        saliente='Eventos que publica: Período abierto, Aporte registrado, Aporte validado, Inconsistencia detectada, Aporte rechazado, Aporte cubierto, Pozo completo, Pozo entregado, Ciclo cerrado.\n'
                 'Los consumen: Notifications (recordatorios y avisos), Compliance History (historial).\n'
                 'Consultas que hace: reglas, integrantes y calendario de turnos a Savings Groups.\n'
                 'Colaboradores: Notifications, Compliance History, Savings Groups.',
        supuestos='1. Las capturas de Yape y Plin tienen un formato estable que ML Kit lee con acierto suficiente para monto, fecha, destinatario y número de operación.\n'
                  '2. La transferencia ocurre fuera de Pozzo; la aplicación solo registra y valida la evidencia, nunca custodia fondos.\n'
                  '3. La cabeza acepta revisar las pocas inconsistencias que la validación no resuelve.',
        metricas='1. Porcentaje de aportes validados automáticamente sin revisión de la cabeza (meta: 80 %).\n'
                 '2. Tiempo entre la transferencia y la validación del aporte.\n'
                 '3. Porcentaje de períodos con pozo completo antes de la fecha de corte.\n'
                 '4. Discrepancias resueltas dentro de la aplicación frente a las resueltas por WhatsApp.',
        preguntas='1. ¿Cómo tratar comprobantes de bancos distintos a Yape y Plin?\n'
                  '2. ¿Cuántos días de gracia después de la fecha de corte antes de marcar la morosidad?\n'
                  '3. ¿La cobertura la registra solo la cabeza o también el integrante que cubre?\n'
                  '4. ¿Se guarda la imagen del comprobante en el servidor o solo los datos leídos?'),

    dict(
        archivo='bcc_savings_groups.png', nombre='Savings Groups', tipo='supporting',
        color='#EEF4FD', acento='#305BAB',
        proposito='Crear y configurar la junta con sus reglas, incorporar y administrar a los '
                  'integrantes por código, enlace o registro manual, asignar los turnos por sorteo, '
                  'orden acordado o subasta, e iniciar el ciclo. Define las reglas que Contributions '
                  'ejecuta en cada período.',
        clasificacion='Dominio: Supporting. Necesario para que exista una junta, pero la competencia también lo ofrece.\n'
                      'Modelo de negocio: Adopción. La incorporación sin fricción por enlace sostiene la hipótesis de crecimiento.\n'
                      'Evolución: Custom built. Las reglas de las juntas peruanas (subasta, cupos, corte) no vienen en ningún producto.',
        roles='Specification context: fija las reglas (aporte, periodicidad, cupos, fecha de corte, turnos) que otros contextos consultan.\n'
              'Gateway context: las invitaciones son la puerta de entrada de los participantes a una junta.',
        entrante='Comandos (Cabeza): Crear junta, Definir destino de los aportes, Generar invitación, Agregar integrante sin la aplicación, Retirar integrante, Asignar turnos, Abrir subasta, Cerrar subasta, Iniciar junta, Registrar deserción y reemplazo.\n'
                 'Comandos (Participante): Unirse con código o enlace, Ofertar en la subasta.\n'
                 'Consultas: Reglas de la junta, Lista de integrantes, Calendario de turnos, Resumen de la junta antes de unirse.\n'
                 'Colaboradores: Aplicación móvil, Identity & Access, Compliance History.',
        lenguaje='Junta, Regla, Aporte acordado, Periodicidad, Cupo, Integrante, Invitación, Turno, '
                 'Sorteo, Orden acordado, Subasta, Oferta, Deserción, Reemplazo.',
        decisiones='1. Una junta se inicia solo con todos los cupos cubiertos y todos los turnos asignados.\n'
                   '2. Al iniciar, las reglas quedan bloqueadas y el código de invitación caduca.\n'
                   '3. Un integrante sin la aplicación lo registra la cabeza y ella registra sus aportes.\n'
                   '4. En la subasta gana la oferta mayor; el empate lo resuelve la cabeza.\n'
                   '5. Un reemplazo hereda el turno pendiente del integrante que desertó.',
        saliente='Eventos que publica: Junta creada, Invitación generada, Integrante incorporado, Integrante retirado, Turnos asignados, Subasta cerrada, Junta iniciada, Integrante desertó, Reemplazo incorporado.\n'
                 'Los consumen: Contributions (abre el primer período y calcula lo esperado), Notifications (avisos), Compliance History.\n'
                 'Consultas que hace: historial del nuevo integrante a Compliance History; identidad a Identity & Access.\n'
                 'Colaboradores: Contributions, Notifications, Compliance History, WhatsApp.',
        supuestos='1. Las juntas son de conocidos, entre 5 y 15 integrantes.\n'
                  '2. El enlace de invitación se comparte por WhatsApp y abre la aplicación directamente.\n'
                  '3. La cabeza define las reglas antes de invitar y rara vez las cambia después.',
        metricas='1. Juntas iniciadas sobre juntas creadas.\n'
                 '2. Tiempo entre la creación y el inicio de la junta.\n'
                 '3. Porcentaje de integrantes incorporados por enlace frente a registro manual.\n'
                 '4. Juntas que usan subasta frente a sorteo u orden acordado.',
        preguntas='1. ¿Se permite cambiar la cabeza de junta durante el ciclo?\n'
                  '2. ¿Puede una persona ocupar dos cupos en la misma junta?\n'
                  '3. ¿Cómo se verifica que el sorteo fue justo ante el grupo?'),

    dict(
        archivo='bcc_compliance_history.png', nombre='Compliance History', tipo='supporting',
        color='#EAF9EF', acento='#067429',
        proposito='Consolidar el comportamiento de pago de cada integrante a lo largo de todas sus '
                  'juntas, a partir de los hechos registrados en Pozzo, y ofrecerlo de forma '
                  'verificable a la cabeza que lo incorpora y a quien decida compartirlo.',
        clasificacion='Dominio: Supporting. Refuerza la confianza, que es la razón por la que las juntas existen, pero depende de los hechos del core.\n'
                      'Modelo de negocio: Engagement y retención: un historial acumulado es una razón para volver a usar Pozzo.\n'
                      'Evolución: Custom built.',
        roles='Analysis context: es un modelo de lectura derivado de los eventos de Contributions y '
              'Savings Groups; no toma decisiones sobre la junta.',
        entrante='Eventos que consume: Aporte validado, Aporte rechazado, Aporte cubierto, Integrante desertó, Ciclo cerrado.\n'
                 'Comandos (Integrante): Compartir mi historial.\n'
                 'Consultas: Mi historial de cumplimiento, Historial del integrante que se une (desde Savings Groups), Historial compartido (enlace público con vigencia).\n'
                 'Colaboradores: Contributions, Savings Groups, Aplicación móvil.',
        lenguaje='Historial de cumplimiento, Aporte puntual, Aporte tardío, Cobertura recibida, '
                 'Deserción, Juntas completadas, Enlace verificable.',
        decisiones='1. El historial se compone solo de hechos registrados en Pozzo; no admite carga manual.\n'
                   '2. Se muestra agregado: puntuales, tardíos, cubiertos, deserciones y juntas completadas, sin montos ni nombres de otras juntas.\n'
                   '3. Compartir genera un enlace con vigencia limitada que cualquiera puede verificar.\n'
                   '4. La cabeza ve el historial de quien se une solo mientras la junta no ha iniciado.',
        saliente='Eventos que publica: Historial actualizado, Historial compartido.\n'
                 'Respuestas a consultas: resumen del historial a Savings Groups y a la aplicación móvil.\n'
                 'Colaboradores: Savings Groups, Aplicación móvil, hoja de compartir del sistema operativo.',
        supuestos='1. Un historial visible para el grupo incentiva el cumplimiento.\n'
                  '2. Los integrantes aceptan que su comportamiento de pago sea visible para la cabeza de las juntas a las que se unen.',
        metricas='1. Porcentaje de cabezas que consultan el historial de un integrante antes de iniciar.\n'
                 '2. Porcentaje de participantes que comparten su historial al menos una vez.\n'
                 '3. Diferencia de morosidad entre integrantes con historial y sin historial.',
        preguntas='1. ¿Cómo tratar los aportes registrados por la cabeza para integrantes sin la aplicación?\n'
                  '2. ¿Prescriben las deserciones antiguas?\n'
                  '3. ¿Se necesita una puntuación numérica o basta el resumen?'),

    dict(
        archivo='bcc_notifications.png', nombre='Notifications', tipo='generic',
        color='#F4F2FD', acento='#6631D7',
        proposito='Enviar recordatorios escalonados a quien no ha aportado antes de la fecha de corte '
                  'y avisar a los integrantes de los hechos relevantes de la junta, aunque la '
                  'aplicación esté cerrada, para que la cabeza no tenga que cobrar por WhatsApp.',
        clasificacion='Dominio: Generic. Enviar notificaciones es un problema resuelto; lo específico es la política de escalonamiento.\n'
                      'Modelo de negocio: Engagement. Sostiene el objetivo de cero recordatorios manuales.\n'
                      'Evolución: Product. Se apoya en Firebase Cloud Messaging.',
        roles='Execution context reactivo: aplica políticas sobre los eventos de los demás contextos.\n'
              'Gateway context: es el único que habla con Firebase Cloud Messaging.',
        entrante='Comandos: Registrar dispositivo (Integrante), Configurar los recordatorios de la junta (Cabeza).\n'
                 'Eventos que consume: Sesión iniciada, Junta iniciada, Turnos asignados, Período abierto, Aporte validado, Aporte rechazado, Pozo completo, Pozo entregado, Ciclo cerrado, Reemplazo incorporado.\n'
                 'Consultas: Avisos recibidos.\n'
                 'Colaboradores: Contributions, Savings Groups, Identity & Access, Aplicación móvil.',
        lenguaje='Recordatorio, Escalonamiento, Aviso, Dispositivo, Plan de recordatorios, Hecho relevante.',
        decisiones='1. Recordatorios a 3 días, 1 día y el mismo día de la fecha de corte, solo a quien tiene aporte pendiente.\n'
                   '2. Los recordatorios de un integrante se detienen al validar su aporte.\n'
                   '3. La cabeza puede ajustar el plan por junta, no por integrante.\n'
                   '4. Un integrante no recibe dos avisos por el mismo hecho.\n'
                   '5. Los integrantes sin la aplicación no reciben avisos; la cabeza los ve como pendientes.',
        saliente='Eventos que publica: Dispositivo registrado, Recordatorios configurados, Recordatorio enviado, Aviso enviado.\n'
                 'Mensajes externos: notificaciones push a Firebase Cloud Messaging.\n'
                 'Colaboradores: Firebase Cloud Messaging, Aplicación móvil.',
        supuestos='1. El plan gratuito de Firebase Cloud Messaging cubre el volumen inicial.\n'
                  '2. Los integrantes aceptan el permiso de notificaciones en Android 13 o superior.\n'
                  '3. Un recordatorio automático se percibe menos incómodo que el mensaje de la cabeza.',
        metricas='1. Porcentaje de aportes registrados dentro de las 24 horas posteriores a un recordatorio.\n'
                 '2. Tasa de entrega de las notificaciones push.\n'
                 '3. Recordatorios manuales por WhatsApp reportados por la cabeza en las entrevistas de validación.',
        preguntas='1. ¿Recordatorio por SMS o WhatsApp a integrantes sin la aplicación?\n'
                  '2. ¿En qué horario se envían los recordatorios?\n'
                  '3. ¿Programador de tareas en el servidor o cola con retardo? (Spike Story pendiente)'),

    dict(
        archivo='bcc_identity_access.png', nombre='Identity & Access', tipo='generic',
        color='#F5F5F5', acento='#313131',
        proposito='Identificar a cada integrante por su número de celular, verificado con un código '
                  'SMS y sin contraseña, mantener su sesión en el dispositivo y administrar su '
                  'perfil. Provee la identidad que los demás contextos usan para referirse a un '
                  'integrante.',
        clasificacion='Dominio: Generic. Cualquier aplicación móvil lo necesita y no diferencia a Pozzo.\n'
                      'Modelo de negocio: Reducción de costo y riesgo: no se administran contraseñas.\n'
                      'Evolución: Commodity. La verificación por SMS se contrata a un proveedor.',
        roles='Gateway context: es el punto de entrada de todo integrante a Pozzo.\n'
              'Identity provider: emite el token de sesión que autoriza cada solicitud a los servicios RESTful.',
        entrante='Comandos (Integrante): Solicitar código SMS, Verificar código, Completar registro, Iniciar sesión, Cerrar sesión, Administrar perfil.\n'
                 'Consultas: Perfil, Validar token (desde los demás servicios), ¿Este celular ya tiene cuenta?\n'
                 'Colaboradores: Aplicación móvil, Proveedor de SMS, los demás contextos (validación del token).',
        lenguaje='Cuenta, Número de celular, Código SMS, Sesión, Token, Perfil, Términos y política de privacidad.',
        decisiones='1. Un número de celular corresponde a una sola cuenta.\n'
                   '2. El código tiene 6 dígitos, vence a los 5 minutos y admite 3 intentos.\n'
                   '3. La sesión persiste en el dispositivo hasta que el integrante la cierra.\n'
                   '4. Los términos y la política de privacidad se aceptan al completar el registro.\n'
                   '5. El perfil muestra nombre y foto; el número no se expone a otros integrantes salvo en la junta.',
        saliente='Eventos que publica: Cuenta creada, Sesión iniciada, Perfil actualizado.\n'
                 'Los consumen: Notifications (registro del dispositivo tras iniciar sesión).\n'
                 'Mensajes externos: envío del código al proveedor de SMS.\n'
                 'Colaboradores: Proveedor de SMS, Notifications, todos los contextos.',
        supuestos='1. Todos los integrantes tienen un número peruano que recibe SMS.\n'
                  '2. El costo por SMS es aceptable para el volumen del primer año.\n'
                  '3. Ingresar sin contraseña reduce el abandono en el registro.',
        metricas='1. Porcentaje de verificaciones exitosas al primer intento.\n'
                 '2. Tiempo desde solicitar el código hasta completar el registro.\n'
                 '3. Costo por cuenta creada.',
        preguntas='1. ¿Cómo recupera su cuenta un integrante que cambia de número?\n'
                  '2. ¿Verificación por WhatsApp como alternativa al SMS?\n'
                  '3. ¿Qué proveedor de SMS: Twilio, Firebase Authentication u otro? (por evaluar)'),
]

# (clave, titulo, x, y, ancho, alto, caracteres por linea, tamano de letra)
CASILLAS = [
    ('proposito',     'Purpose',                 0.000, 0.700, 0.330, 0.228, 54, 8.2),
    ('clasificacion', 'Strategic Classification', 0.335, 0.700, 0.330, 0.228, 56, 7.6),
    ('roles',         'Domain Roles',             0.670, 0.700, 0.330, 0.228, 56, 7.6),
    ('entrante',      'Inbound Communication',    0.000, 0.272, 0.330, 0.420, 54, 7.5),
    ('lenguaje',      'Ubiquitous Language',      0.335, 0.510, 0.330, 0.182, 54, 7.8),
    ('decisiones',    'Business Decisions',       0.335, 0.272, 0.330, 0.230, 54, 7.4),
    ('saliente',      'Outbound Communication',   0.670, 0.272, 0.330, 0.420, 54, 7.5),
    ('supuestos',     'Assumptions',              0.000, 0.000, 0.330, 0.264, 54, 7.5),
    ('metricas',      'Verification Metrics',     0.335, 0.000, 0.330, 0.264, 54, 7.5),
    ('preguntas',     'Open Questions',           0.670, 0.000, 0.330, 0.264, 54, 7.5),
]


def envolver(texto, ancho):
    salida = []
    for parrafo in texto.split('\n'):
        if not parrafo.strip():
            salida.append('')
            continue
        sangria = '   ' if parrafo[:2].strip().rstrip('.').isdigit() else ''
        salida.extend(textwrap.wrap(parrafo, ancho, subsequent_indent=sangria) or [''])
    return '\n'.join(salida)


def dibujar(c):
    fig = plt.figure(figsize=(16.5, 11.2), dpi=160)
    ax = fig.add_axes([0.008, 0.008, 0.984, 0.984])
    ax.set_xlim(0, 1); ax.set_ylim(0, 1); ax.axis('off')

    # Banda del nombre
    ax.add_patch(Rectangle((0, 0.936), 1, 0.064, facecolor=c['color'],
                           edgecolor='white', linewidth=2.5, zorder=1))
    ax.text(0.010, 0.968, f"Name: {c['nombre']}", ha='left', va='center',
            fontsize=17, fontweight='bold', color=c['acento'], zorder=2)
    ax.text(0.990, 0.968, 'Bounded Context Canvas v5', ha='right', va='center',
            fontsize=8, color=ETIQUETA, style='italic', zorder=2)

    for clave, titulo, x, y, w, h, ancho, tam in CASILLAS:
        ax.add_patch(Rectangle((x, y), w, h, facecolor=c['color'],
                               edgecolor='white', linewidth=2.5, zorder=1))
        ax.text(x + 0.010, y + h - 0.010, titulo, ha='left', va='top',
                fontsize=10.5, fontweight='bold', color=TITULO, zorder=2)
        ax.text(x + 0.010, y + h - 0.040, envolver(c[clave], ancho), ha='left', va='top',
                fontsize=tam, color=CUERPO, linespacing=1.45, zorder=2)

    SALIDA.mkdir(parents=True, exist_ok=True)
    destino = SALIDA / c['archivo']
    fig.savefig(destino, facecolor='white', bbox_inches='tight', pad_inches=0.1)
    plt.close(fig)
    print(f'escrito {destino.name}')


if __name__ == '__main__':
    for canvas in CANVASES:
        dibujar(canvas)
