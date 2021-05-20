import sqlite3
import xlrd
import csv
import os


file_path = 'timu.xlsx'

open_file = xlrd.open_workbook(file_path)

open_file.sheet_names()

# print("sheets: " + str(open_file.sheet_names()))
na = open_file.sheet_names()
table = open_file.sheet_by_name(na[0])
timus = table.col_values(0)


tableRows = table.nrows
print(tableRows) #行数

conn = sqlite3.connect('practiceServer.db')
c= conn.cursor()



for i in range(0,tableRows):
    table_data = table.row_values(i)
    timu = table_data[0]
    daan = table_data[1]
    # print("timu:: " + timu)
    # print("daan: "+ daan)
    # print("\n") 
    input_str = 'INSERT INTO TIKU (ID,TITLE,ANSWER) VALUES (NULL, \'{timu}\', \'{daan}\');'.format(timu=timu,daan=daan)
    # print(input_str)
    c.execute(input_str)

    
conn.commit()    
conn.close()
