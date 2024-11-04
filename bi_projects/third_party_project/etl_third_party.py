import os
import json
import shutil
import pandas as pd

# Daily data file path
daily_data_file = 'extracted_daily_data.json'

# Define paths
source_file_path = r"C:\Users\galwo\OneDrive\Desktop\mp_api_raw_data.json"
destination_dir = r"C:\workspace\temp\bi\third_party_project\json_files"
destination_file_path = os.path.join(destination_dir, "mp_api_raw_20241007.json")

# Ensure the destination directory exists
os.makedirs(destination_dir, exist_ok=True)

# Check if the source file exists
if os.path.exists(source_file_path):
    print(f"Extracting JSON file from: {source_file_path}")

    # Copy the JSON file to the destination directory
    shutil.copy(source_file_path, destination_file_path)
    print(f"File copied to: {destination_file_path}")

    # Read and process each line of the JSON file separately
    try:
        with open(destination_file_path, 'r', encoding='utf-8') as json_file:
            for line in json_file:
                try:
                    json_data = json.loads(line)
                    print(f"JSON object extracted: {json_data}")
                except json.JSONDecodeError as e:
                    print(f"Failed to decode JSON on this line: {line}")
                    print(f"Error: {e}")
    except Exception as e:
        print(f"An error occurred while processing the file: {e}")
else:
    print(f"JSON file not found at {source_file_path}")



