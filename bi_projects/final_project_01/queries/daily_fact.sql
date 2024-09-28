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
FROM  `ppltx-ba-course.{dataset_src}.{table_src}`
WHERE {partition_att} >= date('{date}')
AND time < current_timestamp()