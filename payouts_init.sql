COPY slots_symbols(symbol_name)
FROM '/var/lib/postgresql/data/slots_symbols.txt'
DELIMITER ','
CSV HEADER;

COPY slots_payouts(
    SELECT symbol_id FROM slots_symbols Where symbol_name = roll_1, 
    SELECT symbol_id FROM slots_symbols Where symbol_name = roll_2,
    SELECT symbol_id FROM slots_symbols Where symbol_name = roll_3, 
    payout)
FROM '/var/lib/postgresql/data/payouts.csv'
DELIMITER ','
CSV HEADER;