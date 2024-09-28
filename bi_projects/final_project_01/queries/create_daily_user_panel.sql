/*
Description
Create Daily User Panel - For main KPIs

{run_time}
*/

CREATE OR REPLACE TABLE
  `{project_id}.{dataset_dst}.{table_dst}`
(
    dt              DATE	options(description='Activity date'),
    distinct_id     STRING	options(description='User unique ID'),
    Version         STRING	,
    Platform        STRING	,
    Level           INTEGER	,
    t_Session_Start INTEGER	,
    t_Match_Start   INTEGER	,
    t_revenue       INTEGER	,
    t_GemsEarned    INTEGER	,
    t_XpEarned      INTEGER
)

PARTITION BY
   {partition_att}
 OPTIONS( description="{description}" )
as
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
WHERE {partition_att} <= '{date}'
GROUP BY
  all