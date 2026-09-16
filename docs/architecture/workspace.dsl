workspace "Pozzo" "Arquitectura de software de Pozzo con el C4 Model: contexto, contenedores y despliegue." {

    !identifiers hierarchical

    model {
        organizer = person "Cabeza de junta" "Convoca la junta, define sus reglas, incorpora integrantes, revisa aportes con inconsistencia y entrega el pozo en cada turno."
        member = person "Participante" "Se une a una junta, registra su aporte con el comprobante y consulta el estado del pozo y su historial."
        visitor = person "Visitante" "Conoce Pozzo desde el landing page y descarga la aplicación."

        smsProvider = softwareSystem "Proveedor de SMS" "Envía el código de verificación al número de celular del integrante." "Externo"
        fcm = softwareSystem "Firebase Cloud Messaging" "Entrega las notificaciones push a los dispositivos, aunque la aplicación esté cerrada." "Externo"
        wallets = softwareSystem "Yape, Plin y aplicaciones bancarias" "Donde ocurre la transferencia del aporte. Pozzo solo recibe la captura del comprobante." "Externo"
        whatsapp = softwareSystem "WhatsApp" "Canal por el que la cabeza comparte el enlace de invitación." "Externo"

        pozzo = softwareSystem "Pozzo" "Organiza juntas de ahorro: registra y valida los aportes contra el comprobante, muestra el estado del pozo a todo el grupo y recuerda a quien no ha aportado." {

            landing = container "Landing Page" "Sitio estático que presenta el problema, la propuesta de valor y el acceso a la aplicación." "HTML, CSS, JavaScript" "Web"

            mobile = container "Aplicación móvil" "Experiencia de la cabeza de junta y del participante: crear y unirse a juntas, registrar aportes con el comprobante (leído en el dispositivo con ML Kit), consultar el pozo y recibir avisos." "Kotlin, Jetpack Compose, Material 3, ML Kit Text Recognition" "Móvil"

            localStore = container "Almacenamiento local" "Copia de la sesión, la junta vigente y sus períodos para consultar la junta sin conexión." "Room (SQLite)" "Base de datos"

            api = container "Servicios RESTful" "Implementa los cinco bounded contexts como módulos: Identity & Access, Savings Groups, Contributions, Notifications y Compliance History. Expone la API documentada con OpenAPI." "Java 21, Spring Boot 3, Spring Security, springdoc-openapi" "API" {

                # Bounded Context: Contributions
                contributionsController = component "ContributionsController" "Endpoints para registrar un aporte con comprobante, en efectivo o como cobertura, y para aprobar o rechazar los que tienen inconsistencias." "Spring MVC REST Controller" "Contributions,Interface"
                periodsController = component "PeriodsController" "Endpoints para consultar el estado del pozo, los períodos anteriores y la proyección, registrar la entrega del pozo y cerrar la junta." "Spring MVC REST Controller" "Contributions,Interface"
                contributionCommandService = component "ContributionCommandService" "Atiende los comandos de registro, efectivo, cobertura y revisión de aportes; coordina la validación y publica los eventos." "Spring Service" "Contributions,Application"
                cycleCommandService = component "CycleCommandService" "Atiende los comandos de inicio del ciclo, entrega del pozo y cierre; abre el siguiente período." "Spring Service" "Contributions,Application"
                periodQueryService = component "PeriodQueryService" "Resuelve las consultas del estado del pozo, períodos anteriores, proyección, aportes del integrante y pendientes de revisión." "Spring Service" "Contributions,Application"
                contributionsEventHandlers = component "Contributions Event Handlers" "Reacciona a Junta iniciada y Reemplazo incorporado (Savings Groups) y a Aporte validado y Pozo entregado (propios) para abrir períodos y completar el pozo." "Spring Event Listeners" "Contributions,Application"
                contributionsDomain = component "Contributions Domain Model" "Agregados Cycle, Period y Contribution, sus value objects y el servicio de dominio ContributionValidationService con las reglas de validación." "Java, POJOs" "Contributions,Domain"
                contributionsRepositories = component "Contributions Repositories" "Implementación JPA de CycleRepository, PeriodRepository y ContributionRepository sobre el esquema contributions." "Spring Data JPA" "Contributions,Infrastructure"
                savingsGroupsFacade = component "ExternalSavingsGroupsService" "Capa anticorrupción que traduce reglas, integrantes y turnos de Savings Groups al modelo de Contributions." "Spring Service (ACL)" "Contributions,Infrastructure"

                # Bounded Context: Savings Groups
                savingsGroupsController = component "SavingsGroupsController" "Endpoints para crear la junta, definir el destino de los aportes, consultar sus reglas e iniciarla." "Spring MVC REST Controller" "SavingsGroups,Interface"
                membershipsController = component "MembershipsController" "Endpoints de invitaciones, unirse con código o enlace, agregar integrantes sin la aplicación, retirarlos y registrar deserciones." "Spring MVC REST Controller" "SavingsGroups,Interface"
                turnsController = component "TurnsController" "Endpoints para asignar turnos por sorteo u orden acordado, abrir y cerrar subastas, ofertar y consultar el calendario." "Spring MVC REST Controller" "SavingsGroups,Interface"
                savingsGroupCommandService = component "SavingsGroupCommandService" "Atiende los comandos de la junta, los integrantes, las invitaciones y el inicio; publica los eventos." "Spring Service" "SavingsGroups,Application"
                turnCommandService = component "TurnCommandService" "Atiende la asignación de turnos y el ciclo de vida de las subastas con el servicio de dominio TurnAssignmentService." "Spring Service" "SavingsGroups,Application"
                savingsGroupQueryService = component "SavingsGroupQueryService" "Resuelve reglas, lista de integrantes, calendario de turnos, resumen por invitación y ofertas vigentes." "Spring Service" "SavingsGroups,Application"
                savingsGroupsDomain = component "Savings Groups Domain Model" "Agregados SavingsGroup, Invitation y Auction, sus entidades y value objects, y el servicio de dominio TurnAssignmentService." "Java, POJOs" "SavingsGroups,Domain"
                savingsGroupsRepositories = component "Savings Groups Repositories" "Implementación JPA de SavingsGroupRepository, InvitationRepository y AuctionRepository sobre el esquema savings_groups." "Spring Data JPA" "SavingsGroups,Infrastructure"
                complianceHistoryFacade = component "ExternalComplianceHistoryService" "Capa anticorrupción que consulta el resumen de cumplimiento de un integrante a Compliance History." "Spring Service (ACL)" "SavingsGroups,Infrastructure"

                # Bounded Context: Compliance History
                complianceHistoryController = component "ComplianceHistoryController" "Endpoints para consultar el historial propio, el de un integrante que se une, compartirlo y ver un historial compartido." "Spring MVC REST Controller" "ComplianceHistory,Interface"
                complianceCommandService = component "ComplianceCommandService" "Registra hechos de cumplimiento y emite enlaces para compartir el historial." "Spring Service" "ComplianceHistory,Application"
                complianceQueryService = component "ComplianceQueryService" "Resuelve el resumen y el detalle del historial, propio, de otro integrante o por enlace compartido." "Spring Service" "ComplianceHistory,Application"
                complianceEventHandlers = component "Compliance Event Handlers" "Traduce Aporte validado, rechazado o cubierto, Integrante desertó y Ciclo cerrado a hechos de cumplimiento (capa anticorrupción)." "Spring Event Listeners" "ComplianceHistory,Application"
                complianceDomain = component "Compliance History Domain Model" "Agregados MemberRecord y ShareLink, la entidad ComplianceEntry y el servicio de dominio ComplianceScoringService." "Java, POJOs" "ComplianceHistory,Domain"
                complianceRepositories = component "Compliance History Repositories" "Implementación JPA de MemberRecordRepository y ShareLinkRepository sobre el esquema compliance_history." "Spring Data JPA" "ComplianceHistory,Infrastructure"

                # Bounded Context: Notifications
                devicesController = component "DevicesController" "Endpoints para registrar y dar de baja el dispositivo del integrante." "Spring MVC REST Controller" "Notifications,Interface"
                reminderPlansController = component "ReminderPlansController" "Endpoints para consultar y configurar los recordatorios de una junta." "Spring MVC REST Controller" "Notifications,Interface"
                notificationsController = component "NotificationsController" "Endpoint para consultar los avisos recibidos por el integrante." "Spring MVC REST Controller" "Notifications,Interface"
                notificationCommandService = component "NotificationCommandService" "Registra dispositivos, configura planes, programa y cancela recordatorios y crea avisos deduplicados." "Spring Service" "Notifications,Application"
                notificationQueryService = component "NotificationQueryService" "Resuelve los avisos recibidos y el plan de recordatorios de una junta." "Spring Service" "Notifications,Application"
                notificationEventHandlers = component "Notification Event Handlers" "Reacciona a Período abierto, Aporte validado, Aporte rechazado, Pozo completo, Pozo entregado, Junta iniciada, Turnos asignados y Ciclo cerrado." "Spring Event Listeners" "Notifications,Application"
                notificationDispatcher = component "NotificationDispatcher" "Tarea programada que toma las notificaciones vencidas, las envía por FCM y registra el resultado." "Spring @Scheduled" "Notifications,Application"
                notificationsDomain = component "Notifications Domain Model" "Agregados Device, ReminderPlan y Notification, sus value objects y el servicio de dominio ReminderSchedulingService." "Java, POJOs" "Notifications,Domain"
                notificationsRepositories = component "Notifications Repositories" "Implementación JPA de DeviceRepository, ReminderPlanRepository y NotificationRepository sobre el esquema notifications." "Spring Data JPA" "Notifications,Infrastructure"
                fcmPushSender = component "FcmPushSender" "Adaptador que envía notificaciones push con el SDK de Firebase Admin." "Firebase Admin SDK" "Notifications,Infrastructure"

                # Bounded Context: Identity & Access
                authenticationController = component "AuthenticationController" "Endpoints para solicitar el código SMS, verificarlo, completar el registro y cerrar sesión." "Spring MVC REST Controller" "IdentityAccess,Interface"
                profilesController = component "ProfilesController" "Endpoints para consultar y actualizar el perfil y el tema visual." "Spring MVC REST Controller" "IdentityAccess,Interface"
                authenticationCommandService = component "AuthenticationCommandService" "Emite y verifica códigos, crea cuentas, abre y revoca sesiones." "Spring Service" "IdentityAccess,Application"
                accountQueryService = component "AccountQueryService" "Resuelve el perfil, la existencia de una cuenta por celular y la validación del token." "Spring Service" "IdentityAccess,Application"
                identityDomain = component "Identity & Access Domain Model" "Agregados Account, VerificationCode y Session, sus value objects y los servicios de dominio CodeGenerationService y TokenService." "Java, POJOs" "IdentityAccess,Domain"
                identityRepositories = component "Identity & Access Repositories" "Implementación JPA de AccountRepository, VerificationCodeRepository y SessionRepository sobre el esquema identity_access." "Spring Data JPA" "IdentityAccess,Infrastructure"
                smsSender = component "SmsSender" "Adaptador (capa anticorrupción) hacia el proveedor de SMS." "Spring Service (ACL)" "IdentityAccess,Infrastructure"
                jwtTokenService = component "JwtTokenService" "Implementación de TokenService con JSON Web Tokens firmados." "Spring Security, jjwt" "IdentityAccess,Infrastructure"
                authorizationFilter = component "BearerAuthorizationFilter" "Filtro que valida el token de cada solicitud y expone la identidad del integrante a los demás módulos." "Spring Security Filter" "IdentityAccess,Infrastructure"
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

        # Contenedores
        pozzo.mobile -> pozzo.localStore "Guarda la sesión y la copia local de la junta" "Room"
        pozzo.mobile -> pozzo.api "Consume la API: autenticación, juntas, integrantes, turnos, aportes, entrega, historial y registro del dispositivo" "JSON/HTTPS"

        # Contributions: componentes
        pozzo.mobile -> pozzo.api.contributionsController "Registra, revisa y consulta aportes" "JSON/HTTPS"
        pozzo.mobile -> pozzo.api.periodsController "Consulta el pozo, entrega y cierra" "JSON/HTTPS"
        pozzo.api.contributionsController -> pozzo.api.contributionCommandService "Envía comandos"
        pozzo.api.contributionsController -> pozzo.api.periodQueryService "Envía consultas"
        pozzo.api.periodsController -> pozzo.api.cycleCommandService "Envía comandos"
        pozzo.api.periodsController -> pozzo.api.periodQueryService "Envía consultas"
        pozzo.api.contributionCommandService -> pozzo.api.contributionsDomain "Usa los agregados y el servicio de validación"
        pozzo.api.cycleCommandService -> pozzo.api.contributionsDomain "Usa los agregados"
        pozzo.api.contributionCommandService -> pozzo.api.contributionsRepositories "Lee y guarda"
        pozzo.api.cycleCommandService -> pozzo.api.contributionsRepositories "Lee y guarda"
        pozzo.api.periodQueryService -> pozzo.api.contributionsRepositories "Lee"
        pozzo.api.contributionsEventHandlers -> pozzo.api.cycleCommandService "Dispara inicio de ciclo y apertura de períodos"
        pozzo.api.contributionsEventHandlers -> pozzo.api.contributionsRepositories "Lee y guarda"
        pozzo.api.cycleCommandService -> pozzo.api.savingsGroupsFacade "Obtiene reglas, integrantes y turnos"
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
        pozzo.api.savingsGroupQueryService -> pozzo.api.complianceHistoryFacade "Obtiene el historial de quien se une"
        pozzo.api.savingsGroupsRepositories -> pozzo.db "Lee y escribe" "JDBC"
        pozzo.api.savingsGroupsFacade -> pozzo.api.savingsGroupQueryService "Consulta reglas, integrantes y turnos"
        pozzo.api.complianceHistoryFacade -> pozzo.api.complianceQueryService "Consulta el resumen de cumplimiento"

        # Compliance History: componentes
        pozzo.mobile -> pozzo.api.complianceHistoryController "Consulta y comparte el historial" "JSON/HTTPS"
        pozzo.api.complianceHistoryController -> pozzo.api.complianceCommandService "Envía comandos"
        pozzo.api.complianceHistoryController -> pozzo.api.complianceQueryService "Envía consultas"
        pozzo.api.complianceEventHandlers -> pozzo.api.complianceCommandService "Registra hechos de cumplimiento"
        pozzo.api.complianceCommandService -> pozzo.api.complianceDomain "Usa los agregados y el servicio de puntuación"
        pozzo.api.complianceCommandService -> pozzo.api.complianceRepositories "Lee y guarda"
        pozzo.api.complianceQueryService -> pozzo.api.complianceRepositories "Lee"
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
        pozzo.api.notificationCommandService -> pozzo.api.notificationsDomain "Usa los agregados y el servicio de programación"
        pozzo.api.notificationCommandService -> pozzo.api.notificationsRepositories "Lee y guarda"
        pozzo.api.notificationQueryService -> pozzo.api.notificationsRepositories "Lee"
        pozzo.api.notificationDispatcher -> pozzo.api.notificationsRepositories "Toma las notificaciones vencidas y registra el resultado"
        pozzo.api.notificationDispatcher -> pozzo.api.fcmPushSender "Envía"
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
        pozzo.api.authenticationCommandService -> pozzo.api.smsSender "Envía el código"
        pozzo.api.authenticationCommandService -> pozzo.api.jwtTokenService "Emite el token"
        pozzo.api.accountQueryService -> pozzo.api.identityRepositories "Lee"
        pozzo.api.authorizationFilter -> pozzo.api.jwtTokenService "Valida el token"
        pozzo.api.identityRepositories -> pozzo.db "Lee y escribe" "JDBC"
        pozzo.api.smsSender -> smsProvider "Solicita el envío del SMS" "HTTPS"
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
            deploymentNode "Railway" "" "Plataforma en la nube" {
                deploymentNode "Servicio web" "" "Contenedor Docker, Java 21" {
                    containerInstance pozzo.api
                }
                deploymentNode "PostgreSQL" "" "Servicio administrado" {
                    containerInstance pozzo.db
                }
            }
            deploymentNode "Google Cloud" "" "Servicio de terceros" {
                softwareSystemInstance fcm
            }
            deploymentNode "Proveedor de SMS" "" "Servicio de terceros" {
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
            include pozzo.mobile pozzo.db
            autoLayout tb 300 300
        }

        component pozzo.api "ComponentesSavingsGroups" "Componentes del bounded context Savings Groups dentro de los servicios RESTful." {
            include "element.tag==SavingsGroups"
            include pozzo.mobile pozzo.db
            autoLayout tb 300 300
        }

        component pozzo.api "ComponentesComplianceHistory" "Componentes del bounded context Compliance History dentro de los servicios RESTful." {
            include "element.tag==ComplianceHistory"
            include pozzo.mobile pozzo.db
            autoLayout tb 300 300
        }

        component pozzo.api "ComponentesNotifications" "Componentes del bounded context Notifications dentro de los servicios RESTful." {
            include "element.tag==Notifications"
            include pozzo.mobile pozzo.db fcm
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
