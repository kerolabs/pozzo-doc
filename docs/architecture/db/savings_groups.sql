-- Bounded Context: Savings Groups (supporting)
-- Esquema PostgreSQL 16. La junta, sus integrantes, la invitacion vigente,
-- los turnos asignados y las subastas de turno.

CREATE SCHEMA IF NOT EXISTS savings_groups;

CREATE TABLE savings_groups.savings_groups (
    id                  UUID PRIMARY KEY,
    name                VARCHAR(80) NOT NULL,
    organizer_id        UUID NOT NULL,
    contribution_amount NUMERIC(12, 2) NOT NULL,
    currency            CHAR(3) NOT NULL DEFAULT 'PEN',
    periodicity         VARCHAR(10) NOT NULL,
    cutoff_day          SMALLINT NOT NULL,
    seats               SMALLINT NOT NULL,
    destination_account VARCHAR(120),
    turn_method         VARCHAR(10),
    status              VARCHAR(10) NOT NULL DEFAULT 'DRAFT',
    created_at          TIMESTAMP NOT NULL,
    started_at          TIMESTAMP,
    CONSTRAINT ck_groups_periodicity CHECK (periodicity IN ('WEEKLY', 'BIWEEKLY', 'MONTHLY')),
    CONSTRAINT ck_groups_turn_method CHECK (turn_method IN ('DRAW', 'AGREED', 'AUCTION')),
    CONSTRAINT ck_groups_status CHECK (status IN ('DRAFT', 'READY', 'STARTED', 'CLOSED')),
    CONSTRAINT ck_groups_seats CHECK (seats BETWEEN 2 AND 30)
);

CREATE TABLE savings_groups.memberships (
    id           UUID PRIMARY KEY,
    group_id     UUID NOT NULL,
    member_id    UUID,
    display_name VARCHAR(80) NOT NULL,
    phone        VARCHAR(20),
    kind         VARCHAR(10) NOT NULL,
    status       VARCHAR(12) NOT NULL DEFAULT 'ACTIVE',
    joined_at    TIMESTAMP NOT NULL,
    CONSTRAINT fk_memberships_group FOREIGN KEY (group_id) REFERENCES savings_groups.savings_groups (id),
    CONSTRAINT uq_memberships_member UNIQUE (group_id, member_id),
    CONSTRAINT ck_memberships_kind CHECK (kind IN ('APP', 'MANUAL')),
    CONSTRAINT ck_memberships_status CHECK (status IN ('ACTIVE', 'REMOVED', 'DROPPED', 'REPLACEMENT')),
    CONSTRAINT ck_memberships_identity CHECK ((kind = 'APP' AND member_id IS NOT NULL) OR (kind = 'MANUAL' AND phone IS NOT NULL))
);

CREATE TABLE savings_groups.invitations (
    id         UUID PRIMARY KEY,
    group_id   UUID NOT NULL,
    code       VARCHAR(8) NOT NULL,
    created_by UUID NOT NULL,
    created_at TIMESTAMP NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    status     VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_invitations_group FOREIGN KEY (group_id) REFERENCES savings_groups.savings_groups (id),
    CONSTRAINT uq_invitations_code UNIQUE (code),
    CONSTRAINT ck_invitations_status CHECK (status IN ('ACTIVE', 'EXPIRED'))
);

CREATE TABLE savings_groups.turn_slots (
    group_id      UUID NOT NULL,
    turn_number   SMALLINT NOT NULL,
    membership_id UUID NOT NULL,
    assigned_by   VARCHAR(10) NOT NULL,
    PRIMARY KEY (group_id, turn_number),
    CONSTRAINT fk_turn_slots_group FOREIGN KEY (group_id) REFERENCES savings_groups.savings_groups (id),
    CONSTRAINT fk_turn_slots_membership FOREIGN KEY (membership_id) REFERENCES savings_groups.memberships (id),
    CONSTRAINT uq_turn_slots_membership UNIQUE (group_id, membership_id),
    CONSTRAINT ck_turn_slots_assigned_by CHECK (assigned_by IN ('DRAW', 'AGREED', 'AUCTION'))
);

CREATE TABLE savings_groups.auctions (
    id          UUID PRIMARY KEY,
    group_id    UUID NOT NULL,
    turn_number SMALLINT NOT NULL,
    status      VARCHAR(10) NOT NULL DEFAULT 'OPEN',
    opened_at   TIMESTAMP NOT NULL,
    closed_at   TIMESTAMP,
    winner_id   UUID,
    CONSTRAINT fk_auctions_group FOREIGN KEY (group_id) REFERENCES savings_groups.savings_groups (id),
    CONSTRAINT fk_auctions_winner FOREIGN KEY (winner_id) REFERENCES savings_groups.memberships (id),
    CONSTRAINT uq_auctions_turn UNIQUE (group_id, turn_number),
    CONSTRAINT ck_auctions_status CHECK (status IN ('OPEN', 'CLOSED'))
);

CREATE TABLE savings_groups.bids (
    id            UUID PRIMARY KEY,
    auction_id    UUID NOT NULL,
    membership_id UUID NOT NULL,
    amount        NUMERIC(12, 2) NOT NULL,
    placed_at     TIMESTAMP NOT NULL,
    CONSTRAINT fk_bids_auction FOREIGN KEY (auction_id) REFERENCES savings_groups.auctions (id),
    CONSTRAINT fk_bids_membership FOREIGN KEY (membership_id) REFERENCES savings_groups.memberships (id),
    CONSTRAINT ck_bids_amount CHECK (amount > 0)
);

CREATE INDEX ix_memberships_member ON savings_groups.memberships (member_id);
CREATE INDEX ix_bids_auction_amount ON savings_groups.bids (auction_id, amount DESC);
