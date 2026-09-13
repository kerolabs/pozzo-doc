# Capítulo II: Requirements Development and Software Solution Design

## 2.1. Competidores

Para el análisis competitivo de Pozzo se identificaron tres alternativas del mercado vinculadas a la gestión de ahorros rotativos (tandas/ROSCAs), recaudación grupal y división de gastos compartidos:

1. **Tandapp (o MiTandita)** [@tandapp2026]: Aplicación móvil para organizar tandas tradicionales, asignando turnos y registrando abonos de forma manual.
2. **Moneypool** [@moneypool2026]: Plataforma fintech mexicana para crear fondos comunes ("pools") con saldo digital en app, cobro mediante tarjeta y custodia de dinero.
3. **Splitwise** [@splitwise2026]: Aplicación global orientada al registro, cálculo y división equitativa de gastos compartidos entre amigos, compañeros de vivienda o viajes.

Pozzo se diferencia por resolver la realidad operativa de las juntas peruanas: opera sobre transferencias directas por Yape y Plin sin custodiar el dinero (evitando comisiones y trámites financieros), automatiza el registro de aportes leyendo los vouchers mediante OCR, despersonaliza la cobranza con recordatorios automáticos y permite gestionar turnos (por sorteo, orden acordado o subasta) junto a un historial de cumplimiento para futuros ciclos.

### 2.1.1. Análisis Competitivo

#### ¿Por qué llevar a cabo este análisis?

El propósito de este análisis es examinar las fortalezas y vacíos de las aplicaciones existentes para definir una propuesta de valor realista y diferenciada para Pozzo. En el Perú, las juntas se pagan por canales digitales (Yape/Plin), pero su administración sigue atrapada en cuadernos y grupos de WhatsApp saturados de capturas. Identificar las carencias de los competidores permite enfocar el desarrollo en solucionar el desorden administrativo, los errores de conteo y las discusiones sobre aportes sin alterar la dinámica de confianza del grupo.

#### Competitive Analysis Landscape

<table>
  <colgroup><col style="width:16%"><col style="width:21%"><col style="width:21%"><col style="width:21%"><col style="width:21%"></colgroup>
  <thead><tr><th>Característica</th><th>Pozzo</th><th>Tandapp / MiTandita</th><th>Moneypool</th><th>Splitwise</th></tr></thead>
  <tbody>
    <tr><td><strong>Perfil / Overview</strong></td><td>Plataforma móvil y web para administrar juntas de ahorro en tiempo real, validando vouchers sin custodiar dinero.</td><td>App móvil para registrar integrantes, armar tandas, asignar turnos y marcar pagos manualmente.</td><td>Plataforma fintech para recaudar fondos grupales mediante saldo digital y links de pago.</td><td>Aplicación para registrar, calcular y saldar gastos compartidos entre grupos de personas.</td></tr>
    <tr><td><strong>Ventaja competitiva</strong></td><td>Validación OCR de vouchers de Yape/Plin y modelo 100 % no custodial adaptado a las juntas en Perú.</td><td>Interfaz enfocada únicamente en la dinámica de tandas sin requerir cuentas bancarias.</td><td>Cobro integrado con tarjeta de crédito/débito y dispersión a cuentas bancarias vía SPEI.</td><td>Marca global consolidada con algoritmo para optimizar y simplificar deudas cruzadas.</td></tr>
    <tr><td><strong>Valor ofrecido</strong></td><td>Elimina el conteo manual, evita reclamos ("yo sí pagué"), despersonaliza la cobranza y transparenta el estado del pozo.</td><td>Permite calendarizar montos, fechas y turnos para consultar el avance de la tanda desde el celular.</td><td>Centraliza dinero en un fondo digital compartido para eventos o compras conjuntas antes de retirarlo.</td><td>Otorga claridad continua sobre quién le debe a quién en gastos diarios compartidos y viajes.</td></tr>
    <tr><td><strong>Mercado objetivo</strong></td><td>Organizadores y participantes de juntas de ahorro en zonas urbanas del Perú (NSE B, C y D).</td><td>Organizadores y miembros de tandas comunitarias y familiares en México y Latinoamérica.</td><td>Grupos de amigos, familias y organizadores de eventos sociales en México.</td><td>Compañeros de departamento, grupos de viaje, parejas y amigos a nivel internacional.</td></tr>
    <tr><td><strong>Estrategias de marketing</strong></td><td>Invitación directa vía enlace de WhatsApp y recomendación orgánica dentro de redes de confianza.</td><td>Posicionamiento en tiendas de aplicaciones (ASO) mediante palabras clave ("tanda", "ahorro grupal").</td><td>Marketing digital B2C, campañas en redes sociales y alianzas en el ecosistema fintech mexicano.</td><td>Crecimiento guiado por el producto (PLG) y optimización en Google Play y App Store.</td></tr>
    <tr><td><strong>Productos y servicios</strong></td><td>Panel de organizador, app de participante, validador OCR de vouchers, gestión de turnos e historial de cumplimiento.</td><td>Creación de tandas, lista de participantes, asignador de turnos/fechas y registro manual de aportes.</td><td>Creación de "pools", links de cobro, saldo virtual interno y transferencias vía SPEI.</td><td>Calculadora de división de cuentas, balance de saldos, registro de abonos y reportes exportables.</td></tr>
    <tr><td><strong>Precios & costos</strong></td><td>Modelo freemium / microcomisión por ciclo de junta administrada.</td><td>Descarga gratuita con anuncios publicitarios invasivos; opción de compra in-app para retirarlos.</td><td>Comisión por transacción con tarjeta (aprox. 3.9 %) y tarifas según el tamaño del pool.</td><td>Versión gratuita básica; suscripción prémium (<em>Splitwise Pro</em>) para escaneo de recibos y gráficos.</td></tr>
    <tr><td><strong>Canales de distribución</strong></td><td>Aplicación móvil nativa (Android/iOS), version multiplataforma (PWA) y enlaces por WhatsApp.</td><td>Google Play Store y Apple App Store.</td><td>Sitio web oficial (moneypool.mx) y app en Google Play / App Store.</td><td>Sitio web oficial (splitwise.com) y app en Google Play / App Store.</td></tr>
  </tbody>
</table>

* **Tandapp / MiTandita** se enfoca exclusivamente en la calendarización de tandas, permitiendo registrar participantes y definir el orden de entrega. Su limitación principal radica en que el registro de aportes es enteramente manual por parte del administrador, no cuenta con herramientas para validar transferencias bancarias y monetiza mediante anuncios publicitarios invasivos.
* **Moneypool** resuelve la recaudación colectiva centralizando los fondos en una cuenta virtual propia y habilitando cobros con tarjeta. Esta infraestructura presenta fricciones para el ahorro tradicional: la plataforma retiene el dinero y cobra comisiones por transacción, lo cual desincentiva a grupos informales habituados a transferencias directas, inmediatas y gratuitas entre cuentas bancarias personales.
* **Splitwise** destaca en la división de gastos comunes diarios o viajes. Sin embargo, su estructura está diseñada para liquidar saldos netos variables entre integrantes, no para el modelo de cuotas fijas rotativas con fechas estrictas de adjudicación de una junta, y restringe la lectura automatizada de recibos a su versión de pago prémium.

#### Análisis SWOT

##### Pozzo

<table>
  <colgroup><col style="width:50%"><col style="width:50%"></colgroup>
  <thead><tr><th>Fortalezas</th><th>Debilidades</th></tr></thead>
  <tbody>
    <tr><td>• Adaptada al flujo de pago real en Perú mediante lectura OCR de comprobantes de Yape y Plin.<br>• Modelo 100 % no custodial: no retiene dinero, eliminando riesgos legales y desconfianza de los usuarios.<br>• Transparencia en tiempo real: calendario compartido donde todos ven el estado de aportes y el pozo.<br>• Cobranza automatizada mediante recordatorios escalonados que evitan el desgaste entre conocidos.<br>• Flexibilidad para asignar turnos según la costumbre del grupo (sorteo, orden acordado o subasta).</td><td>• Producto nuevo en etapa de desarrollo, sin base instalada de usuarios previa.<br>• Dependencia técnica de la legibilidad de vouchers y de posibles cambios visuales en Yape/Plin.<br>• Capacidad operativa y recursos de difusión acotados frente a plataformas comerciales consolidadas.<br>• Resistencia inicial al uso de herramientas digitales en participantes poco familiarizados con apps.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:50%"><col style="width:50%"></colgroup>
  <thead><tr><th>Oportunidades</th><th>Amenazas</th></tr></thead>
  <tbody>
    <tr><td>• Uso masivo y cotidiano de billeteras móviles en el Perú (más de 16 millones de usuarios activos).<br>• Alto porcentaje de la población no bancarizada o sub-bancarizada que ahorra activamente en juntas.<br>• Adquisición viral de bajo costo: cada organizador incorpora directamente a su grupo por WhatsApp.<br>• Reutilización del historial de cumplimiento para facilitar la organización de siguientes ciclos.</td><td>• Hábito arraigado de organizadores de llevar sus cuentas en cuadernos físicos o libretas de notas.<br>• Posibilidad de que billeteras como Yape incorporen herramientas nativas de ahorro grupal.<br>• Ingreso de comprobantes duplicados, ilegibles o manipulados que requieran revisión manual.<br>• Casos de morosidad o deserción de integrantes que comprometan la continuidad de la junta.</td></tr>
  </tbody>
</table>

##### Tandapp / MiTandita

<table>
  <colgroup><col style="width:50%"><col style="width:50%"></colgroup>
  <thead><tr><th>Fortalezas</th><th>Debilidades</th></tr></thead>
  <tbody>
    <tr><td>• Especialización directa en el flujo tradicional de tandas y ahorro rotativo.<br>• Configuración rápida y uso ligero sin solicitar vinculación de cuentas bancarias.<br>• Buen posicionamiento orgánico en tiendas móviles para búsquedas relacionadas con tandas.</td><td>• Registro de pagos 100 % manual por parte del organizador.<br>• Experiencia de uso deteriorada por la presencia de publicidad en la versión gratuita.<br>• Nula validación de comprobantes ni compatibilidad con billeteras móviles peruanas.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:50%"><col style="width:50%"></colgroup>
  <thead><tr><th>Oportunidades</th><th>Amenazas</th></tr></thead>
  <tbody>
    <tr><td>• Interés de sectores populares por ordenar el seguimiento de sus tandas desde el celular.<br>• Posibilidad de transicionar hacia esquemas de suscripción accesibles sin anuncios.</td><td>• Pérdida de usuarios ante aplicaciones que automaticen la verificación de abonos.<br>• Alta tasa de abandono provocada por la saturación de anuncios dentro de la app.</td></tr>
  </tbody>
</table>

##### Moneypool

<table>
  <colgroup><col style="width:50%"><col style="width:50%"></colgroup>
  <thead><tr><th>Fortalezas</th><th>Debilidades</th></tr></thead>
  <tbody>
    <tr><td>• Respaldo formal como entidad fintech regulada (IFPE) en México.<br>• Infraestructura propia con links de cobro y recepción de pagos con tarjeta de débito/crédito.<br>• Marca reconocida en recaudación de fondos y eventos sociales en su país de origen.</td><td>• Cobro de comisiones que reducen el monto final del ahorro acumulado.<br>• Fricción y rechazo de usuarios informales a dejar su dinero bajo custodia de un tercero.<br>• Operatividad restringida al sistema bancario mexicano, sin soporte para soles peruanos.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:50%"><col style="width:50%"></colgroup>
  <thead><tr><th>Oportunidades</th><th>Amenazas</th></tr></thead>
  <tbody>
    <tr><td>• Generación de microrendimientos financieros sobre los saldos depositados en la plataforma.<br>• Expansión hacia cobros colectivos corporativos, institucionales y eventos masivos.</td><td>• Preferencia del público por transferencias interbancarias directas y sin comisión.<br>• Mayor rigidez en normativas sobre captación de fondos y billeteras electrónicas.</td></tr>
  </tbody>
</table>

##### Splitwise

<table>
  <colgroup><col style="width:50%"><col style="width:50%"></colgroup>
  <thead><tr><th>Fortalezas</th><th>Debilidades</th></tr></thead>
  <tbody>
    <tr><td>• Marca global líder en administración y liquidación de gastos compartidos.<br>• Algoritmo optimizado para consolidar saldos y reducir transferencias entre integrantes.<br>• Plataforma madura con sincronización multidispositivo y respaldo en la nube.</td><td>• No contempla la estructura de turnos rotativos ni el cobro de cuotas periódicas de una junta.<br>• La lectura automática de recibos (OCR) está restringida al plan de pago prémium.<br>• Carece de recordatorios de cobro escalonados diseñados para la disciplina de ahorro.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:50%"><col style="width:50%"></colgroup>
  <thead><tr><th>Oportunidades</th><th>Amenazas</th></tr></thead>
  <tbody>
    <tr><td>• Integración con medios de pago locales en mercados emergentes.<br>• Desarrollo de funciones orientadas a metas de ahorro grupal para viajes o proyectos.</td><td>• Fuga de usuarios hacia aplicaciones verticales enfocadas en esquemas de ahorro rotativo.<br>• Descontento de los usuarios frente a la limitación progresiva de opciones gratuitas.</td></tr>
  </tbody>
</table>

### 2.1.2. Estrategias y tácticas frente a competidores

Pozzo no busca competir como pasarela de pagos ni como un divisor de gastos general. La propuesta se fundamenta en resolver la carga operativa y los conflictos de las juntas peruanas sin intervenir en el dinero y respetando la relación de confianza del grupo.

#### Estrategia 1: Validación automatizada de pagos sin custodia de fondos

Pozzo se posiciona como una herramienta de administración y auditoría: el dinero continúa transfiriéndose directamente de persona a persona por Yape o Plin, mientras la plataforma se encarga de conciliar los aportes mediante lectura de comprobantes.

**Tácticas:**

* Desarrollar un motor OCR entrenado para reconocer con precisión monto, fecha, destinatario y número de operación en vouchers de Yape y Plin.
* Mostrar una pantalla de previsualización para que el participante confirme o corrija los datos leídos antes de registrar el aporte, resolviendo fallos por capturas borrosas.
* Incorporar validaciones automáticas contra datos esperados (destinatario y fecha) y alertar sobre comprobantes duplicados para que el organizador solo intervenga ante inconsistencias.
* Explicar de forma clara en la interfaz que Pozzo no retiene ni maneja los fondos, eliminando dudas de seguridad y barreras legales.

***

#### Estrategia 2: Adopción sin fricción y experiencia mobile-first

Para que una junta adopte la solución, todo el grupo debe poder utilizarla sin trámites complejos ni barreras tecnológicas.

**Tácticas:**

* Permitir el ingreso mediante un enlace de invitación distribuido por WhatsApp, facilitando que los participantes consulten el calendario en pocos segundos.
* Diseñar un flujo de registro mínimo que requiera únicamente nombre y número de celular, priorizando la facilidad de uso sobre la carga de datos.
* Disponer de una versión multiplataforma (PWA) junto a la app móvil, permitiendo consultar turnos y subir vouchers sin exigir una descarga obligatoria a quienes tengan limitaciones de almacenamiento.
* Presentar una interfaz gráfica limpia y visual que permita entender de un vistazo el avance de la junta, accesible para usuarios con poca experiencia digital.

#### Estrategia 3: Cobranza despersonalizada y transparencia de recaudación

Pozzo asume el seguimiento de pagos para liberar al organizador del desgaste de perseguir a familiares o amigos, reduciendo la morosidad y las discusiones sobre aportes.

**Tácticas:**

* Configurar notificaciones automáticas escalonadas que incrementen su periodicidad conforme se aproxime la fecha límite de aporte.
* Mostrar en un calendario compartido el estado de aportes en tiempo real, de manera que la visibilidad colectiva funcione como un incentivo natural de puntualidad.
* Proveer al participante que cobra en el turno vigente un indicador directo de cuánto falta para completar el pozo acordado.
* Mantener un registro verificable de cada aporte validado para resolver de inmediato controversias del tipo "yo sí pagué".

#### Estrategia 4: Gestión integral del ciclo e historial de cumplimiento

La herramienta acompaña a la junta durante todo su ciclo operativo, desde la organización inicial hasta el cierre y apertura de nuevas rondas.

**Tácticas:**

* Ofrecer opciones flexibles para asignar los turnos adaptadas a cómo opera cada grupo: por sorteo aleatorio, orden acordado entre integrantes o mecanismo de subasta.
* Generar al término del ciclo un historial de cumplimiento individual que acredite la puntualidad de cada miembro.
* Permitir que el historial sirva de referencia de confianza para organizar siguientes juntas con el mismo grupo o incorporar participantes a rondas de mayor monto.

## 2.2. Entrevistas

Esta sección presenta el estudio cualitativo basado en entrevistas semiestructuradas orientadas a validar Pozzo, una aplicación para administrar juntas (o panderos) informales sin que el dinero pase por la plataforma. El estudio exploró cómo se administran hoy las juntas, cómo se registran y comprueban los aportes por Yape o Plin, cómo se reparten los turnos y cómo se maneja la cobranza y los reclamos dentro del grupo. Participaron cabezas de junta con experiencia organizando varios ciclos y participantes de juntas activas, lo que permitió identificar que el registro manual en cuadernos y la revisión de capturas una por una son las principales fuentes de errores y desconfianza en la administración.

### 2.2.1. Diseño de entrevistas

"Antes de iniciar la entrevista, se brinda un saludo cordial y una breve presentación del entrevistador, explicando que el propósito de la conversación es conocer cómo las personas organizan y participan en juntas de ahorro en su día a día. Se aclara que la información recopilada será utilizada únicamente con fines académicos para el desarrollo del proyecto Pozzo y se mantendrá en estricta confidencialidad. Como primer paso, se solicita al entrevistado brindar su nombre completo, edad y lugar de residencia para fines de registro. Asimismo, se señala que la entrevista tendrá una duración aproximada de 10 a 15 minutos y se desarrollará de manera abierta, por lo que se le invita a responder con total libertad y basándose en ejemplos de su experiencia real, destacando que no existen respuestas correctas o incorrectas."

**Preguntas introductorias**

-   ¿Cuál es su nombre completo?

**Segmento 1: Cabezas de junta (organizadores)**

1. Para empezar, cuéntame de ti: ¿qué edad tienes, en qué distrito vives y a qué te dedicas?

2. ¿Cómo terminaste organizando juntas? ¿Hace cuánto y cuántas has administrado?

3. La junta que llevas ahora, ¿de quiénes se compone? ¿Trabajo, familia, vecinos, una mezcla?

4. Descríbeme la última junta que organizaste de principio a fin: cuánta gente, cuánto aportaba cada uno y cada cuánto tiempo.

5. ¿Cómo decidieron quién cobra primero y quién al final?

6. ¿Cómo te llegan los aportes? ¿Yape, Plin, efectivo, una mezcla?

7. En el último ciclo, ¿dónde anotaste quién había depositado y quién no?

8. Cuéntame paso a paso qué hiciste en la última fecha de corte, desde que se acercaba el día hasta que confirmaste que el pozo estaba completo.

9. En ese ciclo, ¿a cuántas personas tuviste que recordarles el pago? ¿Y cuántas veces a cada una?

10. ¿Cuántos comprobantes revisaste ese ciclo y cómo los revisabas?

11. Cuéntame la última vez que la cuenta no cuadró, o que alguien dijo haber pagado y no te aparecía. ¿Qué pasó y cómo se resolvió?

12. De todas las juntas que has organizado, ¿en cuántas pasó algo parecido? ¿Alguna se rompió por eso?

13. ¿Qué es lo que menos te gusta de organizar la junta?

14. ¿Has intentado llevarlo con Excel, alguna app o algo parecido? ¿Qué pasó?

15. ¿Qué celular usas y qué aplicaciones abres todos los días?

**Segmento 2: Participantes de junta**

1. Cuéntame de ti: ¿qué edad tienes, en qué distrito vives y a qué te dedicas?

2. ¿Cómo entraste a tu primera junta? ¿Quién te invitó?

3. El dinero que cobraste, ¿para qué lo usaste?

4. Descríbeme la junta en la que estás ahora: cuánta gente, cuánto aportas y cada cuánto.

5. Cuéntame paso a paso qué haces cuando toca aportar, desde que te acuerdas hasta que terminas.

6. ¿Cómo supiste qué turno te tocaba?

7. Después de yapear, ¿qué haces con la captura?

8. ¿Alguna vez te dijeron que no habías pagado cuando sí lo habías hecho? Cuéntame qué pasó.

9. Si el organizador te dijera hoy que falta un aporte tuyo de hace tres meses, ¿podrías demostrar que sí pagaste? ¿Cómo lo buscarías?

10. Antes de que te toque cobrar, ¿cómo sabes si el pozo va a estar completo?

11. Cuéntame cómo fue la última vez que te tocó cobrar.

12. ¿Has estado en una junta que se rompió o donde alguien dejó de pagar? ¿Qué pasó?

13. Cuando te invitan a una junta nueva, ¿qué te hace decidir si entras o no?

14. ¿Alguna vez pediste ver cómo iba la cuenta de la junta? ¿Qué te respondieron?

15. ¿Qué celular usas y qué aplicaciones abres todos los días?

### 2.2.2. Registro de entrevistas

**Segmento 1: Cabezas de junta (organizadores)**

- **Primera entrevista**

<table>
  <colgroup><col style="width:24%"><col style="width:76%"></colgroup>
  <thead><tr><th>Campo</th><th>Detalle</th></tr></thead>
  <tbody>
    <tr><td><strong>Entrevistado(a)</strong></td><td>Shirley Romy Becerra Pinchi</td></tr>
    <tr><td><strong>Género</strong></td><td>Femenino</td></tr>
    <tr><td><strong>Edad</strong></td><td>33</td></tr>
    <tr><td><strong>Lugar de residencia</strong></td><td>Tarapoto</td></tr>
    <tr><td><strong>Entrevistador(a)</strong></td><td>Fernando Flores</td></tr>
    <tr><td><strong>Duración</strong></td><td>22:31</td></tr>
    <tr><td><strong>Link de la entrevista</strong></td><td>https://upcedupe-my.sharepoint.com/:v:/g/personal/u20241a290_upc_edu_pe/IQDdvQoO5oy9TryDnR0F1bBHAb2aLP_LWFC5botPe_XVj3Q?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D&e=FpKimc</td></tr>
  </tbody>
</table>

![Captura de la entrevista a Shirley Romy Becerra Pinchi](images/chapter_2/shirley_pinchi.png){width=90%}

Shirley organiza panderos desde el colegio y lo ve como una forma de ahorrar; por eso suele quedarse con el último turno en vez del primero. Hoy administra, junto a su mamá, dos juntas mensuales: una de S/100 formada por maestros conocidos de su mamá y otra de S/200, con un total de 24 números, de los cuales seis participantes van a dejar el aporte en efectivo a su casa y el resto paga por Yape o Plin. Los turnos se definen por sorteo o por preferencia de meses, según la necesidad de cada quien (por ejemplo, quien necesita el dinero para la matrícula escolar pide ese mes). Lleva el control en un cuaderno y, el mismo día de corte, verifica los pagos revisando uno por uno sus movimientos de Yape; para la cobranza arma un grupo de WhatsApp donde manda un recordatorio el 25 y vuelve a insistir el 28. En cada ciclo tiene que recordarle el pago a dos o tres personas, hasta tres o cuatro veces cada una. Su peor experiencia ocurrió cuando su mamá sufrió un infarto cerebral y no quedó registro de quién había aportado: tuvieron que llamar uno por uno para reconstruir la cuenta, y hubo un reclamo de "yo sí pagué" imposible de comprobar. También recuerda un caso en pandemia en el que un integrante perdió su trabajo y dejó de aportar a mitad del ciclo, por lo que su mamá tuvo que cubrir esas cuotas; desde entonces son más cuidadosas al elegir personas responsables. No usa Excel ni aplicaciones, aunque reconoce que con más juntas un sistema le sería necesario. Usa un celular Redmi y a diario abre Yape y TikTok.

***

- **Segunda entrevista**

<table>
  <colgroup><col style="width:24%"><col style="width:76%"></colgroup>
  <thead><tr><th>Campo</th><th>Detalle</th></tr></thead>
  <tbody>
    <tr><td><strong>Entrevistado(a)</strong></td><td>Ariel Roberto Mendoza Blanco</td></tr>
    <tr><td><strong>Género</strong></td><td>Masculino</td></tr>
    <tr><td><strong>Edad</strong></td><td>29</td></tr>
    <tr><td><strong>Lugar de residencia</strong></td><td>Pueblo Libre, Lima</td></tr>
    <tr><td><strong>Entrevistador(a)</strong></td><td>Fernando Flores</td></tr>
    <tr><td><strong>Duración</strong></td><td>8:22</td></tr>
    <tr><td><strong>Link de la entrevista</strong></td><td>https://upcedupe-my.sharepoint.com/:v:/g/personal/u20241a290_upc_edu_pe/IQDRpPL_neBqRL0gl1hTRH-lAWqb_FLzHgtfgUrKclzgcQE?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D&e=AL0giv</td></tr>
  </tbody>
</table>

![Captura de la entrevista a Ariel Roberto Mendoza Blanco](images/chapter_2/ariel_mendoza.png){width=90%}

Ariel organiza juntas desde los 20 años como una forma de obligarse a ahorrar, ya que le cuesta juntar el dinero por su cuenta. Hoy lleva dos, una familiar y una del trabajo, de hasta 12 personas para completar un año, con un cobro por mes. Los turnos se acuerdan dialogando según la urgencia de cada quien, y él siempre se deja el último turno; al principio ponía el dinero él, hasta que vio que era una mejor forma de ahorrar. Recibe los aportes en efectivo y por transferencia, y lleva un doble registro, en un cuaderno y en un Excel: cuando alguien paga por transferencia, verifica contra su estado de cuenta y le pide la captura antes de marcarlo con un check. Tiene que recordar el pago a varias personas, hasta cuatro o cinco veces en el grupo familiar y dos o tres en el del trabajo. Su incidente más claro fue un pago hecho de madrugada que el banco retuvo 24 horas: el compañero afirmaba haber pagado, le mandó la captura, pero a Ariel no le llegaba nada. En otros casos ha tenido que poner algo de su propio dinero cuando alguien se atrasa por temas de salud. Lo que menos le gusta es tener que insistir para cobrar, y le gustaría una aplicación que verifique los pagos automáticamente y le informe cuando cada persona ya pagó. Usa un iPhone 15 y la computadora para su archivo de Excel.

***

- **Tercera entrevista**

<table>
  <colgroup><col style="width:24%"><col style="width:76%"></colgroup>
  <thead><tr><th>Campo</th><th>Detalle</th></tr></thead>
  <tbody>
    <tr><td><strong>Entrevistado(a)</strong></td><td>Jorge Chávez</td></tr>
    <tr><td><strong>Género</strong></td><td>Masculino</td></tr>
    <tr><td><strong>Edad</strong></td><td>25</td></tr>
    <tr><td><strong>Lugar de residencia</strong></td><td>San Martín de Porres, Lima</td></tr>
    <tr><td><strong>Entrevistador(a)</strong></td><td>Fernando Flores</td></tr>
    <tr><td><strong>Duración</strong></td><td>8:11</td></tr>
    <tr><td><strong>Link de la entrevista</strong></td><td>https://upcedupe-my.sharepoint.com/:v:/g/personal/u20241a290_upc_edu_pe/IQBMwoKhRDb-Ta5sFdnCJm7SATYbCURZgS1q9Fn4MKZ6yZ8?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D&e=iNPW0v</td></tr>
  </tbody>
</table>

![Captura de la entrevista a Jorge Chávez](images/chapter_2/jorge_chavez.png){width=90%}

Jorge organiza juntas desde hace unos cinco años; empezó entre hermanos y primos para juntar dinero para gastos comunes, y luego se sumaron amigos del trabajo y quedó él a cargo. Su junta actual es de unas diez personas, entre familia y amigos cercanos, con un aporte de S/500 al mes y un pozo de S/5000 mensual; antes de empezar arman una lista con todos y definen el orden de cobro, y él participa y aporta igual que el resto. Los turnos se deciden por urgencia, quien tiene una compra o un pago pendiente cobra primero, y un cambio de turno se acuerda conversando en el grupo. Los aportes llegan por Yape y lleva el control en un Excel de doble entrada (meses por nombres, como un checklist mensual), apoyándose también en el grupo de WhatsApp. En cada corte avisa días antes por el grupo, el día de pago compara los Yapes contra su lista (a veces alguien paga por Plin y se confunde), revisa el saldo de su cuenta, escribe a quien falta y, cuando el pozo llega a los S/5000, avisa y transfiere al que le toca. Suele recordar el pago a dos o tres personas y revisa entre 15 y 20 comprobantes por ciclo. Su incidente más claro fue hace dos meses: un integrante afirmaba haber pagado y hasta mandó una captura, pero el dinero no le llegaba; resultó que había yapeado a otra persona por equivocarse de número, y tuvieron que contactar a ese tercero para recuperarlo. Lo que menos le gusta es perseguir a la gente para que pague, algo incómodo tratándose de familia y amigos. No usa aplicaciones para gestionar la junta, solo Excel. Usa un Honor X8 y a diario abre WhatsApp, Yape e Instagram.

**Segmento 2: Participantes de junta**

- **Primera entrevista**

<table>
  <colgroup><col style="width:24%"><col style="width:76%"></colgroup>
  <thead><tr><th>Campo</th><th>Detalle</th></tr></thead>
  <tbody>
    <tr><td><strong>Entrevistado(a)</strong></td><td>Elizabeth Díaz</td></tr>
    <tr><td><strong>Género</strong></td><td>Femenino</td></tr>
    <tr><td><strong>Edad</strong></td><td>22</td></tr>
    <tr><td><strong>Lugar de residencia</strong></td><td>Callao</td></tr>
    <tr><td><strong>Entrevistador(a)</strong></td><td>Fernando Flores</td></tr>
    <tr><td><strong>Duración</strong></td><td>7:57</td></tr>
    <tr><td><strong>Link de la entrevista</strong></td><td>https://upcedupe-my.sharepoint.com/:v:/g/personal/u20241a290_upc_edu_pe/IQCFSDS82wYXTLbYwVMsMQKqAYFMxBZ7A2ITCzsY__4CGdI?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D&e=MGNr2M</td></tr>
  </tbody>
</table>

![Captura de la entrevista a Elizabeth Díaz](images/chapter_2/elizabeth_diaz.png){width=90%}

Elizabeth entró a su primera junta invitada por una amiga de la universidad, que le comentó que varias amigas estaban ahorrando en grupo para recibir una cantidad más grande de dinero; al principio dudó, pero como conocía a todas, decidió entrar, y ese primer cobro lo usó para comprarse una laptop que necesitaba para estudiar. Hoy participa en una junta de ocho personas que aportan S/300 al mes durante ocho meses, con los turnos definidos por sorteo y publicados por la organizadora en el grupo de WhatsApp. Cuando toca aportar, la organizadora avisa por el grupo, ella revisa que tenga el dinero, yapea, toma la captura del comprobante y se la envía; la organizadora confirma en el grupo que el aporte se hizo. Guarda las capturas en su galería, pero mezcladas con todas las demás, sin una carpeta propia. Ya le pasó que la organizadora pensó que no había pagado y tuvo que buscar la conversación y reenviar la captura de Yape para demostrarlo; si le pidieran probar un aporte de hace tres meses, revisaría primero el chat de WhatsApp, luego la galería y, por último, sus movimientos de Yape. Antes de cobrar le preocupa que alguien se atrase, sobre todo si ya cuenta con ese dinero, aunque confía porque son amigas y la organizadora avisa quiénes ya pagaron. Para decidir entrar a una junta le importa quién la organiza y quiénes participan, porque con desconocidos sería más difícil reclamar si ocurre un problema. Usa un celular Android y hace todo lo de la junta desde el teléfono, con WhatsApp y Yape.

***

- **Segunda entrevista**

<table>
  <colgroup><col style="width:24%"><col style="width:76%"></colgroup>
  <thead><tr><th>Campo</th><th>Detalle</th></tr></thead>
  <tbody>
    <tr><td><strong>Entrevistado(a)</strong></td><td>Mariana López</td></tr>
    <tr><td><strong>Género</strong></td><td>Femenino</td></tr>
    <tr><td><strong>Edad</strong></td><td>35</td></tr>
    <tr><td><strong>Lugar de residencia</strong></td><td>San Juan de Lurigancho</td></tr>
    <tr><td><strong>Entrevistador(a)</strong></td><td>Fernando Flores</td></tr>
    <tr><td><strong>Duración</strong></td><td>8:12</td></tr>
    <tr><td><strong>Link de la entrevista</strong></td><td>https://upcedupe-my.sharepoint.com/:v:/g/personal/u20241a290_upc_edu_pe/IQBGVs0x_7sNQqDkjCTOiN9nAYOPzQ04mGl01GjuDQbolVg?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D&e=uhHyGn</td></tr>
  </tbody>
</table>

![Captura de la entrevista a Mariana López](images/chapter_2/mariana_lopez.png){width=90%}

Mariana entró a su primera junta invitada por una amiga del trabajo; prefirió la junta a un préstamo bancario para no pagar intereses ni endeudarse, y porque ya conocía a las personas. Ese primer cobro lo usó para comprar mercadería para su negocio de venta de ropa. Hoy participa en una junta de diez personas que aportan S/200 al mes durante diez meses, con los turnos definidos por sorteo y publicados por el organizador en el grupo de WhatsApp. Anota la fecha en su calendario y, cuando se acerca el día, revisa que tenga el dinero, aporta por Yape o en efectivo y envía la captura al grupo y al organizador; guarda los comprobantes en su galería sin ordenarlos, por lo que puede ser difícil encontrarlos. Ya le pasó que el organizador le dijo que faltaba un pago y tuvo que revisar hasta encontrar el comprobante para demostrarlo. Antes de cobrar le preocupa que alguien se atrase, y se apoya en que el organizador recuerda los pagos unos días antes, lo que en su última cobranza ayudó a que le llegara el monto completo y a tiempo. Conoció el caso de una persona que dijo que pagaría después, dejó de responder y el grupo tuvo que ponerse de acuerdo para resolverlo, algo incómodo porque no sabían cómo contactarla. Para entrar a una junta valora que el organizador sea conocido y responsable, además del tiempo que durará. Usa un celular Samsung y a diario WhatsApp, Yape, Facebook, Instagram y TikTok.

***

- **Tercera entrevista**

<table>
  <colgroup><col style="width:24%"><col style="width:76%"></colgroup>
  <thead><tr><th>Campo</th><th>Detalle</th></tr></thead>
  <tbody>
    <tr><td><strong>Entrevistado(a)</strong></td><td>Catherine Villar</td></tr>
    <tr><td><strong>Género</strong></td><td>Femenino</td></tr>
    <tr><td><strong>Edad</strong></td><td>27</td></tr>
    <tr><td><strong>Lugar de residencia</strong></td><td>Los Olivos, Lima</td></tr>
    <tr><td><strong>Entrevistador(a)</strong></td><td>Fernando Flores</td></tr>
    <tr><td><strong>Duración</strong></td><td>7:33</td></tr>
    <tr><td><strong>Link de la entrevista</strong></td><td>https://upcedupe-my.sharepoint.com/:v:/g/personal/u20241a290_upc_edu_pe/IQCj6omQVLR0RLcd9rwXUD8RAbMbkbsxrhkpd7shCpX2DGM?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D&e=yhcfhQ</td></tr>
  </tbody>
</table>

![Captura de la entrevista a Catherine Villar](images/chapter_2/catherine_villar.png){width=90%}

Catherine entró a su primera junta invitada por una compañera del trabajo y ya ha estado en dos. Su primer cobro lo usó para pagar un curso que le interesaba y bajar la deuda de un crédito; prefirió la junta a un préstamo bancario para no pagar intereses. Hoy participa en una junta de ocho personas que aportan S/250 al mes durante ocho meses, con los turnos definidos por sorteo y publicados por el organizador en el grupo de WhatsApp. Cuando toca aportar, revisa que tenga el dinero, yapea al organizador, que a veces avisa porque se les pasa la fecha, toma la captura y la manda por WhatsApp para dejar constancia; luego la guarda en su galería, pero sin ningún orden. En su segunda junta le dijeron que no había pagado y, como no ordena las capturas, tuvo que buscarla y reenviarla para que la verificaran y corrigieran; reconoce que probar un aporte de hace tres meses le costaría y sería incómodo, aunque lo buscaría sí o sí por WhatsApp o por sus movimientos de Yape y del banco. Antes de cobrar no puede estar segura de que el pozo esté completo: para ella es cosa de confiar y de preguntar quién ya pagó, y sabe de casos en que el pozo no llega completo y se termina cobrando por partes. En su última cobranza el pago se le retrasó dos o tres días porque dos integrantes no habían aportado a tiempo. Ya vivió una junta en la que alguien dejó de pagar a la mitad, algo difícil e incómodo que el grupo tuvo que resolver. Para entrar a una junta le importa que quien la organiza sea de confianza y conocer a los demás participantes; con desconocidos no entra. Usa un celular Xiaomi y a diario WhatsApp, Yape, Instagram, TikTok y las aplicaciones de su trabajo.

### 2.2.3. Análisis de entrevistas

Se realizaron 6 entrevistas semiestructuradas distribuidas en dos segmentos objetivos: 3 cabezas de junta que organizan y administran los aportes, y 3 participantes que aportan cada mes y esperan su turno para cobrar. El propósito fue identificar patrones comunes en sus experiencias, frustraciones y expectativas en torno al registro de aportes, la validación de pagos, la asignación de turnos y la cobranza. A partir de los resúmenes obtenidos, se extrajeron características objetivas y subjetivas de cada perfil, las cuales se presentan con respaldo estadístico expresado en porcentajes sobre el total de entrevistados por segmento.

#### Segmento objetivo #1: Cabezas de junta (organizadores)

**Hallazgos**

- El 100% administra la junta de forma manual, con un cuaderno y/o un Excel, y ninguno usa una aplicación dedicada para gestionarla.
- El 100% valida los pagos revisando uno por uno sus movimientos de Yape y las capturas que le envían, normalmente el mismo día de corte.
- El 100% debe recordar el pago a dos o tres integrantes en cada ciclo, a veces varias veces a cada uno.
- El 100% ha enfrentado al menos un incidente de descuadre o un reclamo de pago no verificable (registro perdido, pago retenido por el banco o transferencia a la persona equivocada).
- El 67% ha tenido que cubrir con su propio dinero, o el de un familiar, el atraso o incumplimiento de un integrante para que la cadena no se cayera.
- El 100% recibe los aportes por billetera digital (Yape o Plin) y el 67% además recibe una parte en efectivo.

**Prácticas y problemas comunes**

![Prácticas y problemas comunes del segmento 1](images/chapter_2/graf_seg1_practicas.png){width=75%}

El registro manual, la verificación uno por uno de los pagos, la necesidad de recordar la cuota cada ciclo y los incidentes de descuadre aparecen en el 100% del segmento, lo que los posiciona como los problemas centrales y compartidos por todas las cabezas de junta. El 67% incluso ha tenido que poner dinero propio para cubrir un atraso, lo que muestra que el costo del desorden no es solo de tiempo, sino también económico.

**Herramienta de registro actual**

![Herramienta de registro del segmento 1](images/chapter_2/graf_seg1_registro.png){width=60%}

El 67% del segmento ya se apoya en Excel, con o sin cuaderno, y el 33% restante lleva todo únicamente en un cuaderno; ninguno usa una aplicación dedicada. Esto indica que Pozzo no compite con un sistema digital consolidado, sino que se posiciona como la primera herramienta formal de gestión de la junta, lo que reduce la resistencia al cambio y facilita la adopción.

**Canal de recepción de aportes**

![Canal de recepción de aportes del segmento 1](images/chapter_2/graf_seg1_canal.png){width=60%}

El 100% recibe los aportes por billetera digital (Yape o Plin) y el 67% además maneja algo de efectivo. La preferencia por la billetera valida directamente el enfoque de Pozzo de leer los vouchers de Yape/Plin sin custodiar el dinero, ya que el pago ya ocurre por ese canal y solo falta ordenar su registro y validación.

**Conclusiones**

Las cabezas de junta administran con herramientas insuficientes: dependen del cuaderno o de un Excel, validan los pagos revisando movimientos uno por uno y asumen personalmente la cobranza. Esa carga operativa se traduce en errores de conteo, reclamos difíciles de resolver e incluso en pérdidas cuando toca cubrir un atraso. La totalidad del segmento paga y cobra por billeteras digitales, lo que confirma que existe una necesidad real de una herramienta que automatice el registro y la validación de aportes sin intervenir en el dinero.

#### Segmento objetivo #2: Participantes de junta

**Hallazgos**

- El 100% aporta por billetera digital (Yape) y guarda las capturas en su galería sin ningún orden, mezcladas con las demás.
- El 100% ya vivió que le dijeran que no había pagado cuando sí lo había hecho, y tuvo que buscar y reenviar la captura para demostrarlo.
- El 100% reconoce que probar un aporte antiguo (por ejemplo, de hace tres meses) le costaría y sería incómodo.
- El 100% siente incertidumbre antes de cobrar sobre si el pozo estará completo, y se apoya en la confianza y en preguntar quién ya pagó.
- El 100% conoce o vivió una junta en la que alguien dejó de pagar, lo que generó incomodidad en el grupo.
- El 67% tuvo un retraso en su última cobranza porque algún integrante no había aportado a tiempo, y el 67% prefiere la junta a un préstamo bancario para no pagar intereses.

**Experiencias y percepciones**

![Experiencias y percepciones del segmento 2](images/chapter_2/graf_seg2_experiencias.png){width=75%}

El desorden de las capturas, los reclamos de "no pagaste" cuando sí se pagó, la dificultad para probar un aporte antiguo, la incertidumbre sobre el pozo y el conocimiento de casos de incumplimiento aparecen en el 100% del segmento. Todos estos puntos apuntan al mismo vacío: la falta de una prueba de pago ordenada y de visibilidad del estado de la junta.

**Última cobranza**

![Resultado de la última cobranza del segmento 2](images/chapter_2/graf_seg2_cobranza.png){width=60%}

El 67% del segmento tuvo un retraso en su última cobranza porque algún integrante no aportó a tiempo, frente a un 33% que cobró sin contratiempos. Esto confirma que la incertidumbre sobre completar el pozo no es solo una preocupación, sino un problema que efectivamente ocurre.

**Factores para entrar a una junta**

![Factores para entrar a una junta del segmento 2](images/chapter_2/graf_seg2_decision.png){width=60%}

El 100% decide entrar a una junta según la confianza en quien la organiza y el conocer a los demás participantes, y el 67% además la prefiere frente a un préstamo bancario para no pagar intereses. La confianza es el factor decisivo, lo que refuerza que Pozzo debe apoyarse en las redes existentes del grupo y aportar transparencia sin reemplazar esa relación.

**Conclusiones**

Los participantes viven la junta con poca visibilidad y sin una prueba de pago ordenada: guardan las capturas sin criterio, ya han tenido que defender un pago que sí hicieron y sienten incertidumbre cada vez que se acerca su turno. La totalidad conoce casos de incumplimiento y la mayoría ya sufrió un retraso al cobrar. La confianza en el organizador es lo que los hace entrar, por lo que valoran una herramienta que dé transparencia del estado del pozo y respaldo verificable de sus aportes, sin alterar la dinámica de confianza del grupo.
***

## 2.3. Needfinding
En esta sección se presentan los artefactos resultantes del análisis de la información recolectada en las entrevistas de la sección 2.2. A partir de los patrones identificados en los dos segmentos objetivo se construyeron los arquetipos de usuario, se mapearon las tareas que realizan hoy con independencia de la existencia de Pozzo, se representaron sus recorridos actuales y su marco emocional, y se consolidó el lenguaje del dominio que el equipo utilizará de forma uniforme durante todo el proyecto.

Cada característica presente en los arquetipos proviene de los resúmenes y del análisis estadístico de las seis entrevistas registradas; no se incorporó ningún atributo que no tenga respaldo en dicha información.

### 2.3.1. User Personas

Se elaboró una ficha de User Persona por cada segmento objetivo, utilizando UXPressia. Para cada segmento se construyó un arquetipo representativo a partir de los patrones recurrentes identificados en las tres entrevistas, contrastando sus características con los resultados consolidados de la sección 2.2.3.

#### User Persona 1: Cabeza de junta

![Anna Weber](images/chapter_2/anna_weber_us1.png)

#### User Persona 2: Participante de junta
![Sofia Gonzales](images/chapter_2/sofia_gonzales_us2.png)

***

### 2.3.2. User Task Matrix
El User Task Matrix concentra las tareas que los User Personas realizan para cumplir sus objetivos dentro de una junta, con independencia de que exista o no una solución de software. No se trata de funcionalidades de Pozzo, sino de actividades que ambos segmentos ya ejecutan hoy con cuaderno, hoja de cálculo y mensajería.

<table>
  <colgroup><col style="width:33%"><col style="width:15%"><col style="width:16%"><col style="width:18%"><col style="width:18%"></colgroup>
  <thead><tr><th>User Task Matrix</th><th align="center">Anna Weber (Frecuencia)</th><th align="center">Anna Weber (Importancia)</th><th align="center">Sofia Gonzales (Frecuencia)</th><th align="center">Sofia Gonzales (Importancia)</th></tr></thead>
  <tbody>
    <tr><td>Convocar y conformar el grupo de la junta</td><td align="center">Media</td><td align="center">Alta</td><td align="center">Baja</td><td align="center">Media</td></tr>
    <tr><td>Definir monto, periodicidad y número de integrantes</td><td align="center">Media</td><td align="center">Alta</td><td align="center">Baja</td><td align="center">Media</td></tr>
    <tr><td>Acordar o sortear el orden de los turnos</td><td align="center">Baja</td><td align="center">Alta</td><td align="center">Baja</td><td align="center">Alta</td></tr>
    <tr><td>Transferir el aporte por billetera digital</td><td align="center">Media</td><td align="center">Alta</td><td align="center">Alta</td><td align="center">Alta</td></tr>
    <tr><td>Guardar el comprobante del aporte propio</td><td align="center">Media</td><td align="center">Media</td><td align="center">Alta</td><td align="center">Alta</td></tr>
    <tr><td>Registrar quién aportó en cada fecha de corte</td><td align="center">Alta</td><td align="center">Alta</td><td align="center">Baja</td><td align="center">Baja</td></tr>
    <tr><td>Verificar el comprobante de cada aporte recibido</td><td align="center">Alta</td><td align="center">Alta</td><td align="center">Baja</td><td align="center">Media</td></tr>
    <tr><td>Recordar el pago a los integrantes atrasados</td><td align="center">Alta</td><td align="center">Alta</td><td align="center">Baja</td><td align="center">Baja</td></tr>
    <tr><td>Consultar cuánto falta para completar el pozo</td><td align="center">Media</td><td align="center">Alta</td><td align="center">Media</td><td align="center">Alta</td></tr>
    <tr><td>Entregar el pozo al integrante del turno</td><td align="center">Media</td><td align="center">Alta</td><td align="center">Baja</td><td align="center">Media</td></tr>
    <tr><td>Resolver un reclamo sobre un aporte no registrado</td><td align="center">Media</td><td align="center">Alta</td><td align="center">Media</td><td align="center">Alta</td></tr>
    <tr><td>Demostrar que un aporte propio sí se realizó</td><td align="center">Baja</td><td align="center">Media</td><td align="center">Media</td><td align="center">Alta</td></tr>
    <tr><td>Cubrir el atraso de un integrante para no romper la cadena</td><td align="center">Baja</td><td align="center">Alta</td><td align="center">Baja</td><td align="center">Baja</td></tr>
    <tr><td>Decidir si acepta entrar a una nueva junta</td><td align="center">Baja</td><td align="center">Media</td><td align="center">Media</td><td align="center">Alta</td></tr>
  </tbody>
</table>

**Leyenda:** Frecuencia e Importancia se expresan en tres niveles: Baja, Media y Alta.

Del cuadro se desprenden tres lecturas. La primera es que **las tareas de mayor frecuencia e importancia para Anna son precisamente las administrativas**: registrar aportes, verificar comprobantes y recordar el pago. Son actividades que no aportan valor al ahorro en sí mismo y que, sin embargo, consumen la mayor parte de su esfuerzo. La segunda es que **para Sofia las tareas de alta frecuencia son las de ejecución y resguardo**, transferir el aporte y guardar el comprobante, mientras que las de mayor importancia relativa son las defensivas: demostrar un aporte y saber si el pozo estará completo.

Entre las tareas compartidas por ambos segmentos, destacan especialmente consultar cuánto falta para completar el pozo y resolver reclamos sobre aportes no registrados, porque ambas están directamente relacionadas con la transparencia y trazabilidad del ciclo.
***

### 2.3.3. User Journey Mapping

Los User Journey Maps representan el recorrido actual de los dos segmentos objetivo durante su participación en una junta de ahorro, antes de la introducción de Pozzo. A partir de los patrones identificados en las entrevistas, se modelan las actividades, objetivos, dificultades y emociones que experimentan tanto la cabeza de junta como el participante a lo largo de un ciclo.

#### User Journey Map 1: Anna Weber - Cabeza de junta

El journey de Anna Weber representa el recorrido de una cabeza de junta desde la conformación del grupo hasta la entrega del pozo correspondiente a cada período. El proceso se caracteriza por una alta carga administrativa: coordinación mediante WhatsApp, registro manual de aportes, revisión individual de comprobantes y seguimiento constante a los participantes atrasados. La angustia y estrés se concentran cerca de la fecha de corte, cuando Anna necesita comprobar que todos los aportes hayan sido recibidos y resolver cualquier inconsistencia antes de realizar la entrega.

![Anna Weber Journey Map](images/chapter_2/anna_weber_journey_map.png)

#### User Journey Map 2: Sofia Gonzales - Participante de junta

El journey de Sofia Gonzales representa la experiencia de una participante desde que evalúa incorporarse a una junta hasta que recibe el pozo en el turno asignado. Su decisión inicial depende principalmente de la confianza en el organizador y en los demás integrantes. Durante el ciclo realiza sus aportes mediante Yape o, eventualmente, otros medios acordados, envía comprobantes por WhatsApp y conserva las capturas como respaldo. Los principales problemas aparecen al intentar demostrar aportes anteriores y durante la espera previa a su turno, cuando no existe certeza de que todos los integrantes hayan pagado a tiempo.

![Sofia Gonzales Journey Map](images/chapter_2/sofia_gonzales_journey_map.png)

### 2.3.4. Empathy Mapping

#### Empathy map 1: Anna Weber - Cabeza de Junta

El empathy map de Anna Weber, como administradora de juntas entre conocidos, refleja su rol clave en coordinar reglas, turnos y la entrega del pozo, enfrentando el desafío de equilibrar su confianza en el grupo con la frustración de la revisión manual de comprobantes y la incomodidad de gestionar cobranzas, lo que demuestra la necesidad de mejorar estos procesos, asegurar la transparencia de los aportes y preservar la confianza.

![Anna Weber Empathy Map](images/chapter_2/anna_webber_empathy_map.png)

#### Empathy map 2: Sofia Gonzales - Participante de Junta

El empathy map de Sofia Gonzales, como participante en una junta, está basada en la confianza donde busca cumplir puntualmente con sus aportes y recibir el pozo en su turno. Asimismo enfrenta la incomodidad de buscar comprobantes antiguos y la incertidumbre ante posibles retrasos del grupo. Esto demuestra la necesidad de evidenciar de forma organizada los pagos, el estado del pozo y así tener la tranquilidad frente al cumplimiento general.

![Sofia Gonzales Empathy Map](images/chapter_2/sofia_gonzales_empathy_map.png)


### 2.3.5. Big Picture EventStorming

El Big Picture EventStorming se utilizó para representar de manera colaborativa el funcionamiento general de una junta de ahorro, identificando los eventos relevantes que ocurren desde la conformación del grupo hasta la finalización del ciclo. El objetivo fue construir una visión compartida del dominio a partir de los hallazgos obtenidos en las entrevistas, sin incorporar todavía funcionalidades específicas de Pozzo.

**Leyenda**
- **Domain Event**: Hecho relevante del dominio que ya ocurrió.
- **Hotspot**: Problema, duda, riesgo o punto que requiere mayor análisis.
- **Actor**: Persona o rol que participa en una acción del proceso.
- **Command**: Acción o intención que provoca un cambio en el dominio.
- **Policy**: Regla que determina qué acción realizar cuando ocurre determinado evento.
- **External System**: Sistema o herramienta externa que interactúa con el proceso.
- **Comment**: Nota, pregunta o aclaración añadida durante el análisis

![Leyenda de conceptos](images/chapter_2/leyenda.jpg)

#### Identificación de eventos
El equipo inició la sesión identificando los principales eventos que ocurren durante una junta de ahorro. Cada evento se formuló como un hecho ocurrido dentro del dominio, sin considerar todavía su orden ni posibles soluciones tecnológicas.

![Identificacion de eventos](images/chapter_2/identificacion_de_eventos.jpg)

#### Ordenamiento temporal
Los eventos identificados se organizaron cronológicamente para reconstruir el recorrido completo de una junta, desde su conformación hasta la finalización del ciclo.

![Ordenamiento temporal](images/chapter_2/ordenamiento_temporal.jpg)

#### Actores, sistemas externos y comandos
Posteriormente se incorporaron los roles que participan en cada actividad y las herramientas utilizadas actualmente, entre ellas WhatsApp, Yape, Plin, aplicaciones bancarias y hojas de cálculo. Ademas se utilizan verbos en infinitivo para representar las acciones que se están haciendo.

![Actores,sistemas externos y comandos](images/chapter_2/actores_sistemas_externos_comandos.jpg)

#### Identificación de problemas y validación

Finalmente, mediante storytelling se revisó el recorrido completo y se identificaron los principales puntos de fricción, como la cobranza repetitiva, la verificación manual y los aportes pendientes.

![Problemas y Validación](images/chapter_2/problemas_validacion.jpg)

### 2.3.6. Ubiquitous Language

El siguiente glosario reúne los términos y conceptos del dominio del ahorro rotativo que el equipo utiliza de forma uniforme en todos los artefactos, en el código y en la comunicación con los interesados. Se incluyen únicamente términos del negocio, no términos técnicos de ingeniería de software. Los términos se registran en inglés, con su equivalente de uso corriente en el Perú entre paréntesis.

<table>
  <colgroup><col style="width:38%"><col style="width:62%"></colgroup>
  <thead><tr><th>Término</th><th>Definición</th></tr></thead>
  <tbody>
    <tr><td><strong>Savings Group</strong> (Junta, pandero)</td><td>Asociación rotativa de ahorro y crédito conformada por personas conocidas entre sí, que aportan un monto fijo con periodicidad acordada para que el fondo acumulado se entregue íntegro a un integrante distinto en cada turno.</td></tr>
    <tr><td><strong>Cycle</strong> (Ciclo)</td><td>Duración total de una junta, equivalente al número de períodos necesarios para que todos los integrantes hayan cobrado una vez.</td></tr>
    <tr><td><strong>Contribution Period</strong> (Período de aporte)</td><td>Intervalo de tiempo acordado entre un aporte y el siguiente. Puede ser semanal, quincenal o mensual.</td></tr>
    <tr><td><strong>Contribution</strong> (Aporte)</td><td>Monto fijo que cada integrante entrega en cada período de aporte.</td></tr>
    <tr><td><strong>Pot</strong> (Pozo)</td><td>Suma de todos los aportes de un período, que se entrega completa al integrante cuyo turno corresponde.</td></tr>
    <tr><td><strong>Turn</strong> (Turno)</td><td>Posición dentro del ciclo que determina en qué período le corresponde cobrar el pozo a cada integrante.</td></tr>
    <tr><td><strong>Turn Assignment</strong> (Asignación de turnos)</td><td>Mecanismo mediante el cual el grupo determina el orden de cobro al constituir la junta.</td></tr>
    <tr><td><strong>Draw</strong> (Sorteo)</td><td>Mecanismo de asignación de turnos en el que el orden se determina al azar entre los integrantes.</td></tr>
    <tr><td><strong>Agreed Order</strong> (Orden acordado)</td><td>Mecanismo de asignación de turnos en el que el orden se define por consenso, generalmente según la urgencia de cada integrante.</td></tr>
    <tr><td><strong>Bidding</strong> (Subasta)</td><td>Mecanismo de asignación de turnos en el que un integrante cede parte del pozo a cambio de cobrar en un período anterior al que le correspondería.</td></tr>
    <tr><td><strong>Organizer</strong> (Cabeza de junta)</td><td>Integrante que convoca al grupo, define las reglas de la junta, registra los aportes y entrega el pozo en cada turno.</td></tr>
    <tr><td><strong>Member</strong> (Participante)</td><td>Integrante que aporta en cada período y recibe el pozo cuando llega su turno.</td></tr>
    <tr><td><strong>Cut-off Date</strong> (Fecha de corte)</td><td>Fecha límite acordada para que todos los aportes de un período estén realizados.</td></tr>
    <tr><td><strong>Payout</strong> (Cobro, adjudicación)</td><td>Entrega del pozo completo al integrante cuyo turno corresponde en el período vigente.</td></tr>
    <tr><td><strong>Payment Proof</strong> (Comprobante, voucher)</td><td>Constancia de la transferencia realizada por un integrante, que acredita el monto, la fecha y el destinatario de su aporte.</td></tr>
    <tr><td><strong>Delinquency</strong> (Morosidad)</td><td>Situación en la que un integrante no realiza su aporte dentro de la fecha de corte.</td></tr>
    <tr><td><strong>Coverage</strong> (Cobertura)</td><td>Práctica por la cual el organizador u otro integrante asume con dinero propio el aporte de un moroso para que el pozo se complete y la cadena no se rompa.</td></tr>
    <tr><td><strong>Dropout</strong> (Deserción)</td><td>Abandono definitivo de un integrante antes de finalizar el ciclo, habitualmente después de haber cobrado su turno.</td></tr>
    <tr><td><strong>Compliance History</strong> (Historial de cumplimiento)</td><td>Registro del comportamiento de pago de un integrante a lo largo de los ciclos en los que ha participado.</td></tr>
    <tr><td><strong>Reminder</strong> (Recordatorio)</td><td>Aviso dirigido a un integrante para que realice su aporte antes de la fecha de corte.</td></tr>
  </tbody>
</table>
***

## 2.4. Requirements specification

En esta sección se especifican los requisitos de los productos digitales de Pozzo a partir de la información obtenida en la investigación: las entrevistas a cabezas de junta y participantes, el análisis por segmento, los User Personas de Anna Weber y Sofia Gonzales, el User Task Matrix, los User Journey Maps, el Big Picture EventStorming y las feature assumptions e hipótesis del Lean UX Process. Para reducir la ambigüedad antes de redactar, el equipo construyó un prototipo navegable de la aplicación móvil con datos de ejemplo, recorrió con él los flujos de ambos roles y ajustó pantallas y reglas hasta obtener una versión acordada; las historias que siguen describen ese comportamiento.

La especificación cubre los tres productos del alcance: la aplicación móvil, los servicios RESTful de desarrollo propio y el sitio web estático del landing page. Se organiza en tres partes: las User Stories, agrupadas en Epics e incluyendo Technical Stories y Spike Stories; el Impact Map, que vincula los objetivos de negocio con las historias; y el Product Backlog, con la estimación y priorización de cada historia.

### 2.4.1. User Stories

Las historias se redactan desde la perspectiva de los dos actores del dominio identificados en los segmentos objetivo, la **cabeza de junta** (Organizer) y el **participante** (Member), y se usa **integrante** cuando la historia aplica a ambos por igual. Para el landing page el actor es el **visitante**, y para las Technical Stories y Spike Stories el rol **Developer**. Los términos siguen el Ubiquitous Language: junta, ciclo, período de aporte, turno, pozo, fecha de corte, comprobante, cobertura, deserción e historial de cumplimiento.

Los criterios de aceptación siguen la estructura Gherkin (Dado, Cuando, Entonces), se redactan en tiempo presente y tercera persona, no hacen referencia a detalles de interfaz de usuario y son comprobables. Cuando un criterio es una regla de negocio que no depende de una condición, se enuncia como tal. La prioridad refleja el valor para el negocio según las hipótesis del Lean UX Process: Alta para lo que sostiene la validación automática, la transparencia del pozo y la adopción; Media para lo que completa el ciclo; Baja para lo que amplía la propuesta.

#### Epics

<table>
  <colgroup><col style="width:10%"><col style="width:28%"><col style="width:62%"></colgroup>
  <thead><tr><th>Epic ID</th><th>Nombre</th><th>Descripción</th></tr></thead>
  <tbody>
    <tr><td>EP01</td><td>Acceso y cuenta</td><td>Ingreso a Pozzo con el número de celular verificado por SMS, sin contraseña, y administración del perfil.</td></tr>
    <tr><td>EP02</td><td>Configuración de la junta</td><td>Creación de la junta con sus reglas (aporte, periodicidad, integrantes, fecha de corte, destino de los aportes) y su inicio.</td></tr>
    <tr><td>EP03</td><td>Incorporación de integrantes</td><td>Invitación por código o enlace, ingreso del participante, integrantes sin la aplicación y administración de la lista antes de iniciar.</td></tr>
    <tr><td>EP04</td><td>Asignación de turnos</td><td>Reparto del orden de cobro por sorteo, orden acordado o subasta, y consulta del calendario de turnos.</td></tr>
    <tr><td>EP05</td><td>Registro y validación de aportes</td><td>Registro del aporte a partir del comprobante, lectura automática de sus datos, validación contra lo esperado, revisión de inconsistencias y aportes en efectivo.</td></tr>
    <tr><td>EP06</td><td>Transparencia del pozo</td><td>Estado del período vigente visible para todo el grupo: quién aportó, quién debe y cuánto falta.</td></tr>
    <tr><td>EP07</td><td>Recordatorios y avisos</td><td>Recordatorios automáticos escalonados a quien no ha aportado y avisos de los hechos relevantes de la junta.</td></tr>
    <tr><td>EP08</td><td>Entrega del pozo y cierre del ciclo</td><td>Entrega del pozo al integrante del turno, apertura del siguiente período, coberturas, deserciones y cierre de la junta.</td></tr>
    <tr><td>EP09</td><td>Historial de cumplimiento</td><td>Registro del comportamiento de pago de cada integrante a lo largo de sus juntas, consultable y compartible.</td></tr>
    <tr><td>EP10</td><td>Landing page</td><td>Sitio web estático que presenta el problema, la propuesta de valor y la vía de acceso a la aplicación.</td></tr>
    <tr><td>EP11</td><td>Servicios RESTful</td><td>Technical Stories de los servicios web que sostienen la aplicación móvil.</td></tr>
    <tr><td>EP12</td><td>Investigación técnica</td><td>Spike Stories para reducir la incertidumbre técnica antes de implementar.</td></tr>
  </tbody>
</table>

#### Historias de usuario

##### EP01 Acceso y cuenta

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US01</td><td>Integrante</td><td>Alta</td><td>EP01</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Ingresar con el número de celular</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como integrante de una junta, deseo ingresar a Pozzo con mi número de celular, para acceder sin crear ni recordar una contraseña.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Solicitud del código</strong><br>Dado que el integrante no tiene una sesión iniciada,<br>Cuando ingresa un número de celular peruano de nueve dígitos y solicita el código,<br>Entonces el sistema envía un código de verificación de seis dígitos por SMS a ese número y queda a la espera de su confirmación.<br><br><strong>Escenario 2: Número inválido</strong><br>Dado que el integrante no tiene una sesión iniciada,<br>Cuando ingresa un número que no tiene nueve dígitos o no comienza en 9,<br>Entonces el sistema no envía ningún código e indica que el número no es válido.<br><br><strong>Escenario 3: Reenvío</strong><br>Dado que el integrante solicitó un código hace menos de 30 segundos,<br>Cuando solicita un reenvío,<br>Entonces el sistema no envía un nuevo código hasta que transcurra el tiempo de espera.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US02</td><td>Integrante</td><td>Alta</td><td>EP01</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Verificar el código SMS</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como integrante, deseo confirmar el código que recibí por SMS, para demostrar que el número es mío y entrar a mis juntas.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Código correcto de un número registrado</strong><br>Dado que el número ya tiene una cuenta en Pozzo,<br>Cuando el integrante ingresa el código correcto dentro de los 10 minutos de vigencia,<br>Entonces el sistema inicia la sesión y muestra sus juntas.<br><br><strong>Escenario 2: Código correcto de un número nuevo</strong><br>Dado que el número no tiene una cuenta en Pozzo,<br>Cuando el integrante ingresa el código correcto,<br>Entonces el sistema le solicita completar su registro.<br><br><strong>Escenario 3: Código incorrecto o vencido</strong><br>Dado que el integrante recibió un código,<br>Cuando ingresa un código distinto o uno emitido hace más de 10 minutos,<br>Entonces el sistema rechaza el ingreso, informa el motivo y permite solicitar un nuevo código.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US03</td><td>Integrante</td><td>Alta</td><td>EP01</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Completar el registro</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como integrante nuevo, deseo registrarme solo con mi nombre y aceptar los términos, para empezar a usar Pozzo sin trámites.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Registro completo</strong><br>Dado que el integrante verificó un número nuevo,<br>Cuando ingresa su nombre y apellido y acepta los Términos y Condiciones y la Política de Privacidad,<br>Entonces el sistema crea la cuenta asociada al número verificado e inicia la sesión.<br><br><strong>Escenario 2: Términos no aceptados</strong><br>Dado que el integrante verificó un número nuevo,<br>Cuando intenta completar el registro sin aceptar los términos,<br>Entonces el sistema no crea la cuenta e indica que la aceptación es obligatoria.<br><br><strong>Escenario 3: Consulta de los términos</strong><br>Dado que el integrante está completando su registro,<br>Cuando solicita ver los Términos y Condiciones o la Política de Privacidad,<br>Entonces el sistema muestra el texto completo, que indica de forma explícita que Pozzo no recibe, retiene ni transfiere dinero.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US04</td><td>Integrante</td><td>Media</td><td>EP01</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Mantener la sesión en el dispositivo</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como integrante, deseo que mi sesión permanezca iniciada en mi teléfono, para no verificar mi número cada vez que abro Pozzo.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Sesión persistente</strong><br>Dado que el integrante inició sesión en un dispositivo,<br>Cuando vuelve a abrir la aplicación en ese mismo dispositivo,<br>Entonces el sistema lo reconoce sin solicitar un nuevo código.<br><br><strong>Escenario 2: Cierre de sesión</strong><br>Dado que el integrante tiene una sesión iniciada,<br>Cuando cierra la sesión,<br>Entonces el sistema elimina las credenciales guardadas en el dispositivo y solicita verificar el número en el siguiente ingreso.<br><br><strong>Escenario 3: Dispositivo nuevo</strong><br>Dado que el integrante inicia sesión en un segundo dispositivo,<br>Cuando verifica su número,<br>Entonces el sistema le muestra las mismas juntas e historial que en el primer dispositivo.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US05</td><td>Integrante</td><td>Media</td><td>EP01</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Administrar mi perfil</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como integrante, deseo mantener mi nombre, mi número de Yape o Plin y un correo de respaldo, para que mi grupo sepa a quién transferir y yo pueda recuperar mi cuenta.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Número para recibir aportes</strong><br>Dado que el integrante tiene una cuenta,<br>Cuando registra o modifica su número de Yape o Plin,<br>Entonces el sistema lo guarda y lo muestra a los integrantes de sus juntas cuando les corresponde transferirle.<br><br><strong>Escenario 2: Correo de respaldo</strong><br>Dado que el integrante registra un correo,<br>Cuando pierde acceso a su número de celular y solicita recuperar la cuenta,<br>Entonces el sistema le permite verificar su identidad por ese correo y asociar un número nuevo.<br><br><strong>Escenario 3: Cambio de número</strong><br>Dado que el integrante tiene una sesión iniciada,<br>Cuando solicita cambiar su número de celular e ingresa el código SMS enviado al número nuevo,<br>Entonces el sistema asocia la cuenta al número nuevo y conserva sus juntas e historial.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US06</td><td>Integrante</td><td>Baja</td><td>EP01</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Elegir el tema visual</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como integrante, deseo elegir entre el tema del sistema, claro u oscuro, para usar Pozzo con la apariencia que me resulte cómoda.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Tema del sistema</strong><br>Dado que el integrante no ha elegido un tema,<br>Cuando el sistema operativo cambia entre claro y oscuro,<br>Entonces la aplicación adopta la misma apariencia.<br><br><strong>Escenario 2: Preferencia manual</strong><br>Dado que el integrante elige claro u oscuro,<br>Cuando vuelve a abrir la aplicación,<br>Entonces el sistema mantiene la preferencia elegida con independencia del ajuste del sistema operativo.</td></tr>
  </tbody>
</table>

##### EP02 Configuración de la junta

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US07</td><td>Cabeza de junta</td><td>Alta</td><td>EP02</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Crear una junta</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo crear una junta definiendo el aporte, la periodicidad, el número de integrantes, el día de corte y la fecha del primer aporte, para reproducir en Pozzo las reglas que mi grupo ya acordó.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Creación con reglas completas</strong><br>Dado que la cabeza de junta tiene una sesión iniciada,<br>Cuando ingresa un nombre, un monto de aporte mayor a cero, una periodicidad semanal, quincenal o mensual, un número de integrantes entre 2 y 50, un día de corte y una fecha de inicio,<br>Entonces el sistema crea la junta en estado "por iniciar", la asigna a la cabeza como organizadora y primera integrante, y calcula el pozo por turno como el aporte multiplicado por el número de integrantes.<br><br><strong>Escenario 2: Datos incompletos</strong><br>Dado que la cabeza de junta está creando una junta,<br>Cuando omite el monto, la periodicidad o el número de integrantes,<br>Entonces el sistema no crea la junta e indica qué dato falta.<br><br><strong>Regla de negocio</strong><br>El número de turnos del ciclo es igual al número de integrantes: cada integrante cobra el pozo exactamente una vez por ciclo.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US08</td><td>Cabeza de junta</td><td>Alta</td><td>EP02</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Definir el destino de los aportes</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo indicar el número de Yape o Plin al que deben llegar los aportes, para que Pozzo valide los comprobantes contra ese destinatario y los participantes sepan a quién transferir.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Destino por defecto</strong><br>Dado que la cabeza de junta tiene un número de Yape o Plin en su perfil,<br>Cuando crea una junta,<br>Entonces el sistema propone ese número como destino de los aportes y permite cambiarlo.<br><br><strong>Escenario 2: Destino visible para el participante</strong><br>Dado que la junta tiene un destino definido,<br>Cuando un participante consulta cómo aportar,<br>Entonces el sistema le muestra el nombre y el número de destino registrados.<br><br><strong>Regla de negocio</strong><br>Pozzo no recibe, retiene ni transfiere dinero; el destino registrado es solo una referencia para la validación y para orientar al participante.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US09</td><td>Cabeza de junta</td><td>Media</td><td>EP02</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Consultar y ajustar las reglas de la junta</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo revisar y corregir las reglas de la junta antes de iniciarla, para que queden exactamente como las acordó el grupo.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Ajuste antes de iniciar</strong><br>Dado que la junta está en estado "por iniciar",<br>Cuando la cabeza modifica el aporte, la periodicidad, el número de integrantes o el día de corte,<br>Entonces el sistema guarda los cambios y recalcula el pozo por turno.<br><br><strong>Escenario 2: Reglas bloqueadas</strong><br>Dado que la junta ya fue iniciada,<br>Cuando la cabeza intenta modificar el aporte, la periodicidad o el número de integrantes,<br>Entonces el sistema no permite el cambio e indica que las reglas quedaron fijas al iniciar el ciclo.<br><br><strong>Escenario 3: Consulta por un participante</strong><br>Dado que un participante pertenece a la junta,<br>Cuando consulta la configuración,<br>Entonces el sistema le muestra todas las reglas en modo de solo lectura.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US10</td><td>Cabeza de junta</td><td>Alta</td><td>EP02</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Iniciar la junta</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo iniciar la junta cuando el grupo está completo y los turnos definidos, para abrir el primer período de aporte.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Inicio con grupo completo</strong><br>Dado que la junta tiene tantos integrantes como turnos y el método de asignación de turnos está confirmado,<br>Cuando la cabeza inicia la junta,<br>Entonces el sistema crea los períodos del ciclo con sus fechas de corte, abre el primer período, fija las reglas y avisa a todos los integrantes.<br><br><strong>Escenario 2: Grupo incompleto</strong><br>Dado que la junta tiene menos integrantes que turnos,<br>Cuando la cabeza intenta iniciarla,<br>Entonces el sistema no la inicia e indica cuántos integrantes faltan.<br><br><strong>Escenario 3: Turnos sin definir</strong><br>Dado que la junta tiene el grupo completo pero no se ha confirmado un método de asignación de turnos,<br>Cuando la cabeza intenta iniciarla,<br>Entonces el sistema no la inicia y solicita definir los turnos.</td></tr>
  </tbody>
</table>

##### EP03 Incorporación de integrantes

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US11</td><td>Cabeza de junta</td><td>Alta</td><td>EP03</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Invitar integrantes con código y enlace</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo obtener un código y un enlace de invitación y compartirlos por mensajería, para que mi grupo entre a la junta sin que yo registre a cada uno.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Código generado</strong><br>Dado que la cabeza creó una junta,<br>Cuando la creación se completa,<br>Entonces el sistema genera un código único de invitación y un enlace equivalente asociados a esa junta.<br><br><strong>Escenario 2: Compartir</strong><br>Dado que la junta tiene un código,<br>Cuando la cabeza elige compartirlo,<br>Entonces el sistema entrega a la aplicación de mensajería elegida un mensaje con el nombre de la junta, el aporte, la periodicidad, el número de integrantes, el código y el enlace.<br><br><strong>Escenario 3: Invitación vencida</strong><br>Dado que la junta ya fue iniciada,<br>Cuando alguien intenta unirse con el código,<br>Entonces el sistema rechaza el ingreso e indica que la junta ya no acepta integrantes.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US12</td><td>Participante</td><td>Alta</td><td>EP03</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Unirme a una junta con código o enlace</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como participante, deseo unirme a la junta con el código o el enlace que me compartió la cabeza, para quedar registrado sin configurar nada.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Ingreso por código</strong><br>Dado que el participante tiene una sesión iniciada,<br>Cuando ingresa un código vigente,<br>Entonces el sistema le muestra los datos de la junta para confirmar.<br><br><strong>Escenario 2: Ingreso por enlace</strong><br>Dado que el participante abre el enlace de invitación en su teléfono,<br>Cuando tiene Pozzo instalado,<br>Entonces la aplicación se abre directamente en la confirmación de esa junta; y cuando no lo tiene, el enlace lo dirige a la descarga y conserva la invitación para después de instalar.<br><br><strong>Escenario 3: Código inexistente</strong><br>Dado que el participante ingresa un código,<br>Cuando el código no corresponde a ninguna junta,<br>Entonces el sistema indica que no encontró la junta y permite intentar de nuevo.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US13</td><td>Participante</td><td>Media</td><td>EP03</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Revisar la junta antes de unirme</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como participante, deseo ver quién organiza, cuánto se aporta, con qué frecuencia y cuántos integrantes son, para decidir si entro.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Confirmación informada</strong><br>Dado que el participante ingresó un código válido,<br>Cuando revisa la junta,<br>Entonces el sistema le muestra el nombre de la cabeza, el aporte, la periodicidad, el número de integrantes, cuántos ya se unieron, el día de corte y el método de turnos, e indica que su historial de cumplimiento queda visible para la cabeza.<br><br><strong>Escenario 2: Unión confirmada</strong><br>Dado que el participante revisó la junta,<br>Cuando confirma que desea unirse,<br>Entonces el sistema lo agrega como integrante y avisa a la cabeza.<br><br><strong>Escenario 3: Junta llena</strong><br>Dado que la junta ya tiene tantos integrantes como turnos,<br>Cuando un participante intenta unirse,<br>Entonces el sistema no lo agrega e indica que la junta está completa.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US14</td><td>Cabeza de junta</td><td>Media</td><td>EP03</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Agregar un integrante sin la aplicación</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo registrar a un integrante que no instalará Pozzo o que aporta en efectivo, para que la junta refleje a todo el grupo aunque no todos usen la aplicación.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Registro con nombre</strong><br>Dado que la junta está por iniciar,<br>Cuando la cabeza ingresa el nombre de una persona y, opcionalmente, su celular,<br>Entonces el sistema la agrega como integrante marcada como "sin aplicación" y sus aportes solo pueden ser registrados por la cabeza.<br><br><strong>Escenario 2: Reclamo de cuenta</strong><br>Dado que un integrante sin aplicación fue registrado con su número de celular,<br>Cuando esa persona se registra en Pozzo con el mismo número,<br>Entonces el sistema vincula la cuenta nueva con el integrante existente y conserva sus aportes e historial.<br><br><strong>Regla de negocio</strong><br>Un integrante sin aplicación ocupa un turno como cualquier otro y aparece en el calendario y en el estado del pozo.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US15</td><td>Cabeza de junta</td><td>Media</td><td>EP03</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Retirar un integrante antes de iniciar</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo retirar a alguien que entró por error o que se arrepintió, para que el grupo quede correcto antes de asignar los turnos.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Retiro con posibilidad de deshacer</strong><br>Dado que la junta está por iniciar,<br>Cuando la cabeza retira a un integrante distinto de sí misma,<br>Entonces el sistema lo quita de la lista y ofrece deshacer la acción durante cinco segundos.<br><br><strong>Escenario 2: Retiro tras iniciar</strong><br>Dado que la junta ya fue iniciada,<br>Cuando la cabeza intenta retirar a un integrante,<br>Entonces el sistema no lo permite e indica que corresponde registrar una deserción.<br><br><strong>Regla de negocio</strong><br>La cabeza de junta no puede retirarse a sí misma de su propia junta.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US16</td><td>Integrante</td><td>Media</td><td>EP03</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Ver la lista de integrantes</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como integrante, deseo ver quiénes están en la junta, quién es la cabeza y quién usa Pozzo, para saber con quién comparto el ciclo.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Lista completa</strong><br>Dado que el integrante pertenece a la junta,<br>Cuando consulta los integrantes,<br>Entonces el sistema muestra a cada uno con su nombre, si es la cabeza, si usa la aplicación y, una vez asignados, su turno.<br><br><strong>Escenario 2: Avance de la convocatoria</strong><br>Dado que la junta está por iniciar,<br>Cuando el integrante consulta la lista,<br>Entonces el sistema indica cuántos integrantes hay y cuántos faltan para completar el grupo.</td></tr>
  </tbody>
</table>

##### EP04 Asignación de turnos

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US17</td><td>Cabeza de junta</td><td>Alta</td><td>EP04</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Asignar turnos por sorteo</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo sortear el orden de cobro entre todos los integrantes, para que el reparto sea al azar y nadie cuestione el resultado.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Sorteo</strong><br>Dado que la junta tiene el grupo completo y está por iniciar,<br>Cuando la cabeza elige el sorteo,<br>Entonces el sistema asigna a cada integrante un turno distinto entre 1 y el número de integrantes, de forma aleatoria.<br><br><strong>Escenario 2: Repetir el sorteo</strong><br>Dado que ya se realizó un sorteo y la junta no se ha iniciado,<br>Cuando la cabeza vuelve a sortear,<br>Entonces el sistema genera un nuevo orden y descarta el anterior.<br><br><strong>Escenario 3: Confirmación</strong><br>Dado que hay un orden sorteado,<br>Cuando la cabeza lo confirma e inicia la junta,<br>Entonces el sistema fija los turnos y comunica a cada integrante el suyo.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US18</td><td>Cabeza de junta</td><td>Alta</td><td>EP04</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Asignar turnos por orden acordado</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo ordenar los turnos según lo conversado con el grupo, para respetar la urgencia de cada integrante.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Orden manual</strong><br>Dado que la junta tiene el grupo completo y está por iniciar,<br>Cuando la cabeza elige el orden acordado y reordena a los integrantes,<br>Entonces el sistema asigna los turnos según esa posición.<br><br><strong>Escenario 2: Sin duplicados</strong><br>Dado que la cabeza está ordenando los turnos,<br>Cuando mueve a un integrante de posición,<br>Entonces el sistema reacomoda al resto de modo que ningún turno quede repetido ni vacío.<br><br><strong>Escenario 3: Intercambio posterior</strong><br>Dado que la junta ya fue iniciada,<br>Cuando la cabeza intercambia dos turnos cuyos períodos aún no han empezado,<br>Entonces el sistema actualiza el calendario y avisa a los dos integrantes afectados.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US19</td><td>Cabeza de junta</td><td>Media</td><td>EP04</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Configurar la junta por subasta</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo definir que cada turno se asigne por subasta, indicando cuándo cierra, la oferta mínima y qué pasa si nadie oferta, para reproducir el reparto que mi grupo practica.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Reglas de la subasta</strong><br>Dado que la junta está por iniciar,<br>Cuando la cabeza elige la subasta, define con cuántos días de anticipación al corte cierra cada subasta, la oferta mínima y el mecanismo de respaldo (sorteo o elección de la cabeza),<br>Entonces el sistema guarda esas reglas y no asigna turnos por adelantado.<br><br><strong>Escenario 2: Apertura de la primera subasta</strong><br>Dado que la junta se configuró por subasta,<br>Cuando la cabeza la inicia,<br>Entonces el sistema abre la subasta del primer período con su fecha de cierre y avisa a los integrantes.<br><br><strong>Regla de negocio</strong><br>Solo participan en la subasta los integrantes que aún no han cobrado un turno en el ciclo.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US20</td><td>Participante</td><td>Media</td><td>EP04</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Ofertar en la subasta del turno</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como participante que aún no ha cobrado, deseo ofrecer un descuento sobre el pozo para cobrar este turno, para acceder al dinero cuando lo necesito.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Oferta válida</strong><br>Dado que la subasta del período está abierta y el participante no ha cobrado en el ciclo,<br>Cuando registra una oferta igual o mayor a la oferta mínima,<br>Entonces el sistema la guarda, muestra cuánto recibiría (pozo menos su oferta) y le indica si su oferta es la mayor hasta el momento.<br><br><strong>Escenario 2: Mejorar la oferta</strong><br>Dado que el participante ya tiene una oferta registrada,<br>Cuando registra una mayor,<br>Entonces el sistema reemplaza la anterior y conserva solo la más reciente.<br><br><strong>Escenario 3: Oferta inferior al mínimo o participante que ya cobró</strong><br>Dado que la subasta está abierta,<br>Cuando un participante ofrece menos que el mínimo, o cuando quien ya cobró intenta ofertar,<br>Entonces el sistema rechaza la oferta e indica el motivo.<br><br><strong>Escenario 4: Transparencia de ofertas</strong><br>Dado que hay ofertas registradas,<br>Cuando cualquier integrante consulta la subasta,<br>Entonces el sistema muestra todas las ofertas ordenadas de mayor a menor con el nombre de quien las hizo.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US21</td><td>Cabeza de junta</td><td>Media</td><td>EP04</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Cerrar la subasta y asignar el turno</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo cerrar la subasta del período y asignar el turno a la mejor oferta, para que el grupo sepa quién cobra y cuánto.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Cierre con ofertas</strong><br>Dado que la subasta tiene al menos una oferta,<br>Cuando la cabeza la cierra o llega la fecha de cierre,<br>Entonces el sistema asigna el turno al integrante con la mayor oferta, registra que recibe el pozo menos su oferta y avisa a todos los integrantes.<br><br><strong>Escenario 2: Reparto del descuento</strong><br>Dado que se cerró una subasta con un descuento,<br>Cuando el sistema asigna el turno,<br>Entonces reparte el descuento en partes iguales entre los integrantes que aún no han cobrado y reduce en esa parte el aporte de cada uno en el siguiente período.<br><br><strong>Escenario 3: Sin ofertas</strong><br>Dado que la subasta no tiene ofertas al cierre,<br>Cuando se aplica el mecanismo de respaldo,<br>Entonces el sistema asigna el turno por sorteo entre quienes no han cobrado, o permite que la cabeza lo elija, sin descuento.<br><br><strong>Regla de negocio</strong><br>En caso de empate en la mayor oferta, gana la que se registró primero. El último integrante en cobrar recibe el pozo completo.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US22</td><td>Integrante</td><td>Alta</td><td>EP04</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Consultar el calendario de turnos</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como integrante, deseo ver el calendario completo del ciclo con quién cobra en cada período y cuándo, para saber cuándo me toca y planificar mi dinero.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Calendario asignado</strong><br>Dado que la junta fue iniciada con sorteo u orden acordado,<br>Cuando el integrante consulta el calendario,<br>Entonces el sistema muestra cada período con su número, mes, fecha de corte, quién cobra y su estado (cerrado, en curso o próximo), y destaca el turno del propio integrante.<br><br><strong>Escenario 2: Calendario por subasta</strong><br>Dado que la junta se asigna por subasta,<br>Cuando el integrante consulta el calendario,<br>Entonces los períodos ya cerrados muestran quién cobró y por cuánto, el período vigente indica que la subasta está abierta y los futuros aparecen como pendientes de subastar.<br><br><strong>Escenario 3: Fecha estimada de cobro</strong><br>Dado que el integrante tiene un turno asignado,<br>Cuando consulta su junta,<br>Entonces el sistema le indica el número de su turno, el mes en que cobra y el monto del pozo.</td></tr>
  </tbody>
</table>

##### EP05 Registro y validación de aportes

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US23</td><td>Participante</td><td>Alta</td><td>EP05</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Registrar mi aporte con el comprobante</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como participante, deseo registrar mi aporte tomando una foto del comprobante o eligiéndolo de mi galería, para que quede constancia sin reenviar capturas por el chat.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Comprobante desde la cámara</strong><br>Dado que el participante tiene un aporte pendiente en el período vigente,<br>Cuando elige tomar una foto y concede el permiso de cámara,<br>Entonces el sistema captura la imagen y la envía a la lectura automática de datos.<br><br><strong>Escenario 2: Comprobante desde la galería</strong><br>Dado que el participante tiene un aporte pendiente,<br>Cuando elige una imagen de su galería,<br>Entonces el sistema la toma sin solicitar permisos adicionales y la envía a la lectura automática.<br><br><strong>Escenario 3: Permiso denegado</strong><br>Dado que el participante deniega el permiso de cámara,<br>Cuando intenta registrar su aporte,<br>Entonces el sistema le ofrece elegir la imagen desde la galería y explica para qué necesita la cámara.<br><br><strong>Escenario 4: Sin aporte pendiente</strong><br>Dado que el aporte del participante en el período vigente ya está validado,<br>Cuando intenta registrar otro,<br>Entonces el sistema le informa que su aporte ya está registrado.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US24</td><td>Participante</td><td>Alta</td><td>EP05</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Revisar los datos leídos del comprobante</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como participante, deseo ver el monto, la fecha, el destinatario y el número de operación que Pozzo leyó de mi comprobante y corregirlos si hace falta, para que un error de lectura no se convierta en un aporte rechazado.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Lectura correcta</strong><br>Dado que el participante envió un comprobante legible,<br>Cuando el sistema termina la lectura,<br>Entonces muestra el monto, la fecha, el destinatario y el número de operación leídos, e indica para cada uno si coincide con lo esperado.<br><br><strong>Escenario 2: Corrección manual</strong><br>Dado que un dato leído es incorrecto,<br>Cuando el participante lo corrige y confirma,<br>Entonces el sistema valida el aporte con los datos corregidos y conserva la imagen original como evidencia.<br><br><strong>Escenario 3: Comprobante ilegible</strong><br>Dado que el sistema no logra leer los datos de la imagen,<br>Cuando termina el intento,<br>Entonces indica que no pudo leer el comprobante, permite ingresar los datos a mano o tomar otra foto, y el aporte queda pendiente de revisión de la cabeza si se ingresa a mano.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US25</td><td>Participante</td><td>Alta</td><td>EP05</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Validación automática del aporte</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como participante, deseo que mi aporte quede validado al instante cuando el comprobante coincide con lo esperado, para no depender de que la cabeza lo revise a mano.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Coincidencia total</strong><br>Dado que el participante confirmó los datos de su comprobante,<br>Cuando el monto es igual al aporte esperado para ese integrante, el destinatario es el registrado en la junta, la fecha está dentro del período vigente y el número de operación no fue usado antes,<br>Entonces el sistema marca el aporte como validado, lo suma al pozo del período, guarda el comprobante y avisa a la cabeza y al participante.<br><br><strong>Escenario 2: Inconsistencia</strong><br>Dado que el participante confirmó los datos,<br>Cuando alguno no coincide con lo esperado,<br>Entonces el sistema marca el aporte como pendiente de revisión, indica cuál dato no coincide y avisa a la cabeza.<br><br><strong>Escenario 3: Número de operación repetido</strong><br>Dado que ya existe un aporte con el mismo número de operación en la junta,<br>Cuando el participante intenta registrar el comprobante,<br>Entonces el sistema rechaza el registro e indica que el comprobante ya fue usado.<br><br><strong>Regla de negocio</strong><br>El aporte esperado de un integrante en un período es el aporte de la junta menos el descuento que le corresponda por una subasta anterior; para juntas sin subasta es siempre el aporte de la junta.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US26</td><td>Cabeza de junta</td><td>Alta</td><td>EP05</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Revisar un aporte con inconsistencia</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo ver el comprobante y los datos leídos de un aporte que no coincidió, para aprobarlo o rechazarlo con conocimiento en lugar de revisar todos uno por uno.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Aprobación</strong><br>Dado que un aporte está pendiente de revisión,<br>Cuando la cabeza revisa el comprobante, los datos leídos y el dato que no coincide, y lo aprueba,<br>Entonces el sistema marca el aporte como validado, lo suma al pozo y avisa al participante.<br><br><strong>Escenario 2: Rechazo</strong><br>Dado que un aporte está pendiente de revisión,<br>Cuando la cabeza lo rechaza y confirma la acción,<br>Entonces el sistema devuelve el aporte a pendiente, descarta el comprobante como validación y avisa al participante para que registre uno nuevo.<br><br><strong>Escenario 3: Pendientes visibles</strong><br>Dado que hay aportes pendientes de revisión en el período vigente,<br>Cuando la cabeza consulta la junta,<br>Entonces el sistema le indica cuántos hay y le permite ir directamente a revisarlos.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US27</td><td>Cabeza de junta</td><td>Alta</td><td>EP05</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Registrar un aporte en efectivo</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo registrar el aporte de quien me entregó el dinero en efectivo, para que el pozo refleje todos los aportes y no solo los que llegaron por billetera.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Registro en efectivo</strong><br>Dado que un integrante tiene su aporte pendiente en el período vigente,<br>Cuando la cabeza registra que recibió el aporte en efectivo, con el monto y la fecha,<br>Entonces el sistema marca el aporte como registrado en efectivo, lo suma al pozo y avisa al integrante si usa la aplicación.<br><br><strong>Escenario 2: Monto distinto</strong><br>Dado que la cabeza registra un aporte en efectivo,<br>Cuando el monto es distinto del aporte esperado,<br>Entonces el sistema solicita confirmar la diferencia antes de registrarlo.<br><br><strong>Regla de negocio</strong><br>Un aporte en efectivo se distingue de uno validado por comprobante en el estado del pozo y en el historial de cumplimiento.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US28</td><td>Participante</td><td>Alta</td><td>EP05</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Consultar mis aportes y sus comprobantes</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como participante, deseo ver todos mis aportes de la junta con su estado y su comprobante, para demostrar que pagué cuando alguien lo cuestiona.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Lista de aportes</strong><br>Dado que el participante pertenece a una junta iniciada,<br>Cuando consulta sus aportes,<br>Entonces el sistema muestra un registro por período con su estado (validado, en efectivo, en revisión, pendiente o atrasado), la fecha y el número de operación cuando existe.<br><br><strong>Escenario 2: Detalle del comprobante</strong><br>Dado que un aporte fue validado con comprobante,<br>Cuando el participante lo abre,<br>Entonces el sistema muestra la imagen del comprobante y los datos verificados con el resultado de cada verificación.<br><br><strong>Escenario 3: Compartir el comprobante</strong><br>Dado que el participante está viendo un aporte validado,<br>Cuando elige compartirlo,<br>Entonces el sistema entrega a la aplicación elegida un resumen del aporte con un enlace verificable al registro.</td></tr>
  </tbody>
</table>

##### EP06 Transparencia del pozo

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US29</td><td>Integrante</td><td>Alta</td><td>EP06</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Ver el estado del pozo del período vigente</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como integrante, deseo ver cuánto se ha reunido, cuánto falta, quién ya aportó y quién debe, para tener la misma información que la cabeza sin preguntar en el chat.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Estado del pozo</strong><br>Dado que la junta está iniciada,<br>Cuando el integrante consulta la junta,<br>Entonces el sistema muestra el monto reunido, el monto total del pozo, el número del turno, el mes, la fecha de corte, quién cobra y la lista de integrantes con el estado de su aporte.<br><br><strong>Escenario 2: Actualización inmediata</strong><br>Dado que un aporte cambia de estado,<br>Cuando cualquier integrante consulta la junta,<br>Entonces el sistema refleja el nuevo estado sin que el integrante deba hacer nada adicional.<br><br><strong>Escenario 3: Misma información para todos</strong><br>Dado que dos integrantes consultan la junta en el mismo momento,<br>Cuando comparan lo que ven,<br>Entonces ambos observan los mismos estados y montos.<br><br><strong>Regla de negocio</strong><br>El monto reunido suma solo los aportes validados y los registrados en efectivo; los aportes en revisión o pendientes no cuentan.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US30</td><td>Participante</td><td>Media</td><td>EP06</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Saber si mi pozo estará completo</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como participante al que le toca cobrar, deseo ver cuánto falta para completar mi pozo y quiénes no han aportado, para anticipar si cobraré a tiempo.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Indicador para quien cobra</strong><br>Dado que el participante es quien cobra en el período vigente,<br>Cuando consulta la junta,<br>Entonces el sistema le indica de forma destacada que es su turno de cobro, el monto que recibe y cuánto falta por reunir.<br><br><strong>Escenario 2: Pozo completo</strong><br>Dado que todos los aportes del período están validados o en efectivo,<br>Cuando quien cobra consulta la junta,<br>Entonces el sistema le informa que el pozo está completo y a la espera de la entrega por parte de la cabeza.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US31</td><td>Integrante</td><td>Media</td><td>EP06</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Consultar la junta sin conexión</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como integrante, deseo ver el último estado de mi junta, mi calendario y mis comprobantes aunque no tenga señal, para no depender de la conexión al momento de defender un aporte.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Datos guardados en el dispositivo</strong><br>Dado que el integrante consultó su junta con conexión,<br>Cuando la abre sin conexión,<br>Entonces el sistema muestra el último estado guardado, el calendario y sus propios comprobantes, e indica la fecha y hora de la última actualización.<br><br><strong>Escenario 2: Acciones que requieren conexión</strong><br>Dado que el integrante está sin conexión,<br>Cuando intenta registrar un aporte u ofertar,<br>Entonces el sistema le informa que necesita conexión para completar la acción y conserva lo ingresado para reintentarlo.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US32</td><td>Integrante</td><td>Baja</td><td>EP06</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Consultar períodos anteriores</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como integrante, deseo revisar los períodos ya cerrados de la junta, para reconstruir qué pasó en un turno pasado.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Historial del ciclo</strong><br>Dado que la junta tiene períodos cerrados,<br>Cuando el integrante consulta uno de ellos,<br>Entonces el sistema muestra quién cobró, el monto entregado, la fecha de entrega y el estado final del aporte de cada integrante en ese período.</td></tr>
  </tbody>
</table>

##### EP07 Recordatorios y avisos

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US33</td><td>Participante</td><td>Alta</td><td>EP07</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Recibir recordatorios escalonados de mi aporte</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como participante, deseo recibir recordatorios automáticos que aumenten su frecuencia conforme se acerca la fecha de corte, para no atrasarme sin que la cabeza tenga que escribirme.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Cadencia antes del corte</strong><br>Dado que el participante tiene su aporte pendiente,<br>Cuando faltan tres días, un día y llega el día de corte,<br>Entonces el sistema le envía una notificación en cada uno de esos momentos con el monto, la junta y la fecha límite.<br><br><strong>Escenario 2: Atraso</strong><br>Dado que pasó la fecha de corte y el aporte sigue pendiente,<br>Cuando transcurre cada día adicional,<br>Entonces el sistema envía un recordatorio diario y marca el aporte como atrasado, visible para la cabeza y el grupo.<br><br><strong>Escenario 3: Detención al aportar</strong><br>Dado que el participante recibía recordatorios,<br>Cuando su aporte queda validado o registrado en efectivo,<br>Entonces el sistema deja de enviarle recordatorios de ese período.<br><br><strong>Regla de negocio</strong><br>Los recordatorios los envía el sistema en nombre de la junta, no de la cabeza, y su texto es idéntico para todos los integrantes.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US34</td><td>Cabeza de junta</td><td>Media</td><td>EP07</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Configurar los recordatorios de la junta</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo activar o desactivar los recordatorios automáticos y ver su cadencia, para ajustarlos a la costumbre del grupo.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Consulta de la cadencia</strong><br>Dado que la junta está iniciada,<br>Cuando la cabeza consulta la configuración,<br>Entonces el sistema muestra si los recordatorios están activos y los momentos en que se envían.<br><br><strong>Escenario 2: Desactivación</strong><br>Dado que los recordatorios están activos,<br>Cuando la cabeza los desactiva,<br>Entonces el sistema deja de enviarlos a todos los integrantes de esa junta a partir de ese momento y lo indica en el estado de la junta.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US35</td><td>Integrante</td><td>Media</td><td>EP07</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Recibir avisos de los hechos de la junta</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como integrante, deseo recibir un aviso cuando ocurre algo relevante en mi junta, para enterarme sin revisar la aplicación.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Avisos a la cabeza</strong><br>Dado que la cabeza tiene la aplicación,<br>Cuando un aporte queda validado, queda pendiente de revisión o el pozo se completa,<br>Entonces el sistema le envía una notificación con el integrante y el monto involucrados.<br><br><strong>Escenario 2: Avisos al participante</strong><br>Dado que el participante tiene la aplicación,<br>Cuando se confirman los turnos, su aporte es aprobado o rechazado, se cierra una subasta o se entrega el pozo,<br>Entonces el sistema le envía una notificación que describe el hecho.<br><br><strong>Escenario 3: Centro de avisos</strong><br>Dado que el integrante recibió avisos,<br>Cuando los consulta dentro de la aplicación,<br>Entonces el sistema los muestra ordenados del más reciente al más antiguo, con la junta y la fecha de cada uno.<br><br><strong>Regla de negocio</strong><br>Los recordatorios de aporte y los avisos de la junta se envían por canales de notificación separados, para que el integrante pueda silenciar unos sin perder los otros.</td></tr>
  </tbody>
</table>

##### EP08 Entrega del pozo y cierre del ciclo

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US36</td><td>Cabeza de junta</td><td>Alta</td><td>EP08</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Entregar el pozo y abrir el siguiente turno</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo registrar que entregué el pozo al integrante del turno, para cerrar el período y que el siguiente empiece con todos avisados.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Entrega con pozo completo</strong><br>Dado que todos los aportes del período están validados o en efectivo y el turno tiene un integrante asignado,<br>Cuando la cabeza marca el pozo como entregado, con la opción de adjuntar el comprobante de la transferencia,<br>Entonces el sistema cierra el período, registra la fecha y el monto entregado, abre el siguiente período con todos los aportes en pendiente y avisa a todos los integrantes.<br><br><strong>Escenario 2: Pozo incompleto</strong><br>Dado que hay aportes pendientes o en revisión,<br>Cuando la cabeza intenta marcar el pozo como entregado,<br>Entonces el sistema no cierra el período e indica qué aportes faltan.<br><br><strong>Escenario 3: Monto con descuento de subasta</strong><br>Dado que el turno se asignó por subasta con un descuento,<br>Cuando la cabeza registra la entrega,<br>Entonces el sistema muestra como monto a entregar el pozo menos el descuento ofrecido por quien cobra.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US37</td><td>Cabeza de junta</td><td>Media</td><td>EP08</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Registrar la cobertura de un aporte</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo registrar que yo u otro integrante cubrió el aporte de alguien que no pagó, para que el pozo se complete y quede constancia de quién puso el dinero y quién lo debe.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Cobertura registrada</strong><br>Dado que un aporte está atrasado,<br>Cuando la cabeza registra quién lo cubre y por cuánto,<br>Entonces el sistema suma el monto al pozo, marca el aporte como cubierto, registra la deuda del integrante moroso con quien lo cubrió y avisa a ambos.<br><br><strong>Escenario 2: Efecto en el historial</strong><br>Dado que un aporte fue cubierto,<br>Cuando se consulta el historial de cumplimiento del integrante moroso,<br>Entonces el sistema muestra ese aporte como cubierto por un tercero y no como puntual.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US38</td><td>Cabeza de junta</td><td>Baja</td><td>EP08</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Registrar una deserción y su reemplazo</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo registrar que un integrante abandonó la junta a mitad del ciclo y, si el grupo lo acuerda, quién ocupa su lugar, para que el ciclo pueda continuar.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Deserción</strong><br>Dado que la junta está iniciada,<br>Cuando la cabeza registra la deserción de un integrante,<br>Entonces el sistema lo marca como desertor, conserva sus aportes y cobros previos, lo registra en su historial de cumplimiento y avisa al grupo.<br><br><strong>Escenario 2: Reemplazo</strong><br>Dado que un integrante desertó,<br>Cuando la cabeza asigna un reemplazo con código de invitación o como integrante sin aplicación,<br>Entonces el sistema le asigna el turno del desertor y los aportes pendientes desde ese período.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US39</td><td>Cabeza de junta</td><td>Alta</td><td>EP08</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Cerrar la junta al completar el ciclo</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo que la junta se cierre cuando se entrega el último pozo, para tener el resumen del ciclo y poder abrir uno nuevo con el mismo grupo.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Cierre del ciclo</strong><br>Dado que se entregó el pozo del último turno,<br>Cuando el sistema registra la entrega,<br>Entonces marca la junta como completada, actualiza el historial de cumplimiento de todos los integrantes y muestra un resumen con los turnos, los pozos completos y los atrasos del ciclo.<br><br><strong>Escenario 2: Nuevo ciclo con el mismo grupo</strong><br>Dado que la junta está completada,<br>Cuando la cabeza elige abrir un nuevo ciclo,<br>Entonces el sistema crea una junta nueva con las mismas reglas e integrantes, en estado por iniciar, y permite ajustarla antes de asignar los turnos.<br><br><strong>Regla de negocio</strong><br>Una junta completada no admite cambios; sus registros permanecen consultables para todos sus integrantes.</td></tr>
  </tbody>
</table>

##### EP09 Historial de cumplimiento

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US40</td><td>Participante</td><td>Alta</td><td>EP09</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Consultar mi historial de cumplimiento</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como participante, deseo ver mi historial de aportes puntuales, atrasados y cubiertos a lo largo de mis juntas, para saber cómo me ven y acreditar mi cumplimiento.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Resumen</strong><br>Dado que el participante ha aportado en al menos una junta,<br>Cuando consulta su historial,<br>Entonces el sistema muestra el número de juntas completadas, el porcentaje de aportes puntuales y los totales de aportes a tiempo, atrasados y cubiertos.<br><br><strong>Escenario 2: Detalle por junta</strong><br>Dado que el participante consulta su historial,<br>Cuando lo revisa por junta,<br>Entonces el sistema muestra cada junta con su período, sus aportes puntuales y atrasados y si el ciclo se completó, está en curso o el participante desertó.<br><br><strong>Regla de negocio</strong><br>Un aporte cuenta como puntual si queda validado o en efectivo hasta la fecha de corte del período; después de esa fecha cuenta como atrasado aunque se complete.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US41</td><td>Participante</td><td>Baja</td><td>EP09</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Compartir mi historial</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como participante, deseo compartir un resumen verificable de mi historial, para que me acepten en una junta nueva sin depender de la palabra de un tercero.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Compartir</strong><br>Dado que el participante tiene historial,<br>Cuando elige compartirlo,<br>Entonces el sistema entrega a la aplicación elegida un resumen con su nombre, juntas completadas y porcentaje de puntualidad, junto con un enlace verificable.<br><br><strong>Escenario 2: Verificación por un tercero</strong><br>Dado que alguien abre el enlace compartido,<br>Cuando lo consulta,<br>Entonces el sistema muestra el resumen del historial sin exponer los montos ni las juntas concretas del participante.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US42</td><td>Cabeza de junta</td><td>Media</td><td>EP09</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Ver el historial de quien se une a mi junta</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como cabeza de junta, deseo ver el historial de cumplimiento de quien entra a mi junta, para decidir con información si lo acepto, sobre todo en juntas de mayor monto.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Historial visible al unirse</strong><br>Dado que un participante se unió a la junta con código,<br>Cuando la cabeza consulta la lista de integrantes,<br>Entonces el sistema le muestra el resumen del historial de ese participante en Pozzo.<br><br><strong>Escenario 2: Participante sin historial</strong><br>Dado que el participante nunca ha completado un período en Pozzo,<br>Cuando la cabeza consulta su historial,<br>Entonces el sistema indica que aún no tiene registros, sin calificarlo de forma negativa.</td></tr>
  </tbody>
</table>

##### EP10 Landing page

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US43</td><td>Visitante</td><td>Alta</td><td>EP10</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Entender qué resuelve Pozzo</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como visitante del landing page, deseo entender en pocos segundos qué problema resuelve Pozzo y cómo, para decidir si me interesa para mi junta.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Propuesta de valor</strong><br>Dado que el visitante llega al landing page,<br>Cuando lee la primera sección,<br>Entonces encuentra el nombre del producto, una frase que describe el problema de administrar la junta a mano y una que describe la solución, junto con la aclaración de que Pozzo no maneja el dinero.<br><br><strong>Escenario 2: Funcionalidades</strong><br>Dado que el visitante avanza,<br>Cuando llega a la sección de funcionalidades,<br>Entonces encuentra descritas la validación de comprobantes, el estado del pozo en tiempo real, los recordatorios automáticos, los turnos por sorteo, orden acordado o subasta y el historial de cumplimiento, cada una con una imagen de la aplicación.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US44</td><td>Visitante</td><td>Alta</td><td>EP10</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Acceder a la aplicación desde el landing page</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como visitante, deseo encontrar cómo obtener la aplicación o dejar mi contacto, para empezar a usar Pozzo con mi grupo.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Llamada a la acción</strong><br>Dado que el visitante está en cualquier sección,<br>Cuando busca cómo empezar,<br>Entonces encuentra una llamada a la acción visible que lo lleva a la descarga de la aplicación o al registro de interés.<br><br><strong>Escenario 2: Registro de interés</strong><br>Dado que la aplicación aún no está publicada,<br>Cuando el visitante deja su nombre y correo o celular,<br>Entonces el sistema confirma el registro y le informa que recibe un aviso cuando la aplicación esté disponible.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US45</td><td>Visitante</td><td>Media</td><td>EP10</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Conocer al equipo y contactarlo</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como visitante, deseo saber quiénes están detrás de Pozzo y cómo contactarlos, para confiar en el producto antes de proponerlo a mi grupo.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Equipo</strong><br>Dado que el visitante llega a la sección del equipo,<br>Cuando la lee,<br>Entonces encuentra el nombre de la startup, su misión y a cada integrante con su nombre y rol.<br><br><strong>Escenario 2: Contacto</strong><br>Dado que el visitante desea comunicarse,<br>Cuando llega a la sección de contacto,<br>Entonces encuentra un correo de contacto y los enlaces a las redes de la startup.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>US46</td><td>Visitante</td><td>Media</td><td>EP10</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Navegar el landing page desde el celular</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como visitante que abre el enlace desde WhatsApp en su celular, deseo que el landing page se lea y navegue bien en pantalla pequeña, para no abandonarlo antes de entender la propuesta.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Diseño adaptable</strong><br>Dado que el visitante abre el landing page en una ventana de 360 píxeles de ancho o más,<br>Cuando lo recorre,<br>Entonces todo el contenido se lee sin desplazamiento horizontal y las llamadas a la acción se alcanzan con una mano.<br><br><strong>Escenario 2: Navegación entre secciones</strong><br>Dado que el visitante está en el landing page,<br>Cuando elige una sección,<br>Entonces el sistema lo lleva a esa sección y la navegación permanece disponible desde cualquier punto de la página.</td></tr>
  </tbody>
</table>

#### Technical Stories

Las Technical Stories describen los servicios RESTful de desarrollo propio que sostienen la aplicación móvil. Se redactan desde el rol Developer y sus criterios de aceptación son escenarios de solicitud y respuesta.

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>TS01</td><td>Developer</td><td>Alta</td><td>EP11</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Servicio de autenticación por SMS</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como desarrollador, deseo contar con endpoints para solicitar y verificar códigos SMS y emitir tokens de sesión, para que la aplicación móvil autentique a los integrantes sin contraseña.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Solicitud de código</strong><br>Dado un número de celular válido,<br>Cuando el cliente envía POST /api/v1/auth/otp con el número,<br>Entonces el servicio responde 202 Accepted, envía el código por el proveedor de SMS y guarda su vencimiento a 10 minutos.<br><br><strong>Escenario 2: Verificación correcta</strong><br>Dado un código vigente,<br>Cuando el cliente envía POST /api/v1/auth/otp/verify con el número y el código,<br>Entonces el servicio responde 200 OK con un token de acceso, un token de renovación y un indicador de si la cuenta es nueva.<br><br><strong>Escenario 3: Código incorrecto o vencido</strong><br>Dado un código incorrecto o vencido,<br>Cuando el cliente lo envía a verificar,<br>Entonces el servicio responde 401 Unauthorized con un mensaje que distingue ambos casos, y tras cinco intentos fallidos bloquea el número durante 15 minutos con 429 Too Many Requests.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>TS02</td><td>Developer</td><td>Alta</td><td>EP11</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Servicio de juntas</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como desarrollador, deseo contar con endpoints para crear, consultar, actualizar e iniciar juntas, para que la aplicación móvil administre el ciclo de vida de cada junta.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Creación</strong><br>Dado un usuario autenticado,<br>Cuando envía POST /api/v1/savings-groups con nombre, aporte, periodicidad, número de integrantes, día de corte, fecha de inicio y destino de los aportes,<br>Entonces el servicio responde 201 Created con la junta en estado DRAFT, su código de invitación y al usuario como organizador.<br><br><strong>Escenario 2: Consulta de las juntas del usuario</strong><br>Dado un usuario autenticado,<br>Cuando envía GET /api/v1/savings-groups,<br>Entonces el servicio responde 200 OK con las juntas en las que participa, su rol en cada una, el período vigente y el estado de su aporte.<br><br><strong>Escenario 3: Inicio</strong><br>Dado una junta en estado DRAFT con el grupo completo y turnos confirmados,<br>Cuando el organizador envía POST /api/v1/savings-groups/{id}/start,<br>Entonces el servicio responde 200 OK con la junta en estado ACTIVE y sus períodos generados; y cuando falta algún requisito responde 409 Conflict indicando cuál.<br><br><strong>Escenario 4: Actualización bloqueada</strong><br>Dado una junta ACTIVE,<br>Cuando el organizador envía PUT /api/v1/savings-groups/{id} modificando aporte, periodicidad o número de integrantes,<br>Entonces el servicio responde 409 Conflict.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>TS03</td><td>Developer</td><td>Alta</td><td>EP11</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Servicio de integrantes e invitaciones</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como desarrollador, deseo contar con endpoints para resolver un código de invitación, unir a un usuario a una junta y administrar sus integrantes, para que la incorporación funcione por código, enlace y registro manual.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Resolver invitación</strong><br>Dado un código de invitación,<br>Cuando el cliente envía GET /api/v1/invitations/{code},<br>Entonces el servicio responde 200 OK con el resumen de la junta si está en DRAFT, o 410 Gone si ya fue iniciada o no existe.<br><br><strong>Escenario 2: Unirse</strong><br>Dado un usuario autenticado y una junta en DRAFT con cupo,<br>Cuando envía POST /api/v1/savings-groups/{id}/members,<br>Entonces el servicio responde 201 Created con el integrante; y cuando la junta está llena responde 409 Conflict.<br><br><strong>Escenario 3: Integrante sin aplicación</strong><br>Dado el organizador de una junta en DRAFT,<br>Cuando envía POST /api/v1/savings-groups/{id}/members con nombre y celular opcional y sin usuario asociado,<br>Entonces el servicio responde 201 Created con el integrante marcado como OFFLINE.<br><br><strong>Escenario 4: Retiro</strong><br>Dado el organizador de una junta en DRAFT,<br>Cuando envía DELETE /api/v1/savings-groups/{id}/members/{memberId} para un integrante distinto de sí mismo,<br>Entonces el servicio responde 204 No Content; y cuando la junta está ACTIVE responde 409 Conflict.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>TS04</td><td>Developer</td><td>Media</td><td>EP11</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Servicio de turnos y subastas</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como desarrollador, deseo contar con endpoints para asignar turnos por sorteo u orden acordado, y para registrar y cerrar subastas, para que la aplicación móvil soporte los tres métodos de reparto.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Asignación por sorteo u orden</strong><br>Dado el organizador de una junta en DRAFT,<br>Cuando envía PUT /api/v1/savings-groups/{id}/turns con el método DRAW, o con el método AGREED y la lista ordenada de integrantes,<br>Entonces el servicio responde 200 OK con el turno de cada integrante, sin repeticiones.<br><br><strong>Escenario 2: Oferta en subasta</strong><br>Dado un integrante que no ha cobrado y una subasta OPEN,<br>Cuando envía POST /api/v1/savings-groups/{id}/periods/{n}/bids con un monto igual o mayor al mínimo,<br>Entonces el servicio responde 201 Created reemplazando cualquier oferta previa del mismo integrante; y responde 422 Unprocessable Entity si el monto es menor al mínimo o 403 Forbidden si el integrante ya cobró.<br><br><strong>Escenario 3: Cierre</strong><br>Dado el organizador y una subasta OPEN con ofertas,<br>Cuando envía POST /api/v1/savings-groups/{id}/periods/{n}/close-auction,<br>Entonces el servicio responde 200 OK con el ganador, el monto a recibir y el crédito aplicado a cada integrante que aún no cobra; y sin ofertas aplica el mecanismo de respaldo configurado.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>TS05</td><td>Developer</td><td>Alta</td><td>EP11</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Servicio de aportes y comprobantes</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como desarrollador, deseo contar con endpoints para registrar un aporte con su comprobante, validarlo contra lo esperado, revisarlo y registrar aportes en efectivo, para que el estado del pozo se calcule en el servidor.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Registro con comprobante</strong><br>Dado un integrante con aporte pendiente,<br>Cuando envía POST /api/v1/savings-groups/{id}/periods/{n}/contributions con la imagen del comprobante y los datos confirmados (monto, fecha, destinatario, número de operación),<br>Entonces el servicio guarda la imagen, compara los datos con los esperados y responde 201 Created con el estado VALIDATED o IN_REVIEW y la lista de verificaciones con su resultado.<br><br><strong>Escenario 2: Comprobante duplicado</strong><br>Dado un número de operación ya registrado en la junta,<br>Cuando un integrante lo envía,<br>Entonces el servicio responde 409 Conflict.<br><br><strong>Escenario 3: Revisión</strong><br>Dado el organizador y un aporte IN_REVIEW,<br>Cuando envía POST /api/v1/contributions/{id}/approve o /reject,<br>Entonces el servicio responde 200 OK con el aporte en VALIDATED o PENDING respectivamente.<br><br><strong>Escenario 4: Efectivo</strong><br>Dado el organizador,<br>Cuando envía POST /api/v1/savings-groups/{id}/periods/{n}/contributions con el integrante, el monto y la fecha y sin comprobante,<br>Entonces el servicio responde 201 Created con el estado CASH.<br><br><strong>Escenario 5: Estado del período</strong><br>Dado cualquier integrante,<br>Cuando envía GET /api/v1/savings-groups/{id}/periods/{n},<br>Entonces el servicio responde 200 OK con el monto reunido, el total, quién cobra y el estado del aporte de cada integrante.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>TS06</td><td>Developer</td><td>Alta</td><td>EP11</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Servicio de entrega del pozo y cierre</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como desarrollador, deseo contar con endpoints para registrar la entrega del pozo, coberturas, deserciones y el cierre del ciclo, para que el avance de la junta quede registrado de forma consistente.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Entrega</strong><br>Dado el organizador y un período con todos los aportes VALIDATED o CASH y receptor asignado,<br>Cuando envía POST /api/v1/savings-groups/{id}/periods/{n}/payout con el comprobante opcional,<br>Entonces el servicio responde 200 OK, marca el período CLOSED, abre el siguiente y, si era el último, marca la junta COMPLETED.<br><br><strong>Escenario 2: Entrega prematura</strong><br>Dado un período con aportes pendientes,<br>Cuando el organizador intenta la entrega,<br>Entonces el servicio responde 409 Conflict con la lista de aportes que faltan.<br><br><strong>Escenario 3: Cobertura y deserción</strong><br>Dado el organizador,<br>Cuando envía POST /api/v1/contributions/{id}/coverage con quién cubre y el monto, o POST /api/v1/savings-groups/{id}/members/{memberId}/dropout,<br>Entonces el servicio responde 200 OK y refleja el cambio en el período y en el historial de cumplimiento.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>TS07</td><td>Developer</td><td>Media</td><td>EP11</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Servicio de recordatorios y notificaciones</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como desarrollador, deseo contar con el registro de dispositivos y un programador de recordatorios en el servidor, para que las notificaciones se envíen aunque la aplicación esté cerrada.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Registro de dispositivo</strong><br>Dado un usuario autenticado,<br>Cuando envía POST /api/v1/devices con el token de notificaciones de su dispositivo,<br>Entonces el servicio responde 201 Created y asocia el token al usuario.<br><br><strong>Escenario 2: Programación</strong><br>Dado un período abierto,<br>Cuando el programador se ejecuta,<br>Entonces envía a cada integrante con aporte pendiente el recordatorio que corresponda a tres días antes, un día antes, el día de corte o cada día de atraso, y no envía nada a quien ya aportó ni a juntas con recordatorios desactivados.<br><br><strong>Escenario 3: Avisos por evento</strong><br>Dado que ocurre un aporte validado, un aporte en revisión, un pozo completo, un cierre de subasta o una entrega,<br>Cuando el servicio registra el evento,<br>Entonces envía la notificación a los destinatarios definidos para ese evento por el canal correspondiente y la guarda en su lista de avisos.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>TS08</td><td>Developer</td><td>Media</td><td>EP11</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Servicio de historial de cumplimiento</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como desarrollador, deseo contar con un endpoint que calcule el historial de cumplimiento de un integrante a partir de sus aportes, para que la aplicación lo muestre y lo comparta de forma verificable.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Historial propio</strong><br>Dado un usuario autenticado,<br>Cuando envía GET /api/v1/members/me/compliance-history,<br>Entonces el servicio responde 200 OK con juntas completadas, aportes puntuales, atrasados y cubiertos, y el detalle por junta.<br><br><strong>Escenario 2: Historial de otro integrante</strong><br>Dado el organizador de una junta,<br>Cuando envía GET /api/v1/members/{id}/compliance-history para un integrante de su junta,<br>Entonces el servicio responde 200 OK con el resumen; y para un usuario ajeno a sus juntas responde 403 Forbidden.<br><br><strong>Escenario 3: Enlace público</strong><br>Dado un enlace de historial compartido,<br>Cuando cualquiera envía GET /api/v1/compliance-history/shared/{token},<br>Entonces el servicio responde 200 OK con el resumen sin montos ni nombres de juntas.</td></tr>
  </tbody>
</table>

#### Spike Stories

Las Spike Stories cubren la investigación necesaria antes de implementar las historias con mayor incertidumbre técnica. La primera corresponde al feature de aprendizaje autónomo del proyecto: la lectura automática de comprobantes, que ninguna herramienta del curso resuelve y que sostiene la hipótesis principal de Pozzo.

**Contexto común.** La solución de Pozzo se compone de una aplicación móvil nativa para Android, una versión multiplataforma, un backend de servicios RESTful de desarrollo propio con enfoque Domain-Driven Design y un landing page estático. Ninguno de los tres spikes tiene precedente en el curso: la lectura de texto en imágenes, el envío de notificaciones con la aplicación cerrada y la apertura de la aplicación desde un enlace externo dependen de bibliotecas y servicios de terceros cuya selección debe justificarse y documentarse.

**Definition of Done común a los tres spikes.** El prototipo queda registrado en una rama del repositorio; el informe de hallazgos se comparte y revisa en una reunión del equipo o sesión de refinamiento del backlog; los hallazgos se usan para crear o refinar las historias de implementación; y el spike está limitado a entre 8 y 16 horas y se completa dentro del sprint en que se planifica.

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>SP01</td><td>Developer</td><td>Alta</td><td>EP12</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Investigar la lectura automática de comprobantes de Yape y Plin</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como equipo de desarrollo, deseo investigar, comparar y prototipar una biblioteca o servicio de reconocimiento de texto para extraer monto, fecha, destinatario y número de operación de las capturas de Yape y Plin, para decidir con evidencia cómo implementar la validación automática de aportes.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Alternativas evaluadas</strong><br>Dado que el equipo necesita leer texto en imágenes desde la aplicación móvil,<br>Cuando el desarrollador revisa la documentación de al menos tres alternativas (por ejemplo ML Kit Text Recognition en el dispositivo, Tesseract y un servicio de reconocimiento en la nube),<br>Entonces documenta para cada una el modo de ejecución (en el dispositivo o en la nube), el costo, los permisos requeridos, el tamaño que agrega a la aplicación y la compatibilidad con Android e iOS.<br><br><strong>Escenario 2: Prueba con comprobantes reales</strong><br>Dado un conjunto de al menos 30 capturas reales de Yape y Plin con distintas resoluciones y recortes,<br>Cuando el desarrollador ejecuta cada alternativa sobre el conjunto,<br>Entonces registra el porcentaje de acierto por campo (monto, fecha, destinatario, número de operación) y el tiempo de lectura promedio.<br><br><strong>Escenario 3: Reglas de extracción</strong><br>Dado el texto reconocido de un comprobante,<br>Cuando el desarrollador define las expresiones y reglas para ubicar cada campo según el diseño de Yape y de Plin,<br>Entonces documenta las reglas y los casos en que fallan (capturas borrosas, comprobantes recortados, formatos de fecha).<br><br><strong>Escenario 4: Prototipo</strong><br>Dado la alternativa con mejor relación entre acierto, costo y privacidad,<br>Cuando el desarrollador construye un prototipo mínimo en la aplicación móvil que toma una captura y muestra los cuatro campos leídos,<br>Entonces el prototipo queda registrado en una rama del repositorio y referenciado en el informe.<br><br><strong>Escenario 5: Hallazgos y estimación</strong><br>Dado que el spike está completo,<br>Cuando el desarrollador compila los hallazgos,<br>Entonces el informe incluye la alternativa recomendada, sus limitaciones, el tratamiento de la imagen del comprobante como dato personal y una estimación en puntos de historia para las historias de registro y validación de aportes, y se revisa con el equipo en la sesión de refinamiento.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>SP02</td><td>Developer</td><td>Media</td><td>EP12</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Investigar las notificaciones push y la programación de recordatorios</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como equipo de desarrollo, deseo investigar cómo enviar notificaciones push desde nuestros servicios RESTful y cómo programar los recordatorios escalonados, para implementar los recordatorios automáticos de forma confiable.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Proveedor de notificaciones</strong><br>Dado que la aplicación debe recibir notificaciones con la aplicación cerrada,<br>Cuando el desarrollador evalúa Firebase Cloud Messaging y sus requisitos en Android e iOS,<br>Entonces documenta el registro de tokens, los canales de notificación, los permisos en Android 13 o superior y los límites del plan gratuito.<br><br><strong>Escenario 2: Programación en el servidor</strong><br>Dado que los recordatorios dependen de la fecha de corte de cada junta,<br>Cuando el desarrollador compara un programador de tareas en el backend con una cola de mensajes con retardo,<br>Entonces documenta la alternativa elegida, cómo evita envíos duplicados y cómo se detiene el recordatorio al validar el aporte.<br><br><strong>Escenario 3: Prototipo</strong><br>Dado la alternativa elegida,<br>Cuando el desarrollador envía desde el backend una notificación a un dispositivo físico con la aplicación cerrada y otra programada para un minuto después,<br>Entonces ambas llegan y el prototipo queda registrado en una rama del repositorio.<br><br><strong>Escenario 4: Hallazgos</strong><br>Dado que el spike está completo,<br>Cuando el desarrollador documenta los hallazgos,<br>Entonces el informe incluye la arquitectura recomendada, los riesgos (entrega no garantizada, ahorro de batería del sistema) y una estimación para las historias de recordatorios y avisos.</td></tr>
  </tbody>
</table>

<table>
  <colgroup><col style="width:18%"><col style="width:58%"><col style="width:12%"><col style="width:12%"></colgroup>
  <thead><tr><th>Story ID</th><th>User</th><th>Priority</th><th>Epic</th></tr></thead>
  <tbody>
    <tr><td>SP03</td><td>Developer</td><td>Media</td><td>EP12</td></tr>
    <tr><td><strong>Title</strong></td><td colspan="3">Investigar los enlaces de invitación que abren la aplicación</td></tr>
    <tr><td><strong>Description</strong></td><td colspan="3">Como equipo de desarrollo, deseo investigar cómo un enlace compartido por WhatsApp abre Pozzo directamente en la junta invitada, o lleva a la descarga si no está instalada, para que la incorporación por enlace funcione como se prometió.</td></tr>
    <tr><td><strong>Acceptance Criteria</strong></td><td colspan="3"><strong>Escenario 1: Mecanismos evaluados</strong><br>Dado que el enlace debe funcionar con y sin la aplicación instalada,<br>Cuando el desarrollador evalúa Android App Links y iOS Universal Links, junto con la verificación de dominio requerida,<br>Entonces documenta los archivos que debe publicar el landing page, la configuración en cada plataforma y el comportamiento cuando la aplicación no está instalada.<br><br><strong>Escenario 2: Invitación diferida</strong><br>Dado que el visitante instala la aplicación después de abrir el enlace,<br>Cuando el desarrollador evalúa cómo conservar el código de invitación hasta el primer inicio,<br>Entonces documenta la alternativa elegida y sus limitaciones.<br><br><strong>Escenario 3: Prototipo y hallazgos</strong><br>Dado la alternativa elegida,<br>Cuando el desarrollador prueba en un dispositivo físico un enlace que abre la aplicación en la confirmación de una junta,<br>Entonces el prototipo queda en una rama del repositorio y el informe incluye la recomendación y una estimación para la historia de unión por enlace.</td></tr>
  </tbody>
</table>

### 2.4.2. Impact Mapping

El Impact Map vincula los objetivos de negocio de Pozzo con las personas que pueden hacerlos posibles, el cambio de comportamiento que se espera de ellas, lo que el producto entrega para provocar ese cambio y las historias que lo implementan. El equipo lo elaboró en UXPressia a partir de las fichas de User Persona de Anna Weber y Sofia Gonzales, respondiendo en cada nivel las preguntas del método: quiénes ayudan a lograr la meta, qué tendrían que hacer, qué puede hacer el negocio digital para provocarlo y con qué historias.

Los objetivos de negocio se derivan de los resultados que el equipo definió en los Business Outcome Assumptions y en el Problem Statement, formulados con los criterios SMART (específicos, medibles, alcanzables, relevantes y con plazo). El horizonte de medición son las juntas piloto que el equipo acompañará después del lanzamiento. Se seleccionaron los tres outcomes del primer ciclo de uso; el outcome de crecimiento por referidos (una de cada tres juntas nuevas formada por integrantes que ya usaron Pozzo) se medirá recién entre los meses 7 y 12, por lo que queda fuera de este mapa y se retoma al planificar el segundo semestre.

<table>
  <colgroup><col style="width:18%"><col style="width:82%"></colgroup>
  <thead><tr><th>Business Goal</th><th>Enunciado</th></tr></thead>
  <tbody>
    <tr><td>BG01</td><td>Lograr que 10 juntas piloto completen un ciclo entero en Pozzo, sin volver al cuaderno ni al grupo de mensajería para llevar la cuenta, en los 6 meses siguientes al lanzamiento.</td></tr>
    <tr><td>BG02</td><td>Alcanzar que al menos el 80 % de los aportes de cada ciclo se validen sin revisión manual de la cabeza de junta, y que el 100 % de las discrepancias sobre aportes se resuelvan dentro de la aplicación con comprobante localizable, en las juntas piloto, dentro de los 3 primeros meses.</td></tr>
    <tr><td>BG03</td><td>Reducir a cero los recordatorios de cobranza enviados a mano por la cabeza de junta durante un ciclo, en las juntas piloto, dentro de los 3 primeros meses.</td></tr>
  </tbody>
</table>

Los actores son los dos User Personas del proyecto: **Anna Weber**, cabeza de junta y tomadora de la decisión de adoptar Pozzo, y **Sofia Gonzales**, participante que aporta cada período y espera su turno. Los deliverables corresponden a las Epics de la especificación, y cada historia se identifica con su código y su enunciado. Las Technical Stories y las Spike Stories no aparecen en el mapa porque no modifican el comportamiento de un actor; entran al Product Backlog por la dependencia técnica de las historias que habilitan.

#### Business Goal 01: ciclo completo en Pozzo

<table>
  <colgroup><col style="width:14%"><col style="width:30%"><col style="width:20%"><col style="width:36%"></colgroup>
  <thead><tr><th>Actor</th><th>Impact</th><th>Deliverable</th><th>User Stories</th></tr></thead>
  <tbody>
    <tr><td>Anna Weber</td><td>Conoce Pozzo por el landing page que le compartió un integrante y decide probarlo con su junta.</td><td>EP10 Landing page</td><td>US43 Como visitante, deseo entender en pocos segundos qué problema resuelve Pozzo, para decidir si me interesa para mi junta.<br>US44 Como visitante, deseo encontrar cómo obtener la aplicación o dejar mi contacto, para empezar a usar Pozzo con mi grupo.<br>US45 Como visitante, deseo saber quiénes están detrás de Pozzo y cómo contactarlos, para confiar en el producto.<br>US46 Como visitante que abre el enlace desde el celular, deseo que el landing page se lea bien en pantalla pequeña, para no abandonarlo.</td></tr>
    <tr><td>Anna Weber</td><td>Configura su junta con las mismas reglas que su grupo ya acordó y la inicia sin ayuda de nadie.</td><td>EP02 Configuración de la junta<br>EP04 Asignación de turnos</td><td>US07 Como cabeza de junta, deseo crear una junta definiendo aporte, periodicidad, integrantes, día de corte y fecha de inicio, para reproducir en Pozzo las reglas que mi grupo acordó.<br>US09 Como cabeza de junta, deseo revisar y corregir las reglas antes de iniciar, para que queden como las acordó el grupo.<br>US10 Como cabeza de junta, deseo iniciar la junta cuando el grupo está completo y los turnos definidos, para abrir el primer período.<br>US17 Como cabeza de junta, deseo sortear el orden de cobro, para que el reparto sea al azar.<br>US18 Como cabeza de junta, deseo ordenar los turnos según lo conversado, para respetar la urgencia de cada integrante.<br>US19 Como cabeza de junta, deseo definir que cada turno se asigne por subasta, para reproducir el reparto que mi grupo practica.<br>US20 Como participante que aún no ha cobrado, deseo ofertar un descuento por cobrar este turno, para acceder al dinero cuando lo necesito.<br>US21 Como cabeza de junta, deseo cerrar la subasta y asignar el turno a la mejor oferta, para que el grupo sepa quién cobra y cuánto.</td></tr>
    <tr><td>Anna Weber</td><td>Incorpora al grupo entero, incluidos los que no instalan la aplicación, sin registrar a cada uno a mano.</td><td>EP03 Incorporación de integrantes</td><td>US11 Como cabeza de junta, deseo obtener un código y un enlace de invitación y compartirlos, para que mi grupo entre sin que yo registre a cada uno.<br>US14 Como cabeza de junta, deseo registrar a un integrante que no instalará Pozzo, para que la junta refleje a todo el grupo.<br>US15 Como cabeza de junta, deseo retirar a alguien que entró por error, para que el grupo quede correcto antes de asignar turnos.<br>US16 Como integrante, deseo ver quiénes están en la junta, para saber con quién comparto el ciclo.</td></tr>
    <tr><td>Anna Weber</td><td>Registra la entrega de cada pozo y avanza de turno dentro de la aplicación en lugar del cuaderno, hasta cerrar el ciclo.</td><td>EP08 Entrega del pozo y cierre del ciclo</td><td>US36 Como cabeza de junta, deseo registrar que entregué el pozo, para cerrar el período y que el siguiente empiece con todos avisados.<br>US38 Como cabeza de junta, deseo registrar una deserción y su reemplazo, para que el ciclo pueda continuar.<br>US39 Como cabeza de junta, deseo que la junta se cierre al entregar el último pozo, para tener el resumen del ciclo y abrir uno nuevo con el mismo grupo.</td></tr>
    <tr><td>Sofia Gonzales</td><td>Se une a la junta el mismo día que recibe la invitación, sin configurar nada.</td><td>EP01 Acceso y cuenta<br>EP03 Incorporación de integrantes</td><td>US01 Como integrante, deseo ingresar con mi número de celular, para acceder sin contraseña.<br>US02 Como integrante, deseo confirmar el código que recibí por SMS, para demostrar que el número es mío.<br>US03 Como integrante nuevo, deseo registrarme solo con mi nombre y aceptar los términos, para empezar sin trámites.<br>US04 Como integrante, deseo que mi sesión permanezca iniciada, para no verificar mi número cada vez.<br>US12 Como participante, deseo unirme con el código o el enlace que me compartió la cabeza, para quedar registrada sin configurar nada.<br>US13 Como participante, deseo ver los datos de la junta antes de unirme, para decidir si entro.</td></tr>
    <tr><td>Sofia Gonzales</td><td>Consulta el estado del pozo y su turno en Pozzo en lugar de preguntar en el grupo de mensajería.</td><td>EP06 Transparencia del pozo<br>EP04 Asignación de turnos</td><td>US29 Como integrante, deseo ver cuánto se ha reunido, quién aportó y quién debe, para tener la misma información que la cabeza.<br>US22 Como integrante, deseo ver el calendario completo del ciclo, para saber cuándo me toca cobrar.<br>US31 Como integrante, deseo ver el último estado de mi junta sin conexión, para no depender de la señal.</td></tr>
    <tr><td>Sofia Gonzales</td><td>Cumple con sus aportes durante todo el ciclo porque su historial de cumplimiento queda registrado y le sirve para juntas futuras.</td><td>EP09 Historial de cumplimiento</td><td>US40 Como participante, deseo ver mi historial de aportes puntuales, atrasados y cubiertos, para acreditar mi cumplimiento.<br>US41 Como participante, deseo compartir un resumen verificable de mi historial, para que me acepten en una junta nueva.<br>US42 Como cabeza de junta, deseo ver el historial de quien entra a mi junta, para decidir con información si lo acepto.</td></tr>
  </tbody>
</table>

#### Business Goal 02: aportes validados y discrepancias resueltas en la aplicación

<table>
  <colgroup><col style="width:14%"><col style="width:30%"><col style="width:20%"><col style="width:36%"></colgroup>
  <thead><tr><th>Actor</th><th>Impact</th><th>Deliverable</th><th>User Stories</th></tr></thead>
  <tbody>
    <tr><td>Sofia Gonzales</td><td>Registra su aporte con el comprobante inmediatamente después de transferir, en lugar de enviar la captura al chat.</td><td>EP05 Registro y validación de aportes</td><td>US23 Como participante, deseo registrar mi aporte tomando una foto del comprobante o eligiéndolo de la galería, para que quede constancia sin reenviar capturas.<br>US24 Como participante, deseo revisar y corregir los datos que Pozzo leyó de mi comprobante, para que un error de lectura no se convierta en un rechazo.</td></tr>
    <tr><td>Sofia Gonzales</td><td>Transfiere el monto exacto al destinatario correcto, de modo que el comprobante coincide con lo esperado.</td><td>EP05 Registro y validación de aportes<br>EP02 Configuración de la junta<br>EP01 Acceso y cuenta</td><td>US25 Como participante, deseo que mi aporte quede validado al instante cuando el comprobante coincide, para no depender de la revisión de la cabeza.<br>US08 Como cabeza de junta, deseo indicar el número de Yape o Plin al que deben llegar los aportes, para que Pozzo valide contra ese destinatario.<br>US05 Como integrante, deseo mantener mi número de Yape o Plin en mi perfil, para que mi grupo sepa a quién transferir.</td></tr>
    <tr><td>Sofia Gonzales</td><td>Muestra su comprobante desde Pozzo cuando alguien cuestiona su pago, en lugar de buscar capturas en la galería o el chat.</td><td>EP05 Registro y validación de aportes<br>EP06 Transparencia del pozo</td><td>US28 Como participante, deseo ver todos mis aportes con su estado y su comprobante, para demostrar que pagué cuando alguien lo cuestiona.<br>US31 Como integrante, deseo ver mis comprobantes aunque no tenga señal, para no depender de la conexión al defender un aporte.<br>US32 Como integrante, deseo revisar los períodos ya cerrados, para reconstruir qué pasó en un turno pasado.</td></tr>
    <tr><td>Anna Weber</td><td>Revisa únicamente los aportes con alguna inconsistencia y confía en la validación automática del resto.</td><td>EP05 Registro y validación de aportes</td><td>US26 Como cabeza de junta, deseo ver el comprobante y los datos leídos de un aporte que no coincidió, para aprobarlo o rechazarlo con conocimiento.</td></tr>
    <tr><td>Anna Weber</td><td>Registra en la aplicación los aportes que recibe en efectivo y las coberturas, de modo que el registro siempre cuadra con el dinero.</td><td>EP05 Registro y validación de aportes<br>EP08 Entrega del pozo y cierre del ciclo</td><td>US27 Como cabeza de junta, deseo registrar el aporte de quien me entregó el dinero en efectivo, para que el pozo refleje todos los aportes.<br>US37 Como cabeza de junta, deseo registrar que alguien cubrió el aporte de un moroso, para que el pozo se complete y quede constancia de quién puso el dinero.</td></tr>
    <tr><td>Anna Weber</td><td>Consulta el registro de aportes de la junta en lugar de reconstruir la cuenta de memoria o pedir capturas.</td><td>EP06 Transparencia del pozo</td><td>US29 Como integrante, deseo ver el estado del pozo del período vigente, para tener la misma información que todos.<br>US32 Como integrante, deseo revisar los períodos ya cerrados, para reconstruir qué pasó en un turno pasado.</td></tr>
  </tbody>
</table>

#### Business Goal 03: cero recordatorios manuales

<table>
  <colgroup><col style="width:14%"><col style="width:30%"><col style="width:20%"><col style="width:36%"></colgroup>
  <thead><tr><th>Actor</th><th>Impact</th><th>Deliverable</th><th>User Stories</th></tr></thead>
  <tbody>
    <tr><td>Sofia Gonzales</td><td>Aporta antes de la fecha de corte al recibir los recordatorios automáticos, sin que la cabeza le escriba.</td><td>EP07 Recordatorios y avisos</td><td>US33 Como participante, deseo recibir recordatorios automáticos que aumenten su frecuencia conforme se acerca el corte, para no atrasarme sin que la cabeza me escriba.<br>US35 Como integrante, deseo recibir un aviso cuando ocurre algo relevante en mi junta, para enterarme sin revisar la aplicación.</td></tr>
    <tr><td>Sofia Gonzales</td><td>Aporta a tiempo porque el grupo entero ve quién debe.</td><td>EP06 Transparencia del pozo</td><td>US29 Como integrante, deseo ver quién aportó y quién debe, para tener la misma información que la cabeza.<br>US30 Como participante al que le toca cobrar, deseo ver cuánto falta para mi pozo, para anticipar si cobraré a tiempo.</td></tr>
    <tr><td>Anna Weber</td><td>Deja que el sistema recuerde los aportes en nombre de la junta y no escribe a nadie por su cuenta.</td><td>EP07 Recordatorios y avisos</td><td>US34 Como cabeza de junta, deseo activar o desactivar los recordatorios automáticos y ver su cadencia, para ajustarlos a la costumbre del grupo.</td></tr>
  </tbody>
</table>

### 2.4.3. Product Backlog

## 2.5. Strategic-Level Domain-Driven Design

### 2.5.1. EventStorming

#### 2.5.1.1. Candidate Context Discovery

#### 2.5.1.2. Domain Message Flows Modeling

#### 2.5.1.3. Bounded Context Canvases

### 2.5.2. Context Mapping

### 2.5.3. Software Architecture

#### 2.5.3.1. Software Architecture Context Level Diagrams

#### 2.5.3.2. Software Architecture Container Level Diagrams

#### 2.5.3.3. Software Architecture Deployment Diagrams

## 2.6. Tactical-Level Domain-Driven Design

### 2.6.1. Bounded Context: NombreDelBoundedContext

#### 2.6.1.1. Domain Layer

#### 2.6.1.2. Interface Layer

#### 2.6.1.3. Application Layer

#### 2.6.1.4. Infrastructure Layer

#### 2.6.1.5. Bounded Context Software Architecture Component Level Diagrams

#### 2.6.1.6. Bounded Context Software Architecture Code Level Diagrams

##### 2.6.1.6.1. Bounded Context Domain Layer Class Diagrams

##### 2.6.1.6.2. Bounded Context Database Design Diagram
