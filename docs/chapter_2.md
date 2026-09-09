# Capítulo II: Requirements Development and Software Solution Design

## 2.1. Competidores

Para el análisis competitivo de Pozzo se identificaron tres alternativas del mercado vinculadas a la gestión de ahorros rotativos (tandas/ROSCAs), recaudación grupal y división de gastos compartidos:

1. **Tandapp (o MiTandita)**: Aplicación móvil para organizar tandas tradicionales, asignando turnos y registrando abonos de forma manual.
2. **Moneypool**: Plataforma fintech mexicana para crear fondos comunes ("pools") con saldo digital en app, cobro mediante tarjeta y custodia de dinero.
3. **Splitwise**: Aplicación global orientada al registro, cálculo y división equitativa de gastos compartidos entre amigos, compañeros de vivienda o viajes.

Pozzo se diferencia por resolver la realidad operativa de las juntas peruanas: opera sobre transferencias directas por Yape y Plin sin custodiar el dinero (evitando comisiones y trámites financieros), automatiza el registro de aportes leyendo los vouchers mediante OCR, despersonaliza la cobranza con recordatorios automáticos y permite gestionar turnos (por sorteo, orden acordado o subasta) junto a un historial de cumplimiento para futuros ciclos.

### 2.1.1. Análisis Competitivo

#### ¿Por qué llevar a cabo este análisis?

El propósito de este análisis es examinar las fortalezas y vacíos de las aplicaciones existentes para definir una propuesta de valor realista y diferenciada para Pozzo. En el Perú, las juntas se pagan por canales digitales (Yape/Plin), pero su administración sigue atrapada en cuadernos y grupos de WhatsApp saturados de capturas. Identificar las carencias de los competidores permite enfocar el desarrollo en solucionar el desorden administrativo, los errores de conteo y las discusiones sobre aportes sin alterar la dinámica de confianza del grupo.

#### Competitive Analysis Landscape

| Característica | Pozzo | Tandapp / MiTandita | Moneypool | Splitwise |
| :--- | :--- | :--- | :--- | :--- |
| **Perfil / Overview** | Plataforma móvil y web para administrar juntas de ahorro en tiempo real, validando vouchers sin custodiar dinero. | App móvil para registrar integrantes, armar tandas, asignar turnos y marcar pagos manualmente. | Plataforma fintech para recaudar fondos grupales mediante saldo digital y links de pago. | Aplicación para registrar, calcular y saldar gastos compartidos entre grupos de personas. |
| **Ventaja competitiva** | Validación OCR de vouchers de Yape/Plin y modelo 100 % no custodial adaptado a las juntas en Perú. | Interfaz enfocada únicamente en la dinámica de tandas sin requerir cuentas bancarias. | Cobro integrado con tarjeta de crédito/débito y dispersión a cuentas bancarias vía SPEI. | Marca global consolidada con algoritmo para optimizar y simplificar deudas cruzadas. |
| **Valor ofrecido** | Elimina el conteo manual, evita reclamos ("yo sí pagué"), despersonaliza la cobranza y transparenta el estado del pozo. | Permite calendarizar montos, fechas y turnos para consultar el avance de la tanda desde el celular. | Centraliza dinero en un fondo digital compartido para eventos o compras conjuntas antes de retirarlo. | Otorga claridad continua sobre quién le debe a quién en gastos diarios compartidos y viajes. |
| **Mercado objetivo** | Organizadores y participantes de juntas de ahorro en zonas urbanas del Perú (NSE B, C y D). | Organizadores y miembros de tandas comunitarias y familiares en México y Latinoamérica. | Grupos de amigos, familias y organizadores de eventos sociales en México. | Compañeros de departamento, grupos de viaje, parejas y amigos a nivel internacional. |
| **Estrategias de marketing** | Invitación directa vía enlace de WhatsApp y recomendación orgánica dentro de redes de confianza. | Posicionamiento en tiendas de aplicaciones (ASO) mediante palabras clave ("tanda", "ahorro grupal"). | Marketing digital B2C, campañas en redes sociales y alianzas en el ecosistema fintech mexicano. | Crecimiento guiado por el producto (PLG) y optimización en Google Play y App Store. |
| **Productos y servicios** | Panel de organizador, app de participante, validador OCR de vouchers, gestión de turnos e historial de cumplimiento. | Creación de tandas, lista de participantes, asignador de turnos/fechas y registro manual de aportes. | Creación de "pools", links de cobro, saldo virtual interno y transferencias vía SPEI. | Calculadora de división de cuentas, balance de saldos, registro de abonos y reportes exportables. |
| **Precios & costos** | Modelo freemium / microcomisión por ciclo de junta administrada. | Descarga gratuita con anuncios publicitarios invasivos; opción de compra in-app para retirarlos. | Comisión por transacción con tarjeta (aprox. 3.9 %) y tarifas según el tamaño del pool. | Versión gratuita básica; suscripción prémium (*Splitwise Pro*) para escaneo de recibos y gráficos. |
| **Canales de distribución** | Aplicación móvil nativa (Android/iOS), versión web responsiva (PWA) y enlaces por WhatsApp. | Google Play Store y Apple App Store. | Sitio web oficial (moneypool.mx) y app en Google Play / App Store. | Sitio web oficial (splitwise.com) y app en Google Play / App Store. |

* **Tandapp / MiTandita** se enfoca exclusivamente en la calendarización de tandas, permitiendo registrar participantes y definir el orden de entrega. Su limitación principal radica en que el registro de aportes es enteramente manual por parte del administrador, no cuenta con herramientas para validar transferencias bancarias y monetiza mediante anuncios publicitarios invasivos.
* **Moneypool** resuelve la recaudación colectiva centralizando los fondos en una cuenta virtual propia y habilitando cobros con tarjeta. Esta infraestructura presenta fricciones para el ahorro tradicional: la plataforma retiene el dinero y cobra comisiones por transacción, lo cual desincentiva a grupos informales habituados a transferencias directas, inmediatas y gratuitas entre cuentas bancarias personales.
* **Splitwise** destaca en la división de gastos comunes diarios o viajes. Sin embargo, su estructura está diseñada para liquidar saldos netos variables entre integrantes, no para el modelo de cuotas fijas rotativas con fechas estrictas de adjudicación de una junta, y restringe la lectura automatizada de recibos a su versión de pago prémium.

#### Análisis SWOT

##### Pozzo

| Fortalezas | Debilidades |
| :--- | :--- |
| • Adaptada al flujo de pago real en Perú mediante lectura OCR de comprobantes de Yape y Plin.<br>• Modelo 100 % no custodial: no retiene dinero, eliminando riesgos legales y desconfianza de los usuarios.<br>• Transparencia en tiempo real: calendario compartido donde todos ven el estado de aportes y el pozo.<br>• Cobranza automatizada mediante recordatorios escalonados que evitan el desgaste entre conocidos.<br>• Flexibilidad para asignar turnos según la costumbre del grupo (sorteo, orden acordado o subasta). | • Producto nuevo en etapa de desarrollo, sin base instalada de usuarios previa.<br>• Dependencia técnica de la legibilidad de vouchers y de posibles cambios visuales en Yape/Plin.<br>• Capacidad operativa y recursos de difusión acotados frente a plataformas comerciales consolidadas.<br>• Resistencia inicial al uso de herramientas digitales en participantes poco familiarizados con apps. |
| **Oportunidades** | **Amenazas** |
| • Uso masivo y cotidiano de billeteras móviles en el Perú (más de 16 millones de usuarios activos).<br>• Alto porcentaje de la población no bancarizada o sub-bancarizada que ahorra activamente en juntas.<br>• Adquisición viral de bajo costo: cada organizador incorpora directamente a su grupo por WhatsApp.<br>• Reutilización del historial de cumplimiento para facilitar la organización de siguientes ciclos. | • Hábito arraigado de organizadores de llevar sus cuentas en cuadernos físicos o libretas de notas.<br>• Posibilidad de que billeteras como Yape incorporen herramientas nativas de ahorro grupal.<br>• Ingreso de comprobantes duplicados, ilegibles o manipulados que requieran revisión manual.<br>• Casos de morosidad o deserción de integrantes que comprometan la continuidad de la junta. |

##### Tandapp / MiTandita

| Fortalezas | Debilidades |
| :--- | :--- |
| • Especialización directa en el flujo tradicional de tandas y ahorro rotativo.<br>• Configuración rápida y uso ligero sin solicitar vinculación de cuentas bancarias.<br>• Buen posicionamiento orgánico en tiendas móviles para búsquedas relacionadas con tandas. | • Registro de pagos 100 % manual por parte del organizador.<br>• Experiencia de uso deteriorada por la presencia de publicidad en la versión gratuita.<br>• Nula validación de comprobantes ni compatibilidad con billeteras móviles peruanas. |
| **Oportunidades** | **Amenazas** |
| • Interés de sectores populares por ordenar el seguimiento de sus tandas desde el celular.<br>• Posibilidad de transicionar hacia esquemas de suscripción accesibles sin anuncios. | • Pérdida de usuarios ante aplicaciones que automaticen la verificación de abonos.<br>• Alta tasa de abandono provocada por la saturación de anuncios dentro de la app. |

##### Moneypool

| Fortalezas | Debilidades |
| :--- | :--- |
| • Respaldo formal como entidad fintech regulada (IFPE) en México.<br>• Infraestructura propia con links de cobro y recepción de pagos con tarjeta de débito/crédito.<br>• Marca reconocida en recaudación de fondos y eventos sociales en su país de origen. | • Cobro de comisiones que reducen el monto final del ahorro acumulado.<br>• Fricción y rechazo de usuarios informales a dejar su dinero bajo custodia de un tercero.<br>• Operatividad restringida al sistema bancario mexicano, sin soporte para soles peruanos. |
| **Oportunidades** | **Amenazas** |
| • Generación de microrendimientos financieros sobre los saldos depositados en la plataforma.<br>• Expansión hacia cobros colectivos corporativos, institucionales y eventos masivos. | • Preferencia del público por transferencias interbancarias directas y sin comisión.<br>• Mayor rigidez en normativas sobre captación de fondos y billeteras electrónicas. |

##### Splitwise

| Fortalezas | Debilidades |
| :--- | :--- |
| • Marca global líder en administración y liquidación de gastos compartidos.<br>• Algoritmo optimizado para consolidar saldos y reducir transferencias entre integrantes.<br>• Plataforma madura con sincronización multidispositivo y respaldo en la nube. | • No contempla la estructura de turnos rotativos ni el cobro de cuotas periódicas de una junta.<br>• La lectura automática de recibos (OCR) está restringida al plan de pago prémium.<br>• Carece de recordatorios de cobro escalonados diseñados para la disciplina de ahorro. |
| **Oportunidades** | **Amenazas** |
| • Integración con medios de pago locales en mercados emergentes.<br>• Desarrollo de funciones orientadas a metas de ahorro grupal para viajes o proyectos. | • Fuga de usuarios hacia aplicaciones verticales enfocadas en esquemas de ahorro rotativo.<br>• Descontento de los usuarios frente a la limitación progresiva de opciones gratuitas. |

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
* Disponer de una versión web responsiva (PWA) junto a la app móvil, permitiendo consultar turnos y subir vouchers sin exigir una descarga obligatoria a quienes tengan limitaciones de almacenamiento.
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

### 2.2.1. Diseño de entrevistas

### 2.2.2. Registro de entrevistas

### 2.2.3. Análisis de entrevistas

## 2.3. Needfinding

### 2.3.1. User Personas

### 2.3.2. User Task Matrix

### 2.3.3. User Journey Mapping

### 2.3.4. Empathy Mapping

### 2.3.5. Big Picture EventStorming

### 2.3.6. Ubiquitous Language

## 2.4. Requirements specification

### 2.4.1. User Stories

### 2.4.2. Impact Mapping

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
