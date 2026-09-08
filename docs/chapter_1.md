# Capítulo I: Presentación

## 1.1. Startup Profile

### 1.1.1. Descripción de la Startup

### 1.1.2. Perfiles de integrantes del equipo

## 1.2. Solution Profile

### 1.2.1. Antecedentes y problemática

### 1.2.2. Lean UX Process

En esta sección aplicamos el Lean UX Process (Gothelf & Seiden, 3rd Edition).
Presentamos los Problem Statement, Assumptions, Hypothesis Statements y el Lean UX
Canvas, adaptados al proyecto Pozzo.

#### 1.2.2.1. Lean UX Problem Statements

Pozzo se plantea como una aplicación para administrar juntas (o panderos) informales:
esos grupos de conocidos donde cada integrante aporta un monto fijo cada mes y el pozo
completo lo recibe una persona distinta en cada turno. La solución permitirá que la
cabeza de la junta configure el grupo con sus datos clave, como el monto del aporte, el
número de participantes, la periodicidad y el método con el que se asignan los turnos. A
partir de ello, cada participante ingresará por un enlace y verá el calendario completo
de la junta, con el mes que le toca cobrar y cuánto le falta aportar.

Durante la operación de la junta, el dinero se seguirá moviendo por Yape, tal como el
grupo ya lo hace, sin que pase por la plataforma. Cuando un participante deposite, le
tomará una foto al voucher y Pozzo leerá el monto, la fecha y el destinatario para
validar el aporte de forma automática, sin que la cabeza tenga que revisar capturas una
por una. El integrante que cobra ese mes verá en tiempo real quién ya depositó y quién
falta, de modo que sepa cuánto resta para completar el pozo.

Además, la solución se encargará de la cobranza y del reparto de turnos. Los
recordatorios saldrán solos y subirán de tono conforme se acerque la fecha, así nadie
tendrá que hacer de cobrador. Los turnos se asignarán por sorteo, por orden acordado o
por subasta, donde un participante cede parte de su turno para recibir antes. Al cerrar
el ciclo, cada integrante se quedará con su historial de cumplimiento, que le servirá
para entrar a la siguiente junta.

Hemos identificado que muchas juntas informales enfrentan problemas recurrentes: la
administración sigue en papel, con la cabeza anotando en un cuaderno quién depositó; la
cobranza se hace persiguiendo por WhatsApp a los que faltan; no hay forma de comprobar
un pago cuando alguien reclama que sí depositó; y el que cobra no sabe con certeza
cuánto falta para que el pozo esté completo. Estos problemas generan errores de conteo,
discusiones dentro del grupo y desconfianza en la administración.

¿Cómo puede Pozzo ayudar a las juntas informales a administrarse solas, validando los
aportes y dando transparencia del avance en tiempo real, sin que el dinero pase por la
plataforma y sin agregar complejidad a la forma en que el grupo ya opera?

#### 1.2.2.2. Lean UX Assumptions

**Assumptions**

- Suponemos que las cabezas de junta adoptarán Pozzo si perciben que les ahorra el conteo manual y la persecución de los que faltan.
- Creemos que validar el aporte leyendo el voucher de Yape aportará más confianza que anotar los depósitos a mano en un cuaderno.
- Suponemos que los participantes estarán dispuestos a entrar por un enlace y registrar su aporte si el proceso es breve y simple.
- Creemos que el calendario con el estado de los aportes en tiempo real reducirá los reclamos del tipo "yo sí pagué".
- Suponemos que los recordatorios automáticos que suben de tono bajarán la morosidad sin que la cabeza tenga que hacer de cobrador.
- Creemos que ofrecer la asignación de turnos por sorteo, orden acordado o subasta se ajustará a cómo cada junta ya reparte los turnos.
- Suponemos que administrar la junta sin custodiar el dinero reducirá la desconfianza y las trabas legales frente a manejar los aportes en la plataforma.
- Creemos que una interfaz simple y visual facilitará la adopción en grupos con poca familiaridad con aplicaciones.
- Suponemos que el historial de cumplimiento motivará el pago puntual y servirá para entrar a nuevas juntas.
- Creemos que la trazabilidad de cada aporte y de cada turno convertirá a Pozzo en una solución confiable y diferenciada frente al cuaderno y el WhatsApp.

¿Quién es el usuario?

El usuario principal de Pozzo es la cabeza de junta y los participantes de un grupo que
ya existe. La cabeza es quien arma la junta y hoy lleva las cuentas a mano; los
participantes aportan cada mes y esperan su turno para cobrar. Son personas que ya usan
Yape y WhatsApp con soltura, que valoran la confianza dentro del grupo y que quieren una
forma simple de saber cuándo les toca y de probar que cumplieron.

¿Dónde encaja nuestro producto en su trabajo o vida?

Pozzo se integra en el ciclo mensual de la junta. Se usa al crear la junta y definir sus
reglas, al depositar el aporte y subir el voucher, al revisar quién ya pagó y quién
falta, al recibir los recordatorios y al cerrar cada turno. No reemplaza la forma en que
el grupo mueve el dinero por Yape, sino que acompaña y ordena la administración que hoy
se hace en el cuaderno y en el chat.

¿Qué problemas tiene nuestro producto y cómo se pueden resolver?

- Problema: La lectura del voucher puede fallar si la captura está borrosa o el formato del Yape cambia. Solución: Mostrar lo que Pozzo leyó y permitir corregir el monto, la fecha o el destinatario antes de dar el aporte por válido.
- Problema: Un participante podría subir un voucher que no corresponde a la junta o uno repetido. Solución: Validar contra el destinatario y la fecha esperados, y marcar como pendiente cualquier aporte que no calce para que la cabeza lo revise.
- Problema: El grupo puede percibir la app como complicada si le pide demasiados datos al inicio. Solución: Mantener una configuración breve y guiada, con lo mínimo para arrancar la junta y valores por defecto sensatos.

¿Cuándo y cómo es usado nuestro producto?

Pozzo se usará en momentos puntuales del mes: al inicio del ciclo, cuando la cabeza crea
o abre la junta; a la hora de depositar, cuando el participante sube su voucher; en los
días previos a la fecha límite, cuando llegan los recordatorios; y cuando le toca cobrar
a alguien y necesita ver cuánto falta. El uso será breve pero recurrente, con consultas
rápidas al calendario y confirmaciones de aporte.

¿Qué características son importantes?

- Lectura del voucher de Yape para validar monto, fecha y destinatario del aporte.
- Calendario de turnos con el estado de los aportes en tiempo real.
- Recordatorios automáticos que suben de tono conforme se acerca la fecha.
- Asignación de turnos por sorteo, orden acordado o subasta.
- Historial de cumplimiento portable entre juntas.
- Administración de la junta sin que el dinero pase por la plataforma.

¿Cómo debe verse nuestro producto y cómo debe comportarse?

Pozzo debe transmitir confianza y claridad. La interfaz debe ser simple y muy visual,
con el calendario y el estado de los aportes fáciles de leer de un vistazo, y con los
pendientes bien destacados. Su comportamiento debe ser en tiempo real, de modo que
cuando alguien deposita y valida su aporte, el resto del grupo lo vea de inmediato y
todos confíen en que la app refleja lo que realmente pasó.

Business outcomes

- Aumentar el número de juntas activas administradas en Pozzo.
- Lograr que las cabezas sigan usando Pozzo en el siguiente ciclo.
- Reducir el costo de adquisición, ya que cada cabeza invita a todos sus participantes.
- Posicionar a Pozzo como una forma confiable de administrar juntas informales sin custodiar el dinero.

User

Nuestro usuario central es la cabeza de junta, que quiere dejar de perseguir gente y de
equivocarse en el conteo, y el participante, que quiere saber cuándo le toca, tener con
qué probar que depositó y ver si el grupo va al día antes de que llegue su turno.

Users outcomes

- La cabeza administrará la junta sin revisar capturas una por una ni llevar las cuentas en un cuaderno.
- Los participantes tendrán una prueba clara de su aporte cuando surja un reclamo.
- El que cobra sabrá en tiempo real cuánto falta para completar el pozo.
- Los participantes recibirán recordatorios y pagarán a tiempo sin que nadie los persiga.
- Cada integrante se llevará un historial de cumplimiento que le servirá para entrar a la siguiente junta.

#### 1.2.2.3. Lean UX Hypothesis Statements

- Creemos que, si la cabeza de junta recibe la validación automática de cada aporte a partir del voucher de Yape que lee monto, fecha y destinatario, entonces dejará de revisar capturas una por una y cometerá menos errores al contar. Sabremos que hemos tenido éxito cuando al menos el 80% de los aportes se valide sin que la cabeza intervenga.

- Creemos que, si los participantes y el que cobra este mes pueden ver en el calendario quién depositó, quién falta y cuánto resta para el pozo, entonces habrá menos reclamos por pagos dentro del grupo. Sabremos que vamos por buen camino cuando los reclamos del tipo "yo sí pagué" se reduzcan en al menos un 70%.

- Creemos que, si los recordatorios salen solos y suben de tono conforme se acerca la fecha, entonces bajará la morosidad y la cabeza dejará de hacer de cobrador. Sabremos que hemos tenido éxito cuando al menos el 90% de los aportes llegue a tiempo.

- Creemos que, si Pozzo permite asignar los turnos por sorteo, orden acordado o subasta, entonces más juntas lo adoptarán porque funciona tal como ya operan. Sabremos que hemos tenido éxito cuando al menos el 80% de las juntas arme sus turnos dentro de la app.

- Creemos que, si al cerrar el ciclo cada participante se queda con un historial que prueba su cumplimiento, entonces seguirá usando Pozzo para entrar a nuevas juntas. Sabremos que hemos tenido éxito cuando al menos el 60% de los participantes reutilice su historial en otra junta.

#### 1.2.2.4. Lean UX Canvas

| **1. Problema de negocio** | **5. Ideas de soluciones** | **2. Resultados comerciales** |
| --- | --- | --- |
| Muchas juntas informales se administran a mano, con el dinero moviéndose por Yape pero las cuentas en un cuaderno y en capturas de WhatsApp. Esto genera errores de conteo, falta de prueba de pago y poca visibilidad sobre cuánto falta para el pozo. En ese contexto, Pozzo busca responder: ¿cómo administrar una junta que ya existe, validando los aportes y mostrando el avance en tiempo real, sin mover el dinero por la plataforma? | Lector de vouchers de Yape que valida monto, fecha y destinatario.<br>Calendario de turnos con el estado de los aportes en tiempo real.<br>Recordatorios automáticos que suben de tono.<br>Asignación de turnos por sorteo, orden acordado o subasta.<br>Historial de cumplimiento portable entre juntas.<br>Enlace de invitación para que los participantes entren.<br>Administración de la junta sin custodiar el dinero. | Más juntas activas administradas en Pozzo cada mes.<br>Cabezas que siguen usando Pozzo en el siguiente ciclo.<br>Menor costo de adquisición por la invitación en cadena.<br>La mayoría de las juntas termina su ciclo en la app.<br>Pozzo posicionado como forma confiable de administrar juntas. |
| **3. Usuarios y clientes** | **4. Beneficios del usuario** | |
| La cabeza de junta arma el grupo y hoy lleva las cuentas a mano. Los participantes aportan cada mes y esperan su turno para cobrar. El integrante que cobra ese mes necesita ver quién ya depositó y quién falta. Todos ya usan Yape y WhatsApp. | La cabeza deja de perseguir gente y de equivocarse en el conteo.<br>El participante tiene una prueba clara de su aporte.<br>El que cobra sabe en tiempo real cuánto falta para el pozo.<br>Los recordatorios evitan que alguien haga de cobrador.<br>El historial de cumplimiento abre la puerta a nuevas juntas. | |

***

| **6. Hipótesis** | **7. ¿Qué es lo más importante que necesitamos aprender primero?** | **8. ¿Cuál es la menor cantidad de trabajo que necesitamos hacer para aprenderlo?** |
| --- | --- | --- |
| El lector de vouchers valida solo al menos el 80% de los aportes.<br>El calendario en tiempo real reduce los reclamos por pagos en un 70%.<br>Los recordatorios logran que el 90% de los aportes llegue a tiempo.<br>El 80% de las juntas arma sus turnos dentro de la app.<br>El 60% de los participantes reutiliza su historial en otra junta. | Lo primero que debemos validar es si las cabezas y los participantes confían en que la validación del voucher de Yape basta para dar por registrado un aporte, sin revisarlo a mano. Toda la propuesta de valor depende de esa confianza. | Lanzar un MVP acotado: una junta piloto con configuración básica, lector de vouchers de Yape, calendario en tiempo real y recordatorios automáticos. Probarlo durante 1 o 2 ciclos con 2 o 3 juntas, midiendo aportes validados solos, tiempo de conteo de la cabeza y reclamos por pagos, para ajustar el modelo antes de ampliar el alcance. |

## 1.3. Segmentos objetivo
