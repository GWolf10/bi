#!/bin/bash

#20 6 * * *  bash ~/workspace/bi_projects/final_project_01/scheduler/execute_user_panel_etl.sh
# Run the python script according to our configuration

cd workspace/bi

python ./bi_projects/final_project_01/final_project_01.py  strange-bay-433318-g0 --etl-action daily --etl-name user_panel_etl
