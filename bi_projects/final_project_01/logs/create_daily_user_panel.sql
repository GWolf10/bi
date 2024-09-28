/*
Description
Create Daily User Panel - For main KPIs

2024-09-27 18:50:04
*/

CREATE OR REPLACE TABLE
  `strange-bay-433318-g0.panels.daily_user_panel`
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
   dt
 OPTIONS( description="containes daily aggregated KPIs for every active user" )
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
FROM `strange-bay-433318-g0.raw_data.fact`
WHERE dt <= '2024-09-26'
GROUP BY
  all