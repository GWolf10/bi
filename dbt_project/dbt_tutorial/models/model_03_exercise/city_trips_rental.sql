/*
dbt compile --select city_trips_rental
dbt run --select city_trips_rental

dbt run --select model_03_exercise
dbt compile --select model_03_exercise

*/

{{ config(
  materialized='table',
  schema='dbt_model_03'
)}}

WITH trips AS (
  SELECT
    start_station_id,
    COUNT(*) AS Total_trips
  FROM {{source('citi','trips')}}
  GROUP BY start_station_id
  ORDER BY Total_trips DESC
)

SELECT
  s.name,
  s.rental_methods,
  t.Total_trips
FROM trips AS t
LEFT JOIN {{source('citi','stations')}} AS s
  ON CAST(t.start_station_id AS STRING) = s.station_id
ORDER BY t.Total_trips DESC
