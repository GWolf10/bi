import os
import json
import pandas as pd

# Define paths
destination_file_path = r"C:\workspace\temp\bi\third_party_project\json_files\mp_api_raw_20241007.json"

# Check if the JSON file exists
if os.path.exists(destination_file_path):
    print(f"Reading JSON file from: {destination_file_path}")

    # Read the JSON file line by line and load it into a list
    json_data = []
    with open(destination_file_path, 'r', encoding='utf-8') as json_file:
        for line in json_file:
            try:
                json_data.append(json.loads(line))
            except json.JSONDecodeError as e:
                print(f"Failed to decode JSON on this line: {line}")
                print(f"Error: {e}")

    # Convert the list of dictionaries to a pandas DataFrame
    if json_data:
        # Load the raw data into a DataFrame
        df = pd.json_normalize(json_data)

        # Display the first few rows to see the structure
        print("Original Data (first few rows):")
        print(df.head())

        # Unnest columns if they are dictionaries or lists (e.g., 'properties')
        # Check for any columns containing dictionaries or lists
        nested_columns = [col for col in df.columns if isinstance(df[col].iloc[0], (dict, list))]

        # Unnest these columns if they exist
        for column in nested_columns:
            print(f"Unnesting column: {column}")
            # Use json_normalize to flatten the nested column
            unnested_df = pd.json_normalize(df[column])

            # Append the unnested columns to the original DataFrame, dropping the nested column
            df = pd.concat([df.drop(column, axis=1), unnested_df.add_prefix(f"{column}.")], axis=1)

        print("Data after unnesting (first few rows):")
        print(df.head())

        # Optional: Save the flattened DataFrame to a CSV file if you want
        output_csv_path = r"C:\workspace\temp\bi\third_party_project\json_files\flattened_data.csv"
        df.to_csv(output_csv_path, index=False)
        print(f"Flattened data saved to {output_csv_path}")

else:
    print(f"JSON file not found at {destination_file_path}")
