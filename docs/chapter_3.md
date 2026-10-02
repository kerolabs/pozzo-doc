# Capítulo III: Solution UI/UX Design

## 3.1. Product design

### 3.1.1. Style Guidelines

#### 3.1.1.1. General Style Guidelines

### 3.1.2. Information Architecture
La arquitectura de información define dónde se ubica cada contenido, cómo se denomina, de qué manera se accede a él y cómo puede ser localizado por los usuarios. Las cinco secciones siguientes desarrollan los cuatro sistemas principales de la arquitectura de información: organización, etiquetado, navegación y búsqueda. Además, tanto la aplicación móvil como la landing page incorporan una sección específica de etiquetado. En el caso de la landing page, estas etiquetas también contribuyen a mejorar su visibilidad en la búsqueda y la forma en que se presenta el contenido al ser compartido.

En los dos productos el punto de partida es el mismo. La persona que usa Pozzo no explora un catálogo: llega con una tarea concreta (aportar, revisar un aporte, saber cuándo cobra, decidir si le interesa) y la arquitectura debe llevarla a ella con el menor número de toques posible.
#### 3.1.2.1. Organization Systems
Un sistema de organización combina un esquema, que decide cómo se agrupan los elementos, y una estructura, que decide cómo se relacionan entre sí. En Pozzo el esquema cambia según el producto, porque la aplicación se usa muchas veces con una tarea distinta cada vez y el landing se recorre una sola vez de arriba abajo.

<table>
  <colgroup><col width="22%"><col width="53%"><col width="25%"></colgroup>
  <thead>
    <tr>
      <th>Esquema</th>
      <th>Cómo se aplica</th>
      <th>Dónde se ve</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Por segmento objetivo </b></td>
      <td>El contenido cambia según el rol. La cabeza de junta puede crear, configurar, gestionar aportes y revisar el historial general; el participante puede unirse, aportar, consultar su cumplimiento y recibir recordatorios. Ambos comparten la misma navegación principal.</td>
      <td>B1/B2, K1/K2/G3 y E8/E9.</td>
    </tr>
    <tr>
      <td><b>Por tarea</b></td>
      <td>Las pantallas se agrupan según las acciones principales de cada usuario: crear o unirse a una junta, gestionar o realizar aportes, consultar el avance y revisar el historial.</td>
      <td>Grupos de tareas y wireflows.</td>
    </tr>
    <tr>
      <td><b>Por momento de la junta</b></td>
      <td>La información y las acciones disponibles cambian según si la junta está por iniciar, en curso o cerrada.</td>
      <td>E1, E7, E8, F1, J2 y H6.</td>
    </tr>
    <tr>
      <td><b>Cronológico</b></td>
      <td>El calendario, los aportes, el historial y los avisos se ordenan temporalmente para facilitar el seguimiento de turnos, períodos y eventos recientes.</td>
      <td>G2, K1, I3 y J3.</td>
    </tr>
  </tbody>
</table>

La estructura utiliza una jerarquía poco profunda centrada en cada junta. La navegación inferior contiene cuatro destinos principales: Juntas, Historial, Avisos y Perfil. Desde Juntas, cada junta funciona como punto central para acceder a sus acciones y al calendario de turnos.

La profundidad máxima es de tres niveles: destino principal, detalle de la junta y acción específica. Los modales y los pasos internos de un flujo no se consideran niveles adicionales. Esta estructura reduce la cantidad de toques necesarios para completar tareas frecuentes, especialmente realizar aportes. El primer ingreso funciona como un flujo lineal previo a la navegación principal y, si el usuario aún no pertenece a una junta, se muestra un estado vacío con las opciones de crear una o unirse mediante un código.

![Arquitectura de información de la aplicación: cuatro destinos, grupos de pantallas por segmento y por tarea, y máximo tres niveles](images/chapter_3/ia_mapa_app.png){width=95%}


#### 3.1.2.2. Labelling Systems

#### 3.1.2.3. SEO Tags and Meta Tags

#### 3.1.2.4. Searching Systems

#### 3.1.2.5. Navigation Systems

### 3.1.3. Landing Page UI Design

#### 3.1.3.1. Landing Page Wireframe

#### 3.1.3.2. Landing Page Mock-up

### 3.1.4. Mobile Applications UX/UI Design

#### 3.1.4.1. Mobile Applications Wireframes

#### 3.1.4.2. Mobile Applications Wireflow Diagrams

#### 3.1.4.3. Mobile Applications Mock-ups

#### 3.1.4.4. Mobile Applications User Flow Diagrams

#### 3.1.4.5. Mobile Applications Prototyping
