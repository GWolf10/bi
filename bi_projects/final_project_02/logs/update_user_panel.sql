/*
Description
Update User Panel - For main KPIs

Description
Update the active users in the user panel
2024-09-27 22:30:31
*/


UPDATE
  `strange-bay-433318-g0.panels.user_panel` as dst
SET
    current_Version     = src.Version,
    current_Platform    = src.Platform,
    Level               = src.Level,
    t_active_days       = dst.t_active_days + 1,
    t_Session_Start     = dst.t_Session_Start + ifnull(src.t_Session_Start,0),
    t_Match_Start       = dst.t_Match_Start + ifnull(src.t_Match_Start,0),
    t_revenue           = dst.t_revenue + ifnull(src.t_revenue,0),
    t_GemsEarned        = dst.t_GemsEarned + ifnull(src.t_GemsEarned,0),
    t_XpEarned          = dst.t_XpEarned + ifnull(src.t_XpEarned,0),
    last_activity_dt    = src.dt
FROM `strange-bay-433318-g0.panels.daily_user_panel` as src
WHERE dt = '2024-09-26'
      AND dst.distinct_id = src.distinct_id