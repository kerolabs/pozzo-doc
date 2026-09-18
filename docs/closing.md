# Conclusiones

## Conclusiones y recomendaciones

Esta primera entrega cubre el descubrimiento del problema, la especificación de requisitos y el diseño de la solución. Todavía no existe un producto con el que validar las hipótesis del Lean UX Process, así que las conclusiones contrastan el Problem Statement, los assumptions y las hipótesis con la única evidencia disponible hasta ahora: las seis entrevistas registradas y analizadas en la sección Entrevistas.

**Sobre el Problem Statement.** El problema descrito en la sección Lean UX Problem Statements se confirmó en su totalidad. Las tres cabezas de junta entrevistadas administran su junta con un cuaderno o un Excel, validan los pagos revisando uno por uno sus movimientos de Yape y las capturas del chat, y escriben a dos o tres integrantes en cada ciclo para cobrar. Los tres participantes guardan sus capturas sin orden, ya tuvieron que demostrar un pago que sí habían hecho y llegan a su turno sin saber si el pozo estará completo. Ninguno de los seis usa una aplicación dedicada: el sustituto real de Pozzo es el cuaderno y el chat grupal, no otro producto digital, tal como se había asumido.

**Sobre los assumptions.** De los Business Assumptions, las entrevistas respaldan que las juntas urbanas ya mueven sus aportes por billetera digital (el 100 % de ambos segmentos usa Yape o Plin) y que la cabeza de junta es quien decide cómo se administra el grupo; los participantes declararon entrar por confianza en quien organiza, no por la herramienta. Los User Assumptions sobre el rechazo a una solución que custodie el dinero y sobre la disposición del participante a registrar su aporte si el paso es breve se sostienen en lo que los entrevistados dijeron, pero se comprobarán recién con el producto en sus manos. Quedan sin evidencia todavía el assumption de que existe un número suficiente de juntas para sostener el negocio y el de que el equipo puede construir y sostener los tres productos dentro del ciclo académico; el primero depende de las juntas piloto y el segundo se resolverá en los sprints.

**Sobre los Hypothesis Statements.** Las seis hipótesis siguen abiertas, porque cada una requiere que la funcionalidad exista. Lo que las entrevistas aportaron es la prioridad con que conviene probarlas. La validación automática del aporte a partir del comprobante (Hypothesis Statement 01) y el estado del pozo en tiempo real (02) atacan los problemas presentes en el 100 % de los entrevistados y por eso encabezan el Product Backlog y el diseño del Bounded Context Contributions. Los recordatorios automáticos (03) responden a una carga que las tres cabezas describieron con fastidio. La asignación de turnos por sorteo, orden acordado o subasta (04) reproduce prácticas que los entrevistados ya conocen, aunque ninguno mencionó la subasta de forma espontánea, lo que justifica que quede en el último sprint. El historial de cumplimiento (05) es la hipótesis con menor sustento directo: los participantes valoran la confianza personal por encima de cualquier registro, así que su utilidad se verá recién cuando alguien intente entrar a una junta de desconocidos.

**Sobre los criterios de éxito.** Las entrevistas fijaron la línea base contra la que se medirán los criterios definidos en el Problem Statement: hoy el 100 % de los comprobantes se revisa a mano, la cabeza escribe a dos o tres personas varias veces por ciclo, el 100 % de las cabezas ha enfrentado al menos un reclamo imposible de comprobar y el 67 % de los participantes sufrió un retraso en su última cobranza. Sin esa línea base, los umbrales del 80 % de aportes validados sin intervención y de cero recordatorios manuales no tendrían con qué compararse.

**Sobre el diseño.** El EventStorming de nivel de diseño y el Candidate Context Discovery produjeron cinco Bounded Contexts, con Contributions como núcleo, y el Context Mapping fijó sus relaciones con los patrones Customer/Supplier, Open Host Service con Published Language, Conformist y Anti-corruption Layer, y descartó el Shared Kernel para que cada integrante pueda trabajar en un contexto sin bloquear a los demás. La decisión de aislar la validación de aportes del resto del sistema es coherente con la prioridad que las entrevistas dieron a ese problema, y el diseño táctico de cada contexto quedó listo para que la implementación empiece por ahí.

**Recomendaciones.** Para la siguiente entrega el equipo debe ejecutar primero el spike de lectura automática de comprobantes, porque de su resultado depende la hipótesis principal y la estimación de las historias de validación; desplegar el landing page y registrar el interés de las cabezas de junta que lleguen desde él, como primera señal del tamaño del mercado; construir el flujo mínimo que permita a una junta piloto crear el grupo, invitar integrantes, asignar turnos y ver el estado del pozo, que es lo que exige la hipótesis de completar un ciclo entero en Pozzo; y volver a entrevistar a los mismos seis participantes con las pantallas core, para confirmar con el producto lo que hoy solo se sostiene con sus declaraciones.

# Glosario

Este glosario reúne los términos de metodología, diseño y desarrollo de software que se usan a lo largo del informe. Los términos propios del dominio de las juntas de ahorro (junta, pozo, turno, cabeza de junta, cobertura, historial de cumplimiento y los demás) se definen en la sección Ubiquitous Language y no se repiten aquí.

<table>
  <colgroup><col width="28%"><col width="72%"></colgroup>
  <thead>
    <tr>
      <th>Término</th>
      <th>Definición</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Acceptance Criteria</td>
      <td>Condiciones que una User Story debe cumplir para considerarse terminada. En este informe se redactan en formato Gherkin y en tiempo presente.</td>
    </tr>
    <tr>
      <td>Aggregate</td>
      <td>En Domain-Driven Design, conjunto de entidades y objetos de valor que se tratan como una unidad de consistencia, con una entidad raíz que controla el acceso al resto.</td>
    </tr>
    <tr>
      <td>Anti-corruption Layer</td>
      <td>Patrón de Context Mapping en el que un Bounded Context traduce el modelo de otro antes de usarlo, para que el modelo externo no contamine el propio.</td>
    </tr>
    <tr>
      <td>Assumption</td>
      <td>En Lean UX, creencia que el equipo da por cierta sin haberla comprobado y que debe validarse durante el proyecto. Se clasifican en business, business outcome, user, user outcome and benefit y feature assumptions.</td>
    </tr>
    <tr>
      <td>Big Picture EventStorming</td>
      <td>Sesión de EventStorming orientada a explorar el negocio en su conjunto, identificando eventos, actores, sistemas externos y problemas, sin diseñar todavía la solución.</td>
    </tr>
    <tr>
      <td>Bounded Context</td>
      <td>Límite explícito dentro del cual un modelo de dominio y su lenguaje tienen un significado único. Pozzo define cinco: Contributions, Savings Groups, Compliance History, Notifications e Identity & Access.</td>
    </tr>
    <tr>
      <td>Bounded Context Canvas</td>
      <td>Plantilla que describe un Bounded Context: propósito, reglas de negocio, lenguaje, capabilities, dependencias de entrada y salida y crítica del diseño.</td>
    </tr>
    <tr>
      <td>C4 Model</td>
      <td>Modelo de cuatro niveles para representar la arquitectura de software: contexto, contenedores, componentes y código. En este informe se elabora en Structurizr.</td>
    </tr>
    <tr>
      <td>Candidate Context Discovery</td>
      <td>Sesión en la que, a partir de un EventStorm, se identifican los Bounded Contexts candidatos con técnicas como buscar eventos pivotales o partir del valor de negocio.</td>
    </tr>
    <tr>
      <td>Command Handler</td>
      <td>Clase de la Application Layer que recibe un comando, carga el agregado correspondiente, ejecuta la operación y persiste el resultado.</td>
    </tr>
    <tr>
      <td>Conformist</td>
      <td>Patrón de Context Mapping en el que un Bounded Context adopta el modelo de otro tal como es, sin traducción, porque no tiene poder de negociación sobre él.</td>
    </tr>
    <tr>
      <td>Context Map</td>
      <td>Diagrama que muestra los Bounded Contexts de un sistema y el patrón de relación entre cada par de ellos.</td>
    </tr>
    <tr>
      <td>Customer/Supplier</td>
      <td>Patrón de Context Mapping en el que un Bounded Context proveedor atiende las necesidades de otro cliente, negociando la interfaz entre ambos.</td>
    </tr>
    <tr>
      <td>Domain Event</td>
      <td>Hecho relevante para el negocio que ya ocurrió, expresado en pasado. Es la unidad básica del EventStorming.</td>
    </tr>
    <tr>
      <td>Domain Storytelling</td>
      <td>Técnica de modelado que narra, con pictogramas de actores y objetos de trabajo, cómo colaboran las personas y los sistemas para resolver un caso del negocio. Se usó para visualizar los flujos de mensajes entre Bounded Contexts.</td>
    </tr>
    <tr>
      <td>Domain-Driven Design (DDD)</td>
      <td>Enfoque de diseño de software que centra el modelo en el dominio del negocio y en un lenguaje compartido con los expertos. Tiene un nivel estratégico, que descompone el sistema en Bounded Contexts, y uno táctico, que diseña las clases de cada uno.</td>
    </tr>
    <tr>
      <td>Empathy Map</td>
      <td>Diagrama que resume lo que un User Persona piensa, siente, dice, hace, ve y oye, junto con sus dolores y beneficios esperados.</td>
    </tr>
    <tr>
      <td>Entity</td>
      <td>En Domain-Driven Design, objeto del dominio que se distingue por su identidad y no por sus atributos.</td>
    </tr>
    <tr>
      <td>Epic</td>
      <td>Agrupación de User Stories que comparten un objetivo funcional. Pozzo define doce.</td>
    </tr>
    <tr>
      <td>EventStorming</td>
      <td>Taller colaborativo que modela un dominio colocando en una línea de tiempo sus eventos, comandos, actores, políticas y sistemas externos. Se realizó una sesión Big Picture y otra de nivel de diseño.</td>
    </tr>
    <tr>
      <td>Gherkin</td>
      <td>Formato para escribir criterios de aceptación como escenarios con la estructura Dado, Cuando, Entonces (Given, When, Then).</td>
    </tr>
    <tr>
      <td>Hypothesis Statement</td>
      <td>En Lean UX, enunciado comprobable que vincula un resultado de negocio, una persona, un beneficio para esa persona y la funcionalidad que lo habilita. Se formula uno por cada feature assumption.</td>
    </tr>
    <tr>
      <td>Impact Map</td>
      <td>Mapa que conecta un objetivo de negocio con los actores que pueden lograrlo, el cambio de comportamiento que se espera de ellos, los entregables que lo provocan y las User Stories que los implementan.</td>
    </tr>
    <tr>
      <td>Landing Page</td>
      <td>Sitio web estático que presenta el producto, su propuesta de valor y al equipo, y ofrece la vía de acceso a la aplicación.</td>
    </tr>
    <tr>
      <td>Lean UX</td>
      <td>Proceso de diseño de producto que parte de un Problem Statement, explicita assumptions, las convierte en hipótesis y las valida con experimentos antes de construir.</td>
    </tr>
    <tr>
      <td>Open Host Service</td>
      <td>Patrón de Context Mapping en el que un Bounded Context expone un protocolo público y estable para que cualquier otro contexto lo consuma sin acuerdos particulares.</td>
    </tr>
    <tr>
      <td>Product Backlog</td>
      <td>Lista priorizada de todas las historias del producto, ordenada por valor para el negocio y estimada en Story Points.</td>
    </tr>
    <tr>
      <td>Published Language</td>
      <td>Patrón de Context Mapping en el que la comunicación entre contextos usa un lenguaje documentado y compartido, como el esquema de los eventos que un contexto publica.</td>
    </tr>
    <tr>
      <td>Repository</td>
      <td>Abstracción que da acceso a los agregados como si fueran una colección en memoria. Su interfaz se define en la Domain Layer y su implementación en la Infrastructure Layer.</td>
    </tr>
    <tr>
      <td>RESTful API</td>
      <td>Interfaz de servicios web basada en HTTP que expone recursos identificados por URL y los manipula con los verbos estándar del protocolo. Es la forma en que la aplicación móvil se comunica con el backend de Pozzo.</td>
    </tr>
    <tr>
      <td>ROSCA</td>
      <td>Rotating Savings and Credit Association. Denominación académica de la junta de ahorro y de sus equivalentes en otros países.</td>
    </tr>
    <tr>
      <td>Shared Kernel</td>
      <td>Patrón de Context Mapping en el que dos Bounded Contexts comparten una parte del modelo y se comprometen a cambiarla de forma coordinada.</td>
    </tr>
    <tr>
      <td>SMART</td>
      <td>Criterios para formular objetivos: específicos, medibles, alcanzables, relevantes y con plazo definido. Se aplican a los objetivos de negocio del Impact Map y a los objetivos profesionales de los integrantes.</td>
    </tr>
    <tr>
      <td>Spike Story</td>
      <td>Historia orientada a investigar o probar la viabilidad de una tecnología antes de implementar una funcionalidad. No entrega un incremento de producto, sino conclusiones documentadas y, en su caso, un prototipo.</td>
    </tr>
    <tr>
      <td>Sprint</td>
      <td>Período de trabajo de duración fija al final del cual el equipo entrega un incremento del producto. En este proyecto cada sprint corresponde a una entrega del curso.</td>
    </tr>
    <tr>
      <td>Story Points</td>
      <td>Unidad relativa de estimación del esfuerzo de una historia. Este informe usa la escala 1, 2, 3, 5 y 8.</td>
    </tr>
    <tr>
      <td>Structurizr</td>
      <td>Herramienta que genera los diagramas del C4 Model a partir de una descripción textual de la arquitectura.</td>
    </tr>
    <tr>
      <td>SWOT</td>
      <td>Análisis de fortalezas, debilidades, oportunidades y amenazas (FODA), aplicado a la startup y a cada competidor.</td>
    </tr>
    <tr>
      <td>Technical Story</td>
      <td>Historia que describe un componente sin interacción directa con el usuario final, como un servicio RESTful. Se redacta desde el rol Developer y sus criterios de aceptación son escenarios de solicitud y respuesta.</td>
    </tr>
    <tr>
      <td>Ubiquitous Language</td>
      <td>Lenguaje compartido entre el equipo y los expertos del dominio, usado sin ambigüedad en las conversaciones, los documentos y el código.</td>
    </tr>
    <tr>
      <td>User Journey Map</td>
      <td>Representación del recorrido de un User Persona a través de una experiencia, con sus acciones, pensamientos y emociones en cada etapa. Se elaboraron en su versión As-Is.</td>
    </tr>
    <tr>
      <td>User Persona</td>
      <td>Arquetipo que representa a un segmento objetivo, construido a partir de las características comunes halladas en las entrevistas.</td>
    </tr>
    <tr>
      <td>User Story</td>
      <td>Descripción breve de una funcionalidad desde la perspectiva de quien la usa, con la estructura "Como... deseo... para..." y sus criterios de aceptación.</td>
    </tr>
    <tr>
      <td>User Task Matrix</td>
      <td>Cuadro que registra las tareas que cada User Persona realiza para cumplir sus objetivos, con su frecuencia e importancia, independientemente de que exista la solución.</td>
    </tr>
    <tr>
      <td>Value Object</td>
      <td>En Domain-Driven Design, objeto del dominio definido solo por sus atributos, sin identidad propia e inmutable.</td>
    </tr>
  </tbody>
</table>

# Bibliografía

<!-- pdf:only
::: {#refs}
:::
-->

# Anexos

## Anexo A. Product Backlog en Trello

El Product Backlog se administra en Trello, en el tablero público "Pozzo - Product Backlog". El tablero tiene una lista por sprint y una tarjeta por historia, en el mismo orden de la tabla del Product Backlog: las 46 User Stories, las 8 Technical Stories y las 3 Spike Stories. El título de cada tarjeta lleva el código, el título y los Story Points de la historia; la descripción reproduce la posición en el backlog, la épica, el rol, la historia en el formato "Como... deseo... para..." y los criterios de aceptación en Gherkin. El nombre de cada lista indica el sprint, la entrega del curso a la que corresponde y la suma de Story Points planificados.

Enlace público del tablero: <https://trello.com/b/fRocSVZA/pozzo-product-backlog>

![Product Backlog de Pozzo en Trello](images/closing/product_backlog_trello.png)

<!-- pdf:only
\newpage
-->

## Anexo B. Tablero de Miro del diseño estratégico

Los artefactos del Strategic-Level Domain-Driven Design se elaboraron en un único tablero de Miro, organizado en filas de frames que siguen el orden del proceso: el EventStorming de nivel de diseño en cuatro tramos (acceso, configuración de la junta, registro y validación de aportes, entrega y cierre), los tres pasos del Candidate Context Discovery, las tres historias de Domain Storytelling, los cinco Bounded Context Canvases y el Context Map con sus alternativas. Las capturas que ilustran el capítulo de Requirements Development and Software Solution Design provienen de ese tablero.

Enlace del tablero: <https://miro.com/app/board/uXjVHm8In_g=/?share_link_id=3138613697>

![Tablero de Miro del diseño estratégico de Pozzo](images/closing/miro_eventstorming.png)

<!-- pdf:only
\newpage
-->

## Anexo C. Fuentes de los diagramas de arquitectura

Los diagramas de arquitectura del capítulo de Requirements Development and Software Solution Design no se dibujaron a mano: se generan a partir de archivos de texto que viven en la carpeta `docs/architecture/` del repositorio del informe (<https://github.com/kerolabs/pozzo-doc/tree/develop/docs/architecture>) y se versionan junto con el texto. Los diagramas del C4 Model (contexto, contenedores, componentes y despliegue) se describen en el lenguaje de Structurizr y se renderizan con Structurizr; los diagramas de clases del Domain Layer y los de base de datos se describen en PlantUML, y cada esquema de base de datos lleva además su definición en SQL para PostgreSQL. Las imágenes resultantes son las que aparecen en el capítulo. Mantener los diagramas como texto permite revisarlos en las Pull Requests igual que cualquier otro cambio, ver quién modificó qué y regenerarlos cuando el diseño cambia sin volver a dibujarlos.

<table>
  <colgroup><col width="34%"><col width="22%"><col width="44%"></colgroup>
  <thead>
    <tr>
      <th>Artefacto</th>
      <th>Herramienta</th>
      <th>Archivo en el repositorio</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Diagramas C4 de contexto, contenedores y despliegue, y diagramas de componentes de los cinco Bounded Contexts</td>
      <td>Structurizr DSL, renderizado con Structurizr</td>
      <td>docs/architecture/workspace.dsl</td>
    </tr>
    <tr>
      <td>Diagrama de clases del Domain Layer de Contributions</td>
      <td>PlantUML</td>
      <td>docs/architecture/uml/contributions-domain.puml</td>
    </tr>
    <tr>
      <td>Diagrama de clases del Domain Layer de Savings Groups</td>
      <td>PlantUML</td>
      <td>docs/architecture/uml/savings-groups-domain.puml</td>
    </tr>
    <tr>
      <td>Diagrama de clases del Domain Layer de Compliance History</td>
      <td>PlantUML</td>
      <td>docs/architecture/uml/compliance-history-domain.puml</td>
    </tr>
    <tr>
      <td>Diagrama de clases del Domain Layer de Notifications</td>
      <td>PlantUML</td>
      <td>docs/architecture/uml/notifications-domain.puml</td>
    </tr>
    <tr>
      <td>Diagrama de clases del Domain Layer de Identity &amp; Access</td>
      <td>PlantUML</td>
      <td>docs/architecture/uml/identity-access-domain.puml</td>
    </tr>
    <tr>
      <td>Diagrama de base de datos de Contributions y su DDL</td>
      <td>PlantUML y SQL (PostgreSQL 16)</td>
      <td>docs/architecture/db/contributions.puml, docs/architecture/db/contributions.sql</td>
    </tr>
    <tr>
      <td>Diagrama de base de datos de Savings Groups y su DDL</td>
      <td>PlantUML y SQL (PostgreSQL 16)</td>
      <td>docs/architecture/db/savings_groups.puml, docs/architecture/db/savings_groups.sql</td>
    </tr>
    <tr>
      <td>Diagrama de base de datos de Compliance History y su DDL</td>
      <td>PlantUML y SQL (PostgreSQL 16)</td>
      <td>docs/architecture/db/compliance_history.puml, docs/architecture/db/compliance_history.sql</td>
    </tr>
    <tr>
      <td>Diagrama de base de datos de Notifications y su DDL</td>
      <td>PlantUML y SQL (PostgreSQL 16)</td>
      <td>docs/architecture/db/notifications.puml, docs/architecture/db/notifications.sql</td>
    </tr>
    <tr>
      <td>Diagrama de base de datos de Identity &amp; Access y su DDL</td>
      <td>PlantUML y SQL (PostgreSQL 16)</td>
      <td>docs/architecture/db/identity_access.puml, docs/architecture/db/identity_access.sql</td>
    </tr>
  </tbody>
</table>
