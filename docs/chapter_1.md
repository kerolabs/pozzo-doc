# Capítulo I: Presentación

## 1.1. Startup Profile

En esta sección se presenta el perfil de Kero, incluyendo una descripción general de la startup, su propósito, misión y visión, así como los perfiles de los integrantes del equipo y las principales capacidades que aportan al desarrollo de Pozzo.

### 1.1.1. Descripción de la Startup

Kero es una startup peruana de tecnología financiera comunitaria enfocada en digitalizar la administración de juntas de ahorro. Su producto principal, Pozzo, nace como respuesta a una situación frecuente en estos grupos: aunque los aportes ya se realizan mediante billeteras digitales como Yape, el control de pagos, turnos, comprobantes y recordatorios continúa dependiendo de cuadernos, capturas y mensajes de WhatsApp.

Pozzo permite centralizar la gestión de la junta sin intervenir directamente en el movimiento del dinero. La cabeza de junta puede configurar el monto, número de participantes, periodicidad y asignación de turnos, mientras que los participantes pueden consultar su calendario, registrar sus aportes mediante vouchers y conocer en tiempo real el estado del pozo. De esta manera, la aplicación busca reducir errores de conteo, facilitar la verificación de pagos y disminuir la carga de seguimiento que actualmente recae sobre el organizador.

La propuesta de Kero está orientada principalmente a grupos de familiares, amigos, vecinos o compañeros de trabajo que ya utilizan juntas como mecanismo de ahorro y desean mantener su dinámica habitual, pero con una administración más ordenada, transparente y verificable. A través de Pozzo, la startup busca combinar la confianza social propia de las juntas con herramientas digitales que simplifiquen su operación.

<table>
  <colgroup><col style="width:50%"><col style="width:50%"></colgroup>
  <thead><tr><th align="center"><strong>Misión</strong></th><th align="center"><strong>Visión</strong></th></tr></thead>
  <tbody>
    <tr><td align="center">Facilitar la administración de juntas de ahorro mediante una solución digital simple y confiable que permita organizar aportes, turnos y comprobantes, reduciendo el trabajo manual y mejorando la transparencia entre sus participantes.</td><td align="center">Ser una plataforma referente en la digitalización de juntas de ahorro en el Perú y Latinoamérica, contribuyendo a modernizar mecanismos financieros comunitarios sin alterar la confianza y dinámica social sobre la que se sostienen.</td></tr>
  </tbody>
</table>

### 1.1.2. Perfiles de integrantes del equipo

<table>
  <colgroup><col style="width:27%"><col style="width:73%"></colgroup>
  <thead><tr><th>Integrante</th><th>Información</th></tr></thead>
  <tbody>
    <tr><td><img src="images/chapter_1/leonardo_sanchez_benavente.jpg" alt="Leonardo Sanchez Benavente"></td><td><strong>Leonardo Matias Sanchez Benavente</strong><br><strong>Código de estudiante:</strong> U20241b184<br><strong>Carrera:</strong> Ingeniería de Software<br><br>Estudiante de Ingeniería de Software con base en desarrollo web full-stack: Angular y TypeScript en el cliente, Java con Spring Boot y APIs REST bajo enfoque DDD en el servidor.<br><br></td></tr>
    <tr><td><img src="images/chapter_1/gabriela_tirado_carrera.jpeg" alt="Gabriela Tirado Carrera"></td><td><strong>Gabriela Luciana Tirado Carrera</strong><br><strong>Código de estudiante:</strong> U202519592<br><strong>Carrera:</strong> Ingeniería de Software<br><br>Estudiante de Ingeniería de Software con conocimientos en desarrollo Full Stack, incluyendo Angular, Vue, HTML, CSS, C#, Java, JavaScript y SQL. Hábil en trabajo de equipos y desarrollo de interfaces.<br><br></td></tr>
    <tr><td><img src="images/chapter_1/julius_camargo.png" alt="Joseph Julius Camargo Briceño"></td><td><strong>Joseph Julius Camargo Briceño</strong><br><strong>Código de estudiante:</strong> U20241D992<br><strong>Carrera:</strong> Ingeniería de Software<br><br>Estudiante de Ingeniería de Software especializado en C++ y en desarrollo backend con Java y C#, con conocimientos de HTML, CSS básico y frameworks frontend como Vue y Angular. Orientado a resultados, tanto a nivel de equipo como individual, con capacidad para potenciar el rendimiento del grupo. Abierto a las ideas y opiniones ajenas, y promotor del diálogo y el debate constructivo ante perspectivas en conflicto.<br><br></td></tr>
    <tr><td><img src="images/chapter_1/fernando_flores.png" alt="Jose Fernando Flores Pinchi"></td><td><strong>Jose Fernando Flores Pinchi</strong><br><strong>Código de estudiante:</strong> U20241A290<br><strong>Carrera:</strong> Ingeniería de Software<br><br>Estudiante de Ingeniería de Software de cuarto ciclo, con conocimientos en bases de datos, HTML, CSS y frameworks como Vue y Angular, con orientación hacia la ciberseguridad. Responsable y adaptable, con interés en el aprendizaje continuo y la innovación tecnológica. Aplica sus conocimientos en proyectos prácticos que aporten valor y mejoren la vida cotidiana, fortaleciendo sus competencias mediante la colaboración con otros desarrolladores.<br><br></td></tr>
    <tr><td><img src="images/chapter_1/estefano_solis_campos.png" alt="Estefano Sebastian Solis Campos"></td><td><strong>Estefano Sebastian Solis Campos</strong><br><strong>Código de estudiante:</strong> U202314354<br><strong>Carrera:</strong> Ingeniería de Software<br><br>Estudiante apasionado de la carrera de Ingeniería de Software, enfocado en aplicar sus conocimientos para el desarrollo de soluciones tecnológicas innovadoras y en constante búsqueda de oportunidades de aprendizaje y crecimiento profesional en el sector tecnológico.</td></tr>
  </tbody>
</table>

## 1.2. Solution Profile

Kero es una iniciativa de tecnología financiera comunitaria orientada a digitalizar la administración de las juntas peruanas a través de su producto central: Pozzo. Nuestra solución es un ecosistema compuesto por una aplicación móvil nativa y multiplataforma que atiende tanto al organizador como al participante de la junta, un conjunto de servicios web RESTful de desarrollo propio que sostienen la lógica del ciclo de ahorro rotativo, y un sitio web estático para el landing page del modelo de negocio. Las secciones siguientes presentan los antecedentes y la problemática que originan esta propuesta, y el resultado de aplicar Lean UX Process sobre el dominio del problema.

### 1.2.1. Antecedentes y problemática

La junta, denominada también pandero o tanomoshi, es una asociación rotativa de ahorro y crédito en la que un grupo de personas conocidas entre sí aporta un monto fijo con periodicidad acordada, y el fondo acumulado en cada período se entrega íntegro a un integrante distinto hasta que todos han cobrado una vez. La literatura académica estudia esta figura bajo la denominación de **ROSCA** (*Rotating Savings and Credit Association*), presente con nombres propios en prácticamente todo el mundo en desarrollo: *tanda* en México, *susu* en África Occidental, *chit fund* en la India y *pasanaku* en Bolivia.

Su uso en el Perú sigue siendo extendido: los estudios sobre ahorro voluntario ubican a las juntas y panderos como la principal forma de ahorro informal después del dinero guardado en casa, con el 7 % de la población que ahorra a través de ellas [@sbs2020ahorro]. La razón predominante para preferir este mecanismo, según la misma fuente, no es la ausencia de oferta financiera sino la desconfianza hacia las entidades formales.

Simultáneamente, el medio de pago que sostiene a estas juntas ya se digitalizó por completo. Yape cerró el año 2025 con 19,1 millones de usuarios y 15,9 millones de usuarios activos mensuales, y entre las principales billeteras digitales del país se procesan más de 1,6 millones de transacciones diarias. El aporte a la junta se realiza hoy desde el teléfono, en segundos y sin efectivo. **Lo que no se digitalizó fue la administración**: el registro de quién aportó, el control de los turnos, la cobranza a los morosos y la prueba de que un pago efectivamente ocurrió continúan dependiendo de un cuaderno, de un grupo de mensajería saturado de capturas de pantalla y de la memoria del organizador.

Al analizar esta situación mediante la técnica de las **5 W's y 2 H's** se identifican los siguientes elementos:

* **Who (Quiénes):** La **cabeza de junta**, que asume sin compensación el trabajo de registrar aportes, verificar comprobantes y cobrar a los atrasados, y que responde ante el grupo cuando la cuenta no cuadra; y el **participante**, que carece de un medio para acreditar un aporte cuestionado y de visibilidad sobre si el fondo estará completo al llegar su turno de cobro. De forma indirecta, el problema alcanza al grupo entero, pues un incumplimiento no detectado a tiempo deteriora una relación personal preexistente.

* **What (Qué):** La problemática radica en la **desconexión entre un medio de pago digitalizado y una administración analógica**. No existe una fuente única y confiable que indique quién ha depositado, quién adeuda y cuánto falta para completar el pozo del turno vigente; esa información permanece dispersa entre el cuaderno del organizador, el chat grupal y la aplicación de billetera digital.

* **When (Cuándo):** En cada período de aporte, con la frecuencia que la junta haya pactado (semanal, quincenal o mensual), y se agrava en los días previos a la fecha de corte, cuando el organizador debe escribirle uno por uno a quienes no han depositado. El punto de máxima tensión es la fecha de entrega del fondo, momento en que el pozo debe estar íntegro.

* **Where (Dónde):** En juntas de ámbito urbano en el Perú, conformadas entre compañeros de trabajo, vecinos y familiares. Operativamente, el problema reside en tres espacios simultáneos y desconectados entre sí: el registro manual del organizador, el grupo de mensajería donde se remiten los comprobantes y la billetera digital donde ocurre la transferencia efectiva.

* **Why (Por qué):** Porque la billetera digital resuelve la transferencia individual pero no está diseñada para la lógica de un ahorro rotativo: desconoce la existencia del grupo, no gestiona turnos ni periodicidad y no consolida los aportes de múltiples personas hacia un objetivo común. Ese vacío funcional lo cubre hoy una persona con un cuaderno.

* **How (Cómo):** El participante transfiere mediante la billetera digital, captura el comprobante y lo remite al grupo. El organizador revisa las capturas una por una, las contrasta con su registro manual y escribe a quienes faltan. Ante una discrepancia, la controversia se dirime buscando manualmente una captura antigua en el historial del chat, o simplemente no se dirime.

* **How Much (Cuánto):** El problema se dimensiona con tres magnitudes:
    * Las juntas y panderos representan el **7 %** de las formas de ahorro de la población peruana [@sbs2020ahorro].
    * El mercado global de aplicaciones para la digitalización de ROSCAs fue valorizado en **USD 0,92 mil millones** en 2025, con una tasa de crecimiento anual compuesta proyectada de 14,5 % hacia 2034.
    * El costo del problema para quien organiza, según las entrevistas registradas: en una junta de diez personas la cabeza revisa entre **15 y 20 comprobantes** por ciclo, uno por uno, y escribe a dos o tres integrantes hasta tres o cinco veces cada uno para cobrar. El **100 %** de las cabezas entrevistadas ha enfrentado al menos un reclamo de pago imposible de comprobar y el **67 %** ha tenido que cubrir con su propio dinero el atraso de un integrante.

De este análisis se desprende que el problema no es la carencia de un medio de pago ni la ausencia de confianza entre los integrantes de una junta, sino la **falta de un registro compartido y verificable sobre un dinero que ya circula de forma digital**. Dicho vacío produce tres consecuencias concretas: una carga administrativa no remunerada que recae íntegramente sobre el organizador, quien además debe ejercer de cobrador frente a personas de su entorno cercano; la imposibilidad de dirimir una discrepancia cuando un participante sostiene haber depositado y el registro indica lo contrario; y la opacidad para quien va a cobrar, que no puede anticipar si el fondo de su turno estará completo hasta que la fecha llega y ya no hay margen de reacción. En conjunto, estas consecuencias erosionan la confianza entre conocidos, que es el activo sobre el cual una junta se sostiene, y explican tanto la disolución de numerosos grupos tras un único ciclo como la abstención de personas que valoran el mecanismo pero desconfían de su administración.

### 1.2.2. Lean UX Process

En esta sección aplicamos el Lean UX Process [@gothelf2021leanux].
Presentamos los Problem Statement, Assumptions, Hypothesis Statements y el Lean UX
Canvas, adaptados al proyecto Pozzo.

#### 1.2.2.1. Lean UX Problem Statements

El estado actual de la administración de juntas de ahorro en el Perú se ha
centrado principalmente en digitalizar la transferencia individual de dinero.
Las billeteras digitales resolvieron el aporte, que hoy se hace desde el
teléfono en segundos, pero el control del ciclo sigue recayendo en la cabeza de
junta: anota en un cuaderno o en un Excel quién depositó, revisa una por una las
capturas que llegan al chat grupal y, cuando se acerca la fecha de corte, le
escribe a cada uno de los que faltan. El participante, por su parte, guarda sus
capturas sin orden en la galería del teléfono, ha tenido que defender un pago que
sí hizo y llega a su turno sin saber si el pozo estará completo.

Lo que los productos existentes no atienden es la lógica del ahorro rotativo. La
billetera digital desconoce que el grupo existe, no gestiona turnos ni
periodicidad y no consolida los aportes de varias personas hacia un pozo común.
No hay una fuente única y verificable que indique quién ha depositado, quién
adeuda y cuánto falta para completar el turno vigente; esa información queda
repartida entre el registro manual del organizador, el grupo de mensajería y la
aplicación de billetera.

Nuestra solución atenderá ese vacío con un registro compartido y verificable del
ciclo de la junta, sin intervenir en el movimiento del dinero, que seguirá
ocurriendo por las billeteras que el grupo ya utiliza. Pozzo permitirá
configurar el monto, el número de participantes, la periodicidad y la asignación
de turnos, registrar cada aporte junto con su comprobante y mostrar a todos los
integrantes el estado del pozo en tiempo real.

Nuestro foco inicial será la cabeza de junta, identificada como el tomador de
decisión principal para la adopción de Pozzo. Es quien asume
hoy la carga administrativa sin compensación, quien responde ante el grupo
cuando la cuenta no cuadra y quien decide con qué herramienta se administra la
junta; el participante se incorpora a una junta que alguien más ya creó.

Sabremos que vamos bien cuando veamos que al menos el 80 % de los aportes de
un ciclo se validan sin que la cabeza de junta revise el comprobante a mano,
frente al 100 % que revisa hoy; que la cabeza no envía ningún recordatorio de
cobranza por su cuenta durante el ciclo, cuando hoy escribe a dos o tres
personas hasta tres o cinco veces cada una; que toda discrepancia sobre un
aporte se resuelve consultando la aplicación y ninguna queda sin comprobante
localizable; y que todas las juntas piloto completan un ciclo entero en Pozzo
sin volver al cuaderno ni al grupo de mensajería para llevar la cuenta.

#### 1.2.2.2. Lean UX Assumptions

A partir de la discusión del equipo sobre el dominio del problema se enuncian
las creencias que sostienen la propuesta, agrupadas en los cinco tipos de
assumptions del Lean UX Process. Cada una es una afirmación que damos por cierta
sin haberla comprobado todavía y que, por tanto, debe validarse a lo largo del
proyecto.

##### Business Assumptions

- Existe un número suficiente de juntas urbanas que ya mueven sus aportes por
  billeteras digitales y siguen llevando el control de forma manual.
- Administrar la junta sin custodiar ni movilizar el dinero mantiene a Kero
  fuera del perímetro regulatorio que aplica a las entidades de pago, lo que
  reduce las barreras legales para operar.
- La trazabilidad del ciclo completo es una ventaja defendible frente a los
  sustitutos reales de Pozzo, que son el cuaderno del organizador y el chat
  grupal, y no otras aplicaciones.
- La cabeza de junta decide con qué herramienta se administra el grupo, de modo
  que la adopción puede conseguirse convenciendo al organizador y no a cada
  participante por separado.
- El equipo cuenta con las capacidades técnicas y el tiempo necesarios para
  construir y sostener la aplicación móvil, los servicios RESTful y el landing
  page dentro del ciclo académico.

##### Business Outcome Assumptions

- Todas las juntas piloto que adoptan Pozzo completan un ciclo entero dentro
  de la aplicación, sin volver al cuaderno ni al grupo de mensajería para llevar
  la cuenta.
- La cabeza de junta deja de revisar comprobantes uno por uno: al menos el 80 %
  de los aportes de un ciclo se validan sin su intervención, frente al 100 % que
  revisa a mano hoy (entre 15 y 20 comprobantes por ciclo en una junta de diez
  personas).
- La cabeza de junta no envía ningún recordatorio de cobranza por su cuenta
  durante el ciclo, cuando hoy escribe a dos o tres personas hasta tres o cinco
  veces cada una.
- Ninguna discrepancia sobre un aporte queda sin comprobante localizable: el
  100 % se resuelve consultando la aplicación, cuando hoy el 100 % de las
  cabezas entrevistadas ha enfrentado al menos un reclamo imposible de
  comprobar.
- Al menos una de cada tres juntas nuevas se forma con integrantes, organizadores
  o participantes, que ya usaron Pozzo en un ciclo anterior.
  
##### User Assumptions

- Los actores que interactúan con el sistema son dos: la cabeza de junta, en su
  papel de organizadora, y el participante, ambos descritos en los segmentos objetivo.
- La cabeza de junta es el tomador de decisión principal para la adopción; el
  participante se incorpora a una junta que otra persona ya creó y no elige la
  herramienta.
- Ambos gestionan su día a día desde un teléfono inteligente, mayoritariamente
  Android de gama media, y usan billeteras digitales y mensajería con soltura.
- Ambos rechazarían una solución que retenga o custodie el dinero del grupo, y
  esperan seguir transfiriendo por la billetera que ya utilizan.
- El participante está dispuesto a registrar su aporte desde la aplicación si el
  paso es breve y no le exige configurar nada.
- La junta ya existe como grupo de confianza antes de llegar a Pozzo: la
  aplicación no tiene que formar el grupo ni presentar entre sí a sus
  integrantes.

##### User Outcome and Benefit Assumptions

- La cabeza de junta quiere dejar de revisar comprobantes uno por uno y de
  escribirle individualmente a quienes no han depositado.
- La cabeza de junta quiere poder responder ante el grupo con evidencia cuando
  la cuenta no cuadra, en lugar de sostenerlo con su palabra.
- El participante quiere poder acreditar que aportó sin depender de que su
  captura siga localizable en el chat.
- El participante quiere saber, antes de que llegue su turno, si el pozo estará
  completo cuando le toque cobrar.
- El participante quiere que su historial de cumplimiento le sirva para ser
  aceptado en juntas posteriores, incluidas las de mayor monto.
- Ambos quieren conservar la dinámica social de la junta y la relación de
  confianza que la sostiene, sin que la herramienta la vuelva burocrática.

##### Feature Assumptions

- **F1.** La validación automática del aporte a partir del voucher, reconociendo
  monto, fecha y destinatario, evita que la cabeza de junta revise los
  comprobantes uno por uno.
- **F2.** Un calendario de turnos que muestra en tiempo real quién depositó,
  quién adeuda y cuánto falta para completar el pozo da a todo el grupo la misma
  información.
- **F3.** Los recordatorios automáticos, que aumentan su insistencia conforme se
  acerca la fecha de corte, sustituyen la labor de cobranza del organizador.
- **F4.** Permitir que los turnos se asignen por sorteo, por orden acordado o
  por subasta reproduce en la aplicación el reparto que cada junta ya practica.
- **F5.** Un historial de cumplimiento que el participante conserva al cerrar el
  ciclo le sirve como prueba de solvencia ante juntas futuras.
- **F6.** Ofrecer dos vías de incorporación, un enlace de invitación que el
  organizador comparte por mensajería y el ingreso desde la propia aplicación,
  reduce la fricción de entrada del participante al grupo.

#### 1.2.2.3. Lean UX Hypothesis Statements

Siguiendo el Lean UX Process se formula un hypothesis statement por cada feature
assumption enunciada en la sección anterior. Cada hipótesis vincula un resultado
de negocio, la persona que lo hace posible, el beneficio que esa persona obtiene
y la funcionalidad que lo habilita.

##### Hypothesis Statement 01

- **Creemos que lograremos** que el tiempo que la cabeza de junta dedica a
  administrar su junta por ciclo disminuya respecto del que dedica hoy.
- **Si** las cabezas de junta
- **Alcanzan** dejar de revisar los comprobantes uno por uno y de anotar los
  depósitos a mano
- **Con** la validación automática del aporte a partir del voucher, que reconoce
  monto, fecha y destinatario.

##### Hypothesis Statement 02

- **Creemos que lograremos** que las discrepancias sobre un aporte se resuelvan
  dentro de la aplicación y no buscando capturas antiguas en el chat.
- **Si** los participantes, en especial el que cobra el turno vigente
- **Alcanzan** saber en cualquier momento quién depositó, quién adeuda y cuánto
  falta para completar el pozo
- **Con** el calendario de turnos con el estado de los aportes en tiempo real.

##### Hypothesis Statement 03

- **Creemos que lograremos** que las juntas completen su ciclo sin que el
  organizador tenga que escribirle uno por uno a los atrasados.
- **Si** las cabezas de junta
- **Alcanzan** dejar de hacer de cobrador ante amigos, parientes y compañeros de
  trabajo
- **Con** los recordatorios automáticos que aumentan su insistencia conforme se
  acerca la fecha de corte.

##### Hypothesis Statement 04

- **Creemos que lograremos** que todas las juntas piloto completen un ciclo
  entero en Pozzo sin abandonar la aplicación a mitad de camino.
- **Si** las cabezas de junta
- **Alcanzan** reproducir en la aplicación el método de reparto que su grupo ya
  tiene acordado
- **Con** la asignación de turnos por sorteo, por orden acordado o por subasta.

##### Hypothesis Statement 05

- **Creemos que lograremos** que una parte de las juntas nuevas se forme con
  participantes que ya usaron Pozzo.
- **Si** los participantes
- **Alcanzan** acreditar su cumplimiento ante un grupo nuevo sin depender de la
  palabra de un tercero
- **Con** el historial de cumplimiento que conservan al cerrar el ciclo.

##### Hypothesis Statement 06

- **Creemos que lograremos** que las juntas que adoptan Pozzo completen un ciclo
  entero sin volver al cuaderno ni al grupo de mensajería.
- **Si** los participantes
- **Alcanzan** unirse a la junta y registrar su primer aporte sin tener que
  configurar nada
- **Con** las dos vías de incorporación: el enlace de invitación que el
  organizador comparte por mensajería y el ingreso desde la propia aplicación.

#### 1.2.2.4. Lean UX Canvas

<table>
  <colgroup><col style="width:33%"><col style="width:33%"><col style="width:34%"></colgroup>
  <thead><tr><th><strong>1. Problema de negocio</strong></th><th><strong>5. Ideas de soluciones</strong></th><th><strong>2. Resultados comerciales</strong></th></tr></thead>
  <tbody>
    <tr><td>Muchas juntas informales se administran a mano, con el dinero moviéndose por Yape pero las cuentas en un cuaderno y en capturas de WhatsApp. Esto genera errores de conteo, falta de prueba de pago y poca visibilidad sobre cuánto falta para el pozo. En ese contexto, Pozzo busca responder: ¿cómo administrar una junta que ya existe, validando los aportes y mostrando el avance en tiempo real, sin mover el dinero por la plataforma?</td><td>Lector de vouchers de Yape que valida monto, fecha y destinatario.<br>Calendario de turnos con el estado de los aportes en tiempo real.<br>Recordatorios automáticos que suben de tono.<br>Asignación de turnos por sorteo, orden acordado o subasta.<br>Historial de cumplimiento portable entre juntas.<br>Incorporación por enlace de invitación o desde la propia aplicación.</td><td>Todas las juntas piloto terminan su ciclo en la aplicación sin volver al cuaderno.<br>Al menos el 80 % de los aportes se validan sin revisión manual de la cabeza.<br>Cero recordatorios de cobranza enviados a mano por la cabeza durante el ciclo.<br>Ninguna discrepancia sin comprobante localizable en la aplicación.<br>Al menos una de cada tres juntas nuevas llega por integrantes que ya usaron Pozzo.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:50%"><col style="width:50%"></colgroup>
  <thead><tr><th><strong>3. Usuarios y clientes</strong></th><th><strong>4. Beneficios del usuario</strong></th></tr></thead>
  <tbody>
    <tr><td>La cabeza de junta arma el grupo y hoy lleva las cuentas a mano. Los participantes aportan con la periodicidad que el grupo haya pactado y esperan su turno para cobrar. El participante al que le toca cobrar necesita ver quién ya depositó y quién falta. Todos ya usan Yape y WhatsApp.</td><td>La cabeza deja de perseguir gente y de equivocarse en el conteo.<br>El participante tiene una prueba clara de su aporte.<br>El que va a cobrar sabe en tiempo real cuánto falta para el pozo.<br>Los recordatorios evitan que alguien haga de cobrador.<br>El historial de cumplimiento abre la puerta a nuevas juntas.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:32%"><col style="width:32%"><col style="width:36%"></colgroup>
  <thead><tr><th><strong>6. Hipótesis</strong></th><th><strong>7. ¿Qué es lo más importante que necesitamos aprender primero?</strong></th><th><strong>8. ¿Cuál es la menor cantidad de trabajo que necesitamos hacer para aprenderlo?</strong></th></tr></thead>
  <tbody>
    <tr><td>La validación automática del voucher reduce el tiempo que la cabeza dedica a administrar la junta.<br>El calendario en tiempo real traslada a la aplicación las discrepancias sobre un aporte.<br>Los recordatorios automáticos evitan que el organizador tenga que cobrar uno por uno.<br>El reparto por sorteo, orden acordado o subasta permite adoptar Pozzo sin cambiar la costumbre del grupo.<br>El historial de cumplimiento lleva participantes hacia juntas nuevas.<br>La invitación desde la aplicación permite registrar el primer aporte sin configurar nada.</td><td>Lo primero que debemos validar es si las cabezas y los participantes confían en que la validación del voucher de Yape basta para dar por registrado un aporte, sin revisarlo a mano. Toda la propuesta de valor depende de esa confianza.</td><td>Un experimento sin código: acompañar 2 o 3 juntas reales durante un ciclo, recibiendo las capturas de Yape por WhatsApp y respondiendo a cada participante "aporte registrado" tras validarlas a mano, como si lo hiciera el sistema. Al cierre, medir si la cabeza dejó de revisar sus movimientos por su cuenta y cuántos reclamos surgieron. Si la confianza se sostiene, recién entonces construir el lector de vouchers, el calendario y los recordatorios.</td></tr>
  </tbody>
</table>

## 1.3. Segmentos objetivo

- **La Cabeza o Administrador(a) de Junta (Organizador/a)**

En el entorno peruano, las juntas se sostienen gracias a una persona clave: la cabeza de junta. Suele ser el referente de confianza en la familia, el trabajo o el barrio. Aunque hoy la mayoría de los aportes se transfieren por Yape o Plin, esta persona sigue llevando el control en un cuaderno, una libreta o la memoria. Asume voluntariamente una gran responsabilidad: definir las reglas, armar los turnos, revisar comprobantes uno a uno y responder frente al grupo si la cuenta no cuadra. Al tener la potestad de decidir cómo se administra el grupo, es el tomador de decisión principal (*Primary Decision Maker*) para la adopción de Pozzo.

Demográficamente, abarca a hombres y mujeres de 28 a 55 años en zonas urbanas y periurbanas, principalmente comerciantes, trabajadores dependientes y jefes de hogar (NSE B, C y D). Cuentan con educación secundaria, técnica o superior. No buscan software contable complejo ni corporativo; necesitan una herramienta práctica que alivie su carga operativa sin quitarles el control ni alterar la relación de confianza con sus conocidos.

En lo psicográfico, se caracterizan por su alto sentido del compromiso y reputación intachable. Sin embargo, experimentan un desgaste emocional constante: les resulta sumamente incómodo hacer el papel de cobrador frente a amigos o parientes cuando se acerca la fecha de pago. Su mayor frustración es el desorden de revisar capturas en chats saturados, el tiempo que pierden verificando depósitos a deshoras y el temor constante a que un descuadre los obligue a poner dinero de su propio bolsillo para no romper la cadena.

A nivel tecnográfico, gestionan su rutina desde smartphones (mayoritariamente Android de gama media). Usan WhatsApp y billeteras móviles a diario con total fluidez, pero evitan usar hojas de cálculo complejas en computadora. Demandan una aplicación móvil visual y ligera que automatice la lectura de vouchers de pago y les ahorre el seguimiento manual, con la condición indispensable de que la plataforma no retenga ni custodie el dinero del grupo.

- **El Participante de Junta (Aportante / Beneficiario)**

Representa a la gran mayoría de integrantes: personas que entran a una junta como método de ahorro forzoso o para conseguir dinero rápido sin recurrir a préstamos bancarios con altos intereses. Aunque cumplen transfiriendo su cuota en segundos desde su celular, quedan en una posición de incertidumbre: dependen de la palabra y anotaciones del organizador, carecen de visibilidad sobre el estado real de la recaudación y no tienen un medio ágil para defenderse si una transferencia suya es pasada por alto o cuestionada.

A nivel demográfico, está conformado por hombres y mujeres de 20 a 45 años, desde jóvenes que inician su vida laboral hasta trabajadores independientes o asalariados con ingresos regulares (semanales, quincenales o mensuales). En Pozzo actúan como usuarios finales (*End Users*): no configuran los parámetros de la junta, pero sobre ellos recae la acción recurrente de ingresar a la app, registrar su voucher y consultar su fecha de cobro.

En su comportamiento cotidiano, valoran el apoyo mutuo del grupo, pero conviven con la duda de si los demás integrantes pagarán puntuales. Su principal molestia surge ante la pérdida de comprobantes en el chat grupal y los reclamos del tipo *"yo sí te yapeé"*. Además, sienten ansiedad cuando se acerca su turno de cobro y no saben si el pozo estará completo a tiempo. Tienen interés en que su historial de pagos puntuales quede registrado como prueba de solvencia para participar en futuras juntas de mayor monto.

Tecnográficamente, son usuarios nativos del teléfono móvil. Están acostumbrados a pagar escaneando códigos QR y rechazan registros largos, trámites burocráticos o aplicaciones que pretendan retener sus fondos antes de entregarlos al pozo. Esperan sumarse a la junta a través de un simple enlace de invitación por WhatsApp, validar su cuota subiendo la captura del voucher en dos toques y ver con total transparencia el calendario de cobro en tiempo real.