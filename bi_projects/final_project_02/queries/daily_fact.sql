-- This query insert data raw data into FACT table
/*
Description
{description}

Run Time
{run_time}

*/

--insert the data of the date
insert into `{project_id}.{dataset_dst}.{table_dst}`

SELECT
    *,
FROM  `bigquery-public-data.{dataset_src}.{table_src}`
WHERE {partition_att} >= date('{date}')
AND pickup_datetime < CURRENT_TIMESTAMP();