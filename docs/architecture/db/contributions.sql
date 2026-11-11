-- Bounded Context: Contributions (core)
-- Esquema PostgreSQL 16. Un ciclo por junta iniciada; un periodo por turno;
-- un aporte por integrante y periodo, validado contra lo esperado; en las
-- juntas por subasta, una subasta por periodo con sus ofertas.
-- Los integrantes se identifican por su membresía en la junta, con la cuenta
-- opcional, porque quien no usa la aplicación también aporta.

CREATE SCHEMA IF NOT EXISTS contributions;

CREATE TABLE contributions.cycles (
    id                  UUID PRIMARY KEY,
    group_id            UUID NOT NULL,
    group_name          VARCHAR(60) NOT NULL,
    organizer_account_id UUID NOT NULL,
    contribution_amount NUMERIC(12, 2) NOT NULL,
    currency            CHAR(3) NOT NULL DEFAULT 'PEN',
    periodicity         VARCHAR(10) NOT NULL,
    first_contribution_date DATE NOT NULL,
    cutoff_day          SMALLINT NOT NULL,
    destination_method  VARCHAR(10) NOT NULL,
    destination_phone   VARCHAR(9) NOT NULL,
    payee_name          VARCHAR(80) NOT NULL,
    total_turns         SMALLINT NOT NULL,
    current_turn        SMALLINT NOT NULL DEFAULT 1,
    status              VARCHAR(10) NOT NULL,
    started_at          TIMESTAMP NOT NULL,
    closed_at           TIMESTAMP,
    auction_closes_days_before SMALLINT,
    auction_minimum_bid NUMERIC(12, 2),
    auction_fallback    VARCHAR(10),
    CONSTRAINT uq_cycles_group UNIQUE (group_id),
    CONSTRAINT ck_cycles_periodicity CHECK (periodicity IN ('WEEKLY', 'BIWEEKLY', 'MONTHLY')),
    CONSTRAINT ck_cycles_destination CHECK (destination_method IN ('YAPE', 'PLIN')),
    CONSTRAINT ck_cycles_status CHECK (status IN ('ACTIVE', 'CLOSED')),
    CONSTRAINT ck_cycles_auction_fallback CHECK (auction_fallback IN ('DRAW', 'ORGANIZER'))
);

CREATE TABLE contributions.cycle_turns (
    cycle_id      UUID NOT NULL,
    turn_number   SMALLINT NOT NULL,
    membership_id UUID NOT NULL,
    account_id    UUID,
    display_name  VARCHAR(60) NOT NULL,
    PRIMARY KEY (cycle_id, turn_number),
    CONSTRAINT fk_cycle_turns_cycle FOREIGN KEY (cycle_id) REFERENCES contributions.cycles (id),
    CONSTRAINT uq_cycle_turns_membership UNIQUE (cycle_id, membership_id)
);

CREATE TABLE contributions.periods (
    id               UUID PRIMARY KEY,
    cycle_id         UUID NOT NULL,
    turn_number      SMALLINT NOT NULL,
    opens_at         DATE NOT NULL,
    cutoff_date      DATE NOT NULL,
    payout_membership_id UUID NOT NULL,
    status           VARCHAR(15) NOT NULL,
    delivered_at     TIMESTAMP,
    delivered_by     UUID,
    payout_proof_path VARCHAR(200),
    discount_amount  NUMERIC(12, 2),
    CONSTRAINT fk_periods_cycle FOREIGN KEY (cycle_id) REFERENCES contributions.cycles (id),
    CONSTRAINT uq_periods_turn UNIQUE (cycle_id, turn_number),
    CONSTRAINT ck_periods_status CHECK (status IN ('OPEN', 'POT_COMPLETE', 'DELIVERED'))
);

CREATE TABLE contributions.expected_contributions (
    id                     UUID PRIMARY KEY,
    period_id              UUID NOT NULL,
    membership_id          UUID NOT NULL,
    amount                 NUMERIC(12, 2) NOT NULL,
    currency               CHAR(3) NOT NULL DEFAULT 'PEN',
    status                 VARCHAR(10) NOT NULL DEFAULT 'PENDING',
    settled_by_contribution UUID,
    CONSTRAINT fk_expected_period FOREIGN KEY (period_id) REFERENCES contributions.periods (id),
    CONSTRAINT uq_expected_member UNIQUE (period_id, membership_id),
    CONSTRAINT ck_expected_status CHECK (status IN ('PENDING', 'PAID', 'COVERED'))
);

CREATE TABLE contributions.contributions (
    id                        UUID PRIMARY KEY,
    cycle_id                  UUID NOT NULL,
    period_id                 UUID NOT NULL,
    membership_id             UUID NOT NULL,
    account_id                UUID,
    amount                    NUMERIC(12, 2) NOT NULL,
    currency                  CHAR(3) NOT NULL DEFAULT 'PEN',
    method                    VARCHAR(10) NOT NULL,
    status                    VARCHAR(15) NOT NULL,
    registered_by_account_id  UUID NOT NULL,
    registered_at             TIMESTAMP NOT NULL,
    receipt_operation_number  VARCHAR(40),
    receipt_image_path        VARCHAR(200),
    receipt_payer             VARCHAR(120),
    receipt_payee             VARCHAR(120),
    receipt_amount            NUMERIC(12, 2),
    receipt_paid_at           DATE,
    receipt_source            VARCHAR(10),
    received_on               DATE,
    verification_token        VARCHAR(40),
    covered_by_membership_id  UUID,
    reviewed_by_account_id    UUID,
    review_decision           VARCHAR(10),
    review_note               VARCHAR(300),
    reviewed_at               TIMESTAMP,
    CONSTRAINT fk_contributions_cycle FOREIGN KEY (cycle_id) REFERENCES contributions.cycles (id),
    CONSTRAINT fk_contributions_period FOREIGN KEY (period_id) REFERENCES contributions.periods (id),
    CONSTRAINT uq_contributions_operation UNIQUE (cycle_id, receipt_operation_number),
    CONSTRAINT uq_contributions_token UNIQUE (verification_token),
    CONSTRAINT ck_contributions_method CHECK (method IN ('TRANSFER', 'CASH', 'COVERAGE')),
    CONSTRAINT ck_contributions_status CHECK (status IN ('VALIDATED', 'INCONSISTENT', 'APPROVED', 'REJECTED')),
    CONSTRAINT ck_contributions_decision CHECK (review_decision IN ('APPROVE', 'REJECT')),
    CONSTRAINT ck_contributions_source CHECK (receipt_source IN ('YAPE', 'PLIN', 'BANK'))
);

CREATE TABLE contributions.contribution_inconsistencies (
    contribution_id UUID NOT NULL,
    field           VARCHAR(40) NOT NULL,
    expected_value  VARCHAR(120) NOT NULL,
    found_value     VARCHAR(120) NOT NULL,
    CONSTRAINT fk_inconsistencies_contribution FOREIGN KEY (contribution_id) REFERENCES contributions.contributions (id)
);

CREATE TABLE contributions.auctions (
    id                   UUID PRIMARY KEY,
    cycle_id             UUID NOT NULL,
    period_id            UUID NOT NULL,
    turn_number          SMALLINT NOT NULL,
    closes_on            DATE NOT NULL,
    currency             CHAR(3) NOT NULL DEFAULT 'PEN',
    minimum_bid          NUMERIC(12, 2) NOT NULL,
    pot_amount           NUMERIC(12, 2) NOT NULL,
    fallback             VARCHAR(10) NOT NULL,
    status               VARCHAR(10) NOT NULL DEFAULT 'OPEN',
    winner_membership_id UUID,
    discount             NUMERIC(12, 2),
    credit_per_member    NUMERIC(12, 2),
    resolution           VARCHAR(10),
    closed_at            TIMESTAMP,
    CONSTRAINT fk_auctions_cycle FOREIGN KEY (cycle_id) REFERENCES contributions.cycles (id),
    CONSTRAINT fk_auctions_period FOREIGN KEY (period_id) REFERENCES contributions.periods (id),
    CONSTRAINT uq_auctions_period UNIQUE (period_id),
    CONSTRAINT ck_auctions_fallback CHECK (fallback IN ('DRAW', 'ORGANIZER')),
    CONSTRAINT ck_auctions_status CHECK (status IN ('OPEN', 'CLOSED')),
    CONSTRAINT ck_auctions_resolution CHECK (resolution IN ('BID', 'DRAW', 'ORGANIZER'))
);

CREATE TABLE contributions.auction_bids (
    auction_id    UUID NOT NULL,
    membership_id UUID NOT NULL,
    amount        NUMERIC(12, 2) NOT NULL,
    placed_at     TIMESTAMP NOT NULL,
    CONSTRAINT fk_auction_bids_auction FOREIGN KEY (auction_id) REFERENCES contributions.auctions (id),
    CONSTRAINT uq_auction_bids_member UNIQUE (auction_id, membership_id),
    CONSTRAINT ck_auction_bids_amount CHECK (amount > 0)
);

ALTER TABLE contributions.expected_contributions
    ADD CONSTRAINT fk_expected_settled_by FOREIGN KEY (settled_by_contribution) REFERENCES contributions.contributions (id);

CREATE INDEX ix_contributions_period_member ON contributions.contributions (period_id, membership_id);
CREATE INDEX ix_periods_cycle_status ON contributions.periods (cycle_id, status);
CREATE INDEX ix_auctions_status ON contributions.auctions (status);
