import pandas as pd 

# Load the csv as a pandas array.
def csv_to_pandas(csv_path):
    
    # Load the csv to df.
    df = pd.read_csv(csv_path, header = 0)

    return df 

if __name__ == '__main__':
    print(csv_to_pandas('../CSVs/hotels.csv').head(2))