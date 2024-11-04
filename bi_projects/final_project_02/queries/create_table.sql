CREATE OR REPLACE TABLE
  `{project_id}.{dataset_dst}.{table_dst}`
PARTITION BY
  DATE(pickup_datetime)  -- e.g., pickup_datetime
OPTIONS( description="{description}")
AS
SELECT
  *
FROM
  `bigquery-public-data.{dataset_src}.{table_src}`
WHERE
  DATE(pickup_datetime) <= "2023-01-01"  -- e.g., pickup_datetime <= "2023-01-01"
