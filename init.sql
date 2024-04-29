-- ENUM : exampleEnum_ENUM
-- Table: example_table
-- Column : example_column

CREATE TABLE IF NOT EXISTS "user" (
    "username" varchar(16) PRIMARY KEY,
    "passkey" varchar(64) NOT NULL,
    "balance" numeric(19, 2) NOT NULL DEFAULT 0,
    "created_at" timestamp NOT NULL,
    CHECK ("balance" >= 0)
);

CREATE TABLE IF NOT EXISTS "transaction_history" (
    "transaction_id" serial PRIMARY KEY,
    "username" varchar(16) NOT NULL REFERENCES "user" ("username"),
    "transaction_type" varchar(16) NOT NULL,
    "amount" numeric(19, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS "slots_symbols" (
    "symbol_id" integer PRIMARY KEY,
    "symbol_name" varchar(20) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS "slots_payouts" (
    "payout_id" integer PRIMARY KEY,
    "payout" numeric(10, 5) NOT NULL
);

CREATE TABLE IF NOT EXISTS "slots" (
    "slots_game_id" serial PRIMARY KEY,
    "username" varchar(16) NOT NULL REFERENCES "user" ("username"),
    "bet" numeric(19, 2) NOT NULL,
    "payout_id" integer NOT NULL REFERENCES "slots_payouts" ("payout_id"),
    "winnings" numeric(19, 2) NOT NULL,
    CHECK ("bet" > 0)
);

CREATE TABLE IF NOT EXISTS "blackjack" (
    "blackjack_game_id" serial PRIMARY KEY,
    "username" varchar(16) NOT NULL REFERENCES "user" ("username"),
    "bet" numeric(19, 2) NOT NULL,
    -- winnings or result(i.e. blackjack, stood and lost, etc...);
    "winnings" numeric(19, 2) DEFAULT null,
    "active" boolean NOT NULL DEFAULT true,
    "player_hand" varchar(22) DEFAULT null,
    "dealer_hand" varchar(22) DEFAULT null,
    CHECK ("bet" > 0)
);

CREATE TABLE IF NOT EXISTS "active_blackjack_games" (
    "username" varchar(16) PRIMARY KEY REFERENCES "user" ("username"),
    "bet" numeric(19, 2) NOT NULL,
    "deck" varchar(104) NOT NULL,
    "player_hand" varchar(22) NOT NULL,
    "dealer_hand" varchar(22) NOT NULL,
    CHECK ("bet" > 0)
);

CREATE TABLE IF NOT EXISTS "roulette" (
    "roulette_game_id" serial PRIMARY KEY,
	"username" varchar(16) REFERENCES "user" ("username"),
	"rolled_number" smallint NOT NULL,
	"winnings" numeric(19, 2) NOT NULL,
	"bet_json" varchar(1024)
);


INSERT INTO public.user("username", created_at, passkey) VALUES ('admin', NOW(), '170ffa3b63148dce14912b378ff5c1e8b1108bdb73841723a335a01ec91ac6a8')
	  ON CONFLICT ("username") DO NOTHING;
