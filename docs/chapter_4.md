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

#### 4.2.1.8. Software Deployment Evidence for Sprint Review

#### 4.2.1.9. Team Collaboration Insights during Sprint

## 4.3. Validation Interviews

### 4.3.1. Diseño de Entrevistas

### 4.3.2. Registro de Entrevistas

### 4.3.3. Evaluaciones según heurísticas
