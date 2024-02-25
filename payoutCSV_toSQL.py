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

long_string = "INSERT INTO slots_symbols(symbol_name)\nVALUES\n"

symbols = [x[:-1] for x in open("slots_symbols.txt", "r").readlines()]

for symbol in symbols:
    long_string += "\t(\'"+symbol+"\'),\n"
    
long_string = long_string[:-2]+";\n\n\n"

lines = [x[:-1].split(',') for x in open("payouts.csv", "r").readlines()[1:]]



long_string += "INSERT INTO slots_payouts(roll_1, roll_2, roll_3, payout)\nVALUES\n"

for line in lines:
    long_string += "\t("
    long_string += str(symbols.index(line[0])+1) + ","
    long_string += str(symbols.index(line[1])+1) + ","
    long_string += str(symbols.index(line[2])+1) + ","
    long_string += line[3]+"),\n"

long_string = long_string[:-2]+";\n\n\n"

output = open(input("Output File Name: "), "w")
output.writelines(long_string)
output.close()
