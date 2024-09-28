# ETL - final project 

## Project Description

Manage game BI system

1. Load yesterday`s data from Data Source into FACT table
2. Design and develop Main KPIs
3. Define and develop User Panel & Daily User Panel
4. Define and develop logging system and monitor it with alerts
5. Design and develop dashboards for Main KPIs & alerts
6. The system must be scheduled on a daily basis


### steps
- extract data from data source and save it into fact table
- define the main KPI we want to measure
- aggregate the daily data and save it into main kpis table called daily_user_panel
- update the user_panel with the new data
- add logs and alerts
- design dashboards in Looker or Tableau

## Actions
define data destination datasets
```dtd
create schema `strange-bay-433318-g0.logs` options (description = "contain all the tables")
create schema `strange-bay-433318-g0.raw_data` options (description = "contain all FACT tables- raw data");
create schema `strange-bay-433318-g0.panels` options (description = "contain all the panel tables - aggregated data");

```

#### execution the file 
```dtd
python ./bi_projects/final_project_01/final_project_01.py  strange-bay-433318-g0 --etl-action daily --etl-name fact_etl

```
### step 2 defining the main KPI we want to measure
```dtd
SELECT
  dt,
  distinct_id,  
  COUNT(1) AS total_events,
  SUM(SessionNum) AS total_sessions,
  ROUND(AVG(SessionDuration),2) AS avg_session_duration,
  sum(case when event = 'Session_start' then 1 end) as t_Session_start,
  SUM(XpEarned) AS total_xp_earned
FROM
  `ppltx-ba-course.project_game.fact`
GROUP BY
  ALL
ORDER BY
  dt DESC;
```

- total_events: the total number of events that happened in the game
- total_sessions: the total number of sessions that happened in the game
- avg_session_duration: the average session duration
- total_xp_earned: the total amount of XP earned by all users
- t_Session_start: the total number of session start events

#### step 3 aggregate the daily data and save it into main kpis table called daily_user_panel
```dtd
~/workspace/Bi/bi_projects/final_project_01/scheduler/execute_daily_user_panel_etl.sh
```


#### step 4 update the user_panel with the new data
```dtd
python ./bi_projects/final_project_01/final_project_01.py  strange-bay-433318-g0 --etl-action daily --etl-name user_panel_etl

```