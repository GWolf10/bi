/*
Description
Create Daily Taxi Trip Panel - For main KPIs

{run_time}
*/

CREATE OR REPLACE TABLE
  `{project_id}.{dataset_dst}.{table_dst}`
(
    dt              DATE	options(description='Activity date'),
    vendor_id       STRING	options(description='LPEP provider ID'),
    total_trips     INTEGER	options(description='Total number of trips'),
    total_distance  NUMERIC	options(description='Total trip distance (in miles)'),
    avg_distance    NUMERIC	options(description='Average trip distance (in miles)'),
    total_fare      NUMERIC	options(description='Total fare amount'),
    total_tip       NUMERIC	options(description='Total tip amount'),
    total_tolls     NUMERIC	options(description='Total tolls amount'),
    total_passengers INTEGER	options(description='Total number of passengers'),
    avg_passengers  NUMERIC	options(description='Average number of passengers per trip')
)

PARTITION BY
   {partition_att}
OPTIONS(description="{description}")
AS
-- Main KPIs
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
FROM `{project_id}.{dataset_src}.{table_src}`
WHERE {partition_att} <= '{date}'
GROUP BY
  dt,
  vendor_id
