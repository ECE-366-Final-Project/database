symbols = [x[:-1] for x in open("slots_symbols.txt", "r").readlines()]

#  INSERT INTO slots_payouts(roll_1, roll_2, roll_3, payout) VALUES();

'''
INSERT INTO example
VALUES
  (100, 'Name 1', 'Value 1', 'Other 1'),
  (101, 'Name 2', 'Value 2', 'Other 2'),
  (102, 'Name 3', 'Value 3', 'Other 3'),
  (103, 'Name 4', 'Value 4', 'Other 4');
'''

long_string = "INSERT INTO slots_symbols(symbol_id, symbol_name)\nVALUES\n"

symbols = [x[:-1] for x in open("slots_symbols.txt", "r").readlines()]

i = 0

for symbol in symbols:
    long_string += "\t(\'"+str(i)+", "+symbol+"\'),\n"
    i += 1
    
long_string = long_string[:-2]+";\n\n\n"

lines = [x[:-1].split(',') for x in open("payouts.csv", "r").readlines()[1:]]



long_string += "INSERT INTO slots_payouts(payout_id, roll_1, roll_2, roll_3, payout)\nVALUES\n"

for line in lines:
    long_string += "\t("
    long_string += str((symbols.index(line[0]))*100+(symbols.index(line[1]))*10+symbols.index(line[2])) + ", "
    long_string += str(symbols.index(line[0])) + ", "
    long_string += str(symbols.index(line[1])) + ", "
    long_string += str(symbols.index(line[2])) + ", "
    long_string += line[3]+"),\n"

long_string = long_string[:-2]+";\n"

output = open(input("Output File Name: "), "w")
output.writelines(long_string)
output.close()
