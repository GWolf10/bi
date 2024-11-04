/*
Description
Insert new users to User Panel - For main KPIs

{description}
{run_time}
*/


insert into
  `{project_id}.{dataset_dst}.{table_dst}`

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

FROM `{project_id}.{dataset_src}.{table_src}` as daily
Left join `{project_id}.{dataset_dst}.{table_dst}` as user
using (distinct_id)
WHERE {partition_att} = '{date}'
-- users from Daily panel not exist in the user panel
-- only new users
AND user.distinct_id is null