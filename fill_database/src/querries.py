import pandas as pd 
import loader
import sys

# Function to create querries out of a dataframe.
def to_insert(dataframe,
              database,
              table,  
              export_path
              ):
    
    # Read dataframe keys.
    df_keys = tuple(dataframe.keys())

    # Open the export_path file to save the data.
    with open(export_path,'a') as output:

        # Redirect output to file.
        prev = sys.stdout
        sys.stdout = output

        # Make command to use the table.
        print('USE {};'.format(database))

        # Check each row for missing keys.
        for key,index in dataframe.iterrows():
            df_indexes = tuple(index)
            size = len(df_indexes)

            # Make the querry.
            print('INSERT INTO {} ('.format(table,df_keys),end = '')
            counter = 0
            for key in df_keys:
                print(key, end = '')
                counter += 1
                if counter != size:
                    print(',', end = '')
                else:
                    print(')')

            print('VALUES (', end = '')
            counter = 0
            for value in df_indexes:
                print('\'{}\''.format(value), end ='')
                counter += 1
                if counter != size:
                    print(',', end = '')
                else:
                    print(');')
        else:
            sys.stdout = prev



if __name__ == '__main__':
    to_insert(loader.csv_to_pandas('../CSVs/has_hotels.csv'),database = 'ehotels', table = 'has_hotels', export_path = '../Querries/hotels.sql')