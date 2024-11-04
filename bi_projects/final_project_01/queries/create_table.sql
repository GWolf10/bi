/*
Description
init table by parameters

{run_time} - run time
*/


CREATE OR REPLACE TABLE
  `{project_id}.{dataset_dst}.{table_dst}`
PARTITION BY
  dt
  --{partition_field}
  OPTIONS( description="{description}")
  AS
SELECT
  *
FROM
  `ppltx-ba-course.{dataset_src}.{table_src}`
WHERE
   {partition_att} <= "{date}"