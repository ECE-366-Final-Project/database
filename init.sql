-- ENUM : exampleEnum_ENUM
-- Table: example_table
-- Column : example_column

CREATE TABLE IF NOT EXISTS "user" (
    "username" varchar(16) UNIQUE NOT NULL,
    "user_id" serial PRIMARY KEY,
    "balance" numeric(19, 2) NOT NULL DEFAULT 0,
    "created_at" timestamp NOT NULL,
    "active" boolean NOT NULL DEFAULT true
);

CREATE TABLE IF NOT EXISTS "transaction_history" (
    "transaction_id" serial PRIMARY KEY,
    "user_id" integer NOT NULL REFERENCES "user" ("user_id"),
    "transaction_type" varchar(16) NOT NULL,
    "amount" numeric(19, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS "slots_symbols" (
    "symbol_id" integer PRIMARY KEY,
    "symbol_name" varchar(20) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS "slots_payouts" (
    "payout_id" integer PRIMARY KEY,
    "payout" numeric(10, 5) NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS "slots" (
    "slots_game_id" serial PRIMARY KEY,
    "user_id" integer NOT NULL REFERENCES "user" ("user_id"),
    "bet" numeric(19, 2) NOT NULL,
    "payout_id" integer NOT NULL REFERENCES "slots_payouts" ("payout_id"),
    "winnings" numeric(19, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS "blackjack" (
    "blackjack_game_id" serial PRIMARY KEY,
    "user_id" integer NOT NULL REFERENCES "user" ("user_id"),
    "bet" numeric(19, 2) NOT NULL,
    -- winnings or result(i.e. blackjack, stood and lost, etc...);
    "winnings" numeric(19, 2) DEFAULT null,
    "active" boolean NOT NULL DEFAULT true,
    "player_hand" varchar(22) DEFAULT null,
    "dealer_hand" varchar(22) DEFAULT null
);

CREATE TABLE IF NOT EXISTS "active_blackjack_games" (
    "user_id" integer PRIMARY KEY REFERENCES "user" ("user_id"),
    "bet" numeric(19, 2) NOT NULL,
    "deck" varchar(104) NOT NULL,
    "player_hand" varchar(22) NOT NULL,
    "dealer_hand" varchar(22) NOT NULL
);

-- add admin user for testing purposes
INSERT INTO public.user(username, created_at) VALUES ('admin', NOW())
	  ON CONFLICT (username) DO NOTHING;