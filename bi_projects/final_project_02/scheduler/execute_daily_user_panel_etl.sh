#!/bin/bash

#10 6 * * *  bash ~/workspace/Bi/bi_projects/final_project_01/scheduler/execute_daily_user_panel_etl.sh
# Run the python script according to our configuration

cd Workspace/Bi

python ./bi_projects/final_project_01/final_project_01.py strange-bay-433318-g0 --etl-action daily --etl-name daily_user_panel_etl