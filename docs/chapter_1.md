# Capítulo I: Presentación

## 1.1. Startup Profile

En esta sección se presenta el perfil de Kero, incluyendo una descripción general de la startup, su propósito, misión y visión, así como los perfiles de los integrantes del equipo y las principales capacidades que aportan al desarrollo de Pozzo.

### 1.1.1. Descripción de la Startup

Kero es una startup peruana de tecnología financiera comunitaria enfocada en digitalizar la administración de juntas de ahorro. Su producto principal, Pozzo, nace como respuesta a una situación frecuente en estos grupos: aunque los aportes ya se realizan mediante billeteras digitales como Yape, el control de pagos, turnos, comprobantes y recordatorios continúa dependiendo de cuadernos, capturas y mensajes de WhatsApp.

Pozzo permite centralizar la gestión de la junta sin intervenir directamente en el movimiento del dinero. La cabeza de junta puede configurar el monto, número de participantes, periodicidad y asignación de turnos, mientras que los participantes pueden consultar su calendario, registrar sus aportes mediante vouchers y conocer en tiempo real el estado del pozo. De esta manera, la aplicación busca reducir errores de conteo, facilitar la verificación de pagos y disminuir la carga de seguimiento que actualmente recae sobre el organizador.

La propuesta de Kero está orientada principalmente a grupos de familiares, amigos, vecinos o compañeros de trabajo que ya utilizan juntas como mecanismo de ahorro y desean mantener su dinámica habitual, pero con una administración más ordenada, transparente y verificable. A través de Pozzo, la startup busca combinar la confianza social propia de las juntas con herramientas digitales que simplifiquen su operación.

|                                                                                                                 **Misión**                                                                                                                |                                                                                                               **Visión**                                                                                                               |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| Facilitar la administración de juntas de ahorro mediante una solución digital simple y confiable que permita organizar aportes, turnos y comprobantes, reduciendo el trabajo manual y mejorando la transparencia entre sus participantes. | Ser una plataforma referente en la digitalización de juntas de ahorro en el Perú y Latinoamérica, contribuyendo a modernizar mecanismos financieros comunitarios sin alterar la confianza y dinámica social sobre la que se sostienen. |

### 1.1.2. Perfiles de integrantes del equipo

| Integrante                                                                     | Información                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|--------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Leonardo Sanchez Benavente](images/chapter_1/leonardo_sanchez_benavente.jpg) | **Leonardo Matias Sanchez Benavente**<br>**Código de estudiante:** U20241b184<br>**Carrera:** Ingeniería de Software<br><br>Estudiante de Ingeniería de Software con base en desarrollo web full-stack: Angular y TypeScript en el cliente, Java con Spring Boot y APIs REST bajo enfoque DDD en el servidor.<br><br>                                                                                                                                                                                                                                                                       |
| ![Gabriela Tirado Carrera](images/chapter_1/gabriela_tirado_carrera.jpeg)      | **Gabriela Luciana Tirado Carrera**<br>**Código de estudiante:** U202519592<br>**Carrera:** Ingeniería de Software<br><br>Estudiante de Ingeniería de Software con conocimientos en desarrollo Full Stack, incluyendo Angular, Vue, HTML, CSS, C#, Java, JavaScript y SQL. Hábil en trabajo de equipos y desarrollo de interfaces.<br><br>                                                                                                                                                                                                                                                  |
| ![Joseph Julius Camargo Briceño](images/chapter_1/julius_camargo.png)          | **Joseph Julius Camargo Briceño**<br>**Código de estudiante:** U20241D992<br>**Carrera:** Ingeniería de Software<br><br>Estudiante de Ingeniería de Software especializado en C++ y en desarrollo backend con Java y C#, con conocimientos de HTML, CSS básico y frameworks frontend como Vue y Angular. Orientado a resultados, tanto a nivel de equipo como individual, con capacidad para potenciar el rendimiento del grupo. Abierto a las ideas y opiniones ajenas, y promotor del diálogo y el debate constructivo ante perspectivas en conflicto.<br><br>                            |
| ![Jose Fernando Flores Pinchi](images/chapter_1/fernando_flores.png)           | **Jose Fernando Flores Pinchi**<br>**Código de estudiante:** U20241A290<br>**Carrera:** Ingeniería de Software<br><br>Estudiante de Ingeniería de Software de cuarto ciclo, con conocimientos en bases de datos, HTML, CSS y frameworks como Vue y Angular, con orientación hacia la ciberseguridad. Responsable y adaptable, con interés en el aprendizaje continuo y la innovación tecnológica. Aplica sus conocimientos en proyectos prácticos que aporten valor y mejoren la vida cotidiana, fortaleciendo sus competencias mediante la colaboración con otros desarrolladores.<br><br> |
| ![Estefano Sebastian Solis Campos](images/chapter_1/estefano_solis_campos.png) | **Estefano Sebastian Solis Campos**<br>**Código de estudiante:** U202314354<br>**Carrera:** Ingeniería de Software<br><br>Estudiante apasionado de la carrera de Ingeniería de Software, enfocado en aplicar sus conocimientos para el desarrollo de soluciones tecnológicas innovadoras y en constante búsqueda de oportunidades de aprendizaje y crecimiento profesional en el sector tecnológico. |

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
    * El costo específico del problema (horas mensuales que invierte una cabeza de junta en labores administrativas, frecuencia de discrepancias por ciclo y monto promedio en disputa) se cuantifica a partir de las entrevistas registradas, y constituye una de las asunciones a validar dentro del proceso Lean UX.

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
junta: anota en un cuaderno quién depositó, revisa una por una las capturas que
llegan al chat grupal y, cuando se acerca la fecha de corte, le escribe a cada
uno de los que faltan.

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

Sabremos que vamos bien cuando veamos que una cabeza de junta dedica menos
tiempo a administrar su junta por ciclo del que dedica hoy y deja de verificar
comprobantes uno por uno; que una discrepancia sobre un aporte se resuelve
consultando la aplicación en lugar de buscar una captura antigua en el historial
del chat; y que las juntas completan un ciclo entero en Pozzo sin volver al
cuaderno ni al grupo de mensajería para llevar la cuenta.

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

- Las juntas que adoptan Pozzo completan un ciclo entero dentro de la
  aplicación, sin volver al cuaderno ni al grupo de mensajería para llevar la
  cuenta.
- El tiempo que la cabeza de junta dedica a administrar su junta por ciclo
  disminuye respecto del que dedica hoy.
- La proporción de aportes que se validan sin que la cabeza de junta los revise
  manualmente aumenta a lo largo del ciclo.
- Las discrepancias sobre un aporte se resuelven consultando la aplicación en
  lugar de buscar una captura antigua en el historial del chat.
- Una parte de las juntas nuevas se forma por recomendación de organizadores que
  ya utilizan Pozzo.
  
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

##### Hypothesis Statement 01 (a partir de F1)

- **Creemos que lograremos** que el tiempo que la cabeza de junta dedica a
  administrar su junta por ciclo disminuya respecto del que dedica hoy.
- **Si** las cabezas de junta
- **Alcanzan** dejar de revisar los comprobantes uno por uno y de anotar los
  depósitos a mano
- **Con** la validación automática del aporte a partir del voucher, que reconoce
  monto, fecha y destinatario.

##### Hypothesis Statement 02 (a partir de F2)

- **Creemos que lograremos** que las discrepancias sobre un aporte se resuelvan
  dentro de la aplicación y no buscando capturas antiguas en el chat.
- **Si** los participantes y quien cobra el turno vigente
- **Alcanzan** saber en cualquier momento quién depositó, quién adeuda y cuánto
  falta para completar el pozo
- **Con** el calendario de turnos con el estado de los aportes en tiempo real.

##### Hypothesis Statement 03 (a partir de F3)

- **Creemos que lograremos** que las juntas completen su ciclo sin que el
  organizador tenga que escribirle uno por uno a los atrasados.
- **Si** las cabezas de junta
- **Alcanzan** dejar de hacer de cobrador ante amigos, parientes y compañeros de
  trabajo
- **Con** los recordatorios automáticos que aumentan su insistencia conforme se
  acerca la fecha de corte.

##### Hypothesis Statement 04 (a partir de F4)

- **Creemos que lograremos** que una junta pueda adoptar Pozzo sin modificar la
  forma en que ya reparte sus turnos.
- **Si** las cabezas de junta
- **Alcanzan** reproducir en la aplicación el método de reparto que su grupo ya
  tiene acordado
- **Con** la asignación de turnos por sorteo, por orden acordado o por subasta.

##### Hypothesis Statement 05 (a partir de F5)

- **Creemos que lograremos** que una parte de las juntas nuevas se forme con
  participantes que ya usaron Pozzo.
- **Si** los participantes
- **Alcanzan** acreditar su cumplimiento ante un grupo nuevo sin depender de la
  palabra de un tercero
- **Con** el historial de cumplimiento que conservan al cerrar el ciclo.

##### Hypothesis Statement 06 (a partir de F6)

- **Creemos que lograremos** que las juntas que adoptan Pozzo completen un ciclo
  entero sin volver al cuaderno ni al grupo de mensajería.
- **Si** los participantes
- **Alcanzan** unirse a la junta y registrar su primer aporte sin tener que
  configurar nada
- **Con** las dos vías de incorporación: el enlace de invitación que el
  organizador comparte por mensajería y el ingreso desde la propia aplicación.

#### 1.2.2.4. Lean UX Canvas

| **1. Problema de negocio** | **5. Ideas de soluciones** | **2. Resultados comerciales** |
| --- | --- | --- |
| Muchas juntas informales se administran a mano, con el dinero moviéndose por Yape pero las cuentas en un cuaderno y en capturas de WhatsApp. Esto genera errores de conteo, falta de prueba de pago y poca visibilidad sobre cuánto falta para el pozo. En ese contexto, Pozzo busca responder: ¿cómo administrar una junta que ya existe, validando los aportes y mostrando el avance en tiempo real, sin mover el dinero por la plataforma? | Lector de vouchers de Yape que valida monto, fecha y destinatario.<br>Calendario de turnos con el estado de los aportes en tiempo real.<br>Recordatorios automáticos que suben de tono.<br>Asignación de turnos por sorteo, orden acordado o subasta.<br>Historial de cumplimiento portable entre juntas.<br>Incorporación por enlace de invitación o desde la propia aplicación.<br>Administración de la junta sin custodiar el dinero. | Más juntas activas administradas en Pozzo cada mes.<br>Cabezas que siguen usando Pozzo en el siguiente ciclo.<br>Menor costo de adquisición por la invitación en cadena.<br>Juntas que terminan su ciclo en la aplicación sin volver al cuaderno.<br>Pozzo posicionado como forma confiable de administrar juntas. |

<br><br>

| **3. Usuarios y clientes** | **4. Beneficios del usuario** |
| --- | --- |
| La cabeza de junta arma el grupo y hoy lleva las cuentas a mano. Los participantes aportan con la periodicidad que el grupo haya pactado y esperan su turno para cobrar. El integrante que cobra el turno vigente necesita ver quién ya depositó y quién falta. Todos ya usan Yape y WhatsApp. | La cabeza deja de perseguir gente y de equivocarse en el conteo.<br>El participante tiene una prueba clara de su aporte.<br>El que cobra sabe en tiempo real cuánto falta para el pozo.<br>Los recordatorios evitan que alguien haga de cobrador.<br>El historial de cumplimiento abre la puerta a nuevas juntas. |

<br><br>

| **6. Hipótesis** | **7. ¿Qué es lo más importante que necesitamos aprender primero?** | **8. ¿Cuál es la menor cantidad de trabajo que necesitamos hacer para aprenderlo?** |
| --- | --- | --- |
| La validación automática del voucher reduce el tiempo que la cabeza dedica a administrar la junta.<br>El calendario en tiempo real traslada a la aplicación las discrepancias sobre un aporte.<br>Los recordatorios automáticos evitan que el organizador tenga que cobrar uno por uno.<br>El reparto por sorteo, orden acordado o subasta permite adoptar Pozzo sin cambiar la costumbre del grupo.<br>El historial de cumplimiento lleva participantes hacia juntas nuevas.<br>La invitación desde la aplicación permite registrar el primer aporte sin configurar nada. | Lo primero que debemos validar es si las cabezas y los participantes confían en que la validación del voucher de Yape basta para dar por registrado un aporte, sin revisarlo a mano. Toda la propuesta de valor depende de esa confianza. | Lanzar un MVP acotado: una junta piloto con configuración básica, lector de vouchers de Yape, calendario en tiempo real y recordatorios automáticos. Probarlo durante 1 o 2 ciclos con 2 o 3 juntas, midiendo aportes validados solos, tiempo de conteo de la cabeza y reclamos por pagos, para ajustar el modelo antes de ampliar el alcance. |

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