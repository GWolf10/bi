#!/bin/bash

#0 6 * * *  bash ~/workspace/bi/bi_projects/final_project_01/scheduler/execute_daily_fact_etl.sh
# Run the python script according to our configuration

cd workspace/bi

python ./bi_projects/final_project_01/final_project_01.py strange-bay-433318-g0 --etl-action daily --etl-name fact_etl