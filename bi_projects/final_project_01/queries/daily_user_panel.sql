/*
Description
Append data to Daily User Panel - For main KPIs

{run_time}
*/

Insert into
  `{project_id}.{dataset_dst}.{table_dst}`

-- Main KPIs
SELECT
  dt,
  distinct_id,
  MAX(Version) as Version,
  MAX(Platform) as Platform,
  MAX(Level) as Level,
  SUM(CASE WHEN event = 'Session_Start' then 1 end) as t_Session_Start,
  SUM(CASE WHEN event = 'Match_Start' then 1 end) as t_Match_Start,
  SUM(price_numeric) as t_revenue,
  SUM(GemsEarned) as t_GemsEarned,
  SUM(XpEarned) as t_XpEarned,
FROM `{project_id}.{dataset_src}.{table_src}`
WHERE {partition_att} = '{date}'
GROUP BY
  all



/*
-- Validation
SELECT
  {partition_att},
  COUNT(1)
FROM `{project_id}.{dataset_dst}.{table_dst}`
WHERE {partition_att} = '{date}'
GROUP BY
  1
ORDER BY
  1 DESC


*/