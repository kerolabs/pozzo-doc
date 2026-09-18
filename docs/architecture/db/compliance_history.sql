-- Bounded Context: Compliance History (supporting)
-- Esquema PostgreSQL 16. Un registro por integrante, alimentado por los
-- eventos de Contributions y Savings Groups, y los enlaces para compartirlo.

CREATE SCHEMA IF NOT EXISTS compliance_history;

CREATE TABLE compliance_history.member_records (
    member_id        UUID PRIMARY KEY,
    on_time_count    INTEGER NOT NULL DEFAULT 0,
    late_count       INTEGER NOT NULL DEFAULT 0,
    covered_count    INTEGER NOT NULL DEFAULT 0,
    rejected_count   INTEGER NOT NULL DEFAULT 0,
    dropout_count    INTEGER NOT NULL DEFAULT 0,
    cycles_completed INTEGER NOT NULL DEFAULT 0,
    level            VARCHAR(10) NOT NULL DEFAULT 'NEW',
    updated_at       TIMESTAMP NOT NULL,
    CONSTRAINT ck_records_level CHECK (level IN ('EXCELLENT', 'GOOD', 'REGULAR', 'RISKY', 'NEW'))
);

CREATE TABLE compliance_history.compliance_entries (
    id              UUID PRIMARY KEY,
    member_id       UUID NOT NULL,
    cycle_id        UUID NOT NULL,
    period_id       UUID,
    kind            VARCHAR(16) NOT NULL,
    occurred_at     TIMESTAMP NOT NULL,
    source_event_id VARCHAR(64) NOT NULL,
    CONSTRAINT fk_entries_record FOREIGN KEY (member_id) REFERENCES compliance_history.member_records (member_id),
    CONSTRAINT uq_entries_source UNIQUE (source_event_id),
    CONSTRAINT ck_entries_kind CHECK (kind IN ('ON_TIME', 'LATE', 'COVERED', 'REJECTED', 'DROPOUT', 'CYCLE_COMPLETED'))
);

CREATE TABLE compliance_history.share_links (
    token      VARCHAR(32) PRIMARY KEY,
    member_id  UUID NOT NULL,
    created_at TIMESTAMP NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    revoked    BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT fk_share_links_record FOREIGN KEY (member_id) REFERENCES compliance_history.member_records (member_id)
);

CREATE INDEX ix_entries_member_cycle ON compliance_history.compliance_entries (member_id, cycle_id);
CREATE INDEX ix_share_links_member ON compliance_history.share_links (member_id, expires_at);
