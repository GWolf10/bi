/*
Description
Insert new users to User Panel - For main KPIs

Insert new users to the user panel
2024-09-27 22:30:39
*/


insert into
  `strange-bay-433318-g0.panels.user_panel`

-- Main KPIs
SELECT
    distinct_id,
    dt as install_dt,
    Version as current_Version,
    Platform as current_Platform,
    daily.Level,
    1 as t_active_days,
    daily.t_Session_Start,
    daily.t_Match_Start,
    daily.t_revenue,
    daily.t_GemsEarned,
    daily.t_XpEarned,
    dt as last_activity_dt

FROM `strange-bay-433318-g0.panels.daily_user_panel` as daily
Left join `strange-bay-433318-g0.panels.user_panel` as user
using (distinct_id)
WHERE dt = '2024-09-26'
-- users from Daily panel not exist in the user panel
-- only new users
AND user.distinct_id is null