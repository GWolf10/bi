#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
--this is the execution of the file from its original source--
python ./my_first_etl/run_validation_query.py

-- the script of the place where the logs located--
`strange-bay-433318-g0.logs.bi_jobs`
'''

from google.cloud import bigquery
import pandas as pd
import os
from datetime import datetime
import uuid


# Set the base path based on the OS
if os.name == 'nt':
    home = "C:/workspace/Bi/pythonProject"
else:
    home = "~/workspace/Bi/pythonProject"
bi_path = os.path.expanduser(home + '/my_first_etl/')
bi_auth = os.path.expanduser(home + '/my_first_etl/auth/')
data_path = os.path.expanduser(home + '/my_first_etl/temp/data/')
logs_path = os.path.expanduser(home + '/my_first_etl/temp/logs/')


# Function definitions
def header(string):
    x = len(string) * "="
    print(f"{string}\n{x}\n")


def readFile(fileName):
    with open(fileName, "r") as file:
        data = file.read()
    return data


def ensureDirectory(path):
    if not os.path.exists(path):
        os.makedirs(path)

# Set the log table
log_table="strange-bay-433318-g0.logs.bi_jobs"
def set_log(log_dic,step,msg="",log_table=log_table):
    log_dic["run_time"] = datetime.now()
    log_dic["step"] = step
    log_dic["msg"] = msg
    job = client.load_table_from_dataframe(pd.DataFrame(log_dic, index=[0]),log_table)
    job.result()


#create log dic and need to be excatly the same as the table
log_dic={
    "run_time": datetime.now(),
    "job_name": os.path.basename(__file__),  # get the file name
    "step": "start",
    "msg": "The query has been executed successfully",
    'run_id': str(uuid.uuid4())[:8]
}
client = bigquery.Client()

header("Start")
# Construct a BigQuery client object.
set_log(log_dic,"start","The query has been executed successfully")

header("read query")
set_log(log_dic,"read query","The query has been executed successfully")
# File path
fileName = os.path.join(bi_path, 'etl_validations_google_trends.sql')

# Check if the file exists
if not os.path.exists(fileName):
    print(f"File not found: {fileName}")
else:
    print(f"File found: {fileName}")

# Read and execute the query
query = readFile(fileName)
query_job = client.query(query)
rows = query_job.result()

header("run query")
set_log(log_dic,"run query")
# Extract the data from the table into a dataframe using the query
df = query_job.to_dataframe()
header("Query Output")
set_log(log_dic,"query output")
print(df)

header("Validation message")
set_log(log_dic,"validation message")
# Validation message function
if df["Is_Alarm"].any():
        print("Data is valid")
else:
    print("We have an error")

header("End")
set_log(log_dic,"end")
#TODO add notification message such as WhatssApp or email
#i need to print the data in the query
