/*
Description
Update User Panel - For main KPIs

Description
{description}
{run_time}
*/


UPDATE
  `{project_id}.{dataset_dst}.{table_dst}` as dst
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
FROM `{project_id}.{dataset_src}.{table_src}` as src
WHERE {partition_att} = '{date}'
      AND dst.distinct_id = src.distinct_id