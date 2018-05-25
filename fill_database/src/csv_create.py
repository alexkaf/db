import loader
import querries
import os

class Querries:

    def __init__(self,
                 filename):
        self.__filename = filename
        descr = open(filename,'w')
        descr.close()

    def to_querries(self,
                    list_of_csvs,
                    database,
                    list_of_tables):

        for csv,table in zip(list_of_csvs,list_of_tables): 
            df = loader.csv_to_pandas(csv)
            querries.to_insert(df,database,table,self.__filename)
            print(table)

 

if __name__ == '__main__':
    k = Querries('../Querries/myd.sql')
    csv_list = ['../CSVs/customers.csv',
                '../CSVs/employees.csv',
                '../CSVs/hotel_group.csv',
                '../CSVs/hotels.csv',
                '../CSVs/hotel_room.csv',
                '../CSVs/has_hotels.csv',
                '../CSVs/rents.csv',
                '../CSVs/payment_transaction.csv', 
                '../CSVs/reserves.csv',
                '../CSVs/works.csv',
                '../CSVs/logins.csv',
		'../CSVs/has_room.csv']
    tables_list = ['Customers',
                   'Employees',
                   'Hotel_Group',
                   'Hotels',
                   'Hotel_Room',
                   'Has_Hotels',
                   'Rents',
                   'Payment_Transaction',
                   'Reserves',
                   'Works',
                   'Logins',
		   'Has_Room']
    k.to_querries(csv_list,'ehotels',tables_list)
