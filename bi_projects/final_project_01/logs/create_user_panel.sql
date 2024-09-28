/*
Description
Create User Panel - For main KPIs

2024-09-27 22:29:54
*/

CREATE OR REPLACE TABLE
  `strange-bay-433318-g0.panels.user_panel`
(
    distinct_id     STRING	options(description='User unique ID'),
    install_dt      DATE	options(description='First activity date'),
    current_Version         STRING	,
    current_Platform        STRING	,
    Level           INTEGER	,
    t_active_days   INTEGER	,
    t_Session_Start INTEGER	,
    t_Match_Start   INTEGER	,
    t_revenue       INTEGER	,
    t_GemsEarned    INTEGER	,
    t_XpEarned      INTEGER ,
    last_activity_dt  DATE	options(description='last activity date'),

)

PARTITION BY
   install_dt
 OPTIONS( description="Contains Life time aggregated KPIs for every active user" )
as
-- Main KPIs
SELECT
  distinct_id,
  min(dt) as install_dt,
  substring( max(concat( cast (dt as string) , Version)), 11) as Version,
  substring( max(concat( cast (dt as string) , Platform)), 11) as Platform,
  MAX(Level) as Level,
  count(1) as t_active_days,
  SUM(t_Session_Start) as t_Session_Start,
  SUM(t_Match_Start) as t_Match_Start,
  SUM(t_revenue) as t_revenue,
  SUM(t_GemsEarned) as t_GemsEarned,
  SUM(t_XpEarned) as t_XpEarned,
  max(dt) as last_activity_dt,

FROM `strange-bay-433318-g0.panels.daily_user_panel`
WHERE dt <= '2024-09-26'
GROUP BY
  all