-- Bounded Context: Identity & Access (generic)
-- Esquema PostgreSQL 16. Cuentas identificadas por celular, codigos de
-- verificacion por SMS y sesiones abiertas en cada dispositivo.

CREATE SCHEMA IF NOT EXISTS identity_access;

CREATE TABLE identity_access.accounts (
    id                UUID PRIMARY KEY,
    phone_number      VARCHAR(20) NOT NULL,
    display_name      VARCHAR(80) NOT NULL,
    photo_url         VARCHAR(300),
    theme             VARCHAR(10) NOT NULL DEFAULT 'SYSTEM',
    terms_accepted_at TIMESTAMP NOT NULL,
    status            VARCHAR(12) NOT NULL DEFAULT 'ACTIVE',
    created_at        TIMESTAMP NOT NULL,
    updated_at        TIMESTAMP NOT NULL,
    CONSTRAINT uq_accounts_phone UNIQUE (phone_number),
    CONSTRAINT ck_accounts_theme CHECK (theme IN ('SYSTEM', 'LIGHT', 'DARK')),
    CONSTRAINT ck_accounts_status CHECK (status IN ('ACTIVE', 'DEACTIVATED'))
);

CREATE TABLE identity_access.verification_codes (
    id           UUID PRIMARY KEY,
    phone_number VARCHAR(20) NOT NULL,
    code_hash    VARCHAR(120) NOT NULL,
    issued_at    TIMESTAMP NOT NULL,
    expires_at   TIMESTAMP NOT NULL,
    attempts     SMALLINT NOT NULL DEFAULT 0,
    status       VARCHAR(10) NOT NULL DEFAULT 'PENDING',
    CONSTRAINT ck_codes_status CHECK (status IN ('PENDING', 'VERIFIED', 'EXPIRED', 'BLOCKED')),
    CONSTRAINT ck_codes_attempts CHECK (attempts BETWEEN 0 AND 3)
);

CREATE TABLE identity_access.sessions (
    id           UUID PRIMARY KEY,
    account_id   UUID NOT NULL,
    token_hash   VARCHAR(120) NOT NULL,
    device_label VARCHAR(80),
    issued_at    TIMESTAMP NOT NULL,
    expires_at   TIMESTAMP NOT NULL,
    revoked_at   TIMESTAMP,
    CONSTRAINT fk_sessions_account FOREIGN KEY (account_id) REFERENCES identity_access.accounts (id),
    CONSTRAINT uq_sessions_token UNIQUE (token_hash)
);

CREATE INDEX ix_codes_phone_status ON identity_access.verification_codes (phone_number, status);
CREATE INDEX ix_sessions_account ON identity_access.sessions (account_id, revoked_at);
