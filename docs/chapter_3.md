# Capítulo III: Solution UI/UX Design

## 3.1. Product design

En esta sección se documenta el diseño de producto de Pozzo: la guía de estilo que fija su lenguaje visual, la arquitectura de información que ordena el contenido, y el diseño de interfaz del landing page y de la aplicación móvil, desde el wireframe hasta el prototipo. Todo parte de lo definido en el Capítulo II: los dos arquetipos (Anna Weber, cabeza de junta, y Sofia Gonzales, participante), el Ubiquitous Language de la sección 2.3.6 y las User Stories de la sección 2.4.1, de las que cada pantalla indica cuáles cubre.

Dos aclaraciones sobre cómo se trabajó. Primero, los diseños de la aplicación y el landing se elaboraron en un solo archivo de Figma con una página por tipo de artefacto: guía de estilo, wireframes y mock-ups del landing, wireframes y mock-ups de la aplicación, wireflows, user flows y prototipo. Segundo, el landing page no se quedó en un diseño: se implementó como sitio estático (HTML5, CSS3 y JavaScript) de modo que lo que las secciones 3.1.1 a 3.1.3 describen del landing es lo que el sitio hace, y sus resultados de prueba se resumen en la sección 3.1.3.2.

### 3.1.1. Style Guidelines

#### 3.1.1.1. General Style Guidelines

La guía de estilo es el acuerdo visual entre la aplicación y el landing page: qué colores se usan y para qué, qué tipografía, qué medidas y qué componentes. Se construyó sobre Material Design 3 por dos razones. La primera es que organiza el color en roles, no en tonos sueltos: Material compara los roles con los números de un lienzo de pintar por números, de modo que cada color se elige por la zona que ocupa y no por su aspecto [@material2026color]. Eso permite tener un modo claro y uno oscuro con los mismos componentes. La segunda es que ofrece componentes y comportamientos que cualquier usuario de celular ya conoce, como la barra de navegación inferior, el botón flotante y las hojas modales, lo que reduce lo que hay que aprender para usar Pozzo.

Los valores de esta sección se leyeron del archivo de diseño (estilos de texto, variables de espaciado y forma y roles de color) y del archivo de tokens que consume el landing. No se redondearon ni se reescribieron para el informe.

##### Principios de diseño

Antes de elegir colores o componentes, el equipo fijó siete principios. Cada uno responde a un hallazgo del Capítulo II y se contrastó con las heurísticas de usabilidad de Nielsen [@nielsen1994heuristics], para poder justificar una decisión de interfaz con algo más que gusto personal (ver Tabla 103).

<table>
  <caption>Principios de diseño de Pozzo y los hallazgos que los respaldan</caption>
  <colgroup><col width="19%"><col width="33%"><col width="27%"><col width="21%"></colgroup>
  <thead>
    <tr>
      <th>Principio</th>
      <th>Cómo se aplica en Pozzo</th>
      <th>Hallazgo que lo respalda</th>
      <th>Heurística de Nielsen</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>El estado siempre a la vista</b></td>
      <td>Cada junta muestra el período, el pozo reunido y el estado de cada aporte con color, icono y texto (pantallas B1, B2 y F1).</td>
      <td>El 100% de los participantes siente incertidumbre antes de cobrar sobre si el pozo estará completo.</td>
      <td>Visibility of system status</td>
    </tr>
    <tr>
      <td><b>Se habla como en la junta</b></td>
      <td>La interfaz usa el Ubiquitous Language: aporte, pozo, turno, fecha de corte, cabeza de junta. No aparecen términos técnicos ni financieros ajenos al grupo.</td>
      <td>El glosario de la sección 2.3.6 fija los términos del dominio que el equipo usa en todos sus artefactos.</td>
      <td>Match between system and the real world</td>
    </tr>
    <tr>
      <td><b>Leer en vez de teclear</b></td>
      <td>Pozzo lee el monto, la fecha, el destinatario y el número de operación del comprobante, y la persona solo confirma o corrige (pantalla F4).</td>
      <td>El 100% de las cabezas de junta valida los pagos revisando uno por uno sus movimientos de Yape y las capturas que le envían.</td>
      <td>Recognition rather than recall</td>
    </tr>
    <tr>
      <td><b>Todo error tiene salida</b></td>
      <td>Un comprobante ilegible permite tomar otra foto. Un monto distinto pasa a revisión y la cabeza aprueba o rechaza y pide corrección (F4, F6 y H2). Toda hoja y todo formulario tiene una forma de cancelar.</td>
      <td>El 100% de los participantes ya vivió que le dijeran que no había pagado cuando sí lo había hecho.</td>
      <td>Help users recognize, diagnose, and recover from errors; User control and freedom</td>
    </tr>
    <tr>
      <td><b>Pozzo no toca el dinero y lo dice</b></td>
      <td>Donde se explica cómo aportar o entregar el pozo (F2 y H4) aparece el aviso de que Pozzo no recibe ni retiene el dinero. El landing lo repite en su primera pantalla y en una franja propia.</td>
      <td>El 100% de los participantes decide entrar a una junta por la confianza en quien la organiza: la herramienta no debe sustituir esa relación.</td>
      <td>Visibility of system status</td>
    </tr>
    <tr>
      <td><b>Una mano, una acción principal</b></td>
      <td>Pantallas de 360 x 800 px, margen lateral de 16 px, áreas táctiles de 48 px y una acción principal fija al pie de cada pantalla.</td>
      <td>La historia US46 parte de un visitante que abre el enlace desde WhatsApp en su celular y debe alcanzar las llamadas a la acción con una mano.</td>
      <td>Aesthetic and minimalist design</td>
    </tr>
    <tr>
      <td><b>Un solo sistema para app y landing</b></td>
      <td>Ambos consumen los mismos roles de color, la misma tipografía y los mismos componentes; lo único que cambia es el tamaño de ventana.</td>
      <td>El landing es la primera pantalla de Pozzo que ve una persona. Si no se parece a la aplicación, la promesa se rompe al instalarla.</td>
      <td>Consistency and standards</td>
    </tr>
  </tbody>
</table>

##### Identidad de marca

El logo de Pozzo son dos anillos abiertos que se entrelazan, uno terracota y uno dorado: cada anillo gira hacia el otro, como el dinero que pasa de mano en mano en cada turno, y juntos forman el pozo que el grupo reúne y se reparte. Junto a la marca va la palabra POZZO en mayúsculas, en el mismo terracota. La marca sola se usa en espacios pequeños (icono de la aplicación, avatar y favicon del landing) y el logo completo en cabeceras y portadas. Tiene cuatro variantes: sobre fondo claro, solo la marca, sobre fondo oscuro (con los anillos invertidos y el texto en el tono primary del modo oscuro) y sobre el terracota de la marca, donde todo el logo pasa a crema.

La zona de respeto alrededor del logo es igual a x, la mitad de la altura de la marca, y dentro de ella no se coloca texto, borde ni otra figura. Por debajo de 32 px de altura de marca se usa solo la marca, nunca el logo completo ni una versión estirada, y la marca sola no baja de 24 px (ver Figura 74).

![Guía de estilo: marca, zona de respeto, roles de color en modo claro y oscuro y los tres modos de visualización](images/chapter_3/style_guide_marca_color.png){width=85%}

##### Color

La paleta nace de un terracota cálido (#B5472A) como color semilla y un dorado (#C9A845) como acento. El terracota da cercanía a una herramienta pensada para grupos de familiares, amigos y compañeros, y el dorado se reserva para lo que tiene valor de reconocimiento, como la insignia de puntualidad. A partir de la semilla se definieron los roles de Material 3 para el modo claro y para el modo oscuro. La siguiente tabla lista los quince roles que usan los componentes de la aplicación; el archivo de tokens completo añade las variantes on-color, los contenedores de error, de advertencia y de éxito y los niveles de superficie (ver Tabla 104).

<table>
  <caption>Paleta de color en modo claro y modo oscuro</caption>
  <colgroup><col width="23%"><col width="41%"><col width="18%"><col width="18%"></colgroup>
  <thead>
    <tr>
      <th>Rol</th>
      <th>Uso</th>
      <th align="center">Modo claro</th>
      <th align="center">Modo oscuro</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>primary</b></td>
      <td>Acciones principales: botones rellenos y enlaces</td>
      <td align="center">#943015</td>
      <td align="center">#FFB4A1</td>
    </tr>
    <tr>
      <td><b>on-primary</b></td>
      <td>Texto e iconos sobre primary</td>
      <td align="center">#FFFFFF</td>
      <td align="center">#611300</td>
    </tr>
    <tr>
      <td><b>primary-container</b></td>
      <td>Marca: logo y elementos destacados</td>
      <td align="center">#B5472A</td>
      <td align="center">#B5472A</td>
    </tr>
    <tr>
      <td><b>secondary-container</b></td>
      <td>Chip seleccionado e indicador de navegación</td>
      <td align="center">#FFB5A2</td>
      <td align="center">#6C382B</td>
    </tr>
    <tr>
      <td><b>tertiary-container</b></td>
      <td>Dorado: acento, insignias y destacados</td>
      <td align="center">#C9A845</td>
      <td align="center">#C9A845</td>
    </tr>
    <tr>
      <td><b>surface</b></td>
      <td>Fondo de las pantallas</td>
      <td align="center">#FFF8F6</td>
      <td align="center">#1B110E</td>
    </tr>
    <tr>
      <td><b>surface-container</b></td>
      <td>Barra de navegación y paneles</td>
      <td align="center">#FFE9E4</td>
      <td align="center">#281D1A</td>
    </tr>
    <tr>
      <td><b>on-surface</b></td>
      <td>Texto principal</td>
      <td align="center">#241916</td>
      <td align="center">#F3DED9</td>
    </tr>
    <tr>
      <td><b>on-surface-variant</b></td>
      <td>Texto secundario y etiquetas</td>
      <td align="center">#57423C</td>
      <td align="center">#DEC0B8</td>
    </tr>
    <tr>
      <td><b>outline</b></td>
      <td>Borde de campos y botones de contorno</td>
      <td align="center">#8B716B</td>
      <td align="center">#A68B84</td>
    </tr>
    <tr>
      <td><b>outline-variant</b></td>
      <td>Divisores y bordes suaves</td>
      <td align="center">#DEC0B8</td>
      <td align="center">#57423C</td>
    </tr>
    <tr>
      <td><b>error</b></td>
      <td>Monto distinto o acción destructiva</td>
      <td align="center">#BA1A1A</td>
      <td align="center">#FFB4AB</td>
    </tr>
    <tr>
      <td><b>success</b></td>
      <td>Aporte validado</td>
      <td align="center">#426900</td>
      <td align="center">#A7D567</td>
    </tr>
    <tr>
      <td><b>success-container</b></td>
      <td>Fondo del estado validado</td>
      <td align="center">#C2F280</td>
      <td align="center">#314F00</td>
    </tr>
    <tr>
      <td><b>warning-container</b></td>
      <td>Aporte en revisión o pendiente propio</td>
      <td align="center">#FFDBC8</td>
      <td align="center">#743400</td>
    </tr>
  </tbody>
</table>

Los estados de un aporte tienen un color fijo en toda la aplicación. Validado va en verde (success). En revisión va en naranja (warning). Monto distinto usa el rojo del rol error en su texto y su icono. Pendiente va en naranja cuando es el aporte propio que todavía falta (pantallas B2 y G1) y en neutro cuando es el de otro integrante dentro de una lista (F1 y G2). El color nunca es el único canal: cada estado lleva además un icono (marca de verificación, reloj de arena, reloj o triángulo de advertencia) y una palabra, de modo que una persona que no distingue los tonos lee lo mismo que las demás.

Para comprobar que cada combinación de texto y fondo se lee bien, se calculó la razón de contraste con la fórmula de WCAG 2.2, que exige 4.5:1 para texto normal (criterio 1.4.3) y 3:1 para bordes e indicadores de componentes (criterio 1.4.11) [@w3c2024wcag22]. El cálculo lo hace un script del landing sobre las 29 combinaciones que el sitio usa, en los dos modos, y las 58 resultaron válidas. La tabla muestra las más representativas (ver Tabla 105).

<table>
  <caption>Combinaciones de color y su uso en la interfaz</caption>
  <colgroup><col width="34%"><col width="28%"><col width="10%"><col width="10%"><col width="18%"></colgroup>
  <thead>
    <tr>
      <th>Combinación</th>
      <th>Uso</th>
      <th align="center">Claro</th>
      <th align="center">Oscuro</th>
      <th align="center">Mínimo WCAG</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>on-surface sobre surface</td>
      <td>Texto principal</td>
      <td align="center">16.33</td>
      <td align="center">14.35</td>
      <td align="center">4.5</td>
    </tr>
    <tr>
      <td>on-surface-variant sobre surface</td>
      <td>Texto secundario</td>
      <td align="center">8.89</td>
      <td align="center">10.89</td>
      <td align="center">4.5</td>
    </tr>
    <tr>
      <td>primary sobre surface</td>
      <td>Enlaces y acentos</td>
      <td align="center">7.43</td>
      <td align="center">10.85</td>
      <td align="center">4.5</td>
    </tr>
    <tr>
      <td>on-primary sobre primary</td>
      <td>Etiqueta del botón relleno</td>
      <td align="center">7.80</td>
      <td align="center">7.68</td>
      <td align="center">4.5</td>
    </tr>
    <tr>
      <td>on-primary-container sobre primary-container</td>
      <td>Texto de la franja de confianza</td>
      <td align="center">4.56</td>
      <td align="center">4.56</td>
      <td align="center">4.5</td>
    </tr>
    <tr>
      <td>on-secondary-container sobre secondary-container</td>
      <td>Botón tonal, chip y destino actual</td>
      <td align="center">4.57</td>
      <td align="center">4.58</td>
      <td align="center">4.5</td>
    </tr>
    <tr>
      <td>on-tertiary-container sobre tertiary-container</td>
      <td>Tarjeta de misión (dorado)</td>
      <td align="center">4.59</td>
      <td align="center">4.59</td>
      <td align="center">4.5</td>
    </tr>
    <tr>
      <td>on-success-container sobre success-container</td>
      <td>Chip Validado</td>
      <td align="center">13.25</td>
      <td align="center">7.25</td>
      <td align="center">4.5</td>
    </tr>
    <tr>
      <td>on-warning-container sobre warning-container</td>
      <td>Aviso de borrador y chip En revisión</td>
      <td align="center">13.20</td>
      <td align="center">7.26</td>
      <td align="center">4.5</td>
    </tr>
    <tr>
      <td>error sobre surface</td>
      <td>Texto de error en un campo</td>
      <td align="center">6.16</td>
      <td align="center">10.92</td>
      <td align="center">4.5</td>
    </tr>
    <tr>
      <td>outline sobre surface</td>
      <td>Borde de campos y botones de contorno</td>
      <td align="center">4.28</td>
      <td align="center">5.87</td>
      <td align="center">3</td>
    </tr>
    <tr>
      <td>primary sobre surface</td>
      <td>Indicador de foco del teclado</td>
      <td align="center">7.43</td>
      <td align="center">10.85</td>
      <td align="center">3</td>
    </tr>
  </tbody>
</table>

Las combinaciones entre 4.5 y 4.6 pasan por poco. Si más adelante se cambia un tono, hay que volver a correr el script antes de usarlo, porque un ajuste pequeño puede dejarlas por debajo del mínimo.

##### Tipografía

Pozzo usa una sola familia, Plus Jakarta Sans, publicada con licencia SIL Open Font License. Es una sans serif geométrica con caracteres claros a tamaños pequeños, que es donde más se lee en una aplicación de cifras y fechas. En el landing las fuentes se sirven desde el propio sitio, en formato WOFF2 y en los pesos 400, 500, 600 y 700, de modo que la página no hace pedidos a servicios externos de fuentes.

La escala tiene quince estilos, agrupados como en Material 3 en display, headline, title, body y label. Cada uno se definió como estilo de texto en Figma, y las pantallas usan solo estos estilos (ver Tabla 106).

<table>
  <caption>Escala tipográfica de la guía de estilos</caption>
  <colgroup><col width="25%"><col width="19%"><col width="16%"><col width="40%"></colgroup>
  <thead>
    <tr>
      <th>Estilo</th>
      <th align="center">Tamaño / interlineado</th>
      <th>Peso</th>
      <th>Ejemplo en la guía</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Display/Hero</b></td>
      <td align="center">56 / 64 px</td>
      <td>ExtraBold 800</td>
      <td>Tu junta, al día</td>
    </tr>
    <tr>
      <td><b>Display/Hero Mobile</b></td>
      <td align="center">40 / 46 px</td>
      <td>ExtraBold 800</td>
      <td>Tu junta, al día</td>
    </tr>
    <tr>
      <td><b>Display/Amount</b></td>
      <td align="center">40 / 48 px</td>
      <td>ExtraBold 800</td>
      <td>S/ 2,400.00</td>
    </tr>
    <tr>
      <td><b>Headline/Large</b></td>
      <td align="center">32 / 40 px</td>
      <td>Bold 700</td>
      <td>Pozo del período 3</td>
    </tr>
    <tr>
      <td><b>Headline/Medium</b></td>
      <td align="center">28 / 36 px</td>
      <td>Bold 700</td>
      <td>Aportes por revisar</td>
    </tr>
    <tr>
      <td><b>Headline/Small</b></td>
      <td align="center">24 / 32 px</td>
      <td>Bold 700</td>
      <td>Junta de la familia</td>
    </tr>
    <tr>
      <td><b>Title/Large</b></td>
      <td align="center">22 / 28 px</td>
      <td>SemiBold 600</td>
      <td>Detalle de la junta</td>
    </tr>
    <tr>
      <td><b>Title/Medium</b></td>
      <td align="center">16 / 24 px</td>
      <td>SemiBold 600</td>
      <td>Anna Weber, cabeza de junta</td>
    </tr>
    <tr>
      <td><b>Title/Small</b></td>
      <td align="center">14 / 20 px</td>
      <td>SemiBold 600</td>
      <td>Próximo cobro: 15 de enero</td>
    </tr>
    <tr>
      <td><b>Body/Large</b></td>
      <td align="center">16 / 24 px</td>
      <td>Regular 400</td>
      <td>Sube el comprobante de tu aporte para que Pozzo lo valide.</td>
    </tr>
    <tr>
      <td><b>Body/Medium</b></td>
      <td align="center">14 / 20 px</td>
      <td>Regular 400</td>
      <td>Pozzo compara el monto y el destinatario con lo esperado.</td>
    </tr>
    <tr>
      <td><b>Body/Small</b></td>
      <td align="center">12 / 16 px</td>
      <td>Regular 400</td>
      <td>Última actualización hace 5 minutos</td>
    </tr>
    <tr>
      <td><b>Label/Large</b></td>
      <td align="center">14 / 20 px</td>
      <td>SemiBold 600</td>
      <td>Continuar con mi celular</td>
    </tr>
    <tr>
      <td><b>Label/Medium</b></td>
      <td align="center">12 / 16 px</td>
      <td>SemiBold 600</td>
      <td>Validado</td>
    </tr>
    <tr>
      <td><b>Label/Small</b></td>
      <td align="center">11 / 16 px</td>
      <td>Medium 500</td>
      <td>Período 3 de 8</td>
    </tr>
  </tbody>
</table>

##### Espaciado, forma y elevación

Todas las medidas salen de una cuadrícula de 4 px. El espaciado tiene ocho valores (4, 8, 12, 16, 24, 32, 48 y 64 px), los radios de esquina seis (4, 8, 12, 16, 28 px y pill) y la elevación tres niveles de sombra suave con un tinte terracota. Se guardaron como variables en la colección Spacing and Shape del archivo de Figma, así que cambiar un valor cambia todas las pantallas que lo usan (ver Tabla 107).

<table>
  <caption>Familias de espaciado, forma y elevación</caption>
  <colgroup><col width="20%"><col width="30%"><col width="50%"></colgroup>
  <thead>
    <tr>
      <th>Familia</th>
      <th>Valores</th>
      <th>Dónde se usa</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Espaciado</b></td>
      <td>space/1 a space/8: 4, 8, 12, 16, 24, 32, 48 y 64 px</td>
      <td>16 px (space/4) es el margen lateral de todas las pantallas; 8 px separa elementos relacionados y 24 px separa bloques.</td>
    </tr>
    <tr>
      <td><b>Radios</b></td>
      <td>xs 4, sm 8, md 12, lg 16, xl 28 y full (pill)</td>
      <td>Tarjetas con 16 px, hojas modales con 28 px, botones y chips en pill.</td>
    </tr>
    <tr>
      <td><b>Elevación 1</b></td>
      <td>desplazamiento y 1, desenfoque 3, opacidad 10%</td>
      <td>Tarjetas elevadas y barra superior al hacer scroll.</td>
    </tr>
    <tr>
      <td><b>Elevación 2</b></td>
      <td>desplazamiento y 4, desenfoque 12, opacidad 14%</td>
      <td>Botón flotante y menús.</td>
    </tr>
    <tr>
      <td><b>Elevación 3</b></td>
      <td>desplazamiento y 12, desenfoque 32, opacidad 18%</td>
      <td>Hojas modales (bottom sheet) y diálogos.</td>
    </tr>
  </tbody>
</table>

Además de esas familias, la guía fija las medidas que se repiten en todas las pantallas: (ver Tabla 108)

<table>
  <caption>Medidas de referencia y su justificación</caption>
  <colgroup><col width="35%"><col width="30%"><col width="35%"></colgroup>
  <thead>
    <tr>
      <th>Medida</th>
      <th>Valor</th>
      <th>Motivo</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Pantalla de referencia</b></td>
      <td>360 x 800 px, clase compacta</td>
      <td>Es el ancho mínimo que exige la historia US46 y corresponde a la clase compacta (menos de 600 dp) de las window size classes de Android [@android2026wsc].</td>
    </tr>
    <tr>
      <td><b>Margen lateral</b></td>
      <td>16 px (space/4)</td>
      <td>Deja el texto lejos del borde sin quitarle ancho útil a una pantalla estrecha.</td>
    </tr>
    <tr>
      <td><b>Área táctil mínima</b></td>
      <td>48 x 48 px en botones e iconos</td>
      <td>El equipo fijó 48 px, el doble del mínimo de 24 px que WCAG 2.2 pide para el tamaño del objetivo (criterio 2.5.8) [@w3c2024wcag22], para que las acciones se alcancen con una mano, como pide la historia US46.</td>
    </tr>
    <tr>
      <td><b>Barra superior</b></td>
      <td>64 px de alto</td>
      <td>Alberga el título de la pantalla y sus acciones.</td>
    </tr>
    <tr>
      <td><b>Barra de navegación inferior</b></td>
      <td>80 px de alto, cuatro destinos</td>
      <td>Juntas, Historial, Avisos y Perfil: los cuatro destinos principales de la aplicación.</td>
    </tr>
  </tbody>
</table>

La Figura 75 muestra la guía de estilo: escala tipográfica, espaciado, radios, elevación y medidas clave.

![Guía de estilo: escala tipográfica, espaciado, radios, elevación y medidas clave](images/chapter_3/style_guide_tipografia_forma.png){width=90%}

##### Componentes

El catálogo reúne los componentes que aparecen en las cuarenta y seis pantallas de la aplicación. Cada uno se construyó una vez en Figma y se reutiliza en todas las pantallas, tanto en modo claro como en modo oscuro; lo único que cambia entre los modos es el rol de color que cada componente resuelve (ver Tabla 109).

<table>
  <caption>Componentes de la interfaz, sus variantes y estados</caption>
  <colgroup><col width="22%"><col width="42%"><col width="36%"></colgroup>
  <thead>
    <tr>
      <th>Componente</th>
      <th>Variantes y estados</th>
      <th>Dónde se usa</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Botones</b></td>
      <td>Relleno, tonal, contorno, texto, peligro y deshabilitado. Alto mínimo de 48 px y forma pill.</td>
      <td>Una acción principal rellena por pantalla; la alternativa va en contorno o texto. El botón de peligro se reserva para acciones destructivas, como rechazar un aporte.</td>
    </tr>
    <tr>
      <td><b>Chips</b></td>
      <td>Por tono: success (Validado), warning (En revisión), error (Monto distinto), neutral (por ejemplo, Sin iniciar), primary (Cabeza de junta) y gold (93 % puntual).</td>
      <td>Estado de un aporte, rol de una persona e insignia de puntualidad.</td>
    </tr>
    <tr>
      <td><b>Campos de texto</b></td>
      <td>Predeterminado, enfocado y con error, con texto de ayuda y prefijo (+51 para celulares, S/ para montos).</td>
      <td>Registro, datos leídos del comprobante, monto recibido en efectivo.</td>
    </tr>
    <tr>
      <td><b>Tarjeta</b></td>
      <td>Con título, estado, monto y barra de progreso.</td>
      <td>Pozo del período en la lista de juntas y en el detalle.</td>
    </tr>
    <tr>
      <td><b>Fila de lista</b></td>
      <td>Avatar con iniciales, dos líneas de texto y chip de estado.</td>
      <td>Integrantes, aportes, turnos y avisos.</td>
    </tr>
    <tr>
      <td><b>Aviso (banner)</b></td>
      <td>Informativo y de advertencia.</td>
      <td>Estados como "Sin conexión. Mostrando lo último guardado" y los recordatorios de que los datos ya no pueden cambiar.</td>
    </tr>
    <tr>
      <td><b>Barra de progreso</b></td>
      <td>Con porcentaje o conteo ("6 de 8 aportes validados").</td>
      <td>Avance del período.</td>
    </tr>
    <tr>
      <td><b>Interruptor y tarjeta de opción</b></td>
      <td>Activado y desactivado; opción seleccionada y sin seleccionar.</td>
      <td>Recordatorios automáticos, método de asignación de turnos y tema visual.</td>
    </tr>
    <tr>
      <td><b>Barra superior</b></td>
      <td>Principal (título e iconos de acción, como búsqueda y menú) y de detalle (flecha de regreso y menú).</td>
      <td>Todas las pantallas, salvo las de pantalla completa de confirmación.</td>
    </tr>
    <tr>
      <td><b>Navegación inferior</b></td>
      <td>Cuatro destinos, con indicador del destino actual y punto de aviso.</td>
      <td>Juntas, Historial, Avisos y Perfil.</td>
    </tr>
    <tr>
      <td><b>Botón flotante (FAB)</b></td>
      <td>Extendido, con icono y texto ("Nueva junta").</td>
      <td>Crear una junta o agregar un integrante.</td>
    </tr>
    <tr>
      <td><b>Comprobante (voucher)</b></td>
      <td>Constancia de pago con monto, destinatario, fecha y número de operación.</td>
      <td>Carga y revisión de aportes.</td>
    </tr>
  </tbody>
</table>

Las Figuras 76 y 77 muestran el detalle correspondiente.

![Catálogo de componentes en modo claro](images/chapter_3/style_guide_componentes_1.png){width=90%}

![Catálogo de componentes en modo oscuro](images/chapter_3/style_guide_componentes_2.png){width=90%}

##### Modos de visualización

El mismo conjunto de roles se resuelve en tres modos. El modo claro es el modo base, con fondo crema. El modo oscuro usa el fondo #1B110E y los mismos roles con otros valores, y el contraste de sus combinaciones también se verificó. El modo wireframe usa solo grises y sin color de marca: los textos se conservan en gris oscuro, los íconos también y las imágenes son recuadros con una X. Existe para presentar el diseño de baja fidelidad sin que el color distraiga de la estructura y del peso de cada elemento. En la aplicación, la persona elige entre Usar el del sistema, Claro y Oscuro desde Perfil, y el cambio se aplica al instante (pantalla I2, historia US06). En el landing, un botón de la barra superior alterna entre sistema, claro y oscuro y recuerda la elección en el navegador; si el navegador bloquea el almacenamiento, la página sigue funcionando y sigue el tema del sistema.

##### Voz y contenido

Los textos de la interfaz siguen cinco reglas, que valen igual para la aplicación y para el landing en español:

1. Se tutea y se habla en positivo. Los botones empiezan con un verbo en infinitivo ("Registrar mi aporte de S/ 300", "Confirmar aporte") y las instrucciones usan el imperativo ("Sube el comprobante", "Elige el método").
2. Se usa el vocabulario de la junta, no el de un banco. Se escribe "aporte", "pozo", "turno" y "fecha de corte", y el comprobante de Yape o Plin se llama comprobante, no voucher.
3. Un estado es una sola palabra o una expresión muy corta: Validado, En revisión, Pendiente, Monto distinto.
4. Un mensaje de error dice qué pasó y qué hacer, sin culpar a la persona: "El código tiene 6 dígitos".
5. Los montos llevan el prefijo S/ y separador de miles ("S/ 2,400.00" cuando el monto es el protagonista y "S/ 300" en listas). Las fechas se escriben "5 nov 2026" y las horas en formato de 12 horas ("7:42 p. m."), como las muestran Yape y Plin.

##### Adaptación de la guía al landing page

El landing aplica la misma guía con las mismas tres clases de ancho de ventana que usa la aplicación (compacta, mediana y expandida) [@android2026wsc], y cambia de composición en esos puntos: (ver Tabla 110)

<table>
  <caption>Adaptación de la guía de estilos al landing page según el ancho de ventana</caption>
  <colgroup><col width="20%"><col width="16%"><col width="16%"><col width="48%"></colgroup>
  <thead>
    <tr>
      <th>Clase de ventana</th>
      <th align="center">Margen lateral</th>
      <th align="center">Relleno de sección</th>
      <th>Composición</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Compacta</b> (menos de 600 px)</td>
      <td align="center">16 px</td>
      <td align="center">48 px</td>
      <td>Una columna. Barra superior de 56 px con el menú plegado. Barra inferior fija con la llamada a la acción. Los teléfonos de la aplicación se solapan en el hero.</td>
    </tr>
    <tr>
      <td><b>Mediana</b> (600 a 839 px)</td>
      <td align="center">24 px</td>
      <td align="center">64 px</td>
      <td>Una columna con titulares más grandes y teléfonos de mayor tamaño. Barra superior de 64 px. La barra inferior sigue visible.</td>
    </tr>
    <tr>
      <td><b>Expandida</b> (840 px o más)</td>
      <td align="center">32 px</td>
      <td align="center">64 px</td>
      <td>Hero en dos columnas, tres pasos en fila, funcionalidades en dos columnas que se alternan y barra inferior oculta. El menú de la barra superior se muestra completo desde 1040 px; por debajo se pliega.</td>
    </tr>
  </tbody>
</table>

El contenido nunca supera los 1200 px de ancho. El titular principal mide 45/52 px en el mock-up de escritorio y en el sitio baja de forma fluida hasta 34 px en pantallas estrechas, para que el titular completo quepa en 320 px sin desbordar la pantalla. Los títulos de sección siguen la escala de la guía: 28/36 px en pantallas compactas y 32/40 px desde 600 px, y los títulos de cada funcionalidad usan 22/28 px.

### 3.1.2. Information Architecture
La arquitectura de información define dónde se ubica cada contenido, cómo se denomina, de qué manera se accede a él y cómo puede ser localizado por los usuarios. Las cinco secciones siguientes desarrollan los cuatro sistemas principales de la arquitectura de información: organización, etiquetado, navegación y búsqueda. Además, tanto la aplicación móvil como la landing page incorporan una sección específica de etiquetado. En el caso de la landing page, estas etiquetas también contribuyen a mejorar su visibilidad en la búsqueda y la forma en que se presenta el contenido al ser compartido.

En los dos productos el punto de partida es el mismo. La persona que usa Pozzo no explora un catálogo: llega con una tarea concreta (aportar, revisar un aporte, saber cuándo cobra, decidir si le interesa) y la arquitectura debe llevarla a ella con el menor número de toques posible.
#### 3.1.2.1. Organization Systems
Un sistema de organización combina un esquema, que decide cómo se agrupan los elementos, y una estructura, que decide cómo se relacionan entre sí. En Pozzo el esquema cambia según el producto, porque la aplicación se usa muchas veces con una tarea distinta cada vez y el landing se recorre una sola vez de arriba abajo (ver Tabla 111).

<table>
  <caption>Esquemas de organización aplicados en Pozzo</caption>
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

La profundidad máxima es de tres niveles: destino principal, detalle de la junta y acción específica. Los modales y los pasos internos de un flujo no se consideran niveles adicionales. Esta estructura reduce la cantidad de toques necesarios para completar tareas frecuentes, especialmente realizar aportes. El primer ingreso funciona como un flujo lineal previo a la navegación principal y, si el usuario aún no pertenece a una junta, se muestra un estado vacío con las opciones de crear una o unirse mediante un código (ver Figura 78).

![Arquitectura de información de la aplicación: cuatro destinos, grupos de pantallas por segmento y por tarea, y máximo tres niveles](images/chapter_3/ia_mapa_app.png){width=95%}

##### Landing page

El landing se organiza por tema y por tarea en una sola página de recorrido vertical, con la estructura lineal de un relato: primero qué es Pozzo y qué problema resuelve, luego cómo funciona, por qué confiar, qué incluye, quién lo hace, cómo registrarse y cómo contactar. Es el orden en que las historias US43 a US45 plantean las preguntas de un visitante. La barra superior fija y los enlaces ancla convierten ese recorrido en una estructura de hipertexto interno, de modo que se puede saltar a cualquier sección desde cualquier punto de la página (ver Tabla 112).

<table>
  <caption>Secciones del landing page y la historia que atienden</caption>
  <colgroup><col width="14%"><col width="22%"><col width="42%"><col width="22%"></colgroup>
  <thead>
    <tr>
      <th>Ancla</th>
      <th>Sección</th>
      <th>Contenido</th>
      <th>Historia</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>#top</b></td>
      <td>Propuesta de valor</td>
      <td>Problema, solución, el aviso de que Pozzo no maneja ni mueve el dinero y dos llamadas a la acción.</td>
      <td>US43 (escenario 1)</td>
    </tr>
    <tr>
      <td><b>#how</b></td>
      <td>Cómo funciona</td>
      <td>Tres pasos numerados: crear o unirse, aportar y subir el comprobante, y que Pozzo valide y lleve la cuenta.</td>
      <td>US43</td>
    </tr>
    <tr>
      <td><b>#trust</b></td>
      <td>Tu dinero nunca pasa por Pozzo</td>
      <td>Franja con tres puntos: sin billeteras que conectar, pagos directos entre integrantes y sin comisión sobre el pozo. No figura en la barra superior.</td>
      <td>US43 (aclaración sobre el dinero)</td>
    </tr>
    <tr>
      <td><b>#features</b></td>
      <td>Funcionalidades</td>
      <td>Cinco filas alternadas, cada una con una pantalla de la aplicación: validación de comprobantes, estado del pozo, recordatorios, turnos y historial.</td>
      <td>US43 (escenario 2)</td>
    </tr>
    <tr>
      <td><b>#team</b></td>
      <td>Equipo</td>
      <td>Misión de la startup y los cinco integrantes con nombre, rol y foto.</td>
      <td>US45 (escenario 1)</td>
    </tr>
    <tr>
      <td><b>#join</b></td>
      <td>Registro de interés</td>
      <td>Formulario con nombre y correo o celular, aceptación de los términos y mensaje de confirmación.</td>
      <td>US44 (escenario 2)</td>
    </tr>
    <tr>
      <td><b>#contact</b></td>
      <td>Contacto</td>
      <td>Correo de contacto y enlaces a las redes de la startup.</td>
      <td>US45 (escenario 2)</td>
    </tr>
    <tr>
      <td><b>pie</b></td>
      <td>Pie de página</td>
      <td>Enlaces a las secciones, selector de idioma, Términos y Condiciones y Política de privacidad.</td>
      <td>US44 y US46</td>
    </tr>
  </tbody>
</table>

La Figura 79 muestra la arquitectura de información del landing: dos idiomas con las mismas secciones, páginas legales y barra superior fija.

![Arquitectura de información del landing: dos idiomas con las mismas secciones, páginas legales y barra superior fija](images/chapter_3/ia_mapa_landing.png){width=95%}

#### 3.1.2.2. Labelling Systems

Las etiquetas son la manera en que el sistema habla: el nombre de un destino, el texto de un botón, el título de una sección. Una etiqueta mal elegida obliga a la persona a adivinar qué hay detrás, y eso rompe la heurística de coincidir con el mundo real. Para Pozzo el equipo fijó cuatro reglas:

1. Las etiquetas salen del Ubiquitous Language de la sección 2.3.6. Si un concepto ya tiene nombre en el glosario, la interfaz usa ese nombre y no inventa uno.
2. Cada concepto tiene una sola etiqueta. El glosario registra junta y pandero como sinónimos, pero la interfaz usa solo "junta", para no tener dos nombres para lo mismo.
3. Una etiqueta describe el destino o la acción, no el contenedor: "Historial" y "Avisos" dicen qué se va a encontrar; "Registrar mi aporte de S/ 300" dice qué va a pasar y cuánto.
4. La misma acción lleva el mismo texto en todos los lugares donde aparece. En el landing, los tres botones que llevan al formulario dicen exactamente lo mismo.

##### Etiquetas de la aplicación

La Tabla 113 presenta la correspondencia entre el Ubiquitous Language y las etiquetas de la interfaz.

<table>
  <caption>Correspondencia entre el Ubiquitous Language y las etiquetas de la interfaz</caption>
  <colgroup><col width="22%"><col width="25%"><col width="53%"></colgroup>
  <thead>
    <tr>
      <th>Término del Ubiquitous Language</th>
      <th>Etiqueta en la interfaz</th>
      <th>Dónde aparece</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Savings Group (Junta)</td>
      <td>Junta, Mis juntas</td>
      <td>Destino de la barra inferior y título de B1 y B2.</td>
    </tr>
    <tr>
      <td>Contribution (Aporte)</td>
      <td>Aporte, Aportar</td>
      <td>"Registrar mi aporte de S/ 300" (F1), "Aportar ahora" (B2), "Aporte validado" (F5).</td>
    </tr>
    <tr>
      <td>Pot (Pozo)</td>
      <td>Pozo</td>
      <td>"Estado del pozo" (F1), "Entregar el pozo" (H4).</td>
    </tr>
    <tr>
      <td>Turn y Turn Assignment (Turno, Asignación de turnos)</td>
      <td>Turno, Asignar turnos</td>
      <td>"Tu turno (4.º)" (B2), "Asignar turnos" (E1), "Ordenar turnos" (E5), "Calendario de turnos" (G2).</td>
    </tr>
    <tr>
      <td>Draw, Agreed Order y Bidding (Sorteo, Orden acordado, Subasta)</td>
      <td>Sorteo, Orden acordado, Subasta (con el chip "Próximamente")</td>
      <td>E3, E4 y E5. La subasta se muestra desactivada porque no entra en la primera versión.</td>
    </tr>
    <tr>
      <td>Organizer y Member (Cabeza de junta, Participante)</td>
      <td>Cabeza de junta, Participante</td>
      <td>Chips de las tarjetas de B1 y B2. En la lista de integrantes (E1) el chip se abrevia a "Cabeza".</td>
    </tr>
    <tr>
      <td>Cut-off Date (Fecha de corte)</td>
      <td>Fecha de corte, Corte</td>
      <td>"Fecha de corte 5 de ene" (B1), "Corte 5 ene" (F1).</td>
    </tr>
    <tr>
      <td>Payout (Cobro)</td>
      <td>Cobro, Cobra, Entregar el pozo</td>
      <td>"Cobra Carla Vega" (F1 y H4): el participante cobra y la cabeza entrega.</td>
    </tr>
    <tr>
      <td>Payment Proof (Comprobante)</td>
      <td>Comprobante</td>
      <td>"Subir comprobante" (F3). La palabra voucher no aparece en pantalla.</td>
    </tr>
    <tr>
      <td>Coverage (Cobertura)</td>
      <td>Cubrir un aporte, cubierto</td>
      <td>H5 y el resumen de cierre (H6).</td>
    </tr>
    <tr>
      <td>Compliance History (Historial de cumplimiento)</td>
      <td>Historial, Mi historial de cumplimiento, Integrantes</td>
      <td>Destino Historial de la barra inferior: "Mi historial de cumplimiento" para el participante (G3) y la pestaña Integrantes, con el porcentaje de puntualidad de cada uno, para la cabeza (K2).</td>
    </tr>
    <tr>
      <td>Reminder (Recordatorio)</td>
      <td>Recordatorios automáticos, Detenidos</td>
      <td>Interruptor en Avisos (I3), chip "Detenidos" cuando el aporte ya se validó (J3) y notificaciones de Pozzo antes del corte (J1).</td>
    </tr>
    <tr>
      <td>Cycle y Contribution Period (Ciclo, Período)</td>
      <td>Ciclo, Período</td>
      <td>"Período 3 de 8" (F1), "Ciclo completado" (H6).</td>
    </tr>
    <tr>
      <td>Delinquency y Dropout (Morosidad, Deserción)</td>
      <td>No aparecen</td>
      <td>Son términos del análisis que suenan a reproche. La interfaz dice "Atrasado" (chip en J2) y deja que el dato hable por sí solo.</td>
    </tr>
  </tbody>
</table>

Los estados de un aporte y de una junta también son etiquetas, y se escriben siempre igual y con el mismo tono de color (sección 3.1.1.1): (ver Tabla 114)

<table>
  <caption>Tono y significado de las etiquetas de estado</caption>
  <colgroup><col width="20%"><col width="18%"><col width="62%"></colgroup>
  <thead>
    <tr>
      <th>Etiqueta</th>
      <th>Tono</th>
      <th>Significado</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Validado</b></td>
      <td>success</td>
      <td>El comprobante coincide con lo esperado, o la cabeza aprobó el aporte.</td>
    </tr>
    <tr>
      <td><b>En revisión</b></td>
      <td>warning</td>
      <td>Pozzo leyó el comprobante pero no coincide con lo esperado, y la cabeza debe revisarlo.</td>
    </tr>
    <tr>
      <td><b>Monto distinto, Destinatario</b></td>
      <td>error en texto e icono</td>
      <td>Indican en qué dato no coincide un aporte en revisión: el monto o el destinatario.</td>
    </tr>
    <tr>
      <td><b>Pendiente</b></td>
      <td>warning o neutral</td>
      <td>El aporte todavía no se registró. Va en warning cuando es el propio de la persona y en neutral cuando es el de otro integrante.</td>
    </tr>
    <tr>
      <td><b>Atrasado</b></td>
      <td>error</td>
      <td>Pasó la fecha de corte y el aporte sigue sin registrarse. Se muestra a la cabeza y a todo el grupo (J2), con un reloj junto al texto para no depender solo del color.</td>
    </tr>
    <tr>
      <td><b>Por iniciar, En curso</b></td>
      <td>warning, success</td>
      <td>Estado de la junta: aún se están definiendo los turnos, o ya corre el ciclo.</td>
    </tr>
    <tr>
      <td><b>Usa Pozzo</b></td>
      <td>neutral</td>
      <td>En la lista de integrantes, distingue a quien usa la aplicación de quien fue agregado por la cabeza sin ella.</td>
    </tr>
    <tr>
      <td><b>Solo lectura, Recalculado, Detenidos</b></td>
      <td>neutral, gold, success</td>
      <td>Marcan el estado de una pantalla: reglas que el participante solo puede consultar (E9), pozo por turno recalculado al ajustar el aporte (E7) y recordatorios que Pozzo dejó de enviar al validarse el aporte (J3).</td>
    </tr>
  </tbody>
</table>

##### Etiquetas del landing

El landing tiene dos conjuntos de etiquetas, uno por idioma, que se mantienen en archivos separados y con las mismas claves. Los nombres de los idiomas se escriben en su propio idioma (English y Español) y no se traducen. Las etiquetas de navegación son sustantivos cortos que repiten el título de la sección a la que llevan (ver Tabla 115).

<table>
  <caption>Etiquetas del landing page en inglés y español</caption>
  <colgroup><col width="28%"><col width="36%"><col width="36%"></colgroup>
  <thead>
    <tr>
      <th>Elemento</th>
      <th>English (EN)</th>
      <th>Español (ES)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Barra superior</b></td>
      <td>How it works, Features, Team, Contact</td>
      <td>Cómo funciona, Funcionalidades, Equipo, Contacto</td>
    </tr>
    <tr>
      <td><b>Llamada a la acción principal</b></td>
      <td>Join the waitlist</td>
      <td>Unirme a la lista de espera</td>
    </tr>
    <tr>
      <td><b>Llamada a la acción secundaria</b></td>
      <td>See how it works</td>
      <td>Ver cómo funciona</td>
    </tr>
    <tr>
      <td><b>Título del hero</b></td>
      <td>Your junta, without the notebook or the screenshots</td>
      <td>Tu junta, sin cuaderno ni capturas</td>
    </tr>
    <tr>
      <td><b>Aviso sobre el dinero</b></td>
      <td>Pozzo never holds or moves your money</td>
      <td>Pozzo no maneja ni mueve tu dinero</td>
    </tr>
    <tr>
      <td><b>Franja de confianza</b></td>
      <td>Your money never touches Pozzo</td>
      <td>Tu dinero nunca pasa por Pozzo</td>
    </tr>
    <tr>
      <td><b>Funcionalidades</b></td>
      <td>Receipts checked for you, The pot in real time, Automatic reminders, Fair turns: draw, agreed order or auction, A track record that travels with you</td>
      <td>Comprobantes validados para ti, El pozo en tiempo real, Recordatorios automáticos, Turnos justos: sorteo, orden acordado o subasta, Un historial que te acompaña</td>
    </tr>
    <tr>
      <td><b>Marca de disponibilidad</b></td>
      <td>Available in v1</td>
      <td>Disponible en la v1</td>
    </tr>
    <tr>
      <td><b>Pie de página</b></td>
      <td>Terms and Conditions, Privacy Policy, Back to top</td>
      <td>Términos y Condiciones, Política de privacidad, Volver arriba</td>
    </tr>
    <tr>
      <td><b>Accesibilidad</b></td>
      <td>Skip to content, Main navigation, Theme: system</td>
      <td>Saltar al contenido, Navegación principal, Tema: sistema</td>
    </tr>
  </tbody>
</table>

En el texto del landing, la cabeza de junta se nombra con el mismo término del glosario ("la cabeza de junta") y no con un sinónimo; en inglés se escribe "the organizer" porque el término cabeza de junta no tiene equivalente en esa lengua.

#### 3.1.2.3. SEO Tags and Meta Tags

El landing page es el principal contenido de Pozzo accesible para los motores de búsqueda. El landing page es el principal contenido de Pozzo accesible para los motores de búsqueda. Por ello, sus etiquetas SEO y metadatos forman parte de la arquitectura del sitio y se incorporan de manera consistente en las páginas correspondientes (ver Tabla 116).
<table>
  <caption>Etiquetas SEO y meta tags aplicadas en Pozzo</caption>
  <colgroup><col width="22%"><col width="48%"><col width="30%"></colgroup>
  <thead>
    <tr>
      <th>Etiqueta</th>
      <th>Aplicación en Pozzo</th>
      <th>Función</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>title</b></td>
      <td>Incluye el nombre Pozzo y una propuesta breve de valor, adaptada al idioma y al tipo de página.</td>
      <td>Identifica la página en los resultados de búsqueda y en la pestaña del navegador.</td>
    </tr>
    <tr>
      <td><b>meta description</b></td>
      <td>Resume las principales funciones de Pozzo, aclara que no administra el dinero e incluye una invitación a registrarse.</td>
      <td>Describe brevemente la página en los resultados de búsqueda.</td>
    </tr>
    <tr>
      <td><b>charset y viewport</b></td>
      <td>UTF-8 y configuración responsive para dispositivos móviles.</td>
      <td>Garantiza la correcta visualización del contenido.</td>
    </tr>
    <tr>
      <td><b>robots</b></td>
      <td>Permite indexar y seguir los enlaces de las páginas públicas del sitio.</td>
      <td>Facilita el rastreo e indexación.</td>
    </tr>
    <tr>
      <td><b>canonical</b></td>
      <td>Cada página define su dirección oficial.</td>
      <td>Evita problemas de contenido duplicado.</td>
    </tr>
    <tr>
      <td><b>hreflang</b></td>
      <td>Relaciona las versiones en inglés y español e incluye una versión predeterminada.</td>
      <td>Ayuda al buscador a mostrar el idioma adecuado.</td>
    </tr>
    <tr>
      <td><b>Open Graph</b></td>
      <td>Incluye título, descripción, imagen, URL e idioma.</td>
      <td>Define la vista previa al compartir Pozzo en WhatsApp y redes sociales.</td>
    </tr>
    <tr>
      <td><b>Twitter card</b></td>
      <td>Utiliza una tarjeta con imagen, título y descripción.</td>
      <td>Mejora la presentación del enlace en plataformas compatibles.</td>
    </tr>
    <tr>
      <td><b>JSON-LD</b></td>
      <td>Describe a Kerolabs, el sitio web Pozzo y la aplicación móvil mediante datos estructurados.</td>
      <td>Ayuda a los buscadores a interpretar el contenido y su relación con el producto.</td>
    </tr>
    <tr>
      <td><b>Íconos y manifest</b></td>
      <td>Incluye favicon, iconos para dispositivos móviles y archivo manifest.</td>
      <td>Define la identidad visual del sitio en pestañas, accesos directos y marcadores.</td>
    </tr>
    <tr>
      <td><b>sitemap.xml y robots.txt</b></td>
      <td>El sitemap registra las páginas públicas y robots.txt permite su rastreo.</td>
      <td>Facilita el descubrimiento e indexación del sitio.</td>
    </tr>
  </tbody>
</table>

El atributo lang diferencia las páginas en inglés y español, mientras que hreflang relaciona ambas versiones y define una alternativa predeterminada para otros idiomas. Además, cada versión referencia tanto a sí misma como a las demás, siguiendo las recomendaciones de Google.

El sitio también emplea una estructura semántica clara, con un único h1 por página, encabezados jerarquizados, etiquetas de navegación, contenido principal y pie de página. Las imágenes incluyen texto alternativo, formatos optimizados y carga diferida cuando corresponde, mejorando tanto la accesibilidad como el rendimiento.

##### Ficha de Google Play

La ficha de Google Play cumple una función similar a los metadatos del landing, ya que permite presentar y posicionar la aplicación dentro de la tienda. El equipo propone inicialmente los siguientes contenidos: (ver Tabla 117)

<table>
  <caption>Ficha de la aplicación en Google Play</caption>
  <colgroup><col width="25%"><col width="75%"></colgroup>
  <thead>
    <tr>
      <th>Campo</th>
      <th>Texto propuesto</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Título</b></td>
      <td>Pozzo: administra tu junta</td>
    </tr>
    <tr>
      <td><b>Descripción corta</b></td>
      <td>Valida aportes, mira el pozo en tiempo real y recuerda a quien se atrasa.</td>
    </tr>
    <tr>
      <td><b>Descripción completa</b></td>
      <td>Presentará primero la propuesta de valor y la aclaración de que Pozzo no administra el dinero. Luego resumirá las principales funciones: validación de comprobantes, seguimiento del pozo, recordatorios, turnos e historial, y cerrará con una invitación a crear o unirse a una junta.</td>
    </tr>
  </tbody>
</table>

#### 3.1.2.4. Searching Systems

Un sistema de búsqueda se justifica cuando hay tanto contenido que navegar deja de alcanzar . En Pozzo no ocurre: una persona tiene unas pocas juntas, cada una con un grupo de integrantes que se conocen entre sí y un período activo a la vez. Por eso esta versión no incluye un buscador global dentro de la aplicación. El componente de barra superior del catálogo prevé un icono de búsqueda para cuando el volumen lo justifique, pero ninguna pantalla de esta versión lo usa. En su lugar, cada lugar donde la persona necesita encontrar algo tiene un mecanismo propio, más corto que escribir una consulta: (ver Tabla 118)

<table>
  <caption>Mecanismos de búsqueda y filtrado por pantalla</caption>
  <colgroup><col width="28%"><col width="38%"><col width="14%"><col width="20%"></colgroup>
  <thead>
    <tr>
      <th>Lo que la persona busca</th>
      <th>Mecanismo</th>
      <th align="center">Pantalla</th>
      <th>Historia</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Una junta a la que la invitaron</td>
      <td>Ingresar el código de invitación o abrir el enlace compartido por WhatsApp. El código identifica la junta sin que haya que buscarla por nombre.</td>
      <td align="center">D1</td>
      <td>US12</td>
    </tr>
    <tr>
      <td>Los aportes que la cabeza debe revisar</td>
      <td>Pestañas "Por revisar (2)" y "Todos", con el número de pendientes en la etiqueta, y un aviso con ese mismo número en la pantalla de inicio.</td>
      <td align="center">B1 y H1</td>
      <td>US26</td>
    </tr>
    <tr>
      <td>Cuándo cobra cada quien y cuándo es el corte</td>
      <td>Calendario cronológico con un período por fila, que se abre desde el ícono de calendario de la barra superior de la junta.</td>
      <td align="center">G2</td>
      <td>US22</td>
    </tr>
    <tr>
      <td>Quién aportó en cada período y cómo cumple cada integrante</td>
      <td>Historial de la cabeza: una matriz de integrantes por períodos con el estado de cada aporte (al tocar un estado se ve el comprobante) y una pestaña Integrantes con sus aportes puntuales.</td>
      <td align="center">K1 y K2</td>
      <td>US32 y US42</td>
    </tr>
    <tr>
      <td>La prueba de un aporte propio</td>
      <td>Mis aportes, con una fila por período y el comprobante de cada aporte validado, y el historial de cumplimiento del destino Historial, que resume la puntualidad por junta. Mis aportes sigue disponible sin conexión con lo último guardado.</td>
      <td align="center">G1 y G3</td>
      <td>US28, US31, US40 y US41</td>
    </tr>
  </tbody>
</table>

La última fila responde a un hallazgo del Capítulo II: el 100% de los participantes reconoce que probar un aporte de hace tres meses les costaría y les resultaría incómodo. Hoy buscan la captura en la galería; en Pozzo la prueba ya está en la lista del período correspondiente.

Hacia afuera, la búsqueda ocurre en dos sitios que el equipo no controla: el buscador, donde el landing se encuentra por sus etiquetas de cabecera, y la tienda de aplicaciones, donde la aplicación se encuentra por su ficha. El landing tampoco tiene buscador interno: es una sola página con ocho secciones y se recorre con la barra superior.

#### 3.1.2.5. Navigation Systems

Un sistema de navegación responde tres preguntas: dónde estoy, adónde puedo ir y cómo vuelvo. La aplicación y el landing las resuelven con elementos distintos, porque se usan de manera distinta.

##### Aplicación móvil

La Tabla 119 presenta los sistemas de navegación de la aplicación móvil.

<table>
  <caption>Sistemas de navegación de la aplicación móvil</caption>
  <colgroup><col width="24%"><col width="46%"><col width="30%"></colgroup>
  <thead>
    <tr>
      <th>Tipo de navegación</th>
      <th>Cómo se resuelve</th>
      <th>Pantallas</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Global</b></td>
      <td>Barra inferior de cuatro destinos (Juntas, Historial, Avisos y Perfil), siempre visible en las pantallas raíz. El destino actual se marca con un indicador de color y Avisos muestra un punto cuando hay novedades.</td>
      <td>B, G3, K, I1, I3 y J3</td>
    </tr>
    <tr>
      <td><b>Local</b></td>
      <td>Barra superior con flecha de regreso en las pantallas de detalle y pestañas para dividir una pantalla densa: Integrantes, Turnos y Reglas en el detalle de la junta; Por revisar y Todos en los aportes; Aportes e Integrantes en el historial de la cabeza. La pestaña Reglas de E1 lleva a la edición de las reglas (E7).</td>
      <td>E1, E7 a E9, H1, K1 y K2, y la mayoría de pantallas de detalle</td>
    </tr>
    <tr>
      <td><b>Contextual</b></td>
      <td>Tarjetas y avisos que llevan a la siguiente acción: "2 aportes por revisar" a la cabeza, "Tu aporte vence en 5 días" al participante, "Aporte atrasado desde el 5 ene" cuando vence el corte, y una acción principal fija al pie de la pantalla ("Registrar mi aporte de S/ 300").</td>
      <td>B1, B2, F1 y J2</td>
    </tr>
    <tr>
      <td><b>Por pasos</b></td>
      <td>Los flujos de varios pasos avanzan con un único botón principal y se pueden salir con la flecha de regreso. Los pasos que se abren sobre otra pantalla y se cierran sin dejar rastro (aporte en efectivo, cubrir un aporte) se salen con una X.</td>
      <td>A, C, F, H3 y H5</td>
    </tr>
    <tr>
      <td><b>Complementaria</b></td>
      <td>Botón flotante para crear una junta, hoja modal para agregar un integrante sin la aplicación, la opción "Unirme con un código" visible en el inicio, el ícono de calendario de la barra superior de la junta, que abre el calendario de turnos (G2), y el menú de tres puntos del estado del pozo, que abre las reglas de la junta (E8 o E9).</td>
      <td>B1, B2, B3, E2 y F1</td>
    </tr>
  </tbody>
</table>

Dos decisiones merecen explicarse. La primera es que no hay migas de pan (breadcrumbs): con tres niveles como máximo y una flecha de regreso en cada pantalla de detalle, la persona nunca está a más de dos pantallas de distancia de una pantalla raíz, y las migas de pan ocuparían espacio en una pantalla de 360 px que hace falta para el contenido. La segunda es que la cabeza de junta no tiene un menú aparte para gestionar: llega a la revisión de aportes desde un aviso de la pantalla de inicio y a la entrega del pozo desde el estado del pozo, es decir, desde el lugar donde ya está mirando. Todo el primer ingreso (A1 a A4) es lineal y no muestra la barra inferior hasta que la persona tiene cuenta.

##### Landing page

La Tabla 120 presenta los sistemas de navegación del landing page.

<table>
  <caption>Sistemas de navegación del landing page</caption>
  <colgroup><col width="24%"><col width="50%"><col width="26%"></colgroup>
  <thead>
    <tr>
      <th>Elemento</th>
      <th>Cómo funciona</th>
      <th>Historia o criterio</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Barra superior fija</b></td>
      <td>Logo, cuatro enlaces ancla (Cómo funciona, Funcionalidades, Equipo y Contacto), selector de idioma, botón de tema y la llamada a la acción principal. Queda visible durante todo el recorrido y el botón de tema alterna entre sistema, claro y oscuro.</td>
      <td>US46 (escenario 2)</td>
    </tr>
    <tr>
      <td><b>Menú plegado</b></td>
      <td>Por debajo de 1040 px de ancho, los enlaces se pliegan detrás de un botón de menú que se abre y se cierra con Enter y con Escape, y con Escape devuelve el foco al botón.</td>
      <td>US46 (escenario 1)</td>
    </tr>
    <tr>
      <td><b>Sección activa</b></td>
      <td>Mientras la persona se desplaza, el enlace de la sección que está leyendo se marca como actual. El desplazamiento deja un margen para que el título de la sección no quede tapado por la barra y es suave, salvo que la persona haya pedido reducir el movimiento.</td>
      <td>Criterio del equipo</td>
    </tr>
    <tr>
      <td><b>Barra inferior fija</b></td>
      <td>En pantallas de menos de 840 px aparece una barra con el botón de registro. Se oculta cuando el formulario está a la vista y nunca tapa el pie de página.</td>
      <td>US44 (escenario 1) y US46</td>
    </tr>
    <tr>
      <td><b>Salto al contenido</b></td>
      <td>El primer elemento al que llega el teclado es un enlace para saltar la barra y entrar directo al contenido principal.</td>
      <td>WCAG 2.2, criterio 2.4.1</td>
    </tr>
    <tr>
      <td><b>Selector de idioma</b></td>
      <td>EN y ES, en la barra superior y en el pie. Lleva a la página equivalente en el otro idioma, también en las páginas legales.</td>
      <td>Criterio del equipo</td>
    </tr>
    <tr>
      <td><b>Pie de página</b></td>
      <td>Enlaces a las secciones, selector de idioma, Términos y Condiciones, Política de privacidad y Volver arriba.</td>
      <td>US44</td>
    </tr>
    <tr>
      <td><b>Página 404</b></td>
      <td>Bilingüe, con enlaces a las dos portadas, para que quien llegue a una dirección inexistente no se quede sin salida.</td>
      <td>Criterio del equipo</td>
    </tr>
  </tbody>
</table>

El landing tampoco usa migas de pan, porque tiene un solo nivel de profundidad: una portada con anclas y cuatro páginas hoja que se vuelven a la portada con el logo.

### 3.1.3. Landing Page UI Design
El landing page presenta Pozzo a quien todavía no lo conoce y recoge su interés mientras la aplicación no está publicada. Responde a las cuatro historias del epic EP10: entender qué resuelve Pozzo (US43), encontrar cómo obtenerlo o dejar un contacto (US44), conocer al equipo (US45) y poder leerlo y navegarlo desde el celular (US46). Se diseñó primero en Figma, en dos fidelidades y en dos anchos, y después se implementó como sitio estático en HTML5, CSS3 y JavaScript sin dependencias de ejecución, con textos en inglés (EN, idioma por defecto) y en español (ES). La implementación sale del diseño y lo respeta; las pocas diferencias están señaladas en cada sección.

Como una página completa es demasiado alta para una figura, cada versión se presenta como un tablero de ventanas: cada recuadro es una ventana del navegador (de 1440 x 900 px en escritorio y de 360 x 800 px en celular) puesta sobre el mismo desplazamiento de la página. El escritorio ocupa ocho ventanas, dos por figura, y el celular trece ventanas en una sola figura.
#### 3.1.3.1. Landing Page Wireframe
El wireframe define la estructura y la jerarquía visual del landing page antes de incorporar colores, imágenes y contenido final. Sigue el modo wireframe establecido en la guía de estilo de la sección 3.1.1.1, utilizando tonos grises y elementos simplificados para representar la distribución de cada sección.
La siguiente tabla resume la estructura planteada para las versiones de escritorio y celular: (ver Tabla 121)

<table>
  <caption>Secciones del wireframe del landing page en escritorio y celular</caption>
  <colgroup><col width="17%"><col width="45%"><col width="38%"></colgroup>
  <thead>
    <tr>
      <th>Sección</th>
      <th>Escritorio</th>
      <th>Celular</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Barra superior</b></td>
      <td>Logo a la izquierda, enlaces de navegación al centro y, a la derecha, selector de idioma, cambio de tema y llamada a la acción principal.</td>
      <td>Logo, selector de idioma, llamada a la acción y botón de menú. Los enlaces de navegación se muestran dentro del menú desplegable.</td>
    </tr>
    <tr>
      <td><b>Hero (#top)</b></td>
      <td>Dos columnas. A la izquierda se muestran la propuesta de valor, el problema, la solución, la aclaración de que Pozzo no administra el dinero y las principales llamadas a la acción. A la derecha aparecen dos pantallas de la aplicación.</td>
      <td>El contenido se organiza en una sola columna y las pantallas de la aplicación se colocan debajo del texto.</td>
    </tr>
    <tr>
      <td><b>Cómo funciona (#how)</b></td>
      <td>Tres tarjetas numeradas organizadas en una fila.</td>
      <td>Las tres tarjetas se muestran de forma apilada.</td>
    </tr>
    <tr>
      <td><b>Confianza (#trust)</b></td>
      <td>Franja de ancho completo con un título, tres elementos informativos y una llamada a la acción.</td>
      <td>Los elementos se presentan de forma vertical para facilitar su lectura.</td>
    </tr>
    <tr>
      <td><b>Funcionalidades (#features)</b></td>
      <td>Cinco bloques en los que se alternan texto y pantallas de la aplicación. Cada bloque incluye ícono, título, explicación y una representación visual de la funcionalidad.</td>
      <td>Cada funcionalidad se organiza en una sola columna, con el texto seguido de la pantalla correspondiente.</td>
    </tr>
    <tr>
      <td><b>Equipo (#team)</b></td>
      <td>Se presenta la misión de Pozzo y las tarjetas de los integrantes con fotografía, nombre y rol.</td>
      <td>La misión y las tarjetas se reorganizan para adaptarse al ancho disponible.</td>
    </tr>
    <tr>
      <td><b>Registro (#join)</b></td>
      <td>Texto informativo a un lado y formulario al otro, acompañado por el estado de confirmación.</td>
      <td>El formulario ocupa el ancho disponible y el estado de confirmación aparece debajo.</td>
    </tr>
    <tr>
      <td><b>Contacto y pie (#contact)</b></td>
      <td>Incluye información de contacto, redes sociales, enlaces de navegación, idioma y textos legales.</td>
      <td>Los elementos se presentan de manera apilada para facilitar su lectura.</td>
    </tr>
  </tbody>
</table>

Hay una decisiones del wireframe que conviene explicar: la franja de confianza: se separó del hero y se le dio una banda propia, de ancho completo, porque la aclaración de que Pozzo no maneja el dinero responde a la duda más probable de un visitante y no debía depender de que lea el recuadro del hero (ver Figuras 80 a 84).

![Wireframe del landing en escritorio, ventanas 1 y 2 de 8](images/chapter_3/landing_wireframe_desktop_1.png){width=90%}

![Wireframe del landing en escritorio, ventanas 3 y 4 de 8](images/chapter_3/landing_wireframe_desktop_2.png){width=90%}

![Wireframe del landing en escritorio, ventanas 5 y 6 de 8](images/chapter_3/landing_wireframe_desktop_3.png){width=90%}

![Wireframe del landing en escritorio, ventanas 7 y 8 de 8](images/chapter_3/landing_wireframe_desktop_4.png){width=90%}

![Wireframe del landing en celular de 360 px, trece ventanas](images/chapter_3/landing_wireframe_mobile.png){width=90%}

#### 3.1.3.2. Landing Page Mockup
El mock-up transforma el wireframe en una propuesta de alta fidelidad mediante la incorporación de los colores de la marca, tipografía, componentes visuales y pantallas reales de la aplicación. Las pantallas utilizadas corresponden a los mock-ups desarrollados en la sección 3.1.4.3, manteniendo así coherencia entre la aplicación móvil y su presentación en el landing page.

Además de la versión de escritorio en modo claro, se desarrollaron variantes para el modo oscuro y para las versiones móviles en inglés y español. De esta manera, se puede evaluar cómo se adapta la interfaz a diferentes dispositivos, idiomas y preferencias visuales.

Las pantallas de la aplicación se presentan en español incluso dentro de la versión en inglés del landing, debido a que el producto se encuentra orientado inicialmente al mercado peruano. Esta decisión se comunica dentro de la sección de funcionalidades para evitar confusión.

En el mock-up, las fotografías de los integrantes del equipo se representan mediante elementos gráficos temporales. Las fotografías reales se incorporan posteriormente en la implementación del sitio (ver Figuras 85 a 91).

![Mock-up del landing en escritorio, ventanas 1 y 2 de 8](images/chapter_3/landing_mockup_desktop_1.png){width=90%}

![Mock-up del landing en escritorio, ventanas 3 y 4 de 8](images/chapter_3/landing_mockup_desktop_2.png){width=90%}

![Mock-up del landing en escritorio, ventanas 5 y 6 de 8](images/chapter_3/landing_mockup_desktop_3.png){width=90%}

![Mock-up del landing en escritorio, ventanas 7 y 8 de 8](images/chapter_3/landing_mockup_desktop_4.png){width=90%}

![Mock-up del hero del landing en escritorio, modo oscuro](images/chapter_3/landing_mockup_desktop_dark_hero.png){width=90%}

![Mock-up del landing en celular de 360 px, versión en inglés](images/chapter_3/landing_mockup_mobile_en.png){width=90%}

![Mock-up del landing en celular de 360 px, versión en español (es_419)](images/chapter_3/landing_mockup_mobile_es.png){width=90%}

El landing page se implementó como un sitio web estático utilizando únicamente HTML, CSS y JavaScript.

HTML se utiliza para definir la estructura y el contenido de las páginas; CSS permite aplicar los estilos visuales, la adaptación a distintos tamaños de pantalla y los modos claro y oscuro; mientras que JavaScript se encarga de las principales interacciones del sitio, como el menú móvil, el selector de idioma, el cambio de tema y la validación del formulario.

El sitio se publica mediante GitHub Pages desde un repositorio independiente del utilizado para este informe. Los archivos necesarios para su funcionamiento, como estilos, scripts, imágenes e íconos, se almacenan dentro del mismo proyecto, lo que permite mantener una implementación sencilla y reducir la dependencia de recursos externos.

Las pantallas de la aplicación utilizadas en el landing fueron obtenidas a partir de los mismos mock-ups elaborados en Figma y se presentan en formatos adecuados para su visualización en la web.

La implementación mantiene la propuesta definida en el mock-up, aunque incorpora algunas diferencias intencionales derivadas del funcionamiento real del sitio: (ver Tabla 122)

<table>
  <caption>Diferencias entre el mock-up y el sitio implementado</caption>
  <colgroup><col width="30%"><col width="35%"><col width="35%"></colgroup>
  <thead>
    <tr>
      <th>Aspecto</th>
      <th>Mock-up</th>
      <th>Sitio implementado</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Fotografías del equipo</b></td>
      <td>Recuadro de color con un ícono de persona.</td>
      <td>Fotografía de cada integrante acompañada de su respectivo texto alternativo.</td>
    </tr>
    <tr>
      <td><b>Titular del hero</b></td>
      <td>Tamaño definido para la composición diseñada.</td>
      <td>El tamaño se adapta de acuerdo con el ancho disponible para conservar la legibilidad.</td>
    </tr>
    <tr>
      <td><b>Formulario</b></td>
      <td>Campos y estado de confirmación representados visualmente.</td>
      <td>Campos funcionales con validación mediante JavaScript, mensajes de error y confirmación de la acción realizada.</td>
    </tr>
    <tr>
      <td><b>Menú en celular</b></td>
      <td>Ícono de menú representado gráficamente.</td>
      <td>Menú interactivo que puede abrirse y cerrarse desde dispositivos móviles y mediante teclado.</td>
    </tr>
    <tr>
      <td><b>Modo de tema</b></td>
      <td>Versiones clara y oscura representadas como variantes del diseño.</td>
      <td>Permite utilizar el tema del sistema o seleccionar los modos claro y oscuro.</td>
    </tr>
  </tbody>
</table>

### 3.1.4. Mobile Applications UX/UI Design

La aplicación móvil es donde Pozzo cumple su promesa: que el grupo sepa, sin cuaderno ni capturas, quién aportó, cuánto lleva el pozo y a quién le toca cobrar. Su interfaz se diseñó en cinco artefactos que se leen en este orden: los wireframes fijan la estructura de cada pantalla (3.1.4.1), los wireflows las unen en recorridos (3.1.4.2), los mock-ups les dan color, tipografía y datos reales (3.1.4.3), los user flows muestran las decisiones y los errores que hay detrás de los recorridos (3.1.4.4) y el prototipo permite recorrer los caminos principales con el dedo (3.1.4.5).

Son 46 pantallas de 360 x 800 px, la clase compacta de la guía de estilo (sección 3.1.1.1), repartidas en once flujos que se nombran con una letra (A a K). Cada pantalla lleva un código (la letra del flujo y un número, por ejemplo F4) que se conserva en todos los artefactos, de modo que una pantalla se puede seguir del wireframe al mock-up, al wireflow, al user flow y al prototipo sin perderla. El pie de cada pantalla indica las User Stories de la sección 2.4.1 que cubre.

Además de la letra, cada pantalla pertenece a un segmento objetivo, que es como la lee cada persona: Compartido (lo que ven la cabeza y el participante), Cabeza de junta y Participante. Los wireframes, los mock-ups y los wireflows siguen ese corte: cada lámina y cada wireflow pertenece a un solo segmento, de modo que cada persona puede leer solo el suyo de principio a fin. Una pantalla que sirve a los dos, como el estado del pozo (F1), se dibuja una vez en Compartido y se reutiliza en los recorridos de ambos (ver Tabla 123).

<table>
  <caption>Flujos de la aplicación móvil por segmento</caption>
  <colgroup><col width="8%"><col width="28%"><col width="22%"><col width="42%"></colgroup>
  <thead>
    <tr>
      <th align="center">Letra</th>
      <th>Flujo</th>
      <th>Segmento</th>
      <th>Para qué sirve</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td align="center"><b>A</b></td>
      <td>Acceso con el número de celular</td>
      <td>Compartido</td>
      <td>Entrar y registrarse sin contraseña.</td>
    </tr>
    <tr>
      <td align="center"><b>B</b></td>
      <td>Pantalla de inicio</td>
      <td>Compartido (B3), cabeza (B1) y participante (B2)</td>
      <td>Ver las juntas propias y lo que requiere acción.</td>
    </tr>
    <tr>
      <td align="center"><b>C</b></td>
      <td>Crear una junta e invitar</td>
      <td>Cabeza de junta</td>
      <td>Definir las reglas y compartir el código.</td>
    </tr>
    <tr>
      <td align="center"><b>D</b></td>
      <td>Unirse a una junta</td>
      <td>Participante</td>
      <td>Entrar con un código, revisando antes las reglas.</td>
    </tr>
    <tr>
      <td align="center"><b>E</b></td>
      <td>Preparación y reglas de la junta</td>
      <td>Cabeza de junta (E9 del participante)</td>
      <td>Completar el grupo, asignar turnos, ajustar las reglas e iniciar. El participante las consulta en E9.</td>
    </tr>
    <tr>
      <td align="center"><b>F</b></td>
      <td>Aportar con el comprobante</td>
      <td>Participante (F1 compartido)</td>
      <td>Ver el pozo, aportar y que Pozzo valide.</td>
    </tr>
    <tr>
      <td align="center"><b>G</b></td>
      <td>Seguimiento de la junta</td>
      <td>Participante (G2 compartido)</td>
      <td>Consultar aportes propios, turnos e historial de cumplimiento.</td>
    </tr>
    <tr>
      <td align="center"><b>H</b></td>
      <td>Gestión de la cabeza de junta</td>
      <td>Cabeza de junta</td>
      <td>Revisar aportes, registrar efectivo, cubrir, entregar y cerrar.</td>
    </tr>
    <tr>
      <td align="center"><b>I</b></td>
      <td>Perfil, avisos y ajustes</td>
      <td>Compartido (I3 de la cabeza)</td>
      <td>Datos propios, tema visual y recordatorios automáticos.</td>
    </tr>
    <tr>
      <td align="center"><b>J</b></td>
      <td>Recordatorios del aporte</td>
      <td>Participante</td>
      <td>Recibir recordatorios antes del corte, ver el atraso y que se detengan al aportar.</td>
    </tr>
    <tr>
      <td align="center"><b>K</b></td>
      <td>Historial de la junta</td>
      <td>Cabeza de junta</td>
      <td>Ver quién aportó en cada período y cómo cumple cada integrante.</td>
    </tr>
  </tbody>
</table>

Los dos arquetipos del Capítulo II guían los recorridos: Anna Weber, cabeza de junta, recorre el segmento Cabeza (flujos C, E, H y K, y el aviso I3) y Sofia Gonzales, participante, recorre el segmento Participante (flujos D, F, G y J, y las reglas en E9). Las dos pasan por el segmento Compartido: el acceso (A), el inicio vacío (B3), el estado del pozo (F1), el calendario de turnos (G2) y el perfil (I1 e I2).

El cuarto destino de la barra inferior es Historial y no Calendario. Un calendario de turnos aislado en la barra no permite hacer nada: solo informa, es igual para todos los integrantes de una junta y ya tiene lugar dentro de ella. Por eso se abre desde el ícono de calendario de la barra superior de la junta (G2), y el destino de la barra pasó a llevar lo que cada rol revisa con más frecuencia después de aportar: la cabeza ve quién aportó en cada período (K1) y cómo cumple cada integrante (K2), y el participante ve su propio cumplimiento por junta (G3).

Todas las pantallas comparten los mismos datos de ejemplo, de modo que cada pantalla continúa la historia de la anterior. Se presentan en la sección 3.1.4.3.

#### 3.1.4.1. Mobile Applications Wireframes

Los wireframes fijan qué hay en cada pantalla y en qué orden, sin color y sin imágenes, para discutir la estructura antes de discutir la apariencia. Están en el modo wireframe de la guía de estilo (sección 3.1.1.1): grises, un solo tono oscuro para la acción principal y para lo que más pesa, y recuadros con una X donde irá una imagen o una foto. Los textos se escriben en gris, con el contenido real de cada pantalla, de modo que se lee qué dice cada título, botón y etiqueta y cuánto espacio ocupa, sin que el color lleve la discusión. Los íconos se conservan, porque dicen qué es cada fila o cada botón. Además, cada lámina lleva su título y cada pantalla un pie con su código, su nombre y sus User Stories, que son la referencia con la que se sigue cada pantalla en los demás artefactos.

Las 46 pantallas se agrupan en 14 láminas de dos a cinco pantallas, ordenadas por segmento: dos de Compartido, siete de Cabeza de junta y cinco de Participante. Cuando un grupo de tareas tiene más de tres pantallas se parte en varias láminas (preparar la junta en dos, gestionar los aportes en dos y aportar en dos), para que cada pantalla se lea al tamaño que tendrá en el celular. Los wireframes y los mock-ups salen de la misma especificación de pantallas y se generan en el archivo de Figma con los mismos componentes, así que tienen exactamente la misma estructura y solo cambia la fidelidad (ver Tabla 124).

<table>
  <caption>Láminas de wireframes y las user stories que cubren</caption>
  <colgroup><col width="13%"><col width="20%"><col width="43%"><col width="24%"></colgroup>
  <thead>
    <tr>
      <th>Segmento</th>
      <th>Lámina</th>
      <th>Pantallas</th>
      <th>User Stories</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Compartido</b></td>
      <td>1&#46; Acceso con el número de celular</td>
      <td>A1 Bienvenida, A2 Ingresar celular, A3 Verificar código SMS, A4 Completar registro.</td>
      <td>US01, US02, US03</td>
    </tr>
    <tr>
      <td><b>Compartido</b></td>
      <td>2&#46; Inicio vacío, estado del pozo, calendario y perfil</td>
      <td>B3 Sin juntas todavía, F1 Estado del pozo, G2 Calendario de turnos, I1 Perfil, I2 Tema visual.</td>
      <td>US05, US06, US07, US12, US22, US29, US30</td>
    </tr>
    <tr>
      <td><b>Cabeza de junta</b></td>
      <td>1&#46; Inicio y creación de la junta</td>
      <td>B1 Mis juntas (cabeza de junta), C1 Reglas, C2 Fechas y destino, C3 Resumen, C4 Invitar con código y enlace.</td>
      <td>US07, US08, US11, US26, US29</td>
    </tr>
    <tr>
      <td><b>Cabeza de junta</b></td>
      <td>2&#46; Preparar la junta (1 de 2)</td>
      <td>E1 Detalle de la junta por iniciar, E2 Agregar sin la aplicación, E3 Método de asignación.</td>
      <td>US14, US15, US16, US17, US18, US19</td>
    </tr>
    <tr>
      <td><b>Cabeza de junta</b></td>
      <td>2&#46; Preparar la junta (2 de 2)</td>
      <td>E4 Resultado del sorteo, E5 Orden acordado, E6 Iniciar la junta.</td>
      <td>US10, US17, US18</td>
    </tr>
    <tr>
      <td><b>Cabeza de junta</b></td>
      <td>3&#46; Reglas de la junta y avisos</td>
      <td>E7 Ajustar las reglas, E8 Reglas fijas con la junta iniciada, I3 Avisos y recordatorios.</td>
      <td>US09, US34, US35</td>
    </tr>
    <tr>
      <td><b>Cabeza de junta</b></td>
      <td>4&#46; Gestionar los aportes (1 de 2)</td>
      <td>H1 Aportes por revisar, H2 Revisar un aporte con inconsistencia, H3 Registrar un aporte en efectivo.</td>
      <td>US26, US27</td>
    </tr>
    <tr>
      <td><b>Cabeza de junta</b></td>
      <td>4&#46; Gestionar los aportes (2 de 2)</td>
      <td>H4 Entregar el pozo, H5 Cubrir un aporte, H6 Cierre del ciclo.</td>
      <td>US36, US37, US39</td>
    </tr>
    <tr>
      <td><b>Cabeza de junta</b></td>
      <td>5&#46; Historial de la junta</td>
      <td>K1 Historial de aportes por período, K2 Integrantes e historial de cumplimiento.</td>
      <td>US29, US32, US42</td>
    </tr>
    <tr>
      <td><b>Participante</b></td>
      <td>1&#46; Inicio y unirse a una junta</td>
      <td>B2 Mis juntas (participante), D1 Ingresar el código, D2 Revisar la junta, D3 Unión confirmada.</td>
      <td>US12, US13, US23, US29</td>
    </tr>
    <tr>
      <td><b>Participante</b></td>
      <td>2&#46; Aportar con el comprobante (1 de 2)</td>
      <td>F2 Cómo aportar, F3 Subir el comprobante, F4 Revisar los datos leídos.</td>
      <td>US08, US23, US24</td>
    </tr>
    <tr>
      <td><b>Participante</b></td>
      <td>2&#46; Aportar con el comprobante (2 de 2)</td>
      <td>F5 Aporte validado, F6 Aporte en revisión, G1 Mis aportes y comprobantes (sin conexión).</td>
      <td>US25, US26, US28, US31</td>
    </tr>
    <tr>
      <td><b>Participante</b></td>
      <td>3&#46; Historial y reglas</td>
      <td>G3 Mi historial de cumplimiento, E9 Reglas de la junta en solo lectura.</td>
      <td>US09, US40, US41</td>
    </tr>
    <tr>
      <td><b>Participante</b></td>
      <td>4&#46; Recordatorios</td>
      <td>J1 Recordatorios antes del corte, J2 Estado del pozo con aporte atrasado, J3 Recordatorios detenidos al aportar.</td>
      <td>US33, US35</td>
    </tr>
  </tbody>
</table>

Las historias de la tabla salen del pie de cada pantalla, no de un reparto aproximado por lámina. Cada flujo se resolvió con una decisión de estructura que se puede defender con lo que se ve en pantalla: (ver Tabla 125)

<table>
  <caption>Decisiones de estructura de cada flujo</caption>
  <colgroup><col width="17%"><col width="83%"></colgroup>
  <thead>
    <tr>
      <th>Flujo</th>
      <th>Decisión de estructura</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>A. Acceso</b></td>
      <td>El número de celular verificado por SMS es la identidad: no hay contraseña que recordar ni recuperar. A3 usa un teclado numérico propio con seis casillas, un temporizador para reenviar el código y la opción de cambiar el número. A4 solo pide el nombre y la aceptación de los Términos y Condiciones y de la Política de privacidad. A1 ofrece "Tengo un código de invitación" para quien llega invitado.</td>
    </tr>
    <tr>
      <td><b>B. Inicio</b></td>
      <td>Arriba va lo que requiere acción: a la cabeza, un aviso con los aportes por revisar (B1); al participante, un aviso con los días que le quedan para aportar (B2). Debajo, una tarjeta por junta con un chip de rol (Cabeza de junta, Participante) y uno de estado (En curso, Por iniciar), para no confundir juntas cuando una persona pertenece a varias. Sin juntas (B3), la pantalla ofrece las dos salidas: crear una o unirse con un código.</td>
    </tr>
    <tr>
      <td><b>C. Crear</b></td>
      <td>Un asistente de tres pasos (Reglas, Fechas y destino, Resumen) con una decisión principal por pantalla, un indicador "Paso 1 de 3" y el botón de avance fijo al pie. El resumen calcula el pozo por turno (S/ 300 x 8 integrantes = S/ 2,400) para que la cabeza lo confirme antes de crear, y C4 entrega el código y el enlace listos para compartir.</td>
    </tr>
    <tr>
      <td><b>D. Unirse</b></td>
      <td>Antes de unirse, la persona ve las reglas y quién es la cabeza (D2) y puede responder "Ahora no". Unirse a una junta es un compromiso de pago, y la historia US13 pide revisarla antes de aceptar.</td>
    </tr>
    <tr>
      <td><b>E. Preparación</b></td>
      <td>Una lista de requisitos (Grupo completo, Turnos definidos) convierte "¿ya puedo iniciar?" en algo que se ve (E1 y E6). Quien no usará Pozzo se agrega desde una hoja modal con un interruptor "Aporta en efectivo" (E2). El método de turnos ofrece Sorteo y Orden acordado, y deja la Subasta visible pero marcada "Próximamente" (E3). E6 avisa que, al iniciar, el aporte, la periodicidad y el número de integrantes ya no se pueden cambiar. Hasta ese momento la cabeza puede ajustar las reglas (E7): si cambia el aporte o el número de integrantes, la pantalla muestra el pozo por turno recalculado antes de guardar. Con la junta iniciada, esos tres datos se ven con un candado (E8) y el participante consulta todas las reglas en solo lectura (E9).</td>
    </tr>
    <tr>
      <td><b>F. Aportar</b></td>
      <td>El estado del pozo es la pantalla central y es compartida: la cifra reunida del período, una barra de avance, los días que faltan para el corte y la lista de integrantes con su estado (F1). Desde su barra superior, el ícono de calendario abre el calendario de turnos (G2). Aportar toma tres pasos: cómo aportar (F2), subir la foto (F3) y revisar lo que Pozzo leyó (F4). El participante solo corrige y confirma, y F2 repite que Pozzo no recibe ni retiene el dinero.</td>
    </tr>
    <tr>
      <td><b>G. Seguimiento</b></td>
      <td>Lo que sirve sin conexión se muestra con un aviso ("Sin conexión. Mostrando lo último guardado hace 2 h"). El calendario de turnos marca cada turno como Cobró, Vigente, Tu turno o Pendiente (G2). El historial del participante resume su cumplimiento en un porcentaje y por junta, con un botón para compartirlo (G3), y al tocar una junta se abren sus aportes y comprobantes (G1).</td>
    </tr>
    <tr>
      <td><b>H. Gestión</b></td>
      <td>Cada caso se muestra con lo esperado frente a lo leído en el comprobante (H2). Toda acción que cambia el dinero o el historial pide una confirmación explícita: H4 pide marcar "Ya entregué" antes de abrir el período siguiente, y H5 explica la consecuencia (el integrante queda con una deuda con la cabeza) antes de registrar la cobertura.</td>
    </tr>
    <tr>
      <td><b>I. Perfil y avisos</b></td>
      <td>Los datos propios (número de Yape o Plin, correo de respaldo) y las preferencias están en una sola lista, y ahí mismo están los Términos y Condiciones y la Política de privacidad (I1). El tema visual tiene tres opciones: sistema, claro y oscuro (I2). Los recordatorios automáticos se encienden y apagan en Avisos con un interruptor que muestra sus tres momentos de envío: 3 días antes, 1 día antes y el día de corte (I3).</td>
    </tr>
    <tr>
      <td><b>J. Recordatorios</b></td>
      <td>Los recordatorios llegan primero fuera de la aplicación, como tres notificaciones que suben de tono (3 días antes, 1 día antes y el día de corte). Cada una repite el monto, la junta y la fecha límite, y dice que la envía Pozzo en nombre de la junta, para que no se lea como un reproche de la cabeza (J1). Si pasa el corte, el estado del pozo avisa el atraso, marca como Atrasado a quien no aportó, a la vista de todo el grupo, y dice que Pozzo seguirá recordando cada día (J2). Cuando el aporte se valida, Avisos confirma que los recordatorios se detuvieron (J3).</td>
    </tr>
    <tr>
      <td><b>K. Historial</b></td>
      <td>La cabeza responde dos preguntas desde el mismo destino. La pestaña Aportes es una matriz de integrantes por períodos: cada celda es un estado (Validado, Atraso, Revisión o Pendiente) con un ícono además del color, el período actual está resaltado y debajo hay tres cifras (Validados, Por revisar y Pendientes); al tocar un estado se ve el comprobante de ese aporte (K1). La pestaña Integrantes ordena a cada persona con sus aportes puntuales y un porcentaje, y marca con el chip Manual a quien no usa la aplicación y cuyos aportes registra la cabeza (K2). Un selector cambia de junta cuando la cabeza organiza más de una.</td>
    </tr>
  </tbody>
</table>

Las Figuras 92 a 105 muestran el detalle correspondiente.

![Wireframe de la lámina Compartido 1, acceso con el número de celular](images/chapter_3/wireframe_compartido_1_acceso.png){width=90%}

![Wireframe de la lámina Compartido 2, inicio vacío, estado del pozo, calendario y perfil](images/chapter_3/wireframe_compartido_2_inicio_pozo_perfil.png){width=90%}

![Wireframe de la lámina Cabeza 1, inicio y creación de la junta](images/chapter_3/wireframe_cabeza_1_inicio_crear.png){width=90%}

![Wireframe de la lámina Cabeza 2, preparar la junta (1 de 2)](images/chapter_3/wireframe_cabeza_2_preparar_1.png){width=90%}

![Wireframe de la lámina Cabeza 2, preparar la junta (2 de 2)](images/chapter_3/wireframe_cabeza_2_preparar_2.png){width=90%}

![Wireframe de la lámina Cabeza 3, reglas de la junta y avisos](images/chapter_3/wireframe_cabeza_3_reglas_avisos.png){width=90%}

![Wireframe de la lámina Cabeza 4, gestionar los aportes (1 de 2)](images/chapter_3/wireframe_cabeza_4_aportes_1.png){width=90%}

![Wireframe de la lámina Cabeza 4, gestionar los aportes (2 de 2)](images/chapter_3/wireframe_cabeza_4_aportes_2.png){width=90%}

![Wireframe de la lámina Cabeza 5, historial de la junta](images/chapter_3/wireframe_cabeza_5_historial.png){width=90%}

![Wireframe de la lámina Participante 1, inicio y unirse a una junta](images/chapter_3/wireframe_participante_1_unirse.png){width=90%}

![Wireframe de la lámina Participante 2, aportar con el comprobante (1 de 2)](images/chapter_3/wireframe_participante_2_aportar_1.png){width=90%}

![Wireframe de la lámina Participante 2, aportar con el comprobante (2 de 2)](images/chapter_3/wireframe_participante_2_aportar_2.png){width=90%}

![Wireframe de la lámina Participante 3, historial y reglas](images/chapter_3/wireframe_participante_3_historial_reglas.png){width=90%}

![Wireframe de la lámina Participante 4, recordatorios](images/chapter_3/wireframe_participante_4_recordatorios.png){width=90%}

#### 3.1.4.2. Mobile Applications Wireflow Diagrams

Un wireflow combina wireframes con un diagrama de flujo: miniaturas de baja fidelidad unidas por flechas que indican qué hace la persona para pasar de una pantalla a la siguiente [@laubheimer2016wireflows]. Sirve para comprobar que un recorrido funciona como secuencia, y no solo que cada pantalla se vea bien: una pantalla bien resuelta puede estar en un lugar equivocado del camino.

Los doce wireflows siguen las tareas de la sección 3.1.2.1 y, como las láminas de wireframes, se separan por segmento: uno de Compartido, siete de Cabeza de junta y cuatro de Participante. Cada wireflow tiene una sola persona, de modo que Anna Weber y Sofia Gonzales pueden leer solo el recorrido que les toca. Usan las mismas miniaturas del wireframe, al 50 %. Cada uno lleva, en su encabezado, la persona, el objetivo y las historias que cubre. Debajo de cada miniatura van el código, el nombre y las historias de la pantalla. Cada flecha lleva una etiqueta con la acción que la dispara, por ejemplo "Toca Registrar mi aporte de S/ 300". La línea continua es el camino principal y la línea punteada es una alternativa, un error o un retorno; cuando una pantalla tiene una decisión, salen dos flechas con etiquetas distintas (ver Tabla 126).

<table>
  <caption>Wireflows de la aplicación móvil por segmento</caption>
  <colgroup><col width="5%"><col width="12%"><col width="22%"><col width="15%"><col width="27%"><col width="19%"></colgroup>
  <thead>
    <tr>
      <th align="center">N.º</th>
      <th>Segmento</th>
      <th>Wireflow</th>
      <th>Persona</th>
      <th>Recorrido</th>
      <th>User Stories</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td align="center"><b>1</b></td>
      <td>Compartido</td>
      <td>Registrarse e ingresar</td>
      <td>Anna Weber, usuaria nueva</td>
      <td>A1, A2, A3, A4, B3</td>
      <td>US01, US02, US03</td>
    </tr>
    <tr>
      <td align="center"><b>2</b></td>
      <td>Cabeza de junta</td>
      <td>Crear una junta e invitar</td>
      <td>Anna Weber, cabeza de junta</td>
      <td>B3, C1, C2, C3, C4, B1</td>
      <td>US07, US08, US11</td>
    </tr>
    <tr>
      <td align="center"><b>3</b></td>
      <td>Cabeza de junta</td>
      <td>Preparar e iniciar la junta</td>
      <td>Anna Weber, cabeza de junta</td>
      <td>B1, E1, E2, E3, E4 o E5, E6</td>
      <td>US10, US14 a US19</td>
    </tr>
    <tr>
      <td align="center"><b>4</b></td>
      <td>Cabeza de junta</td>
      <td>Consultar y ajustar las reglas</td>
      <td>Anna Weber, cabeza de junta</td>
      <td>Caso 1: E1, E7, E1. Caso 2: F1, E8.</td>
      <td>US09</td>
    </tr>
    <tr>
      <td align="center"><b>5</b></td>
      <td>Cabeza de junta</td>
      <td>Revisar un aporte con inconsistencia</td>
      <td>Anna Weber, cabeza de junta</td>
      <td>B1, H1, H2, F1</td>
      <td>US26</td>
    </tr>
    <tr>
      <td align="center"><b>6</b></td>
      <td>Cabeza de junta</td>
      <td>Aporte en efectivo y cobertura</td>
      <td>Anna Weber, cabeza de junta</td>
      <td>Caso 1: F1, H3, F1. Caso 2: F1, H5, F1.</td>
      <td>US27, US37</td>
    </tr>
    <tr>
      <td align="center"><b>7</b></td>
      <td>Cabeza de junta</td>
      <td>Cierre de período y de ciclo</td>
      <td>Anna Weber, cabeza de junta</td>
      <td>F1, H4, F1, H6</td>
      <td>US36, US39</td>
    </tr>
    <tr>
      <td align="center"><b>8</b></td>
      <td>Cabeza de junta</td>
      <td>Historial y avisos de la cabeza</td>
      <td>Anna Weber, cabeza de junta</td>
      <td>Caso 1: B1, K1, K2. Caso 2: B1, I3.</td>
      <td>US32, US34, US35, US42</td>
    </tr>
    <tr>
      <td align="center"><b>9</b></td>
      <td>Participante</td>
      <td>Unirse con un código</td>
      <td>Sofia Gonzales, participante</td>
      <td>B3, D1, D2, D3, B2</td>
      <td>US12, US13</td>
    </tr>
    <tr>
      <td align="center"><b>10</b></td>
      <td>Participante</td>
      <td>Aportar con comprobante</td>
      <td>Sofia Gonzales, participante</td>
      <td>B2, F1, F2, F3, F4, F5 o F6</td>
      <td>US08, US23 a US26, US29</td>
    </tr>
    <tr>
      <td align="center"><b>11</b></td>
      <td>Participante</td>
      <td>Seguimiento del participante</td>
      <td>Sofia Gonzales, participante</td>
      <td>Caso 1: F1, G2. Caso 2: F1, E9. Caso 3: B2, G3, G1.</td>
      <td>US09, US22, US28, US31, US40, US41</td>
    </tr>
    <tr>
      <td align="center"><b>12</b></td>
      <td>Participante</td>
      <td>Recordatorios escalonados del aporte</td>
      <td>Sofia Gonzales, participante</td>
      <td>J1, J2, F2, J3</td>
      <td>US33, US35</td>
    </tr>
  </tbody>
</table>

Lo más útil de los wireflows son las ramas, porque son los momentos en que un recorrido puede romperse. Estas son las que se dibujaron: (ver Tabla 127)

<table>
  <caption>Ramas y desvíos de cada wireflow</caption>
  <colgroup><col width="25%"><col width="75%"></colgroup>
  <thead>
    <tr>
      <th>Wireflow</th>
      <th>Ramas y desvíos</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>1. Registrarse</b></td>
      <td>En A3, un código incorrecto deja a la persona en la misma pantalla con un aviso de error; "Reenviar código" envía un SMS nuevo y también la deja en A3.</td>
    </tr>
    <tr>
      <td><b>2. Crear una junta</b></td>
      <td>Desde el resumen (C3), "Atrás" permite ajustar las reglas. En C4, compartir la invitación abre la aplicación elegida y vuelve a C4. Se llega desde B3 (sin juntas) o desde B1 con el botón Crear junta.</td>
    </tr>
    <tr>
      <td><b>3. Preparar la junta</b></td>
      <td>"Agregar sin la aplicación" abre E2 y, al confirmar, el integrante queda en la lista y se vuelve a E1. Con el grupo completo, "Asignar turnos" lleva al método (E3). Los turnos se asignan por sorteo (E4) o por orden acordado (E5), y los dos terminan en E6; la subasta llega después.</td>
    </tr>
    <tr>
      <td><b>4. Reglas de la junta</b></td>
      <td>Son dos casos independientes. En el primero, la cabeza abre la pestaña Reglas de E1, cambia el aporte a S/ 350 y guarda: Pozzo recalcula el pozo por turno (S/ 2,800) y vuelve a E1; también se llega a E7 desde E6 con "Revisar las reglas", y "Descartar cambios" deja las reglas como estaban (no se dibujó). En el segundo, con la junta iniciada, el menú de tres puntos del estado del pozo abre E8, que muestra el aporte, la periodicidad y el número de integrantes con candado. La consulta del participante, en solo lectura, está en el wireflow 11.</td>
    </tr>
    <tr>
      <td><b>5. Revisar un aporte</b></td>
      <td>En H2, "Rechazar y pedir corrección" devuelve el aporte a la lista (H1) y el participante corrige; aprobar lo valida y actualiza el pozo (F1).</td>
    </tr>
    <tr>
      <td><b>6. Efectivo y cobertura</b></td>
      <td>Son dos casos independientes dibujados en el mismo wireflow. En el primero, la cabeza registra el efectivo que recibió y el aporte queda marcado como registrado por ella y sin comprobante. En el segundo, al llegar el corte, la cabeza cubre el aporte que falta: el pozo se completa, el integrante queda con una deuda de S/ 300 con ella y el aporte figura como cubierto en su historial. La miniatura final de F1 repite la inicial; el cambio se describe en el pie y no se redibujó.</td>
    </tr>
    <tr>
      <td><b>7. Cierre</b></td>
      <td>Con todos los aportes validados, "Entregar el pozo" abre el período siguiente (F1 con el pozo en S/ 0). Si era el último período, la confirmación cierra el ciclo (H6).</td>
    </tr>
    <tr>
      <td><b>8. Historial y avisos de la cabeza</b></td>
      <td>Son dos casos independientes. En el primero, la cabeza toca Historial en la barra inferior y ve la matriz de aportes por período (K1); la pestaña Integrantes (K2) muestra el cumplimiento de cada persona. En el segundo, toca Avisos en la barra inferior (I3), ve a quiénes recordó Pozzo y puede activar o desactivar los recordatorios de la junta.</td>
    </tr>
    <tr>
      <td><b>9. Unirse</b></td>
      <td>En D2, "Ahora no" devuelve a Mis juntas (B3). También se llega a D1 desde A1, con "Tengo un código de invitación". Al terminar, la persona ya ve la junta en su inicio de participante (B2).</td>
    </tr>
    <tr>
      <td><b>10. Aportar</b></td>
      <td>En B2, "Aportar ahora" es un atajo directo a F2. En F4, si el monto o el destinatario no coinciden con lo esperado, "Confirmar aporte" lleva a F6 (en revisión) en lugar de F5 (validado).</td>
    </tr>
    <tr>
      <td><b>11. Seguimiento del participante</b></td>
      <td>Son tres casos independientes. En el primero, Sofia consulta cuándo le toca cobrar: toca el ícono de calendario de la barra superior del estado del pozo y abre el calendario de turnos (G2). En el segundo, el menú de tres puntos del mismo estado del pozo abre las reglas en solo lectura (E9), sin botones de edición. En el tercero, toca Historial en la barra inferior (G3) y, al tocar una junta, ve sus aportes y comprobantes (G1), que sin conexión muestran lo último guardado con un aviso.</td>
    </tr>
    <tr>
      <td><b>12. Recordatorios</b></td>
      <td>Los recordatorios llegan como notificaciones (J1) y tocar una abre el aporte directamente (F2). Si Sofia deja pasar el corte, el estado del pozo marca el atraso (J2) y los recordatorios siguen cada día. Al subir el comprobante y validarse (F3 a F5), Avisos informa que se detuvieron (J3). La rama punteada es la alternativa: si la cabeza registra el aporte en efectivo (H3), Pozzo también los detiene. La configuración de los recordatorios por la cabeza está en el wireflow 8.</td>
    </tr>
  </tbody>
</table>

Las Figuras 106 a 117 muestran el detalle correspondiente.

![Wireflow 1 (Compartido), registrarse e ingresar](images/chapter_3/wireflow_01_registro.png){width=90%}

![Wireflow 2 (Cabeza de junta), crear una junta e invitar](images/chapter_3/wireflow_02_crear_junta.png){width=90%}

![Wireflow 3 (Cabeza de junta), preparar e iniciar la junta](images/chapter_3/wireflow_03_preparar_junta.png){width=90%}

![Wireflow 4 (Cabeza de junta), consultar y ajustar las reglas de la junta](images/chapter_3/wireflow_04_reglas_junta.png){width=90%}

![Wireflow 5 (Cabeza de junta), revisar un aporte con inconsistencia](images/chapter_3/wireflow_05_revisar_aportes.png){width=90%}

![Wireflow 6 (Cabeza de junta), aporte en efectivo y cobertura](images/chapter_3/wireflow_06_efectivo_cobertura.png){width=90%}

![Wireflow 7 (Cabeza de junta), cierre de período y de ciclo](images/chapter_3/wireflow_07_cierre.png){width=90%}

![Wireflow 8 (Cabeza de junta), historial y avisos de la cabeza](images/chapter_3/wireflow_08_historial_cabeza.png){width=90%}

![Wireflow 9 (Participante), unirse con un código](images/chapter_3/wireflow_09_unirse.png){width=90%}

![Wireflow 10 (Participante), aportar con comprobante](images/chapter_3/wireflow_10_aportar.png){width=90%}

![Wireflow 11 (Participante), seguimiento del participante](images/chapter_3/wireflow_11_seguimiento.png){width=90%}

![Wireflow 12 (Participante), recordatorios escalonados del aporte](images/chapter_3/wireflow_12_recordatorios.png){width=90%}

#### 3.1.4.3. Mobile Applications Mock-ups

Los mock-ups son las mismas 46 pantallas en alta fidelidad, en las mismas 14 láminas separadas por segmento que los wireframes: los roles de color de la guía en modo claro, la tipografía Plus Jakarta Sans, los íconos Material y los datos de ejemplo. En los mock-ups sí aparecen todos los textos. Son también la fuente de las pantallas que se ven dentro de los teléfonos del landing (sección 3.1.3.2), por eso lo que se promete en el sitio es exactamente lo que se diseñó aquí.

Para que cada pantalla continúe la historia de la anterior, todo el diseño usa un único conjunto de datos de ejemplo. Un mismo número, una misma persona o un mismo estado aparecen igual en cualquier pantalla donde se muestren (ver Tabla 128).

<table>
  <caption>Valores de diseño aplicados en los mock-ups</caption>
  <colgroup><col width="26%"><col width="74%"></colgroup>
  <thead>
    <tr>
      <th>Dato</th>
      <th>Valor en el diseño</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Junta</b></td>
      <td>Junta del barrio, de 8 integrantes y 8 períodos. Anna Weber es la cabeza de junta.</td>
    </tr>
    <tr>
      <td><b>Reglas</b></td>
      <td>Aporte de S/ 300 por integrante y por período, mensual, con corte el día 5 de cada mes y primer aporte el 5 de noviembre de 2026. El pozo por turno es de S/ 2,400.</td>
    </tr>
    <tr>
      <td><b>Destino de los aportes</b></td>
      <td>Yape o Plin de Anna Weber, número 999 000 123.</td>
    </tr>
    <tr>
      <td><b>Código de invitación</b></td>
      <td>JB-7K4M.</td>
    </tr>
    <tr>
      <td><b>Orden de cobro</b></td>
      <td>Por sorteo, realizado el 31 de octubre de 2026: Rosa Medina (5 nov 2026), Jorge Salas (5 dic 2026), Carla Vega (5 ene 2027), Sofia Gonzales (5 feb 2027), Luis Paredes (5 mar 2027), Marta Quispe (5 abr 2027), Diego Ramos (5 may 2027) y Anna Weber (5 jun 2027).</td>
    </tr>
    <tr>
      <td><b>Momento de la historia</b></td>
      <td>Período 3 de 8, en el que cobra Carla Vega: S/ 1,200 reunidos de S/ 2,400, cuatro aportes validados (Anna, Luis, Carla y Jorge), dos en revisión (Marta y Diego) y dos pendientes (Sofia y Rosa), con el corte el 5 de enero de 2027.</td>
    </tr>
    <tr>
      <td><b>Comprobante de ejemplo</b></td>
      <td>S/ 300.00 enviado a Anna Weber el 31 de diciembre de 2026, con número de operación 04581273.</td>
    </tr>
    <tr>
      <td><b>Caso con inconsistencia</b></td>
      <td>Un comprobante de S/ 280 cuando se esperaban S/ 300 (H2 en la vista de la cabeza y F6 en la del participante).</td>
    </tr>
    <tr>
      <td><b>Caso con atraso</b></td>
      <td>J2 y J3 avanzan un día respecto del momento de la historia: es el 6 de enero de 2027, con el corte vencido, y Sofia y Rosa figuran como Atrasado. Sofia aporta ese día y su aporte queda validado a las 10:32 a. m. (J3).</td>
    </tr>
    <tr>
      <td><b>Historial</b></td>
      <td>K1 muestra la matriz de los períodos de la Junta del barrio con el período 3 resaltado; Marta Quispe aportó con atraso en el período 2. K2 y G3 usan las mismas cifras de Sofia Gonzales: 14 de 15 aportes puntuales (93 %) en todas sus juntas, que son la Junta del barrio, Amigas de la universidad y Ahorro 2025.</td>
    </tr>
    <tr>
      <td><b>Ajuste de reglas</b></td>
      <td>E7 muestra a la cabeza cambiando el aporte de S/ 300 a S/ 350 antes de iniciar la junta: es un estado de edición sin guardar, y por eso el pozo recalculado (S/ 2,800) no se repite en las demás pantallas, que muestran la junta con las reglas ya fijadas en S/ 300 (E8).</td>
    </tr>
  </tbody>
</table>

Los estados de un aporte y de un turno se repiten en varias pantallas, así que se resolvieron una sola vez como chips de la guía y se reutilizan. Cada chip combina texto, ícono y color, de modo que el estado se entiende sin depender solo del color (ver Tabla 129).

<table>
  <caption>Estados de la interfaz y su representación</caption>
  <colgroup><col width="18%"><col width="30%"><col width="52%"></colgroup>
  <thead>
    <tr>
      <th>Estado</th>
      <th>Dónde aparece</th>
      <th>Cómo se ve</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Validado</b></td>
      <td>F1, F5, G1, K1</td>
      <td>Chip verde con una marca de verificación.</td>
    </tr>
    <tr>
      <td><b>En revisión</b></td>
      <td>F1 y K1 (F6 es la pantalla que lo explica)</td>
      <td>Chip ámbar con un reloj de arena.</td>
    </tr>
    <tr>
      <td><b>Pendiente</b></td>
      <td>F1, G1, G2, K1</td>
      <td>Chip neutro con un reloj en las filas de los demás integrantes y ámbar en el aporte propio que vence (G1).</td>
    </tr>
    <tr>
      <td><b>Atrasado</b></td>
      <td>J2</td>
      <td>Chip rojo con un reloj en la fila de quien no aportó, y el aviso superior y "Corte vencido hace 1 día" lo repiten con texto.</td>
    </tr>
    <tr>
      <td><b>Aportó con atraso</b></td>
      <td>K1</td>
      <td>Círculo con una marca y solo el contorno, en el período en que el aporte llegó después del corte. En la leyenda de la matriz, que es angosta, los estados se abrevian (Atraso, Revisión).</td>
    </tr>
    <tr>
      <td><b>Monto distinto</b></td>
      <td>F6</td>
      <td>Chip con un triángulo de alerta, junto a los montos esperado y leído.</td>
    </tr>
    <tr>
      <td><b>Cobró, Vigente, Tu turno</b></td>
      <td>G2</td>
      <td>Cobró en verde; el turno vigente con la fila resaltada en terracota claro; Tu turno en dorado.</td>
    </tr>
  </tbody>
</table>

Las Figuras 118 a 131 muestran el detalle correspondiente.

![Mock-up de la lámina Compartido 1, acceso con el número de celular](images/chapter_3/mockup_compartido_1_acceso.png){width=90%}

![Mock-up de la lámina Compartido 2, inicio vacío, estado del pozo, calendario y perfil](images/chapter_3/mockup_compartido_2_inicio_pozo_perfil.png){width=90%}

![Mock-up de la lámina Cabeza 1, inicio y creación de la junta](images/chapter_3/mockup_cabeza_1_inicio_crear.png){width=90%}

![Mock-up de la lámina Cabeza 2, preparar la junta (1 de 2)](images/chapter_3/mockup_cabeza_2_preparar_1.png){width=90%}

![Mock-up de la lámina Cabeza 2, preparar la junta (2 de 2)](images/chapter_3/mockup_cabeza_2_preparar_2.png){width=90%}

![Mock-up de la lámina Cabeza 3, reglas de la junta y avisos](images/chapter_3/mockup_cabeza_3_reglas_avisos.png){width=90%}

![Mock-up de la lámina Cabeza 4, gestionar los aportes (1 de 2)](images/chapter_3/mockup_cabeza_4_aportes_1.png){width=90%}

![Mock-up de la lámina Cabeza 4, gestionar los aportes (2 de 2)](images/chapter_3/mockup_cabeza_4_aportes_2.png){width=90%}

![Mock-up de la lámina Cabeza 5, historial de la junta](images/chapter_3/mockup_cabeza_5_historial.png){width=90%}

![Mock-up de la lámina Participante 1, inicio y unirse a una junta](images/chapter_3/mockup_participante_1_unirse.png){width=90%}

![Mock-up de la lámina Participante 2, aportar con el comprobante (1 de 2)](images/chapter_3/mockup_participante_2_aportar_1.png){width=90%}

![Mock-up de la lámina Participante 2, aportar con el comprobante (2 de 2)](images/chapter_3/mockup_participante_2_aportar_2.png){width=90%}

![Mock-up de la lámina Participante 3, historial y reglas](images/chapter_3/mockup_participante_3_historial_reglas.png){width=90%}

![Mock-up de la lámina Participante 4, recordatorios](images/chapter_3/mockup_participante_4_recordatorios.png){width=90%}

##### Modo oscuro

La historia US06 pide poder elegir el tema visual, y la pantalla I2 ofrece tres opciones: usar el del sistema, claro u oscuro. Para comprobar que los roles de color de la guía se invierten sin perder información, se dibujaron en modo oscuro cuatro pantallas con muchos estados a la vez: Mis juntas de la cabeza (B1), el estado del pozo (F1), el aporte validado (F5) y el historial de aportes de la cabeza (K1). Son los mismos componentes y la misma estructura; solo cambian los roles (ver Figura 132).

![Mock-up en modo oscuro de las pantallas B1, F1, F5 y K1](images/chapter_3/mockup_modo_oscuro.png){width=90%}

##### Cobertura de las User Stories

Las 46 pantallas cubren 38 de las 42 historias de la aplicación (US01 a US42; las cuatro restantes, US43 a US46, son del landing y se cubren en la sección 3.1.3.2). Se contó una historia como cubierta cuando alguna pantalla resuelve lo que su objetivo pide; los caminos de error se ven en las ramas de los wireflows y en los user flows de la sección 3.1.4.4. La subasta (US19) aparece solo como una opción marcada "Próximamente" en E3. No tienen pantalla en esta entrega cuatro historias: (ver Tabla 130)

<table>
  <caption>Cobertura de las user stories en los mock-ups</caption>
  <colgroup><col width="12%"><col width="88%"></colgroup>
  <thead>
    <tr>
      <th>Historia</th>
      <th>Qué pide y por qué no se dibujó</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>US04</b></td>
      <td>Mantener la sesión en el dispositivo. No tiene pantalla propia: es un comportamiento de la aplicación.</td>
    </tr>
    <tr>
      <td><b>US20, US21</b></td>
      <td>Ofertar en la subasta y cerrarla. La subasta se difiere a una versión posterior, y E3 la muestra como "Próximamente".</td>
    </tr>
    <tr>
      <td><b>US38</b></td>
      <td>Registrar una deserción y su reemplazo. Sin pantalla.</td>
    </tr>
  </tbody>
</table>

US09 y US33 sí tienen pantalla. US09 se cubre con E7 (ajuste antes de iniciar, con el pozo por turno recalculado), E8 (el aporte, la periodicidad y el número de integrantes quedan fijos con la junta iniciada) y E9 (consulta del participante en solo lectura). US33 se cubre con J1 (recordatorios 3 días antes, 1 día antes y el día de corte), J2 (atraso visible para la cabeza y el grupo, con recordatorio diario) y J3 (los recordatorios se detienen al aportar). La configuración de los recordatorios por la cabeza (US34) está en I3.

US32 y US42 se contaron como cubiertas con el historial de la cabeza, pero con un alcance que conviene decir con claridad. US32 pide reconstruir un período cerrado: K1 muestra el estado final del aporte de cada integrante en cada período y G2 dice quién cobró en cada turno, pero no hay una vista de detalle de un período con el monto entregado y la fecha de entrega. US42 pide ver el historial de quien se une: K2 muestra a la cabeza el cumplimiento de cada integrante, pero como la unión es con un código y no hay un paso de aceptación (D1 a D3), la cabeza lo consulta después de que la persona entró y no antes, y el mensaje de que un participante aún no tiene registros no se dibujó.

#### 3.1.4.4. Mobile Applications User Flow Diagrams

Un user flow es un diagrama de flujo de lo que hace la persona y lo que hace el sistema para lograr una tarea, con las decisiones y los errores que hay en el camino. Se diferencia del wireflow en que no dibuja pantallas sino pasos: muestra por qué un recorrido se desvía y adónde vuelve, y deja ver cuáles son los puntos donde el diseño debe tener un mensaje de error o una salida. Cada paso lleva una etiqueta roja con el código de la pantalla en la que ocurre.

Los diagramas comparten una misma notación: una píldora para el inicio y el final, un rectángulo redondeado para un paso, un rombo para una decisión, una etiqueta "Pozzo" para lo que hace el sistema sin una pantalla propia y una píldora punteada para "vuelve a un paso". El camino feliz va con flechas continuas y pasos verdes; los caminos alternos, con flechas punteadas y pasos ámbar; y los errores, con flechas punteadas y pasos rojos. Cada diagrama trae su leyenda. El camino feliz se distingue de los demás también por el trazo, y los alternos de los errores por el texto del paso, de modo que no dependen solo del color (ver Tabla 131).

<table>
  <caption>User flows y sus caminos alternativos</caption>
  <colgroup><col width="5%"><col width="20%"><col width="31%"><col width="44%"></colgroup>
  <thead>
    <tr>
      <th align="center">N.º</th>
      <th>User flow</th>
      <th>Decisiones</th>
      <th>Caminos que no son el feliz</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td align="center"><b>1</b></td>
      <td>Ingreso con celular (US01, US02, US03)</td>
      <td>¿Número válido? ¿Código correcto? ¿El código venció? ¿Fue el tercer intento? ¿Es su primer ingreso? ¿Acepta los términos?</td>
      <td>Número inválido (mensaje y vuelve a A2). Sin conexión (aviso y botón de reintento). Código incorrecto (vuelve a A3; al tercer intento, esperar 30 s o reenviar). Código vencido (pedir uno nuevo). No acepta los términos (no puede continuar).</td>
    </tr>
    <tr>
      <td align="center"><b>2</b></td>
      <td>Crear una junta e invitar (US07, US08, US11, US12, US13)</td>
      <td>¿Integrantes entre 2 y 50? ¿Número de destino válido? ¿Código válido? ¿Queda cupo en la junta?</td>
      <td>Aviso de integrantes (vuelve a C1). Aviso de destino no válido (vuelve a C2). Código no válido (vuelve a D1). Junta llena (la persona no puede unirse).</td>
    </tr>
    <tr>
      <td align="center"><b>3</b></td>
      <td>Aportar con comprobante (US23, US24, US25, US26)</td>
      <td>¿Hay conexión? ¿Se leyó bien? ¿Coincide con lo esperado? ¿La cabeza lo aprueba?</td>
      <td>Sin conexión (se guarda el borrador y se envía luego). Lectura ilegible (tomar otra foto). Aporte en revisión (F6). Rechazo de la cabeza (el participante corrige en F4).</td>
    </tr>
    <tr>
      <td align="center"><b>4</b></td>
      <td>Ciclo completo de la junta (US07, US10, US14 a US19, US27, US36, US37, US39)</td>
      <td>¿Todos los aportes están validados? ¿Sigue faltando algún aporte? ¿Fue el último período?</td>
      <td>Aportes pendientes (Pozzo recuerda a quien falta, se espera la fecha de corte y la cabeza cubre el aporte o registra el efectivo).</td>
    </tr>
  </tbody>
</table>

Dos decisiones de forma merecen una explicación. El flujo 3 es el único con carriles: se dibujó con tres (Participante, Pozzo y Cabeza de junta) porque la pregunta que responde es quién hace qué. El participante sube el comprobante, Pozzo lo lee y lo valida, y la cabeza solo interviene cuando algo no coincide; ese reparto es la propuesta de valor de Pozzo y se ve de un vistazo en los carriles. El flujo 4 encierra en un recuadro "Se repite en cada período" los pasos que se repiten, para no dibujar ocho veces el mismo ciclo (ver Figuras 133 a 136).

![User flow 1, ingreso con celular](images/chapter_3/userflow_01_ingreso.png){width=90%}

![User flow 2, crear una junta e invitar](images/chapter_3/userflow_02_crear_junta.png){width=90%}

![User flow 3, aportar con comprobante](images/chapter_3/userflow_03_aportar.png){width=90%}

![User flow 4, ciclo completo de la junta](images/chapter_3/userflow_04_ciclo.png){width=90%}

#### 3.1.4.5. Mobile Applications Prototyping

El prototipo permite recorrer la aplicación con el dedo antes de escribir código. Se armó en Figma con las pantallas del mock-up en modo claro y reproduce los tres caminos que sostienen la promesa de Pozzo: entrar con el celular (P1), crear una junta e invitar (P2) y aportar con comprobante (P3). Los dos primeros son los que hace Anna para empezar y el tercero es el que hace Sofia cada mes. El resto de las pantallas existe como mock-up, pero todavía no está enlazado (ver Tabla 132).


<table>
  <caption>Caminos navegables del prototipo</caption>
  <colgroup><col width="11%"><col width="22%"><col width="37%"><col width="30%"></colgroup>
  <thead>
    <tr>
      <th align="center">Camino</th>
      <th>Desde</th>
      <th>Botón que se toca</th>
      <th>Hacia</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td align="center"><b>P1</b></td>
      <td>A1 Bienvenida</td>
      <td>Continuar con mi celular</td>
      <td>A2 Ingresar celular</td>
    </tr>
    <tr>
      <td align="center"><b>P1</b></td>
      <td>A2 Ingresar celular</td>
      <td>Enviar código</td>
      <td>A3 Verificar código</td>
    </tr>
    <tr>
      <td align="center"><b>P1</b></td>
      <td>A3 Verificar código</td>
      <td>Verificar</td>
      <td>A4 Completar registro</td>
    </tr>
    <tr>
      <td align="center"><b>P1</b></td>
      <td>A4 Completar registro</td>
      <td>Empezar</td>
      <td>B3 Mis juntas (sin juntas)</td>
    </tr>
    <tr>
      <td align="center"><b>P2</b></td>
      <td>B3 Mis juntas (sin juntas)</td>
      <td>Crear una junta</td>
      <td>C1 Reglas de la junta</td>
    </tr>
    <tr>
      <td align="center"><b>P2</b></td>
      <td>C1 Reglas de la junta</td>
      <td>Continuar</td>
      <td>C2 Fechas y destino</td>
    </tr>
    <tr>
      <td align="center"><b>P2</b></td>
      <td>C2 Fechas y destino</td>
      <td>Continuar</td>
      <td>C3 Resumen</td>
    </tr>
    <tr>
      <td align="center"><b>P2</b></td>
      <td>C3 Resumen</td>
      <td>Crear junta</td>
      <td>C4 Invitar integrantes</td>
    </tr>
    <tr>
      <td align="center"><b>P2</b></td>
      <td>C4 Invitar integrantes</td>
      <td>Ir a mi junta</td>
      <td>B1 Mis juntas (cabeza)</td>
    </tr>
    <tr>
      <td align="center"><b>P3</b></td>
      <td>B2 Mis juntas (participante)</td>
      <td>Aportar ahora</td>
      <td>F1 Estado del pozo</td>
    </tr>
    <tr>
      <td align="center"><b>P3</b></td>
      <td>F1 Estado del pozo</td>
      <td>Registrar mi aporte de S/ 300</td>
      <td>F2 Cómo aportar</td>
    </tr>
    <tr>
      <td align="center"><b>P3</b></td>
      <td>F2 Cómo aportar</td>
      <td>Ya transferí, subir comprobante</td>
      <td>F3 Subir comprobante</td>
    </tr>
    <tr>
      <td align="center"><b>P3</b></td>
      <td>F3 Subir comprobante</td>
      <td>Tomar foto</td>
      <td>F4 Revisar datos leídos</td>
    </tr>
    <tr>
      <td align="center"><b>P3</b></td>
      <td>F4 Revisar datos leídos</td>
      <td>Confirmar aporte</td>
      <td>F5 Aporte validado</td>
    </tr>
  </tbody>
</table>

El mapa de flujos resume los tres caminos: las pantallas con interacción tienen borde rojo, el punto de inicio borde verde, la pantalla final borde punteado, y cada flecha lleva el nombre del botón que se toca (ver Figura 137).

![Mapa de flujos del prototipo, caminos P1, P2 y P3](images/chapter_3/prototype_mapa_de_flujos.png){width=95%}

##### Alcance y límites del prototipo

El prototipo recorre solo el camino feliz: los campos de texto, el teclado numérico y los demás elementos no responden, y un botón avanza aunque el campo esté vacío. Los errores, las alternativas y las decisiones están en los wireflows (3.1.4.2) y en los user flows (3.1.4.4). Hay una diferencia entre el prototipo y el wireflow 10 (Participante): en el prototipo, "Aportar ahora" de B2 lleva a F1 (el estado del pozo), mientras que en el wireflow ese botón es un atajo directo a F2 y a F1 se llega tocando la tarjeta de la junta.

Enlace al [Figma](https://www.figma.com/design/8KoGtoEQuWzHgtOih3hTgF/Pozzo---UI-UX-Design--TB1-?node-id=2-5&t=dYJd3mx1D7cuoisU-1)

[Video del prototipo](https://upcedupe-my.sharepoint.com/:v:/g/personal/u202419592_upc_edu_pe/IQCKQ93AN4UkSb_cQemCCdnAAZD40-WVLJ2bjxIGyebPg5s?e=tlbtXK&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D)


