# Capítulo I: Presentación

## 1.1. Startup Profile
En esta sección se presenta el perfil de Kero, incluyendo una descripción general de la startup, su propósito, misión y visión, así como los perfiles de los integrantes del equipo y las principales capacidades que aportan al desarrollo de Pozzo.

### 1.1.1. Descripción de la Startup

Kero es una startup peruana de tecnología financiera comunitaria enfocada en digitalizar la administración de juntas de ahorro. Su producto principal, Pozzo, nace como respuesta a una situación frecuente en estos grupos: aunque los aportes ya se realizan mediante billeteras digitales como Yape, el control de pagos, turnos, comprobantes y recordatorios continúa dependiendo de cuadernos, capturas y mensajes de WhatsApp.

Pozzo permite centralizar la gestión de la junta sin intervenir directamente en el movimiento del dinero. La cabeza de junta puede configurar el monto, número de participantes, periodicidad y asignación de turnos, mientras que los participantes pueden consultar su calendario, registrar sus aportes mediante vouchers y conocer en tiempo real el estado del pozo. De esta manera, la aplicación busca reducir errores de conteo, facilitar la verificación de pagos y disminuir la carga de seguimiento que actualmente recae sobre el organizador.

La propuesta de Kero está orientada principalmente a grupos de familiares, amigos, vecinos o compañeros de trabajo que ya utilizan juntas como mecanismo de ahorro y desean mantener su dinámica habitual, pero con una administración más ordenada, transparente y verificable. A través de Pozzo, la startup busca combinar la confianza social propia de las juntas con herramientas digitales que simplifiquen su operación.

**Misión:**  
Facilitar la administración de juntas de ahorro mediante una solución digital simple y confiable que permita organizar aportes, turnos y comprobantes, reduciendo el trabajo manual y mejorando la transparencia entre sus participantes.

**Visión:**  
Ser una plataforma referente en la digitalización de juntas de ahorro en el Perú y Latinoamérica, contribuyendo a modernizar mecanismos financieros comunitarios sin alterar la confianza y dinámica social sobre la que se sostienen.

### 1.1.2. Perfiles de integrantes del equipo

| Integrante                                                                     | Información                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|--------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Leonardo Sanchez Benavente](images/chapter_1/leonardo_sanchez_benavente.jpg) | **Leonardo Matias Sanchez Benavente**<br>**Código de estudiante:** U20241b184<br>**Carrera:** Ingeniería de Software<br><br>Estudiante de Ingeniería de Software con base en desarrollo web full-stack: Angular y TypeScript en el cliente, Java con Spring Boot y APIs REST bajo enfoque DDD en el servidor.<br><br>                                                                                                                                                                                                                                                                       |
| ![Gabriela Tirado Carrera](images/chapter_1/gabriela_tirado_carrera.jpeg)      | **Gabriela Luciana Tirado Carrera**<br>**Código de estudiante:** U202519592<br>**Carrera:** Ingeniería de Software<br><br>Estudiante de Ingeniería de Software con conocimientos en desarrollo Full Stack, incluyendo Angular, Vue, HTML, CSS, C#, Java, JavaScript y SQL. Hábil en trabajo de equipos y desarrollo de interfaces.<br><br>                                                                                                                                                                                                                                                  |
| ![Joseph Julius Camargo Briceño](images/chapter_1/julius_camargo.png)          | **Joseph Julius Camargo Briceño**<br>**Código de estudiante:** U20241D992<br>**Carrera:** Ingeniería de Software<br><br>Estudiante de Ingeniería de Software especializado en C++ y en desarrollo backend con Java y C#, con conocimientos de HTML, CSS básico y frameworks frontend como Vue y Angular. Orientado a resultados, tanto a nivel de equipo como individual, con capacidad para potenciar el rendimiento del grupo. Abierto a las ideas y opiniones ajenas, y promotor del diálogo y el debate constructivo ante perspectivas en conflicto.<br><br>                            |
| ![Jose Fernando Flores Pinchi](images/chapter_1/fernando_flores.png)           | **Jose Fernando Flores Pinchi**<br>**Código de estudiante:** U20241A290<br>**Carrera:** Ingeniería de Software<br><br>Estudiante de Ingeniería de Software de cuarto ciclo, con conocimientos en bases de datos, HTML, CSS y frameworks como Vue y Angular, con orientación hacia la ciberseguridad. Responsable y adaptable, con interés en el aprendizaje continuo y la innovación tecnológica. Aplica sus conocimientos en proyectos prácticos que aporten valor y mejoren la vida cotidiana, fortaleciendo sus competencias mediante la colaboración con otros desarrolladores.<br><br> |

## 1.2. Solution Profile
Kero es una iniciativa de tecnología financiera comunitaria orientada a digitalizar la administración de las juntas peruanas a través de su producto central: Pozzo. Nuestra solución es un ecosistema compuesto por una aplicación móvil nativa para el participante, una aplicación multiplataforma para el organizador de la junta y un conjunto de servicios web RESTful que sostienen la lógica del ciclo de ahorro rotativo.

### 1.2.1. Antecedentes y problemática
La junta, denominada también pandero o tanomoshi, es una asociación rotativa de ahorro y crédito en la que un grupo de personas conocidas entre sí aporta un monto fijo con periodicidad acordada, y el fondo acumulado en cada período se entrega íntegro a un integrante distinto hasta que todos han cobrado una vez. La literatura académica estudia esta figura bajo la denominación de **ROSCA** (*Rotating Savings and Credit Association*), presente con nombres propios en prácticamente todo el mundo en desarrollo: *tanda* en México, *susu* en África Occidental, *chit fund* en la India y *pasanaku* en Bolivia.

Su vigencia en el Perú no es residual. Al segundo trimestre de 2025, el 61,6 % de la población de 18 años a más contaba con al menos un producto en el sistema financiero, lo que implica que casi cuatro de cada diez adultos peruanos permanecen fuera de él, con una brecha que se acentúa en el área rural, donde el acceso desciende al 41,8 % (SBS, 2025). En ese espacio operan las juntas: los estudios sobre ahorro voluntario en el país las ubican como el 7 % de las formas de ahorro de los hogares peruanos, proporción que asciende al 18,9 % entre quienes alcanzaron a lo sumo educación primaria (SBS, 2020). La razón predominante para preferir este mecanismo, según la misma fuente, no es la ausencia de oferta financiera sino la desconfianza hacia las entidades formales.

Simultáneamente, el medio de pago que sostiene a estas juntas ya se digitalizó por completo. Yape cerró el año 2025 con 19,1 millones de usuarios y 15,9 millones de usuarios activos mensuales, y entre las principales billeteras digitales del país se procesan más de 1,6 millones de transacciones diarias. El aporte a la junta se realiza hoy desde el teléfono, en segundos y sin efectivo. **Lo que no se digitalizó fue la administración**: el registro de quién aportó, el control de los turnos, la cobranza a los morosos y la prueba de que un pago efectivamente ocurrió continúan dependiendo de un cuaderno, de un grupo de mensajería saturado de capturas de pantalla y de la memoria del organizador.

Al analizar esta situación mediante la técnica de las **5 W's y 2 H's** se identifican los siguientes elementos:

* **Who (Quiénes):** La **cabeza de junta**, que asume sin compensación el trabajo de registrar aportes, verificar comprobantes y cobrar a los atrasados, y que responde ante el grupo cuando la cuenta no cuadra; y el **participante**, que carece de un medio para acreditar un aporte cuestionado y de visibilidad sobre si el fondo estará completo al llegar su turno de cobro. De forma indirecta, el problema alcanza al grupo entero, pues un incumplimiento no detectado a tiempo deteriora una relación personal preexistente.

* **What (Qué):** La problemática radica en la **desconexión entre un medio de pago digitalizado y una administración analógica**. No existe una fuente única y confiable que indique quién ha depositado, quién adeuda y cuánto falta para completar el pozo del turno vigente; esa información permanece dispersa entre el cuaderno del organizador, el chat grupal y la aplicación de billetera digital.

* **When (Cuándo):** En cada período de aporte, con la frecuencia que la junta haya pactado (semanal, quincenal o mensual), y se agrava en los días previos a la fecha de corte, cuando el organizador debe requerir individualmente a quienes no han depositado. El punto de máxima tensión es la fecha de entrega del fondo, momento en que el pozo debe estar íntegro.

* **Where (Dónde):** En juntas de ámbito urbano en el Perú, conformadas entre compañeros de trabajo, vecinos y familiares. Operativamente, el problema reside en tres espacios simultáneos y desconectados entre sí: el registro manual del organizador, el grupo de mensajería donde se remiten los comprobantes y la billetera digital donde ocurre la transferencia efectiva.

* **Why (Por qué):** Porque la billetera digital resuelve la transferencia individual pero no está diseñada para la lógica de un ahorro rotativo: desconoce la existencia del grupo, no gestiona turnos ni periodicidad y no consolida los aportes de múltiples personas hacia un objetivo común. Ese vacío funcional lo cubre hoy una persona con un cuaderno.

* **How (Cómo):** El participante transfiere mediante la billetera digital, captura el comprobante y lo remite al grupo. El organizador revisa las capturas una por una, las contrasta con su registro manual y escribe a quienes faltan. Ante una discrepancia, la controversia se dirime buscando manualmente una captura antigua en el historial del chat, o simplemente no se dirime.

* **How Much (Cuánto):**
    * Las juntas y panderos representan el **7 %** de las formas de ahorro de los hogares peruanos, proporción que alcanza el **18,9 %** entre los de menor nivel educativo y el **7,4 %** en hogares encabezados por mujeres frente al 5,7 % en los encabezados por hombres (SBS, 2020).
    * La base potencial la constituye el **38,4 %** de adultos peruanos sin producto alguno en el sistema financiero, cifra que se eleva al 58,2 % en el área rural (SBS, 2025).
    * El mercado global de aplicaciones para la digitalización de ROSCAs fue valorizado en **USD 0,92 mil millones** en 2025, con una tasa de crecimiento anual compuesta proyectada de 14,5 % hacia 2034.
    * El costo específico del problema (horas mensuales que invierte una cabeza de junta en labores administrativas, frecuencia de discrepancias por ciclo y monto promedio en disputa) se cuantificará a partir de las entrevistas registradas en la sección 2.2, y constituye una de las asunciones a validar dentro del proceso Lean UX.

De este análisis se desprende que el problema no es la carencia de un medio de pago ni la ausencia de confianza entre los integrantes de una junta, sino la **falta de un registro compartido y verificable sobre un dinero que ya circula de forma digital**. Dicho vacío produce tres consecuencias concretas: una carga administrativa no remunerada que recae íntegramente sobre el organizador, quien además debe ejercer de cobrador frente a personas de su entorno cercano; la imposibilidad de dirimir una discrepancia cuando un participante sostiene haber depositado y el registro indica lo contrario; y la opacidad para quien va a cobrar, que no puede anticipar si el fondo de su turno estará completo hasta que la fecha llega y ya no hay margen de reacción. En conjunto, estas consecuencias erosionan la confianza entre conocidos, que es el activo sobre el cual una junta se sostiene, y explican tanto la disolución de numerosos grupos tras un único ciclo como la abstención de personas que valoran el mecanismo pero desconfían de su administración.

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
