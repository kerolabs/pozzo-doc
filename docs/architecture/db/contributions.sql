-- Bounded Context: Contributions (core)
-- Esquema PostgreSQL 16. Un ciclo por junta iniciada; un periodo por turno;
-- un aporte por integrante y periodo, validado contra lo esperado.

CREATE SCHEMA IF NOT EXISTS contributions;

CREATE TABLE contributions.cycles (
    id                  UUID PRIMARY KEY,
    group_id            UUID NOT NULL,
    contribution_amount NUMERIC(12, 2) NOT NULL,
    currency            CHAR(3) NOT NULL DEFAULT 'PEN',
    periodicity         VARCHAR(10) NOT NULL,
    cutoff_day          SMALLINT NOT NULL,
    destination_account VARCHAR(120) NOT NULL,
    total_turns         SMALLINT NOT NULL,
    current_turn        SMALLINT NOT NULL DEFAULT 1,
    status              VARCHAR(10) NOT NULL,
    started_at          TIMESTAMP NOT NULL,
    closed_at           TIMESTAMP,
    CONSTRAINT uq_cycles_group UNIQUE (group_id),
    CONSTRAINT ck_cycles_periodicity CHECK (periodicity IN ('WEEKLY', 'BIWEEKLY', 'MONTHLY')),
    CONSTRAINT ck_cycles_status CHECK (status IN ('ACTIVE', 'CLOSED'))
);

CREATE TABLE contributions.cycle_turns (
    cycle_id    UUID NOT NULL,
    turn_number SMALLINT NOT NULL,
    member_id   UUID NOT NULL,
    PRIMARY KEY (cycle_id, turn_number),
    CONSTRAINT fk_cycle_turns_cycle FOREIGN KEY (cycle_id) REFERENCES contributions.cycles (id),
    CONSTRAINT uq_cycle_turns_member UNIQUE (cycle_id, member_id)
);

CREATE TABLE contributions.periods (
    id               UUID PRIMARY KEY,
    cycle_id         UUID NOT NULL,
    turn_number      SMALLINT NOT NULL,
    opens_at         DATE NOT NULL,
    cutoff_date      DATE NOT NULL,
    payout_member_id UUID NOT NULL,
    status           VARCHAR(15) NOT NULL,
    delivered_at     TIMESTAMP,
    delivered_by     UUID,
    CONSTRAINT fk_periods_cycle FOREIGN KEY (cycle_id) REFERENCES contributions.cycles (id),
    CONSTRAINT uq_periods_turn UNIQUE (cycle_id, turn_number),
    CONSTRAINT ck_periods_status CHECK (status IN ('OPEN', 'POT_COMPLETE', 'DELIVERED'))
);

CREATE TABLE contributions.expected_contributions (
    id                     UUID PRIMARY KEY,
    period_id              UUID NOT NULL,
    member_id              UUID NOT NULL,
    amount                 NUMERIC(12, 2) NOT NULL,
    status                 VARCHAR(10) NOT NULL DEFAULT 'PENDING',
    settled_by_contribution UUID,
    CONSTRAINT fk_expected_period FOREIGN KEY (period_id) REFERENCES contributions.periods (id),
    CONSTRAINT uq_expected_member UNIQUE (period_id, member_id),
    CONSTRAINT ck_expected_status CHECK (status IN ('PENDING', 'PAID', 'COVERED', 'LATE'))
);

CREATE TABLE contributions.contributions (
    id                        UUID PRIMARY KEY,
    cycle_id                  UUID NOT NULL,
    period_id                 UUID NOT NULL,
    member_id                 UUID NOT NULL,
    amount                    NUMERIC(12, 2) NOT NULL,
    method                    VARCHAR(10) NOT NULL,
    status                    VARCHAR(15) NOT NULL,
    registered_at             TIMESTAMP NOT NULL,
    receipt_operation_number  VARCHAR(40),
    receipt_payer             VARCHAR(120),
    receipt_payee             VARCHAR(120),
    receipt_amount            NUMERIC(12, 2),
    receipt_paid_at           DATE,
    receipt_source            VARCHAR(10),
    covered_by_member_id      UUID,
    reviewed_by_member_id     UUID,
    review_note               VARCHAR(300),
    reviewed_at               TIMESTAMP,
    CONSTRAINT fk_contributions_cycle FOREIGN KEY (cycle_id) REFERENCES contributions.cycles (id),
    CONSTRAINT fk_contributions_period FOREIGN KEY (period_id) REFERENCES contributions.periods (id),
    CONSTRAINT uq_contributions_operation UNIQUE (cycle_id, receipt_operation_number),
    CONSTRAINT ck_contributions_method CHECK (method IN ('TRANSFER', 'CASH', 'COVERAGE')),
    CONSTRAINT ck_contributions_status CHECK (status IN ('REGISTERED', 'VALIDATED', 'INCONSISTENT', 'APPROVED', 'REJECTED')),
    CONSTRAINT ck_contributions_source CHECK (receipt_source IN ('YAPE', 'PLIN', 'BANK'))
);

CREATE TABLE contributions.contribution_inconsistencies (
    id              UUID PRIMARY KEY,
    contribution_id UUID NOT NULL,
    field           VARCHAR(40) NOT NULL,
    expected_value  VARCHAR(120) NOT NULL,
    found_value     VARCHAR(120) NOT NULL,
    CONSTRAINT fk_inconsistencies_contribution FOREIGN KEY (contribution_id) REFERENCES contributions.contributions (id)
);

ALTER TABLE contributions.expected_contributions
    ADD CONSTRAINT fk_expected_settled_by FOREIGN KEY (settled_by_contribution) REFERENCES contributions.contributions (id);

CREATE INDEX ix_contributions_period_member ON contributions.contributions (period_id, member_id);
CREATE INDEX ix_periods_cycle_status ON contributions.periods (cycle_id, status);
