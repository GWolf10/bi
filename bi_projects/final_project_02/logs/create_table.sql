CREATE OR REPLACE TABLE
  `strange-bay-433318-g0.raw_data.fact2`
PARTITION BY
  DATE(pickup_datetime)  -- e.g., pickup_datetime
OPTIONS( description="raw data of all taxi drivers")
AS
SELECT
  *
FROM
  `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
WHERE
  DATE(pickup_datetime) <= "2023-01-01"  -- e.g., pickup_datetime <= "2023-01-01"
