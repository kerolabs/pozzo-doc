-- Bounded Context: Notifications (generic)
-- Esquema PostgreSQL 16. Dispositivos registrados, plan de recordatorios por
-- junta y cada notificacion programada o enviada.

CREATE SCHEMA IF NOT EXISTS notifications;

CREATE TABLE notifications.devices (
    id            UUID PRIMARY KEY,
    member_id     UUID NOT NULL,
    push_token    VARCHAR(255) NOT NULL,
    platform      VARCHAR(10) NOT NULL,
    registered_at TIMESTAMP NOT NULL,
    active        BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uq_devices_token UNIQUE (push_token),
    CONSTRAINT ck_devices_platform CHECK (platform IN ('ANDROID', 'IOS'))
);

CREATE TABLE notifications.reminder_plans (
    id              UUID PRIMARY KEY,
    group_id        UUID NOT NULL,
    offsets_in_days VARCHAR(30) NOT NULL DEFAULT '3,1,0',
    send_hour       SMALLINT NOT NULL DEFAULT 9,
    enabled         BOOLEAN NOT NULL DEFAULT TRUE,
    updated_at      TIMESTAMP NOT NULL,
    CONSTRAINT uq_reminder_plans_group UNIQUE (group_id),
    CONSTRAINT ck_reminder_plans_hour CHECK (send_hour BETWEEN 0 AND 23)
);

CREATE TABLE notifications.notifications (
    id           UUID PRIMARY KEY,
    member_id    UUID NOT NULL,
    group_id     UUID NOT NULL,
    period_id    UUID,
    kind         VARCHAR(10) NOT NULL,
    title        VARCHAR(80) NOT NULL,
    body         VARCHAR(240) NOT NULL,
    deep_link    VARCHAR(200),
    dedup_key    VARCHAR(120) NOT NULL,
    scheduled_at TIMESTAMP NOT NULL,
    sent_at      TIMESTAMP,
    status       VARCHAR(10) NOT NULL DEFAULT 'SCHEDULED',
    attempts     SMALLINT NOT NULL DEFAULT 0,
    CONSTRAINT uq_notifications_dedup UNIQUE (dedup_key),
    CONSTRAINT ck_notifications_kind CHECK (kind IN ('REMINDER', 'ALERT')),
    CONSTRAINT ck_notifications_status CHECK (status IN ('SCHEDULED', 'SENT', 'CANCELLED', 'FAILED'))
);

CREATE TABLE notifications.deliveries (
    id              UUID PRIMARY KEY,
    notification_id UUID NOT NULL,
    device_id       UUID NOT NULL,
    attempted_at    TIMESTAMP NOT NULL,
    result          VARCHAR(10) NOT NULL,
    provider_message_id VARCHAR(120),
    error           VARCHAR(200),
    CONSTRAINT fk_deliveries_notification FOREIGN KEY (notification_id) REFERENCES notifications.notifications (id),
    CONSTRAINT fk_deliveries_device FOREIGN KEY (device_id) REFERENCES notifications.devices (id),
    CONSTRAINT ck_deliveries_result CHECK (result IN ('DELIVERED', 'FAILED'))
);

CREATE INDEX ix_notifications_due ON notifications.notifications (status, scheduled_at);
CREATE INDEX ix_notifications_period_member ON notifications.notifications (period_id, member_id, status);
CREATE INDEX ix_devices_member ON notifications.devices (member_id, active);
