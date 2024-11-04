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
create schema `strange-bay-433318-g0.panels2` options (description = "contain all the panel tables - aggregated data");

```

#### execution the file 
```dtd
python ./bi_projects/final_project_02/final_project_02.py  strange-bay-433318-g0 --etl-action daily --etl-name fact_etl

```
### step 2 defining the main KPI we want to measure
```dtd
SELECT
  DATE(pickup_datetime) AS dt,
  vendor_id,
  COUNT(*) AS total_trips,
  SUM(trip_distance) AS total_distance,
  ROUND(AVG(trip_distance),2) AS avg_distance,
  SUM(fare_amount) AS total_fare,
  SUM(tip_amount) AS total_tip,
  SUM(tolls_amount) AS total_tolls,
  SUM(passenger_count) AS total_passengers,
  AVG(passenger_count) AS avg_passengers
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
GROUP BY
  dt,
  vendor_id
```


#### step 3 aggregate the daily data and save it into main kpis table called daily_user_panel
```dtd
~/workspace/Bi/bi_projects/final_project_02/scheduler/execute_daily_user_panel_etl.sh
```


#### step 4 update the user_panel with the new data
```dtd
python ./bi_projects/final_project_02/final_project_02.py  strange-bay-433318-g0 --etl-action daily --etl-name user_panel_etl

```