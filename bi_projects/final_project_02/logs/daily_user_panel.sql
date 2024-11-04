/*
Description
Append data to Daily User Panel - For main KPIs

2024-10-14 12:02:06
*/

Insert into
  `strange-bay-433318-g0.panels.daily_user_panel`

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
WHERE dt = '2024-10-13'
GROUP BY
  all



/*
-- Validation
SELECT
  dt,
  COUNT(1)
FROM `strange-bay-433318-g0.panels.daily_user_panel`
WHERE dt = '2024-10-13'
GROUP BY
  1
ORDER BY
  1 DESC


*/