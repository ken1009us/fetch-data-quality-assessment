import pandas as pd
import os

from JSONProcessor import JSONProcessor
from pathlib import Path


def get_dataframe(filename):
    """
    Retrieve a DataFrame from a JSON file.

    Args:
        filename (str): Name of the JSON file.

    Returns:
        pd.DataFrame: DataFrame created from the JSON data.

    """
    data_path = Path('.') / 'data'
    json_processor = JSONProcessor(data_path)

    if filename in os.listdir(data_path):
        json_processor.process_json_file(filename)
        json_data = json_processor.get_json_data(filename)

    else:
        print("File not found.")

    # json_normalize function is used to convert the list of JSON objects into a DataFrame.
    # This function flattens the nested JSON structure and creates
    # a tabular representation suitable for analysis.
    df = pd.json_normalize(json_data)
    return df


def data_cleaning(df):
    """
    Perform data cleaning operations on the DataFrame.

    Args:
        df (pd.DataFrame): DataFrame to be cleaned.

    """
    # Inconsistent column names
    df.rename(columns={'_id.$oid': 'id',
                       'createDate.$date': 'createDate',
                       'dateScanned.$date': 'dateScanned',
                       'finishedDate.$date': 'finishedDate',
                       'modifyDate.$date': 'modifyDate',
                       'pointsAwardedDate.$date': 'pointsAwardedDate',
                       'pointsEarned.$date': 'pointsEarned',
                       'purchaseDate.$date': 'purchaseDate'}, inplace=True)


    # Missing values
    missing_values = df.isnull().sum()
    print('\nMissing values:')
    print(missing_values)

    # Inconsistent formats or data types
    df['createDate'] = pd.to_datetime(df['createDate'], unit='ms').dt.date
    df['dateScanned'] = pd.to_datetime(df['dateScanned'], unit='ms').dt.date
    df['finishedDate'] = pd.to_datetime(df['finishedDate'], unit='ms').dt.date
    df['modifyDate'] = pd.to_datetime(df['modifyDate'], unit='ms').dt.date
    df['pointsAwardedDate'] = pd.to_datetime(df['pointsAwardedDate'],
                                             unit='ms').dt.date
    df['purchaseDate'] = pd.to_datetime(df['purchaseDate'], unit='ms').dt.date


    # Handling missing values
    bonus_points_col = df['bonusPointsEarned']
    points_earned_col = df['pointsEarned']

    if bonus_points_col.dtype.kind in 'iufc':
        # Column is numeric
        mean_bonus_points = bonus_points_col.mean()
        df['bonusPointsEarned'].fillna(mean_bonus_points, inplace=True)
    else:
        # Column is categorical or contains string values
        most_frequent_bonus_points = bonus_points_col.mode().iloc[0]
        df['bonusPointsEarned'].fillna(most_frequent_bonus_points, inplace=True)

    if points_earned_col.dtype.kind in 'iufc':
        # Column is numeric
        mean_points_earned = points_earned_col.mean()
        df['pointsEarned'].fillna(mean_points_earned, inplace=True)
    else:
        # Column is categorical or contains string values
        most_frequent_points_earned = points_earned_col.mode().iloc[0]
        df['pointsEarned'].fillna(most_frequent_points_earned, inplace=True)

    return df


def main():
    """
    Main function to execute the data cleaning process.

    """
    # filename = input("Enter the JSON filename to process: ")
    filename = 'receipts.json'
    brands_df = get_dataframe(filename)
    cleaned_data = data_cleaning(brands_df)
    print(cleaned_data)


if __name__ == "__main__":
    main()