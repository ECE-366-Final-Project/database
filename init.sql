-- ENUM : exampleEnum_ENUM
-- Table: example_table
-- Column : example_column

CREATE TABLE IF NOT EXISTS "user" (
  "username" varchar(16) UNIQUE NOT NULL,
  "user_id" SERIAL PRIMARY KEY,
  "balance" numeric(19,2) NOT NULL DEFAULT 0,
  "created_at" timestamp NOT NULL
);

CREATE TABLE IF NOT EXISTS "transaction_history" (
  "transaction_id" SERIAL PRIMARY KEY,
  "user_id" integer NOT NULL,
  "trasaction_type" varchar(16) NOT NULL,
  "amount" numeric(19,2) NOT NULL
);

-- CREATE TYPE gameType_ENUM AS ENUM('blackjack', 'slots');

-- CREATE TABLE IF NOT EXISTS "games" (
--   "game_id" SERIAL PRIMARY KEY,
--   "game_type" gameType_ENUM NOT NULL,
--   "user_id" integer NOT NULL,
--   "bet" numeric(19,2) NOT NULL,
--   "active" bool NOT NULL,
--   "winnings" numeric(19,2) DEFAULT null
-- );

CREATE TABLE IF NOT EXISTS "slots_symbols" (
  "symbol_id" integer PRIMARY KEY,
  "symbol_name" varchar(20) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS "slots_payouts" (
  "payout_id" integer PRIMARY KEY,
  "payout" numeric(10,5) NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS "slots" (
  -- "game_id" integer PRIMARY KEY NOT NULL,
  "slots_game_id" SERIAL PRIMARY KEY,
  "user_id" integer NOT NULL,
  "active" boolean NOT NULL,
  "bet" numeric(19,2) NOT NULL,
  "payout_id" integer,
  "winnings" numeric(19,2) DEFAULT null
);

CREATE TABLE IF NOT EXISTS "blackjack" (
  -- "game_id" integer UNIQUE PRIMARY KEY NOT NULL,
  "blackjack_game_id" SERIAL PRIMARY KEY,
  "user_id" integer NOT NULL,
  "active" boolean NOT NULL,
  "bet" numeric(19,2) NOT NULL,
  "player_hand" varchar(22) DEFAULT null,
  "dealer_hand" varchar(22) DEFAULT null
);

ALTER TABLE "transaction_history" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("user_id");

-- ALTER TABLE "games" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("user_id");

--ALTER TABLE "slots_payouts" ADD FOREIGN KEY ("roll_1") REFERENCES "slots_symbols" ("symbol_id");

--ALTER TABLE "slots_payouts" ADD FOREIGN KEY ("roll_2") REFERENCES "slots_symbols" ("symbol_id");

--ALTER TABLE "slots_payouts" ADD FOREIGN KEY ("roll_3") REFERENCES "slots_symbols" ("symbol_id");

-- ALTER TABLE "slots" ADD FOREIGN KEY ("game_id") REFERENCES "games" ("game_id");

ALTER TABLE "slots" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("user_id");

ALTER TABLE "slots" ADD FOREIGN KEY ("payout_id") REFERENCES "slots_payouts" ("payout_id");

-- ALTER TABLE "blackjack" ADD FOREIGN KEY ("game_id") REFERENCES "games" ("game_id");

ALTER TABLE "blackjack" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("user_id");
