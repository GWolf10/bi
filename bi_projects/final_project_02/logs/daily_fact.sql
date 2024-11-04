-- This query insert data raw data into FACT table
/*
Description
add data from source to fact table

Run Time
2024-10-14 13:46:35

*/

--insert the data of the date
insert into `strange-bay-433318-g0.raw_data.fact2`

SELECT
    *,
FROM  `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
WHERE DATE(pickup_datetime) >= date('2024-10-13')
AND pickup_datetime < CURRENT_TIMESTAMP();