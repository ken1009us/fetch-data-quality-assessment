# Data Quality Evaluation

This repository contains a Python script and supporting files for performing data quality evaluation on JSON dataset. The script retrieves a DataFrame from a JSON file, performs data cleaning operations, and outputs the cleaned data.

## Files

- `data_quality_evaluation.py`: The main Python script that retrieves the DataFrame from the JSON file and performs data cleaning operations.
- `JSONProcessor.py`: A helper class for processing JSON files and retrieving JSON data.
- `db_tables.sql`: SQL script that contains the database table creation statements.
- `queries.sql`: SQL script that contains sample queries to analyze the dataset.
- `receipts.json`: Sample JSON file containing the dataset to be evaluated.

## Prerequisites

To run the script, you need to have the following installed:

- Python
- pandas library

## Usage

1. Place the JSON dataset file (`receipts.json`) in the data folder as the script.
2. Open a terminal or command prompt and navigate to the directory containing the script.
3. Run the following command to execute the data cleaning process:

```bash
python3 data_quality_evaluation.py
```

The script will read the JSON file, process the data, perform data cleaning operations, and output the cleaned data.

```bash
Missing values:
bonusPointsEarned          575
bonusPointsEarnedReason    575
pointsEarned               510
purchasedItemCount         484
rewardsReceiptItemList     440
rewardsReceiptStatus         0
totalSpent                 435
userId                       0
id                           0
createDate                   0
dateScanned                  0
finishedDate               551
modifyDate                   0
pointsAwardedDate          582
purchaseDate               448
dtype: int64
```

```bash
      bonusPointsEarned                            bonusPointsEarnedReason pointsEarned  ...  modifyDate pointsAwardedDate purchaseDate
0            500.000000  Receipt number 2 completed, bonus point schedu...        500.0  ...  2021-01-03        2021-01-03   2021-01-03
1            150.000000  Receipt number 5 completed, bonus point schedu...        150.0  ...  2021-01-03        2021-01-03   2021-01-02
2              5.000000                         All-receipts receipt bonus            5  ...  2021-01-03               NaT   2021-01-03
3              5.000000                         All-receipts receipt bonus          5.0  ...  2021-01-03        2021-01-03   2021-01-03
4              5.000000                         All-receipts receipt bonus          5.0  ...  2021-01-03        2021-01-03   2021-01-02
...                 ...                                                ...          ...  ...         ...               ...          ...
1114          25.000000                        COMPLETE_NONPARTNER_RECEIPT         25.0  ...  2021-03-01               NaN   2020-08-17
1115         238.893382                                                NaN          5.0  ...  2021-03-01               NaN          NaT
1116         238.893382                                                NaN          5.0  ...  2021-03-01               NaN          NaT
1117          25.000000                        COMPLETE_NONPARTNER_RECEIPT         25.0  ...  2021-03-01               NaN   2020-08-17
1118         238.893382                                                NaN          5.0  ...  2021-03-01               NaN          NaT

[1119 rows x 15 columns]
```

## Customization

JSON file: You can modify the filename variable in the main function of the data_quality_evaluation.py script to specify a different JSON file to process.

Column names: If the JSON data has inconsistent column names, you can modify the df.rename function in the data_cleaning function of the data_quality_evaluation.py script to map the correct column names.

Data cleaning operations: You can customize the data cleaning operations in the data_cleaning function of the data_quality_evaluation.py script to fit your specific requirements.

## Database Integration

The script assumes a MySQL database is set up with the required tables defined in the db_tables.sql script. You need to modify the script and provide your database connection details to integrate with the database. Once integrated, you can execute the SQL queries in the queries.sql script to analyze the dataset using the database.
