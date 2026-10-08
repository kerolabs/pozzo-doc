# Capítulo IV: Product Implementation & Validation

## 4.1. Software Configuration Management

En esta sección se fijan las decisiones que mantienen consistentes los productos de Pozzo durante todo el ciclo de vida: con qué herramientas trabaja el equipo, cómo se organiza y protege el código fuente, qué convenciones siguen el código y los mensajes de commit, y cómo se despliega cada producto a partir de su repositorio. Pozzo se compone de cinco productos, cada uno con su repositorio en la organización `kerolabs` de GitHub: el landing page, los servicios RESTful, la aplicación móvil, las páginas públicas de los enlaces que comparte la aplicación y este informe.

### 4.1.1. Software Development Environment Configuration

El equipo trabaja con las herramientas de la Tabla 133, agrupadas por la actividad del ciclo de vida en la que se usan. Las que funcionan como servicio en la nube se indican con su ruta de referencia; las que se instalan en el computador de cada integrante, con su ruta de descarga. Todas respetan las restricciones de tecnología del curso: UXPressia para personas, journeys, empathy e impact maps; Figma para wireframes, mock-ups y prototipos; Structurizr para el C4 Model; Kotlin nativo para Android; Spring Boot para los servicios; OpenAPI con Swagger para su documentación, y Trello para la gestión del backlog.

<table>
  <caption>Herramientas del entorno de desarrollo por actividad del ciclo de vida</caption>
  <colgroup><col width="17%"><col width="18%"><col width="40%"><col width="25%"></colgroup>
  <thead>
    <tr>
      <th>Actividad</th>
      <th>Producto</th>
      <th>Propósito en Pozzo</th>
      <th>Ruta</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="2">Project Management</td>
      <td>Trello</td>
      <td>Tablero del Product Backlog y de cada Sprint Backlog, con el estado de cada User Story y de sus tareas.</td>
      <td><a href="https://trello.com/b/fRocSVZA/pozzo-product-backlog">trello.com/b/fRocSVZA</a></td>
    </tr>
    <tr>
      <td>GitHub</td>
      <td>Organización <code>kerolabs</code>: repositorios, Pull Requests, revisión de código y analíticos de colaboración.</td>
      <td><a href="https://github.com/kerolabs">github.com/kerolabs</a></td>
    </tr>
    <tr>
      <td rowspan="3">Requirements Management</td>
      <td>Miro</td>
      <td>Big Picture EventStorming, descubrimiento de bounded contexts, flujos de mensajes y Bounded Context Canvases.</td>
      <td><a href="https://miro.com/app/board/uXjVHm8In_g=/">miro.com</a></td>
    </tr>
    <tr>
      <td>UXPressia</td>
      <td>User Personas, Empathy Maps, User Journey Maps e Impact Maps.</td>
      <td><a href="https://uxpressia.com">uxpressia.com</a></td>
    </tr>
    <tr>
      <td>Trello</td>
      <td>Registro de las User Stories, Technical Stories y Spike Stories priorizadas del Product Backlog.</td>
      <td><a href="https://trello.com/b/fRocSVZA/pozzo-product-backlog">trello.com/b/fRocSVZA</a></td>
    </tr>
    <tr>
      <td>Product UX/UI Design</td>
      <td>Figma</td>
      <td>Guía de estilo, wireframes y mock-ups del landing page y de la aplicación, wireflows, user flows y prototipo navegable, en un solo archivo.</td>
      <td><a href="https://www.figma.com/design/8KoGtoEQuWzHgtOih3hTgF/">figma.com</a></td>
    </tr>
    <tr>
      <td rowspan="6">Software Development</td>
      <td>Git</td>
      <td>Control de versiones local de todos los repositorios.</td>
      <td><a href="https://git-scm.com/downloads">git-scm.com/downloads</a></td>
    </tr>
    <tr>
      <td>Android Studio</td>
      <td>Desarrollo de la aplicación móvil en Kotlin con Jetpack Compose, emulador de pruebas y generación del APK firmado.</td>
      <td><a href="https://developer.android.com/studio">developer.android.com/studio</a></td>
    </tr>
    <tr>
      <td>IntelliJ IDEA</td>
      <td>Desarrollo de los servicios RESTful en Java 21 con Spring Boot 4.1 y Maven.</td>
      <td><a href="https://www.jetbrains.com/idea/download">jetbrains.com/idea/download</a></td>
    </tr>
    <tr>
      <td>Eclipse Temurin JDK 21</td>
      <td>Compilación y ejecución local de los servicios; la misma versión que usa el servidor.</td>
      <td><a href="https://adoptium.net">adoptium.net</a></td>
    </tr>
    <tr>
      <td>Visual Studio Code</td>
      <td>Edición del landing page (HTML5, CSS3 y JavaScript), de las páginas públicas de enlaces y de este informe en Markdown.</td>
      <td><a href="https://code.visualstudio.com/download">code.visualstudio.com/download</a></td>
    </tr>
    <tr>
      <td>Supabase</td>
      <td>PostgreSQL de los cinco bounded contexts, con un esquema por contexto, y almacenamiento de fotos de perfil y de imágenes de comprobantes.</td>
      <td><a href="https://supabase.com/dashboard">supabase.com/dashboard</a></td>
    </tr>
    <tr>
      <td rowspan="3">Software Testing</td>
      <td>JUnit 5 y Spring Boot Test</td>
      <td>Pruebas unitarias del dominio y pruebas de integración de los servicios.</td>
      <td><a href="https://junit.org/junit5">junit.org/junit5</a></td>
    </tr>
    <tr>
      <td>Cucumber</td>
      <td>Pruebas de aceptación escritas en Gherkin a partir de los criterios de aceptación de las User Stories.</td>
      <td><a href="https://cucumber.io/docs/installation/java">cucumber.io</a></td>
    </tr>
    <tr>
      <td>Swagger UI</td>
      <td>Prueba manual de cada endpoint contra el servidor desplegado, con datos de muestra.</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui.html">api-kerolabs.duckdns.org/swagger-ui.html</a></td>
    </tr>
    <tr>
      <td rowspan="5">Software Deployment</td>
      <td>GitHub Actions</td>
      <td>Comprueba los mensajes de commit en cada push y Pull Request, despliega los servicios en cada merge a <code>main</code> y compila este informe a PDF en cada entrega.</td>
      <td><a href="https://github.com/features/actions">github.com/features/actions</a></td>
    </tr>
    <tr>
      <td>Oracle Cloud Infrastructure</td>
      <td>Instancia Always Free con Ubuntu 24.04 donde corren los servicios RESTful, detrás de Caddy.</td>
      <td><a href="https://cloud.oracle.com">cloud.oracle.com</a></td>
    </tr>
    <tr>
      <td>DuckDNS</td>
      <td>Nombre de dominio <code>api-kerolabs.duckdns.org</code> que apunta a la instancia.</td>
      <td><a href="https://www.duckdns.org">duckdns.org</a></td>
    </tr>
    <tr>
      <td>GitHub Pages</td>
      <td>Publicación del landing page y de las páginas públicas de los enlaces de invitación e historial.</td>
      <td><a href="https://pages.github.com">pages.github.com</a></td>
    </tr>
    <tr>
      <td>Firebase</td>
      <td>Cloud Messaging para las notificaciones push y App Distribution para entregar la aplicación a quienes la prueban.</td>
      <td><a href="https://console.firebase.google.com">console.firebase.google.com</a></td>
    </tr>
    <tr>
      <td rowspan="4">Software Documentation</td>
      <td>springdoc-openapi</td>
      <td>Genera la especificación OpenAPI de los servicios a partir del código y la publica con Swagger UI.</td>
      <td><a href="https://springdoc.org">springdoc.org</a></td>
    </tr>
    <tr>
      <td>Structurizr</td>
      <td>Diagramas del C4 Model escritos como código en <code>docs/architecture/workspace.dsl</code>.</td>
      <td><a href="https://structurizr.com">structurizr.com</a></td>
    </tr>
    <tr>
      <td>PlantUML</td>
      <td>Diagramas de clases del dominio y de base de datos de cada bounded context.</td>
      <td><a href="https://plantuml.com">plantuml.com</a></td>
    </tr>
    <tr>
      <td>Pandoc y XeLaTeX</td>
      <td>Convierten este informe de Markdown a PDF con formato APA 7.</td>
      <td><a href="https://pandoc.org/installing.html">pandoc.org/installing.html</a></td>
    </tr>
  </tbody>
</table>

### 4.1.2. Source Code Management

El código de Pozzo se versiona con Git y se aloja en GitHub, en la organización `kerolabs`. Cada producto tiene su propio repositorio, de modo que se versiona, se revisa y se despliega por separado. El repositorio de los servicios RESTful incluye, junto al proyecto, sus pruebas unitarias, de integración y de aceptación (ver Tabla 134).

<table>
  <caption>Repositorios de los productos de Pozzo en la organización kerolabs</caption>
  <colgroup><col width="28%"><col width="32%"><col width="40%"></colgroup>
  <thead>
    <tr>
      <th>Producto</th>
      <th>Repositorio</th>
      <th>Contenido</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Landing Page</td>
      <td><a href="https://github.com/kerolabs/pozzo-landing-page">kerolabs/pozzo-landing-page</a></td>
      <td>Sitio estático en HTML5, CSS3 y JavaScript, en inglés y español.</td>
    </tr>
    <tr>
      <td>Web Services</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend">kerolabs/pozzo-backend</a></td>
      <td>Servicios RESTful en Spring Boot con sus pruebas, el workflow de despliegue y la configuración del servidor.</td>
    </tr>
    <tr>
      <td>Mobile Application</td>
      <td><a href="https://github.com/kerolabs/pozzo-mobile">kerolabs/pozzo-mobile</a></td>
      <td>Aplicación Android en Kotlin con Jetpack Compose.</td>
    </tr>
    <tr>
      <td>Páginas públicas de enlaces</td>
      <td><a href="https://github.com/kerolabs/kerolabs.github.io">kerolabs/kerolabs.github.io</a></td>
      <td>Páginas que abren los enlaces de invitación a una junta y de historial compartido.</td>
    </tr>
    <tr>
      <td>Informe</td>
      <td><a href="https://github.com/kerolabs/pozzo-doc">kerolabs/pozzo-doc</a></td>
      <td>Este documento en Markdown, los diagramas como código y la configuración que lo compila a PDF.</td>
    </tr>
  </tbody>
</table>

El flujo de trabajo sigue GitFlow [@driessen2010gitflow]. Además de la rama principal, cada repositorio tiene una rama de integración y ramas de vida corta para cada cambio (ver Tabla 135):

<table>
  <caption>Ramas de GitFlow en los repositorios de Pozzo</caption>
  <colgroup><col width="20%"><col width="18%"><col width="62%"></colgroup>
  <thead>
    <tr>
      <th>Rama</th>
      <th>Sale de</th>
      <th>Uso y convención de nombre</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>main</code></td>
      <td>(permanente)</td>
      <td>Solo estados entregables. En los servicios RESTful, cada merge a <code>main</code> se despliega en el servidor; en el landing page y en las páginas de enlaces, lo publica GitHub Pages.</td>
    </tr>
    <tr>
      <td><code>develop</code></td>
      <td>(permanente)</td>
      <td>Integra el trabajo terminado del equipo. Es la base de todas las ramas de trabajo.</td>
    </tr>
    <tr>
      <td><code>feature/&lt;nombre&gt;</code></td>
      <td><code>develop</code></td>
      <td>Una por funcionalidad, con el nombre en inglés y en kebab-case según lo que agrega: <code>feature/receipts-and-group-notices</code>, <code>feature/group-management</code>. En el informe llevan además el número de la sección: <code>feature/4-1-configuration-management</code>. Vuelven a <code>develop</code> por Pull Request.</td>
    </tr>
    <tr>
      <td><code>fix/</code>, <code>chore/</code>, <code>ci/&lt;nombre&gt;</code></td>
      <td><code>develop</code></td>
      <td>Correcciones que no son urgentes, cambios de configuración y cambios de los workflows, con la misma convención: <code>fix/device-registration-race</code>, <code>chore/oracle-backend</code>, <code>ci/deploy-oracle</code>.</td>
    </tr>
    <tr>
      <td><code>release/&lt;versión&gt;</code></td>
      <td><code>develop</code></td>
      <td>Prepara una entrega: solo admite el número de versión y correcciones de último momento. Se mergea a <code>main</code>, se etiqueta con su versión y se mergea de vuelta a <code>develop</code>. Ejemplo: <code>release/0.1.0</code>.</td>
    </tr>
    <tr>
      <td><code>hotfix/&lt;versión&gt;</code></td>
      <td><code>main</code></td>
      <td>Corrige un error en producción sin esperar la siguiente entrega. Sube el número de parche, se mergea a <code>main</code> y a <code>develop</code> y se etiqueta. Ejemplo: <code>hotfix/0.1.1</code>.</td>
    </tr>
  </tbody>
</table>

Los releases se nombran con Semantic Versioning 2.0.0 [@preston2013semver]: `MAJOR.MINOR.PATCH`, con la etiqueta `v` delante (`v0.1.0`). Mientras el producto se construye la versión mayor es 0, y cada entrega con un Sprint terminado sube la versión menor: `v0.1.0` en la TB1 (Sprint 1) y `v0.2.0` en la AV2 (Sprint 2). La TB2, que es el Release Review, publica la `v1.0.0`. Las correcciones urgentes entre entregas suben solo el parche. El informe usa como etiqueta el nombre de la entrega (`av1`, `tb1`), porque cada una dispara la compilación de su PDF.

Los mensajes de commit siguen Conventional Commits [@conventionalcommits2019]: un tipo, dos puntos y qué hace el cambio, en inglés. Los tipos admitidos son `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore` y `revert`, con un ámbito opcional entre paréntesis.

```
feat: keep receipt images in a private bucket and show them through signed links
fix: retry a device registration that collided with a simultaneous one
ci: deploy main to the Oracle Cloud instance through a restricted SSH key
```

Tres mecanismos hacen que estas reglas se cumplan y no dependan de la memoria de cada integrante:

- **Workflow `commit-policy`.** Corre en GitHub Actions con cada push y cada Pull Request de todos los repositorios, y rechaza los commits que no siguen el formato. También rechaza los pies que algunas herramientas añaden solas al mensaje, porque cada commit debe atribuirse a un integrante del equipo.
- **Hook `commit-msg`.** Aplica las mismas reglas en el computador del integrante, al momento de hacer el commit, para que el error se corrija antes de subirlo.
- **Protección de ramas.** `main` y `develop` rechazan los pushes directos en todos los repositorios, también los de los administradores. Todo cambio entra por Pull Request y solo se puede mergear con el check `commit-policy` en verde. Al terminar, la rama de trabajo se borra.

### 4.1.3. Source Code Style Guide & Conventions

Todo el código de Pozzo se escribe en inglés: nombres de clases, funciones, variables, archivos, rutas de la API, comentarios y mensajes de commit. El español queda para los textos que ve el usuario (pantallas, notificaciones, mensajes de error de la API) y para este informe. Sobre esa base, cada lenguaje sigue una guía de referencia (ver Tabla 136):

<table>
  <caption>Guías de estilo de referencia por lenguaje</caption>
  <colgroup><col width="17%"><col width="27%"><col width="56%"></colgroup>
  <thead>
    <tr>
      <th>Lenguaje</th>
      <th>Guía de referencia</th>
      <th>Convenciones que aplica Pozzo</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Kotlin (aplicación móvil)</td>
      <td>Kotlin Coding Conventions [@kotlin2026conventions] y Android Kotlin Style Guide [@android2026kotlinstyle]</td>
      <td>Clases y composables en PascalCase; funciones y propiedades en camelCase; constantes en UPPER_SNAKE_CASE. Un paquete por bounded context dentro de <code>features</code>, con las capas <code>domain</code>, <code>application</code>, <code>infrastructure</code> y <code>presentation</code>. Las pantallas terminan en <code>Screen</code>, sus view models en <code>ViewModel</code> y los casos de uso en <code>UseCase</code>.</td>
    </tr>
    <tr>
      <td>Java (servicios RESTful)</td>
      <td>Google Java Style Guide [@google2026javastyle] y Spring Boot Reference Documentation [@spring2026boot]</td>
      <td>Nomenclatura de la guía de Google, con sangría de cuatro espacios como el código de Spring. Un paquete por bounded context con las capas <code>domain</code>, <code>application</code>, <code>infrastructure</code> e <code>interfaces</code>. Commands, queries, events y resources son records y terminan en <code>Command</code>, <code>Query</code>, <code>Event</code> y <code>Resource</code>. Las rutas de la API van en plural y en kebab-case bajo <code>/api/v1</code>, por ejemplo <code>/api/v1/groups/{groupId}/members</code>.</td>
    </tr>
    <tr>
      <td>HTML, CSS y JavaScript (landing page y páginas de enlaces)</td>
      <td>Google HTML/CSS Style Guide [@google2026htmlcss]</td>
      <td>Elementos semánticos (<code>header</code>, <code>main</code>, <code>section</code>, <code>footer</code>), etiquetas y atributos en minúsculas y sangría de dos espacios. Clases con la convención Block Element Modifier (<code>brand__logo</code>, <code>brand__logo--dark</code>). Colores, espaciados y tipografía como variables CSS; JavaScript sin dependencias, con <code>const</code> y <code>let</code>.</td>
    </tr>
    <tr>
      <td>Gherkin (pruebas de aceptación)</td>
      <td>Gherkin Reference [@cucumber2026gherkin]</td>
      <td>Un archivo <code>.feature</code> por User Story, con su identificador en el nombre (<code>us23-register-contribution.feature</code>). Palabras clave y pasos en inglés; cada escenario sigue la estructura Given, When, Then de los criterios de aceptación de su User Story.</td>
    </tr>
    <tr>
      <td>Markdown (informe)</td>
      <td>Guía para contribuir del repositorio <code>pozzo-doc</code></td>
      <td>Numeración de títulos escrita a mano, tablas en HTML, imágenes con ruta relativa y citas desde <code>references.bib</code>, para que el mismo archivo se lea en GitHub y se compile a PDF.</td>
    </tr>
  </tbody>
</table>

Los comentarios explican por qué el código hace algo y no qué hace, que ya se lee en el código. Las clases públicas llevan un comentario de documentación (Javadoc o KDoc) que dice qué representan en el dominio, usando los términos del Ubiquitous Language (sección Ubiquitous Language).

### 4.1.4. Software Deployment Configuration

Cada producto se despliega a partir de la rama `main` de su repositorio. Para los servicios RESTful y las páginas web el despliegue es automático: basta con mergear la Pull Request de la entrega. La aplicación móvil se compila y firma en el computador de un integrante y se distribuye como APK.

**Landing Page.** GitHub Pages publica el contenido de la rama `main` de `pozzo-landing-page` en <https://kerolabs.github.io/pozzo-landing-page/>. El sitio no tiene compilación: al mergear a `main`, el workflow `pages-build-deployment` de GitHub publica los archivos tal como están, en uno o dos minutos.

**Páginas públicas de enlaces.** El repositorio `kerolabs.github.io` se publica igual, en la raíz del dominio <https://kerolabs.github.io>. Sirve dos páginas: `unirme`, que muestra el código de una invitación y cómo unirse desde la aplicación, e `historial`, que lee de los servicios el resumen de cumplimiento que un integrante compartió. El archivo `.nojekyll` evita que GitHub Pages ignore las carpetas que empiezan con punto, donde irán los archivos de verificación de Android App Links.

**Web Services.** Los servicios RESTful corren en una instancia Always Free de Oracle Cloud Infrastructure (1 GB de memoria y Ubuntu 24.04), que a diferencia de los planes gratuitos de otras plataformas no se suspende cuando no recibe tráfico. La instancia se preparó una sola vez con el script `deploy/oracle-setup.sh` del repositorio, que deja:

- Java 21, una memoria de intercambio de 2 GB y los puertos 80 y 443 abiertos, tanto en el firewall del sistema como en la Security List de la red de Oracle.
- Caddy como proxy inverso, que obtiene y renueva solo el certificado HTTPS de Let's Encrypt para <https://api-kerolabs.duckdns.org>, el nombre que DuckDNS resuelve a la dirección de la instancia.
- El servicio `pozzo` de systemd, que ejecuta el jar con un usuario sin acceso a consola, escucha solo en `127.0.0.1:8080` detrás de Caddy y se reinicia solo si falla.
- La configuración en `/etc/pozzo/pozzo.env`, que solo leen el servicio y el administrador: conexión a la base de datos, clave de firma de las sesiones y credenciales de SMS Gate (códigos por SMS), Brevo (correos de recuperación), Firebase Cloud Messaging (notificaciones push) y Supabase Storage (imágenes).

Con la instancia preparada, el workflow `deploy.yml` despliega cada merge a `main`:

1. Compila el jar con Java 21 en un runner de GitHub. La instancia no compila nada.
2. Se conecta por SSH con una llave dedicada al usuario `deploy`. Esa llave solo puede ejecutar el script que recibe el jar: no abre consola ni túneles, y el workflow verifica la huella del servidor antes de conectarse.
3. El servidor instala la nueva versión, reinicia el servicio y espera hasta cinco minutos a que `/actuator/health` responda `UP`, mientras envía al workflow el log del arranque. Si la versión nueva no arranca, vuelve a la anterior y el workflow falla.

El estado de los despliegues, los recursos de la instancia y el log en vivo de los servicios se consultan en <https://api-kerolabs.duckdns.org/status>, una página protegida con usuario y contraseña. La documentación OpenAPI se publica en <https://api-kerolabs.duckdns.org/swagger-ui.html>.

**Base de datos y almacenamiento.** PostgreSQL corre en Supabase, con un esquema por bounded context, y los servicios se conectan por el session pooler. Supabase Storage guarda las fotos de perfil en un bucket público y las imágenes de los comprobantes en uno privado, que solo se leen con enlaces firmados que vencen a los quince minutos.

**Mobile Application.** La aplicación tiene dos variantes. `cloud`, la predeterminada, apunta a los servicios desplegados; `local` apunta a los servicios corriendo en el computador del integrante y se instala aparte, para que las dos convivan en el mismo celular. El APK de entrega se genera en Android Studio con la variante `cloudRelease`, firmado con la llave de la aplicación, que se guarda fuera del repositorio. El proyecto de Firebase `kerolabs-pozzo` provee las notificaciones push y, para la entrega final, la distribución de la aplicación a quienes la prueban mediante Firebase App Distribution.

El diagrama de despliegue del C4 Model resume dónde corre cada contenedor de la solución (ver Figura 131):

![Diagrama de despliegue de Pozzo en producción](images/chapter_2/c4_deployment.png){width=85%}

## 4.2. Landing Page & Mobile Application Implementation

### 4.2.1. Sprint 1

#### 4.2.1.1. Sprint Planning 1

#### 4.2.1.2. Aspect Leaders and Collaborators

#### 4.2.1.3. Sprint Backlog 1

#### 4.2.1.4. Development Evidence for Sprint Review

#### 4.2.1.5. Testing Suite Evidence for Sprint Review

#### 4.2.1.6. Execution Evidence for Sprint Review

#### 4.2.1.7. Services Documentation Evidence for Sprint Review

En este Sprint se documentaron con OpenAPI los 54 endpoints de los servicios RESTful de Pozzo, agrupados en 11 recursos que corresponden a los cinco bounded contexts. La documentación se genera desde el código con springdoc-openapi: cada controller declara el resumen y la descripción de sus operaciones, los parámetros, el cuerpo esperado y los códigos de respuesta, incluidos los de error, que comparten el mismo cuerpo `Error` con un código y un mensaje. Los recursos describen cada campo y traen valores de ejemplo, y el documento declara el esquema de seguridad Bearer con el token JWT que emite Identity & Access.

La documentación está desplegada junto con los servicios: Swagger UI en <https://api-kerolabs.duckdns.org/swagger-ui/index.html> y el documento OpenAPI 3.1 en <https://api-kerolabs.duckdns.org/v3/api-docs>. El código está en el repositorio <https://github.com/kerolabs/pozzo-backend>. La Figura 132 muestra la documentación desplegada con sus 11 recursos.

![Swagger UI de los servicios RESTful desplegados](images/chapter_4/swagger_overview.png){width=85%}

Las rutas parten de `https://api-kerolabs.duckdns.org/api/v1` y todas requieren el token Bearer, salvo las marcadas como públicas. Las Tablas 137 a 141 presentan los endpoints de cada bounded context: el verbo HTTP, la sintaxis de la llamada, la acción con su enlace a la documentación desplegada, los parámetros y la respuesta exitosa. Los errores de cada operación están en la documentación desplegada.

<table>
  <caption>Endpoints documentados de Identity &amp; Access</caption>
  <colgroup><col width="12%"><col width="24%"><col width="20%"><col width="18%"><col width="26%"></colgroup>
  <thead>
    <tr>
      <th>Verbo</th>
      <th>Sintaxis de llamada</th>
      <th>Acción</th>
      <th>Parámetros</th>
      <th>Respuesta</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>POST</td>
      <td>/auth/codes</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Authentication/requestCode_2">Solicitar el código de verificación por SMS</a> (pública)</td>
      <td>cuerpo: phoneNumber</td>
      <td><b>202 Accepted</b>: el número al que se envió el código, su vencimiento a los 10 minutos y desde cuándo se puede pedir otro.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/auth/codes/verify</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Authentication/verifyCode_1">Verificar el código</a> (pública)</td>
      <td>cuerpo: code, phoneNumber</td>
      <td><b>200 OK</b>: la sesión si el número ya tiene cuenta; si no, un token de registro válido por 15 minutos.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/auth/register</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Authentication/register">Completar el registro</a> (pública)</td>
      <td>cuerpo: displayName, registrationToken</td>
      <td><b>201 Created</b>: el token de sesión, su vencimiento y el perfil de la cuenta creada.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/auth/sign-out</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Authentication/signOut">Cerrar la sesión</a></td>
      <td>Ninguno</td>
      <td><b>204 No Content</b>: sin cuerpo; la sesión con la que se hizo la solicitud queda revocada.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/auth/recovery/codes</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Account%20recovery/requestCode_1">Solicitar un código de recuperación al correo de respaldo</a> (pública)</td>
      <td>cuerpo: email</td>
      <td><b>202 Accepted</b>: la misma respuesta exista o no una cuenta con ese correo, para no revelar cuáles están registrados.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/auth/recovery/codes/verify</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Account%20recovery/verifyCode">Verificar el código de recuperación</a> (pública)</td>
      <td>cuerpo: code, email</td>
      <td><b>200 OK</b>: un token válido por 15 minutos para vincular un número nuevo.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/auth/recovery/phone-number</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Account%20recovery/recover">Vincular el número nuevo e iniciar sesión</a> (pública)</td>
      <td>cuerpo: code, phoneNumber, recoveryToken</td>
      <td><b>200 OK</b>: la sesión nueva; las sesiones del celular perdido se cierran y las juntas y el historial se conservan.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/auth/recovery/phone-number/codes</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Account%20recovery/requestPhoneCode">Solicitar el código SMS del número nuevo</a> (pública)</td>
      <td>cuerpo: phoneNumber, recoveryToken</td>
      <td><b>202 Accepted</b>: el número, el vencimiento del código y desde cuándo se puede pedir otro.</td>
    </tr>
    <tr>
      <td>PUT</td>
      <td>/members/me/phone-number</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Profiles/changePhoneNumber">Cambiar mi número de celular</a></td>
      <td>cuerpo: code, phoneNumber</td>
      <td><b>200 OK</b>: el perfil con el número nuevo; las juntas y el historial se conservan.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/members/me/phone-number/codes</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Profiles/requestCode">Solicitar el código del número nuevo</a></td>
      <td>cuerpo: phoneNumber</td>
      <td><b>202 Accepted</b>: el número al que se envió el código y su vencimiento.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/members/me/profile</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Profiles/getProfile">Consultar mi perfil</a></td>
      <td>Ninguno</td>
      <td><b>200 OK</b>: el perfil del integrante autenticado.</td>
    </tr>
    <tr>
      <td>PUT</td>
      <td>/members/me/profile</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Profiles/updateProfile">Actualizar mi perfil</a></td>
      <td>cuerpo: displayName, theme</td>
      <td><b>200 OK</b>: el perfil con el nombre, el tema visual, el número de Yape o Plin y el correo de respaldo nuevos.</td>
    </tr>
    <tr>
      <td>PUT</td>
      <td>/members/me/profile/photo</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Profiles/changePhoto">Cambiar mi foto</a></td>
      <td>archivo de imagen (multipart/form-data)</td>
      <td><b>200 OK</b>: el perfil con la URL de la foto nueva; la anterior se borra.</td>
    </tr>
    <tr>
      <td>DELETE</td>
      <td>/members/me/profile/photo</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Profiles/removePhoto">Quitar mi foto</a></td>
      <td>Ninguno</td>
      <td><b>200 OK</b>: el perfil sin foto; la aplicación muestra las iniciales.</td>
    </tr>
  </tbody>
</table>

<table>
  <caption>Endpoints documentados de Savings Groups</caption>
  <colgroup><col width="12%"><col width="24%"><col width="20%"><col width="18%"><col width="26%"></colgroup>
  <thead>
    <tr>
      <th>Verbo</th>
      <th>Sintaxis de llamada</th>
      <th>Acción</th>
      <th>Parámetros</th>
      <th>Respuesta</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>POST</td>
      <td>/groups</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Savings%20Groups/createGroup">Crear una junta</a></td>
      <td>cuerpo: contributionAmount, firstContributionDate, name, periodicity</td>
      <td><b>201 Created</b>: la junta en estado DRAFT, con quien la crea como cabeza.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/groups/{groupId}</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Savings%20Groups/getGroup">Consultar una junta</a></td>
      <td>groupId (ruta)</td>
      <td><b>200 OK</b>: la junta con sus reglas, cupos libres y lo que le falta para iniciar.</td>
    </tr>
    <tr>
      <td>DELETE</td>
      <td>/groups/{groupId}</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Savings%20Groups/deleteGroup">Eliminar la junta</a></td>
      <td>groupId (ruta)</td>
      <td><b>204 No Content</b>: sin cuerpo; los integrantes con la aplicación reciben un aviso.</td>
    </tr>
    <tr>
      <td>PATCH</td>
      <td>/groups/{groupId}/destination</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Savings%20Groups/defineDestination">Definir a dónde se envían los aportes</a></td>
      <td>groupId (ruta), cuerpo: method, phoneNumber</td>
      <td><b>200 OK</b>: la junta con el método (Yape o Plin) y el número de destino.</td>
    </tr>
    <tr>
      <td>PUT</td>
      <td>/groups/{groupId}/rules</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Savings%20Groups/updateRules">Ajustar las reglas</a></td>
      <td>groupId (ruta), cuerpo: contributionAmount, firstContributionDate, name, periodicity</td>
      <td><b>200 OK</b>: la junta con las reglas nuevas; no acepta menos cupos que integrantes.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/groups/{groupId}/start</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Savings%20Groups/startGroup">Iniciar la junta</a></td>
      <td>groupId (ruta)</td>
      <td><b>200 OK</b>: la junta en estado STARTED; las reglas ya no cambian y la invitación vence.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/members/me/groups</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Savings%20Groups/getMyGroups">Listar mis juntas</a></td>
      <td>Ninguno</td>
      <td><b>200 OK</b>: las juntas en las que el integrante participa, con su rol y su turno.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/groups/{groupId}/invitations</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Memberships/generateInvitation">Generar una invitación</a></td>
      <td>groupId (ruta)</td>
      <td><b>201 Created</b>: el código, el enlace para compartir y su vencimiento; la invitación anterior vence.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/groups/{groupId}/invitations/active</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Memberships/getActiveInvitation">Consultar la invitación vigente</a></td>
      <td>groupId (ruta)</td>
      <td><b>200 OK</b>: el código y el enlace que siguen activos.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/groups/{groupId}/members</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Memberships/getMembers">Listar los integrantes</a></td>
      <td>groupId (ruta)</td>
      <td><b>200 OK</b>: los integrantes con su tipo, su turno y su foto; la cabeza va primero.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/groups/{groupId}/members/manual</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Memberships/addManualMember">Registrar un integrante sin la aplicación</a></td>
      <td>groupId (ruta), cuerpo: displayName</td>
      <td><b>201 Created</b>: la lista de integrantes actualizada.</td>
    </tr>
    <tr>
      <td>DELETE</td>
      <td>/groups/{groupId}/members/{membershipId}</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Memberships/removeMember">Retirar a un integrante</a></td>
      <td>groupId (ruta), membershipId (ruta)</td>
      <td><b>204 No Content</b>: sin cuerpo; el integrante puede volver a unirse con otra invitación.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/invitations/{code}</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Memberships/previewGroup">Ver una junta antes de unirse</a></td>
      <td>code (ruta)</td>
      <td><b>200 OK</b>: el nombre, la cabeza, las reglas y los cupos libres, sin la lista de integrantes.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/invitations/{code}/join</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Memberships/joinGroup">Unirse con un código de invitación</a></td>
      <td>code (ruta)</td>
      <td><b>200 OK</b>: la junta a la que el integrante se unió.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/groups/{groupId}/turns</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Turns/getTurns">Consultar el calendario de turnos</a></td>
      <td>groupId (ruta)</td>
      <td><b>200 OK</b>: el turno, la fecha y el integrante que cobra en cada período.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/groups/{groupId}/turns/agreed</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Turns/agreedTurns">Fijar el orden acordado</a></td>
      <td>groupId (ruta), cuerpo: order</td>
      <td><b>200 OK</b>: el calendario de turnos en el orden enviado.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/groups/{groupId}/turns/draw</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Turns/drawTurns">Sortear los turnos</a></td>
      <td>groupId (ruta)</td>
      <td><b>200 OK</b>: el calendario de turnos y la semilla que permite reproducir el sorteo.</td>
    </tr>
  </tbody>
</table>

<table>
  <caption>Endpoints documentados de Contributions</caption>
  <colgroup><col width="12%"><col width="24%"><col width="20%"><col width="18%"><col width="26%"></colgroup>
  <thead>
    <tr>
      <th>Verbo</th>
      <th>Sintaxis de llamada</th>
      <th>Acción</th>
      <th>Parámetros</th>
      <th>Respuesta</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>GET</td>
      <td>/contributions/{contributionId}/receipt-image</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Contributions/getReceiptImage">Ver la imagen de un comprobante</a></td>
      <td>contributionId (ruta)</td>
      <td><b>200 OK</b>: un enlace firmado que funciona durante 15 minutos.</td>
    </tr>
    <tr>
      <td>PUT</td>
      <td>/contributions/{contributionId}/receipt-image</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Contributions/attachReceiptImage">Guardar la imagen de mi comprobante</a></td>
      <td>contributionId (ruta), archivo de imagen (multipart/form-data)</td>
      <td><b>200 OK</b>: el aporte, que indica que ya tiene imagen guardada.</td>
    </tr>
    <tr>
      <td>PATCH</td>
      <td>/contributions/{contributionId}/review</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Contributions/reviewContribution">Revisar un aporte</a></td>
      <td>contributionId (ruta), cuerpo: decision</td>
      <td><b>200 OK</b>: el aporte en APPROVED, que cuenta como pagado, o REJECTED, que el integrante puede registrar de nuevo.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/periods/{periodId}/contributions</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Contributions/registerContribution">Registrar mi aporte con el comprobante</a></td>
      <td>periodId (ruta), cuerpo: amount, operationNumber, paidAt, payeeName, source</td>
      <td><b>201 Created</b>: el aporte en estado VALIDATED, o INCONSISTENT con los campos que no coinciden.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/periods/{periodId}/contributions/cash</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Contributions/registerCash">Registrar un aporte en efectivo</a></td>
      <td>periodId (ruta), cuerpo: amount, membershipId, receivedOn</td>
      <td><b>201 Created</b>: el aporte validado, de método CASH.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/periods/{periodId}/contributions/coverage</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Contributions/registerCoverage">Registrar una cobertura</a></td>
      <td>periodId (ruta), cuerpo: coveredByMembershipId, membershipId</td>
      <td><b>201 Created</b>: el aporte de método COVERAGE e indica quién puso el dinero.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/periods/{periodId}/contributions/pending-review</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Contributions/getPendingReviews">Listar los aportes por revisar</a></td>
      <td>periodId (ruta)</td>
      <td><b>200 OK</b>: los aportes INCONSISTENT del período, con lo esperado y lo encontrado.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/cycles/{cycleId}/members/me/contributions</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Cycles/getMyContributions">Listar mis aportes</a></td>
      <td>cycleId (ruta)</td>
      <td><b>200 OK</b>: lo aportado, lo pendiente y el estado de cada período.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/cycles/{cycleId}/periods</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Cycles/getPeriods">Listar los períodos</a></td>
      <td>cycleId (ruta)</td>
      <td><b>200 OK</b>: los períodos abiertos hasta ahora, en orden de turno.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/cycles/{cycleId}/periods/current</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Cycles/getCurrentPeriod">Consultar el estado del pozo</a></td>
      <td>cycleId (ruta)</td>
      <td><b>200 OK</b>: quién cobra, cuánto se reunió y cuánto falta, y el estado de cada integrante.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/groups/{groupId}/cycle</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Cycles/getCycle">Consultar el ciclo de una junta</a></td>
      <td>groupId (ruta)</td>
      <td><b>200 OK</b>: el ciclo con el turno en curso, el pozo y el destino de los aportes.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/periods/{periodId}/payout</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Periods/deliverPot">Confirmar la entrega del pozo</a></td>
      <td>periodId (ruta)</td>
      <td><b>200 OK</b>: el período entregado; se abre el siguiente o, si era el último, se cierra el ciclo.</td>
    </tr>
  </tbody>
</table>

<table>
  <caption>Endpoints documentados de Compliance History</caption>
  <colgroup><col width="12%"><col width="24%"><col width="20%"><col width="18%"><col width="26%"></colgroup>
  <thead>
    <tr>
      <th>Verbo</th>
      <th>Sintaxis de llamada</th>
      <th>Acción</th>
      <th>Parámetros</th>
      <th>Respuesta</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>GET</td>
      <td>/compliance/shared/{token}</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Compliance%20History/getSharedHistory">Abrir un historial compartido</a> (pública)</td>
      <td>token (ruta)</td>
      <td><b>200 OK</b>: el nombre y el resumen, sin montos ni nombres de juntas.</td>
    </tr>
    <tr>
      <td>DELETE</td>
      <td>/compliance/shares/{token}</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Compliance%20History/revokeShareLink">Revocar un enlace compartido</a></td>
      <td>token (ruta)</td>
      <td><b>204 No Content</b>: sin cuerpo; el enlace deja de funcionar.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/groups/{groupId}/compliance</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Compliance%20History/getGroupCompliance">Consultar el cumplimiento de los integrantes de una junta</a></td>
      <td>groupId (ruta)</td>
      <td><b>200 OK</b>: el resumen de cada integrante de la junta.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/members/me/compliance</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Compliance%20History/getMyHistory">Consultar mi historial</a></td>
      <td>Ninguno</td>
      <td><b>200 OK</b>: el resumen en todas las juntas y el detalle por junta.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/members/me/compliance/share</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Compliance%20History/shareHistory">Compartir mi historial</a></td>
      <td>Ninguno</td>
      <td><b>201 Created</b>: el enlace público y su vencimiento a los 7 días.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/members/{memberId}/compliance/summary</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Compliance%20History/getMemberSummary">Consultar el resumen de un integrante</a></td>
      <td>memberId (ruta)</td>
      <td><b>200 OK</b>: el nivel, la tasa de cumplimiento y los conteos de aportes.</td>
    </tr>
  </tbody>
</table>

<table>
  <caption>Endpoints documentados de Notifications</caption>
  <colgroup><col width="12%"><col width="24%"><col width="20%"><col width="18%"><col width="26%"></colgroup>
  <thead>
    <tr>
      <th>Verbo</th>
      <th>Sintaxis de llamada</th>
      <th>Acción</th>
      <th>Parámetros</th>
      <th>Respuesta</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>GET</td>
      <td>/groups/{groupId}/reminder-plan</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Notifications/getReminderPlan">Consultar los recordatorios de una junta</a></td>
      <td>groupId (ruta)</td>
      <td><b>200 OK</b>: los días de anticipación y la hora de envío.</td>
    </tr>
    <tr>
      <td>PUT</td>
      <td>/groups/{groupId}/reminder-plan</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Notifications/configureReminderPlan">Cambiar los recordatorios de una junta</a></td>
      <td>groupId (ruta), cuerpo: enabled, offsetsInDays, sendHour</td>
      <td><b>200 OK</b>: el plan nuevo, que se aplica desde el siguiente período.</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>/members/me/devices</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Notifications/registerDevice">Registrar mi celular</a></td>
      <td>cuerpo: platform, pushToken</td>
      <td><b>201 Created</b>: el dispositivo con su token de Firebase Cloud Messaging.</td>
    </tr>
    <tr>
      <td>DELETE</td>
      <td>/members/me/devices/{deviceId}</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Notifications/deactivateDevice">Quitar mi celular</a></td>
      <td>deviceId (ruta)</td>
      <td><b>204 No Content</b>: sin cuerpo; el celular deja de recibir notificaciones.</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>/members/me/notifications</td>
      <td><a href="https://api-kerolabs.duckdns.org/swagger-ui/index.html#/Notifications/getMyNotifications">Consultar mis notificaciones</a></td>
      <td>Ninguno</td>
      <td><b>200 OK</b>: las últimas 50, de la más reciente a la más antigua.</td>
    </tr>
  </tbody>
</table>

La Tabla 142 muestra un ejemplo de respuesta de los recursos principales, tomado de la junta de muestra con la que se probó la documentación y reducido a los campos que explican cada recurso. La documentación desplegada tiene el esquema completo de cada uno.

<table>
  <caption>Ejemplos de respuesta de los recursos principales</caption>
  <colgroup><col width="17%"><col width="60%"><col width="23%"></colgroup>
  <thead>
    <tr>
      <th>Recurso</th>
      <th>Ejemplo de respuesta</th>
      <th>Explicación</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ProfileResponse</td>
      <td><code>{<br>&nbsp;"displayName":&nbsp;"Anna&nbsp;Weber",<br>&nbsp;"phoneNumber":&nbsp;"+51987654321",<br>&nbsp;"theme":&nbsp;"SYSTEM",<br>&nbsp;"walletNumber":&nbsp;null<br>}</code></td>
      <td>Perfil de un integrante. Lo devuelven las consultas y los cambios de perfil y de número.</td>
    </tr>
    <tr>
      <td>VerificationResponse</td>
      <td><code>{<br>&nbsp;"registrationRequired":&nbsp;null,<br>&nbsp;"session":&nbsp;null,<br>&nbsp;"registrationToken":&nbsp;null<br>}</code></td>
      <td>Resultado de verificar el código: la sesión, o el token para completar el registro.</td>
    </tr>
    <tr>
      <td>Group</td>
      <td><code>{<br>&nbsp;"name":&nbsp;"Junta&nbsp;de&nbsp;la&nbsp;familia&nbsp;Weber",<br>&nbsp;"status":&nbsp;"STARTED",<br>&nbsp;"role":&nbsp;"ORGANIZER",<br>&nbsp;"membersCount":&nbsp;4,<br>&nbsp;"freeSeats":&nbsp;0,<br>&nbsp;"readiness":&nbsp;{<br>&nbsp;&nbsp;"groupFull":&nbsp;true,<br>&nbsp;&nbsp;"turnsAssigned":&nbsp;true,<br>&nbsp;&nbsp;"destinationDefined":&nbsp;true<br>&nbsp;}<br>}</code></td>
      <td>Junta con sus reglas y lo que le falta para iniciar. Lo devuelven las operaciones sobre la junta.</td>
    </tr>
    <tr>
      <td>Membership</td>
      <td><code>{<br>&nbsp;"displayName":&nbsp;"Anna&nbsp;Weber",<br>&nbsp;"kind":&nbsp;"APP",<br>&nbsp;"organizer":&nbsp;true,<br>&nbsp;"turnNumber":&nbsp;4<br>}</code></td>
      <td>Integrante de una junta: con la aplicación (APP) o registrado por la cabeza (MANUAL).</td>
    </tr>
    <tr>
      <td>TurnCalendar</td>
      <td><code>{<br>&nbsp;"method":&nbsp;"DRAW",<br>&nbsp;"drawSeed":&nbsp;"5bd6904907be3299",<br>&nbsp;"potAmount":&nbsp;800.0,<br>&nbsp;"turns":&nbsp;[<br>&nbsp;&nbsp;{<br>&nbsp;&nbsp;&nbsp;"turnNumber":&nbsp;1,<br>&nbsp;&nbsp;&nbsp;"displayName":&nbsp;"Marta&nbsp;Quispe",<br>&nbsp;&nbsp;&nbsp;"cutoffDate":&nbsp;"2026-10-20"<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;...<br>&nbsp;]<br>}</code></td>
      <td>Calendario de turnos con el método de asignación y la semilla del sorteo.</td>
    </tr>
    <tr>
      <td>Cycle</td>
      <td><code>{<br>&nbsp;"groupName":&nbsp;"Junta&nbsp;de&nbsp;la&nbsp;familia&nbsp;Weber",<br>&nbsp;"status":&nbsp;"ACTIVE",<br>&nbsp;"currentTurn":&nbsp;1,<br>&nbsp;"totalTurns":&nbsp;4,<br>&nbsp;"potAmount":&nbsp;800.0,<br>&nbsp;"destinationMethod":&nbsp;"YAPE"<br>}</code></td>
      <td>Ciclo de una junta iniciada: el turno en curso, el pozo y a dónde se envían los aportes.</td>
    </tr>
    <tr>
      <td>PeriodStatus</td>
      <td><code>{<br>&nbsp;"turnNumber":&nbsp;1,<br>&nbsp;"status":&nbsp;"OPEN",<br>&nbsp;"cutoffDate":&nbsp;"2026-10-20",<br>&nbsp;"payoutMemberName":&nbsp;"Marta&nbsp;Quispe",<br>&nbsp;"potAmount":&nbsp;800.0,<br>&nbsp;"collectedAmount":&nbsp;600.0,<br>&nbsp;"missingAmount":&nbsp;200.0<br>}</code></td>
      <td>Estado del pozo de un período: quién cobra, cuánto se reunió y cuánto falta.</td>
    </tr>
    <tr>
      <td>Contribution</td>
      <td><code>{<br>&nbsp;"memberName":&nbsp;"Marta&nbsp;Quispe",<br>&nbsp;"amount":&nbsp;150.0,<br>&nbsp;"method":&nbsp;"TRANSFER",<br>&nbsp;"status":&nbsp;"INCONSISTENT",<br>&nbsp;"inconsistencies":&nbsp;[<br>&nbsp;&nbsp;{<br>&nbsp;&nbsp;&nbsp;"field":&nbsp;"AMOUNT",<br>&nbsp;&nbsp;&nbsp;"expected":&nbsp;"S/&nbsp;200.00",<br>&nbsp;&nbsp;&nbsp;"found":&nbsp;"S/&nbsp;150.00"<br>&nbsp;&nbsp;}<br>&nbsp;]<br>}</code></td>
      <td>Aporte con su comprobante, su validación y la revisión de la cabeza.</td>
    </tr>
    <tr>
      <td>MyContributions</td>
      <td><code>{<br>&nbsp;"groupName":&nbsp;"Junta&nbsp;de&nbsp;la&nbsp;familia&nbsp;Weber",<br>&nbsp;"contributedAmount":&nbsp;200.0,<br>&nbsp;"pendingAmount":&nbsp;0.0,<br>&nbsp;"periods":&nbsp;[<br>&nbsp;&nbsp;{<br>&nbsp;&nbsp;&nbsp;"turnNumber":&nbsp;1,<br>&nbsp;&nbsp;&nbsp;"cutoffDate":&nbsp;"2026-10-20",<br>&nbsp;&nbsp;&nbsp;"amount":&nbsp;200.0<br>&nbsp;&nbsp;}<br>&nbsp;]<br>}</code></td>
      <td>Aportes del integrante autenticado en un ciclo, período por período.</td>
    </tr>
    <tr>
      <td>ComplianceSummary</td>
      <td><code>{<br>&nbsp;"level":&nbsp;"GOOD",<br>&nbsp;"complianceRate":&nbsp;100,<br>&nbsp;"contributions":&nbsp;1,<br>&nbsp;"onTime":&nbsp;1,<br>&nbsp;"late":&nbsp;0<br>}</code></td>
      <td>Resumen de cumplimiento de un integrante en todas sus juntas.</td>
    </tr>
    <tr>
      <td>ShareLink</td>
      <td><code>{<br>&nbsp;"url":&nbsp;"kerolabs.github.io/historial/?t=...",<br>&nbsp;"expiresAt":&nbsp;"2026-10-15T23:21:58Z"<br>}</code></td>
      <td>Enlace público al historial, que vence a los 7 días.</td>
    </tr>
    <tr>
      <td>Notification</td>
      <td><code>{<br>&nbsp;"kind":&nbsp;"ALERT",<br>&nbsp;"title":&nbsp;"Comprobante&nbsp;por&nbsp;revisar",<br>&nbsp;"body":&nbsp;"Marta&nbsp;Quispe&nbsp;subió&nbsp;un&nbsp;compr...",<br>&nbsp;"sentAt":&nbsp;"2026-10-08T23:21:42Z"<br>}</code></td>
      <td>Notificación enviada al integrante, tal como la muestra la aplicación.</td>
    </tr>
    <tr>
      <td>ReminderPlan</td>
      <td><code>{<br>&nbsp;"offsetsInDays":&nbsp;[<br>&nbsp;&nbsp;3,<br>&nbsp;&nbsp;...<br>&nbsp;],<br>&nbsp;"sendHour":&nbsp;9,<br>&nbsp;"enabled":&nbsp;true<br>}</code></td>
      <td>Plan de recordatorios de una junta: los días de anticipación y la hora de envío.</td>
    </tr>
    <tr>
      <td>CodeRequestedResponse</td>
      <td><code>{<br>&nbsp;"phoneNumber":&nbsp;null,<br>&nbsp;"expiresAt":&nbsp;null,<br>&nbsp;"resendAvailableAt":&nbsp;null<br>}</code></td>
      <td>Confirmación del envío de un código por SMS.</td>
    </tr>
    <tr>
      <td>Error</td>
      <td><code>{<br>&nbsp;"code":&nbsp;"INVITATION_NOT_FOUND",<br>&nbsp;"message":&nbsp;"El&nbsp;código&nbsp;de&nbsp;invitación&nbsp;no..."<br>}</code></td>
      <td>Cuerpo común de todos los errores: un código estable para la aplicación y un mensaje en el idioma del integrante.</td>
    </tr>
  </tbody>
</table>

Para mostrar la interacción con la documentación se usó una junta de muestra de cuatro integrantes: Anna Weber como cabeza, y Sofia Gonzales, Marta Quispe y Jorge Ramos. Sofia registró un aporte que coincidía con lo esperado y Marta uno por un monto menor. Las Figuras 133 a 136 muestran cuatro llamadas hechas desde Swagger UI con el token de cada integrante, con la URL de la solicitud y la respuesta del servicio. Se hicieron sobre una instancia local de los servicios con una base de datos propia, para no mezclar los datos de muestra con los de producción.

Jorge Ramos registra su aporte de S/ 200 con los datos de un comprobante de Plin. El monto, el destinatario y la fecha coinciden con lo esperado, así que el servicio responde 201 Created con el aporte en estado VALIDATED y sin inconsistencias (ver Figura 133).

![Registro de un aporte desde Swagger UI](images/chapter_4/swagger_register_contribution.png){width=80%}

Anna Weber, la cabeza de la junta, consulta los aportes por revisar del período. Aparece el de Marta Quispe en estado INCONSISTENT: el comprobante dice S/ 150 y se esperaban S/ 200 (ver Figura 134).

![Aportes por revisar desde Swagger UI](images/chapter_4/swagger_pending_review.png){width=80%}

La cabeza aprueba ese aporte con una nota. El servicio responde 200 OK con el aporte en estado APPROVED y la decisión guardada en la revisión, y el aporte pasa a contar como pagado (ver Figura 135).

![Revisión de un aporte desde Swagger UI](images/chapter_4/swagger_review_contribution.png){width=80%}

Con los tres aportes, el estado del pozo muestra S/ 600 reunidos de S/ 800, que en este turno cobra Marta Quispe, que solo falta el aporte de Anna Weber y el estado de cada integrante (ver Figura 136).

![Estado del pozo desde Swagger UI](images/chapter_4/swagger_period_status.png){width=80%}

La documentación se escribió junto con cada controller, en el mismo commit que agrega sus endpoints, de modo que ningún endpoint quedó sin documentar en el historial. La Tabla 143 relaciona los commits de los servicios RESTful que agregaron o cambiaron la documentación OpenAPI en este Sprint.

<table>
  <caption>Commits de la documentación de los servicios RESTful</caption>
  <colgroup><col width="15%"><col width="19%"><col width="10%"><col width="34%"><col width="10%"><col width="12%"></colgroup>
  <thead>
    <tr>
      <th>Repository</th>
      <th>Branch</th>
      <th>Commit Id</th>
      <th>Commit Message</th>
      <th>Commit Message Body</th>
      <th>Committed on (Date)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>kerolabs/pozzo-backend</td>
      <td>feature/shared-kernel</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend/commit/af8a6e6">af8a6e6</a></td>
      <td>feat(shared): add the OpenAPI, locale and message bundle configuration</td>
      <td>Sin cuerpo</td>
      <td>06/10/2026</td>
    </tr>
    <tr>
      <td>kerolabs/pozzo-backend</td>
      <td>feature/shared-kernel</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend/commit/b3fc64c">b3fc64c</a></td>
      <td>feat(shared): add the standard error response and global exception handler</td>
      <td>Sin cuerpo</td>
      <td>06/10/2026</td>
    </tr>
    <tr>
      <td>kerolabs/pozzo-backend</td>
      <td>feature/iam</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend/commit/80cf2b0">80cf2b0</a></td>
      <td>feat(iam): add the authentication and profile endpoints</td>
      <td>Sin cuerpo</td>
      <td>06/10/2026</td>
    </tr>
    <tr>
      <td>kerolabs/pozzo-backend</td>
      <td>feature/savings-groups</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend/commit/af8d172">af8d172</a></td>
      <td>feat(savings-groups): add the group, membership and turn endpoints</td>
      <td>Sin cuerpo</td>
      <td>06/10/2026</td>
    </tr>
    <tr>
      <td>kerolabs/pozzo-backend</td>
      <td>feature/contributions</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend/commit/0fa3b5a">0fa3b5a</a></td>
      <td>feat(contributions): add the cycle, period and contribution endpoints</td>
      <td>Sin cuerpo</td>
      <td>07/10/2026</td>
    </tr>
    <tr>
      <td>kerolabs/pozzo-backend</td>
      <td>feature/notifications</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend/commit/fe6fd9f">fe6fd9f</a></td>
      <td>feat(compliance-history): add the history, group compliance and share link endpoints</td>
      <td>Sin cuerpo</td>
      <td>07/10/2026</td>
    </tr>
    <tr>
      <td>kerolabs/pozzo-backend</td>
      <td>feature/notifications</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend/commit/937d678">937d678</a></td>
      <td>feat(notifications): expose devices, reminder plans and the notification inbox</td>
      <td>Sin cuerpo</td>
      <td>07/10/2026</td>
    </tr>
    <tr>
      <td>kerolabs/pozzo-backend</td>
      <td>feature/profile-contact-data</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend/commit/905057f">905057f</a></td>
      <td>feat(iam): add the Yape or Plin number and the backup email to the profile</td>
      <td>Sin cuerpo</td>
      <td>07/10/2026</td>
    </tr>
    <tr>
      <td>kerolabs/pozzo-backend</td>
      <td>feature/account-recovery</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend/commit/d1ac94d">d1ac94d</a></td>
      <td>feat(iam): recover an account with the backup email and change the phone number</td>
      <td>Sin cuerpo</td>
      <td>07/10/2026</td>
    </tr>
    <tr>
      <td>kerolabs/pozzo-backend</td>
      <td>feature/profile-photo</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend/commit/677812d">677812d</a></td>
      <td>feat(iam): store the profile photo in Supabase Storage</td>
      <td>Sin cuerpo</td>
      <td>07/10/2026</td>
    </tr>
    <tr>
      <td>kerolabs/pozzo-backend</td>
      <td>feature/member-photos</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend/commit/76c3eff">76c3eff</a></td>
      <td>feat(savings-groups): include the profile photo of each member and turn</td>
      <td>Sin cuerpo</td>
      <td>07/10/2026</td>
    </tr>
    <tr>
      <td>kerolabs/pozzo-backend</td>
      <td>feature/group-management</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend/commit/2946512">2946512</a></td>
      <td>feat: let removed members rejoin, delete groups before they start and tell the organizer who joins</td>
      <td>Sin cuerpo</td>
      <td>07/10/2026</td>
    </tr>
    <tr>
      <td>kerolabs/pozzo-backend</td>
      <td>feature/receipts-and-group-notices</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend/commit/5716e4f">5716e4f</a></td>
      <td>feat: keep receipt images in a private bucket and show them through signed links</td>
      <td>Sin cuerpo</td>
      <td>07/10/2026</td>
    </tr>
    <tr>
      <td>kerolabs/pozzo-backend</td>
      <td>feature/receipts-and-group-notices</td>
      <td><a href="https://github.com/kerolabs/pozzo-backend/commit/3404b33">3404b33</a></td>
      <td>feat: tell the members when the rules change or the group fills up, and expose each member's account</td>
      <td>Sin cuerpo</td>
      <td>07/10/2026</td>
    </tr>
  </tbody>
</table>

#### 4.2.1.8. Software Deployment Evidence for Sprint Review

#### 4.2.1.9. Team Collaboration Insights during Sprint

## 4.3. Validation Interviews

### 4.3.1. Diseño de Entrevistas

### 4.3.2. Registro de Entrevistas

### 4.3.3. Evaluaciones según heurísticas
