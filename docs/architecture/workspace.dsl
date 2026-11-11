workspace "Pozzo" "Arquitectura de software de Pozzo con el C4 Model: contexto, contenedores y despliegue." {

    !identifiers hierarchical

    model {
        organizer = person "Cabeza de junta" "Convoca la junta, define sus reglas, incorpora integrantes, revisa aportes con inconsistencia y entrega el pozo en cada turno."
        member = person "Participante" "Se une a una junta, registra su aporte con el comprobante y consulta el estado del pozo y su historial."
        visitor = person "Visitante" "Conoce Pozzo desde el landing page y descarga la aplicación."

        smsProvider = softwareSystem "SMS Gate" "Envía por SMS el código de verificación que genera Pozzo, desde un celular Android con su propio chip." "Externo"
        fcm = softwareSystem "Firebase Cloud Messaging" "Entrega las notificaciones push a los dispositivos, aunque la aplicación esté cerrada." "Externo"
        wallets = softwareSystem "Yape, Plin y aplicaciones bancarias" "Donde ocurre la transferencia del aporte. Pozzo solo recibe la captura del comprobante." "Externo"
        whatsapp = softwareSystem "WhatsApp" "Canal por el que la cabeza comparte el enlace de invitación." "Externo"

        pozzo = softwareSystem "Pozzo" "Organiza juntas de ahorro: registra y valida los aportes contra el comprobante, muestra el estado del pozo a todo el grupo y recuerda a quien no ha aportado." {

            landing = container "Landing Page" "Sitio estático que presenta el problema, la propuesta de valor y el acceso a la aplicación." "HTML, CSS, JavaScript" "Web"

            mobile = container "Aplicación móvil" "Experiencia de la cabeza de junta y del participante: crear y unirse a juntas, registrar aportes con el comprobante (leído en el dispositivo con ML Kit), consultar el pozo y recibir avisos." "Kotlin, Jetpack Compose, Material 3, ML Kit Text Recognition" "Móvil"

            localStore = container "Almacenamiento local" "Copia de la sesión, la junta vigente y sus períodos para consultar la junta sin conexión." "Room (SQLite)" "Base de datos"

            api = container "Servicios RESTful" "Implementa los cinco bounded contexts como módulos: Identity & Access, Savings Groups, Contributions, Notifications y Compliance History. Expone la API documentada con OpenAPI." "Java 21, Spring Boot 4, Spring Security, springdoc-openapi" "API" {

                # Bounded Context: Contributions
                contributionsController = component "ContributionsController" "Endpoints para registrar un aporte con comprobante, en efectivo o como cobertura, aprobar o rechazar los que tienen inconsistencias, listar los pendientes de revisión y compartir un aporte con un enlace verificable." "Spring MVC REST Controller" "Contributions,Interface"
                cyclesController = component "CyclesController" "Endpoints para consultar el ciclo de una junta, el estado del pozo, los períodos anteriores y los aportes del integrante, e intercambiar dos turnos que no han empezado." "Spring MVC REST Controller" "Contributions,Interface"
                periodsController = component "PeriodsController" "Endpoints para registrar la entrega del pozo, adjuntar y consultar la imagen de la transferencia, consultar la proyección y cerrar la junta." "Spring MVC REST Controller" "Contributions,Interface"
                contributionCommandService = component "ContributionCommandService" "Atiende los comandos de registro, efectivo, cobertura y revisión de aportes; coordina la validación y publica los eventos." "Spring Service" "Contributions,Application"
                auctionsController = component "AuctionsController" "Endpoints para consultar la subasta del período, ofertar y cerrarla." "Spring MVC REST Controller" "Contributions,Interface"
                cycleCommandService = component "CycleCommandService" "Atiende los comandos de inicio del ciclo, entrega del pozo, intercambio de turnos, vínculo de cuentas, deserción y reemplazo; abre el siguiente período y, si los turnos se subastan, su subasta." "Spring Service" "Contributions,Application"
                auctionCommandService = component "AuctionCommandService" "Recibe las ofertas, cierra las subastas y da el turno a la mejor oferta o, sin ofertas, por sorteo o a quien elija la cabeza." "Spring Service" "Contributions,Application"
                auctionClosingScheduler = component "AuctionClosingScheduler" "Tarea programada que cada hora cierra las subastas cuyo día de cierre pasó." "Spring @Scheduled" "Contributions,Infrastructure"
                periodQueryService = component "ContributionQueryService" "Resuelve las consultas del ciclo, estado del pozo, períodos anteriores, proyección, aportes del integrante, pendientes de revisión, subasta del período y aporte compartido." "Spring Service" "Contributions,Application"
                contributionsEventHandlers = component "Contributions Event Handlers" "SavingsGroupStartedEventHandler inicia el ciclo al recibir Junta iniciada; otros dos handlers mantienen el ciclo al día cuando Savings Groups vincula una cuenta o registra una deserción o un reemplazo; IntegrationEventsPublisher traduce los eventos de dominio a eventos de integración para los demás contextos." "Spring Event Listeners" "Contributions,Application"
                contributionsDomain = component "Contributions Domain Model" "Agregados Cycle, Period, Contribution y Auction y sus value objects, con las reglas de validación del comprobante y de la subasta." "Java, POJOs" "Contributions,Domain"
                contributionsRepositories = component "Contributions Repositories" "Implementación JPA de CycleRepository, PeriodRepository, ContributionRepository y AuctionRepository sobre el esquema contributions." "Spring Data JPA" "Contributions,Infrastructure"

                # Bounded Context: Savings Groups
                savingsGroupsController = component "SavingsGroupsController" "Endpoints para crear la junta, cambiar sus reglas antes de iniciar, definir el destino de los aportes, consultarla, iniciarla y abrir un nuevo ciclo al terminar." "Spring MVC REST Controller" "SavingsGroups,Interface"
                membershipsController = component "MembershipsController" "Endpoints de invitaciones, unirse con código o enlace, agregar integrantes sin la aplicación, retirarlos, registrar deserciones y asignar un reemplazo." "Spring MVC REST Controller" "SavingsGroups,Interface"
                turnsController = component "TurnsController" "Endpoints para asignar turnos por sorteo, orden acordado o subasta y consultar el calendario." "Spring MVC REST Controller" "SavingsGroups,Interface"
                savingsGroupCommandService = component "SavingsGroupCommandService" "Atiende los comandos de la junta, los integrantes, las invitaciones y el inicio; publica los eventos." "Spring Service" "SavingsGroups,Application"
                turnCommandService = component "TurnCommandService" "Atiende la asignación de turnos con el servicio de dominio TurnAssignmentService y guarda las reglas de la subasta cuando los turnos se subastan." "Spring Service" "SavingsGroups,Application"
                savingsGroupQueryService = component "SavingsGroupQueryService" "Resuelve la junta, lista de integrantes, calendario de turnos, invitación vigente y resumen por invitación." "Spring Service" "SavingsGroups,Application"
                groupStartedEventHandler = component "GroupStartedEventHandler" "Traduce Junta iniciada a un evento de integración con la copia de reglas y turnos." "Spring Event Listener" "SavingsGroups,Application"
                savingsGroupsEventHandlers = component "Savings Groups Event Handlers" "Vinculan la cuenta nueva a los integrantes registrados sin la aplicación con ese celular, siguen en el calendario los turnos que Contributions intercambia y cierran la junta cuando termina su ciclo; MembershipEventsHandler publica a los demás contextos las uniones, vínculos, deserciones, reemplazos y nuevos ciclos." "Spring Event Listeners" "SavingsGroups,Application"
                savingsGroupsDomain = component "Savings Groups Domain Model" "Agregados SavingsGroup e Invitation, sus entidades y value objects, entre ellos las reglas de la subasta, y el servicio de dominio TurnAssignmentService." "Java, POJOs" "SavingsGroups,Domain"
                savingsGroupsRepositories = component "Savings Groups Repositories" "Implementación JPA de SavingsGroupRepository e InvitationRepository sobre el esquema savings_groups." "Spring Data JPA" "SavingsGroups,Infrastructure"
                savingsGroupsFacade = component "SavingsGroupsContextFacade" "Open Host Service que dice a los demás contextos quién es cabeza y quién integrante de cada junta." "Spring Service" "SavingsGroups,Application"

                # Bounded Context: Compliance History
                complianceHistoryController = component "ComplianceHistoryController" "Endpoints para consultar el historial propio, el cumplimiento de los integrantes de una junta, el resumen de un integrante, compartirlo y ver un historial compartido." "Spring MVC REST Controller" "ComplianceHistory,Interface"
                complianceCommandService = component "ComplianceCommandService" "Registra hechos de cumplimiento y emite enlaces para compartir el historial." "Spring Service" "ComplianceHistory,Application"
                complianceQueryService = component "ComplianceQueryService" "Resuelve el resumen y el detalle del historial, propio, de otro integrante o por enlace compartido." "Spring Service" "ComplianceHistory,Application"
                complianceEventHandlers = component "Compliance Event Handlers" "Traduce Aporte liquidado (puntual, tardío o cubierto), Comprobante rechazado y Ciclo cerrado a hechos de cumplimiento (capa anticorrupción)." "Spring Event Listeners" "ComplianceHistory,Application"
                complianceDomain = component "Compliance History Domain Model" "Agregados MemberRecord y ShareLink, la entidad ComplianceEntry y el servicio de dominio ComplianceScoringService." "Java, POJOs" "ComplianceHistory,Domain"
                complianceRepositories = component "Compliance History Repositories" "Implementación JPA de MemberRecordRepository y ShareLinkRepository sobre el esquema compliance_history." "Spring Data JPA" "ComplianceHistory,Infrastructure"

                # Bounded Context: Notifications
                devicesController = component "DevicesController" "Endpoints para registrar y dar de baja el dispositivo del integrante." "Spring MVC REST Controller" "Notifications,Interface"
                reminderPlansController = component "ReminderPlansController" "Endpoints para consultar y configurar los recordatorios de una junta." "Spring MVC REST Controller" "Notifications,Interface"
                notificationsController = component "NotificationsController" "Endpoint para consultar los avisos recibidos por el integrante." "Spring MVC REST Controller" "Notifications,Interface"
                notificationCommandService = component "NotificationCommandService" "Registra dispositivos, configura planes, programa y cancela recordatorios, crea avisos deduplicados y envía los vencidos." "Spring Service" "Notifications,Application"
                notificationQueryService = component "NotificationQueryService" "Resuelve los avisos recibidos y el plan de recordatorios de una junta." "Spring Service" "Notifications,Application"
                notificationEventHandlers = component "Notification Event Handlers" "Reacciona, después de confirmada la transacción, a Junta iniciada, Período abierto, Aporte liquidado, Comprobante por revisar o rechazado, Pozo completo, Pozo entregado y Ciclo cerrado." "Spring Event Listeners" "Notifications,Application"
                notificationDispatcher = component "NotificationDispatchScheduler" "Tarea programada que cada minuto pide enviar las notificaciones vencidas." "Spring @Scheduled" "Notifications,Infrastructure"
                notificationsDomain = component "Notifications Domain Model" "Agregados Device, ReminderPlan y Notification y sus value objects; el plan calcula los momentos de envío de cada fecha de corte." "Java, POJOs" "Notifications,Domain"
                notificationsRepositories = component "Notifications Repositories" "Implementación JPA de DeviceRepository, ReminderPlanRepository y NotificationRepository sobre el esquema notifications." "Spring Data JPA" "Notifications,Infrastructure"
                fcmPushSender = component "FcmPushSender" "Adaptador que envía notificaciones push con la API HTTP v1 de FCM, autenticado con la cuenta de servicio de Firebase." "FCM HTTP v1, Google Auth Library" "Notifications,Infrastructure"

                # Bounded Context: Identity & Access
                authenticationController = component "AuthenticationController" "Endpoints para solicitar el código SMS, verificarlo, completar el registro y cerrar sesión." "Spring MVC REST Controller" "IdentityAccess,Interface"
                profilesController = component "ProfilesController" "Endpoints para consultar y actualizar el perfil y el tema visual." "Spring MVC REST Controller" "IdentityAccess,Interface"
                authenticationCommandService = component "AuthenticationCommandService" "Emite y verifica códigos, crea cuentas, abre y revoca sesiones." "Spring Service" "IdentityAccess,Application"
                accountQueryService = component "AccountQueryService" "Resuelve el perfil, la existencia de una cuenta por celular y la validación del token." "Spring Service" "IdentityAccess,Application"
                identityDomain = component "Identity & Access Domain Model" "Agregados Account, VerificationCode y Session, sus value objects y los servicios de dominio CodeGenerationService y TokenService." "Java, POJOs" "IdentityAccess,Domain"
                identityRepositories = component "Identity & Access Repositories" "Implementación JPA de AccountRepository, VerificationCodeRepository y SessionRepository sobre el esquema identity_access." "Spring Data JPA" "IdentityAccess,Infrastructure"
                smsSender = component "SmsGateSmsSender" "Adaptador (capa anticorrupción) que entrega el SMS con el código a SMS Gate, que lo envía desde un celular Android del equipo." "Spring Service (ACL)" "IdentityAccess,Infrastructure"
                jwtTokenService = component "JwtTokenService" "Implementación de TokenService con JSON Web Tokens firmados." "Spring Security, jjwt" "IdentityAccess,Infrastructure"
                authorizationFilter = component "BearerAuthorizationRequestFilter" "Filtro que valida el token de cada solicitud y expone la identidad del integrante a los demás módulos." "Spring Security Filter" "IdentityAccess,Infrastructure"
            }

            db = container "Base de datos" "Persistencia de cuentas, juntas, integrantes, turnos, períodos, aportes, comprobantes, dispositivos e historial, en un esquema por bounded context." "PostgreSQL 16" "Base de datos"
        }

        # Personas y productos
        visitor -> pozzo.landing "Lee la propuesta y descarga la aplicación" "HTTPS"
        organizer -> pozzo.mobile "Crea la junta, invita, asigna turnos, revisa aportes y entrega el pozo"
        member -> pozzo.mobile "Se une, registra su aporte con el comprobante y consulta el pozo"
        organizer -> whatsapp "Comparte el enlace de invitación"
        whatsapp -> pozzo.mobile "Abre la aplicación en la junta invitada" "Enlace"
        member -> wallets "Transfiere el aporte y captura el comprobante"
        wallets -> pozzo "Emite comprobante de pago digital para verificación de aportes" "Comprobante digital"

        # Contenedores
        pozzo.landing -> pozzo.mobile "Enlaza a la descarga e instalación del APK" "HTTPS"
        wallets -> pozzo.mobile "Provee captura del comprobante para extracción con ML Kit" "Captura de pantalla"
        pozzo.mobile -> pozzo.localStore "Guarda la sesión y la copia local de la junta" "Room"
        pozzo.mobile -> pozzo.api "Consume la API: autenticación, juntas, integrantes, turnos, aportes, entrega, historial y registro del dispositivo" "JSON/HTTPS"

        # Contributions: componentes
        pozzo.mobile -> pozzo.api.contributionsController "Registra, revisa y consulta aportes" "JSON/HTTPS"
        pozzo.mobile -> pozzo.api.cyclesController "Consulta el ciclo, el pozo y sus aportes" "JSON/HTTPS"
        pozzo.mobile -> pozzo.api.periodsController "Entrega el pozo y cierra" "JSON/HTTPS"
        pozzo.mobile -> pozzo.api.auctionsController "Oferta y cierra la subasta del turno" "JSON/HTTPS"
        pozzo.api.contributionsController -> pozzo.api.contributionCommandService "Envía comandos"
        pozzo.api.contributionsController -> pozzo.api.periodQueryService "Envía consultas"
        pozzo.api.cyclesController -> pozzo.api.periodQueryService "Envía consultas"
        pozzo.api.periodsController -> pozzo.api.cycleCommandService "Envía comandos"
        pozzo.api.cyclesController -> pozzo.api.cycleCommandService "Envía comandos"
        pozzo.api.auctionsController -> pozzo.api.auctionCommandService "Envía comandos"
        pozzo.api.auctionsController -> pozzo.api.periodQueryService "Envía consultas"
        pozzo.api.auctionClosingScheduler -> pozzo.api.auctionCommandService "Cierra las subastas vencidas"
        pozzo.api.auctionCommandService -> pozzo.api.contributionsDomain "Usa los agregados"
        pozzo.api.auctionCommandService -> pozzo.api.contributionsRepositories "Lee y guarda"
        pozzo.api.contributionCommandService -> pozzo.api.contributionsDomain "Usa los agregados"
        pozzo.api.cycleCommandService -> pozzo.api.contributionsDomain "Usa los agregados"
        pozzo.api.contributionCommandService -> pozzo.api.contributionsRepositories "Lee y guarda"
        pozzo.api.cycleCommandService -> pozzo.api.contributionsRepositories "Lee y guarda"
        pozzo.api.periodQueryService -> pozzo.api.contributionsRepositories "Lee"
        pozzo.api.contributionsEventHandlers -> pozzo.api.cycleCommandService "Dispara el inicio del ciclo y los cambios de integrantes"
        pozzo.api.contributionsEventHandlers -> pozzo.api.contributionsRepositories "Lee el ciclo para enriquecer los eventos"
        pozzo.api.contributionsRepositories -> pozzo.db "Lee y escribe" "JDBC"

        # Savings Groups: componentes
        pozzo.mobile -> pozzo.api.savingsGroupsController "Crea, configura e inicia juntas" "JSON/HTTPS"
        pozzo.mobile -> pozzo.api.membershipsController "Invita, se une y administra integrantes" "JSON/HTTPS"
        pozzo.mobile -> pozzo.api.turnsController "Asigna turnos y subasta" "JSON/HTTPS"
        pozzo.api.savingsGroupsController -> pozzo.api.savingsGroupCommandService "Envía comandos"
        pozzo.api.savingsGroupsController -> pozzo.api.savingsGroupQueryService "Envía consultas"
        pozzo.api.membershipsController -> pozzo.api.savingsGroupCommandService "Envía comandos"
        pozzo.api.membershipsController -> pozzo.api.savingsGroupQueryService "Envía consultas"
        pozzo.api.turnsController -> pozzo.api.turnCommandService "Envía comandos"
        pozzo.api.turnsController -> pozzo.api.savingsGroupQueryService "Envía consultas"
        pozzo.api.savingsGroupCommandService -> pozzo.api.savingsGroupsDomain "Usa los agregados"
        pozzo.api.turnCommandService -> pozzo.api.savingsGroupsDomain "Usa los agregados y el servicio de turnos"
        pozzo.api.savingsGroupCommandService -> pozzo.api.savingsGroupsRepositories "Lee y guarda"
        pozzo.api.turnCommandService -> pozzo.api.savingsGroupsRepositories "Lee y guarda"
        pozzo.api.savingsGroupQueryService -> pozzo.api.savingsGroupsRepositories "Lee"
        pozzo.api.groupStartedEventHandler -> pozzo.api.contributionsEventHandlers "Publica Junta iniciada" "Evento de integración"
        pozzo.api.groupStartedEventHandler -> pozzo.api.notificationEventHandlers "Publica Junta iniciada" "Evento de integración"
        pozzo.api.savingsGroupsEventHandlers -> pozzo.api.savingsGroupCommandService "Envía comandos"
        pozzo.api.savingsGroupsEventHandlers -> pozzo.api.contributionsEventHandlers "Publica vínculos, deserciones y reemplazos" "Evento de integración"
        pozzo.api.contributionsEventHandlers -> pozzo.api.savingsGroupsEventHandlers "Publica Turnos intercambiados y Ciclo cerrado" "Evento de integración"
        pozzo.api.savingsGroupsFacade -> pozzo.api.savingsGroupsRepositories "Lee"
        pozzo.api.savingsGroupsRepositories -> pozzo.db "Lee y escribe" "JDBC"
        pozzo.api.contributionsEventHandlers -> pozzo.api.complianceEventHandlers "Publica eventos de integración" "Evento de integración"
        pozzo.api.contributionsEventHandlers -> pozzo.api.notificationEventHandlers "Publica eventos de integración" "Evento de integración"

        # Compliance History: componentes
        pozzo.mobile -> pozzo.api.complianceHistoryController "Consulta y comparte el historial" "JSON/HTTPS"
        pozzo.api.complianceHistoryController -> pozzo.api.complianceCommandService "Envía comandos"
        pozzo.api.complianceHistoryController -> pozzo.api.complianceQueryService "Envía consultas"
        pozzo.api.complianceEventHandlers -> pozzo.api.complianceCommandService "Registra hechos de cumplimiento"
        pozzo.api.complianceCommandService -> pozzo.api.complianceDomain "Usa los agregados y el servicio de puntuación"
        pozzo.api.complianceCommandService -> pozzo.api.complianceRepositories "Lee y guarda"
        pozzo.api.complianceQueryService -> pozzo.api.complianceRepositories "Lee"
        pozzo.api.complianceQueryService -> pozzo.api.savingsGroupsFacade "Autoriza las consultas de la cabeza"
        pozzo.api.complianceRepositories -> pozzo.db "Lee y escribe" "JDBC"

        # Notifications: componentes
        pozzo.mobile -> pozzo.api.devicesController "Registra el dispositivo" "JSON/HTTPS"
        pozzo.mobile -> pozzo.api.reminderPlansController "Configura los recordatorios" "JSON/HTTPS"
        pozzo.mobile -> pozzo.api.notificationsController "Consulta los avisos" "JSON/HTTPS"
        pozzo.api.devicesController -> pozzo.api.notificationCommandService "Envía comandos"
        pozzo.api.reminderPlansController -> pozzo.api.notificationCommandService "Envía comandos"
        pozzo.api.reminderPlansController -> pozzo.api.notificationQueryService "Envía consultas"
        pozzo.api.notificationsController -> pozzo.api.notificationQueryService "Envía consultas"
        pozzo.api.notificationEventHandlers -> pozzo.api.notificationCommandService "Programa recordatorios y crea avisos"
        pozzo.api.notificationCommandService -> pozzo.api.notificationsDomain "Usa los agregados"
        pozzo.api.notificationCommandService -> pozzo.api.notificationsRepositories "Lee y guarda"
        pozzo.api.notificationQueryService -> pozzo.api.notificationsRepositories "Lee"
        pozzo.api.notificationDispatcher -> pozzo.api.notificationCommandService "Pide enviar las vencidas"
        pozzo.api.notificationCommandService -> pozzo.api.fcmPushSender "Envía"
        pozzo.api.notificationCommandService -> pozzo.api.savingsGroupsFacade "Autoriza el plan de recordatorios"
        pozzo.api.notificationsRepositories -> pozzo.db "Lee y escribe" "JDBC"
        pozzo.api.fcmPushSender -> fcm "Envía la notificación push" "HTTPS"

        # Identity & Access: componentes
        pozzo.mobile -> pozzo.api.authenticationController "Solicita y verifica el código, se registra" "JSON/HTTPS"
        pozzo.mobile -> pozzo.api.profilesController "Consulta y actualiza el perfil" "JSON/HTTPS"
        pozzo.api.authenticationController -> pozzo.api.authenticationCommandService "Envía comandos"
        pozzo.api.profilesController -> pozzo.api.authenticationCommandService "Envía comandos"
        pozzo.api.profilesController -> pozzo.api.accountQueryService "Envía consultas"
        pozzo.api.authenticationCommandService -> pozzo.api.identityDomain "Usa los agregados y los servicios de dominio"
        pozzo.api.authenticationCommandService -> pozzo.api.identityRepositories "Lee y guarda"
        pozzo.api.authenticationCommandService -> pozzo.api.smsSender "Envía el código generado"
        pozzo.api.authenticationCommandService -> pozzo.api.jwtTokenService "Emite el token"
        pozzo.api.accountQueryService -> pozzo.api.identityRepositories "Lee"
        pozzo.api.authorizationFilter -> pozzo.api.jwtTokenService "Valida el token"
        pozzo.api.identityRepositories -> pozzo.db "Lee y escribe" "JDBC"
        pozzo.api.smsSender -> smsProvider "Solicita el envío del código" "HTTPS"
        fcm -> pozzo.mobile "Entrega la notificación push"

        production = deploymentEnvironment "Producción" {
            deploymentNode "Dispositivo Android del integrante" "" "Android 10 o superior" {
                deploymentNode "Pozzo (APK, Firebase App Distribution)" "" "Aplicación instalada" {
                    containerInstance pozzo.mobile
                    containerInstance pozzo.localStore
                }
            }
            deploymentNode "GitHub Pages" "" "CDN estático" {
                containerInstance pozzo.landing
            }
            deploymentNode "Oracle Cloud Infrastructure" "" "Instancia Always Free, Ubuntu 24.04" {
                deploymentNode "Caddy" "" "Proxy inverso con HTTPS, api-kerolabs.duckdns.org" {
                    deploymentNode "Servicio pozzo" "" "systemd, Java 21" {
                        containerInstance pozzo.api
                    }
                }
            }
            deploymentNode "Supabase" "" "PostgreSQL administrado" {
                deploymentNode "PostgreSQL" "" "Conexión por session pooler" {
                    containerInstance pozzo.db
                }
            }
            deploymentNode "Google Cloud" "" "Servicio de terceros" {
                softwareSystemInstance fcm
            }
            deploymentNode "SMS Gate" "" "Servicio de terceros, celular Android del equipo" {
                softwareSystemInstance smsProvider
            }
        }
    }

    views {
        systemContext pozzo "ContextoPozzo" "Pozzo, sus usuarios y los sistemas externos con los que interactúa." {
            include *
            autoLayout tb 300 300
        }

        container pozzo "ContenedoresPozzo" "Productos de Pozzo, tecnología de cada uno y cómo se comunican." {
            include *
            autoLayout tb 300 300
        }

        component pozzo.api "ComponentesContributions" "Componentes del bounded context Contributions dentro de los servicios RESTful." {
            include "element.tag==Contributions"
            include pozzo.mobile pozzo.db pozzo.api.groupStartedEventHandler pozzo.api.savingsGroupsEventHandlers
            autoLayout tb 300 300
        }

        component pozzo.api "ComponentesSavingsGroups" "Componentes del bounded context Savings Groups dentro de los servicios RESTful." {
            include "element.tag==SavingsGroups"
            include pozzo.mobile pozzo.db pozzo.api.contributionsEventHandlers
            autoLayout tb 300 300
        }

        component pozzo.api "ComponentesComplianceHistory" "Componentes del bounded context Compliance History dentro de los servicios RESTful." {
            include "element.tag==ComplianceHistory"
            include pozzo.mobile pozzo.db pozzo.api.contributionsEventHandlers pozzo.api.savingsGroupsFacade
            autoLayout tb 300 300
        }

        component pozzo.api "ComponentesNotifications" "Componentes del bounded context Notifications dentro de los servicios RESTful." {
            include "element.tag==Notifications"
            include pozzo.mobile pozzo.db fcm pozzo.api.contributionsEventHandlers pozzo.api.groupStartedEventHandler pozzo.api.savingsGroupsFacade
            autoLayout tb 300 300
        }

        component pozzo.api "ComponentesIdentityAccess" "Componentes del bounded context Identity & Access dentro de los servicios RESTful." {
            include "element.tag==IdentityAccess"
            include pozzo.mobile pozzo.db smsProvider
            autoLayout tb 300 300
        }

        deployment pozzo production "DespliegueProduccion" "Dónde corre cada contenedor de Pozzo en producción." {
            include *
            autoLayout lr 300 300
        }

        styles {
            element "Person" {
                shape Person
                background #0f766e
                color #ffffff
            }
            element "Software System" {
                background #115e59
                color #ffffff
            }
            element "Externo" {
                background #9ca3af
                color #ffffff
            }
            element "Container" {
                background #14b8a6
                color #ffffff
            }
            element "Móvil" {
                shape MobileDevicePortrait
            }
            element "Web" {
                shape WebBrowser
            }
            element "Base de datos" {
                shape Cylinder
            }
            element "Component" {
                background #5eead4
                color #134e4a
            }
        }

    }
}
