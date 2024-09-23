"""
This script is used to monitor the daily database usage.

execute the following command to run the script:
python ./bi_projects/db_monitor/daily_db_monitor.py strange-bay-433318-g0
python ./bi_projects/db_monitor/daily_db_monitor.py strange-bay-433318-g0 --table-override


bq rm strange-bay-433318-g0:bi_final_project.tables_in_project
bq show strange-bay-433318-g0:bi_final_project.tables_in_project

bq query --use_legacy_sql=false --format=prettyjson "select * from `strange-bay-433318-g0.logs.daily_logs` order by ts desc limit 10"


QA
select * from `strange-bay-433318-g0.logs.daily_logs` order by ts desc limit 10
"""
import argparse
import sys
from pprint import pprint
from google.cloud import bigquery
import pandas as pd
from datetime import datetime, timedelta
import uuid
import platform
import os



def process_command_line(argv):
    """
    Parse the command line and return a dictionary of command line arguments
    :param argv: list of command line arguments
    :return: dictionary of command line arguments
    """
    if argv is None:
        argv = sys.argv[1:]
    parser = argparse.ArgumentParser(description="__doc__",
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("project_id", choices=["strange-bay-433318-g0","bi-ppltx2"],default= "strange-bay-433318-g0", help="Project ID")
    parser.add_argument("--etl-action", choices=["init","daily","delete"], help="ETL action")
    parser.add_argument("--etl-name", help="ETL name")
    parser.add_argument("--dry-run", action="store_true", help="if true dont execute the queries")
    parser.add_argument("--days-back", help="""the number of days back to run the ETL""",default=1)
    parser.add_argument("--table-override", help="""if true truncate the table""",action="store_true")
    return parser,argparse.Namespace()

parser,flags = process_command_line(sys.argv[1:])
x = sys.argv[1:]
parser.parse_args(x,namespace=flags)


# Construct a BigQuery client object.
client = bigquery.Client(project=flags.project_id)


datasets = list(client.list_datasets())  # Make an API request.
project = client.project
tables_info_list = []
run_time = datetime.now()
project_id = flags.project_id

if project_id == "strange-bay-433318-g0":
    log_table = "strange-bay-433318-g0.logs.daily_logs"
else:
    log_table = f"{project_id}.logs.daily_logs"

# Set table_id to the ID of the model to fetch.
table_id = 'bigquery-public-data.noaa_tsunami.historical_runups'
table = client.get_table(table_id)  # Make an API request.
uid = str(uuid.uuid4())
step_id = 0
env_type = 'daily'
#init log dictionary
log_dict = {
    'ts' :datetime.now(),
    'dt': datetime.now().strftime("%Y-%m-%d"),
    'uid': uid,
    'username': platform.node(),
    'file_name': os.path.basename(__file__),
    'step_name': 'start',
    'step_id': step_id,
    'log_type': env_type,
    'message': str(x)
}

def set_log(log_dict,step,log_table= log_table):
    log_dict['step_name'] = step
    log_dict['step_id'] += 1
    log_dict['ts'] = datetime.now()
    log_dict['dt'] = datetime.now().strftime("%Y-%m-%d")
    log_dict['message'] = f"step {step_id} {step} started"
    job = client.load_table_from_dataframe(pd.DataFrame(log_dict,index=[0]),log_table)  # Use correct destination table
    job.result()  # Wait for the job to complete.
# Fetch tables and add metadata
if datasets:
    print("Datasets in project {}:".format(project))
    for dataset in datasets:
        print("\t{}".format(dataset.dataset_id))
        tables = client.list_tables(dataset.dataset_id)  # Make an API request.

        # Iterate over all tables in each dataset
        for table_var in tables:
            table_id = "{}.{}.{}".format(table_var.project, table_var.dataset_id, table_var.table_id)
            print("\t\t{}".format(table_id))

            # Get table metadata and append to list
            table = client.get_table(table_id)
            tables_info_list.append({
                "run_time": run_time,
                "uid": uid,
                "project_id": table.project,
                "dataset_id": table.dataset_id,
                "table_id": table.table_id,
                "num_rows": table.num_rows,
                "created": table.created,
                "modified": table.modified,
                "num_bytes": table.num_bytes
            })

else:
    error_msg = "{} project does not contain any datasets.".format(project)
    print(error_msg)
    log_dict['message'] = error_msg
    set_log(log_dict,"error")

# Create a DataFrame from the list of tables metadata
job_config = bigquery.LoadJobConfig()

if flags.table_override:
    job_config.write_disposition = "WRITE_TRUNCATE"
else:
    job_config.write_disposition = "WRITE_APPEND"

#start
set_log(log_dict,"start")
log_table =f"{project_id}.logs.daily_logs"
# Load tables data into a DataFrame
dataframe = pd.DataFrame(tables_info_list)

# Define destination table in your project
dst_table = "strange-bay-433318-g0.bi_final_project.tables_in_project"

# Load data into the destination BigQuery table
job = client.load_table_from_dataframe(dataframe, dst_table,job_config=job_config)  # Use correct destination table
job.result()  # Wait for the job to complete.

# Fetch metadata for the destination table
table = client.get_table(dst_table)  # Make an API request.

# Output the result of the load job
print("Loaded {} rows and {} columns to {}".format(table.num_rows, len(table.schema), dst_table))

set_log(log_dict,"end")
