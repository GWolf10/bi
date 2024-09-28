/*
Description
append data to daily_user_panel table
2024-09-27 14:36:45 - run time
*/


insert into `strange-bay-433318-g0.panels.daily_user_panel`

SELECT
  dt,
  distinct_id,
  COUNT(1) AS total_events,
  SUM(SessionNum) AS total_sessions,
  ROUND(AVG(SessionDuration),2) AS avg_session_duration,
  SUM(CASE
      WHEN event = 'Session_start' THEN 1
  END
    ) AS t_Session_start,
  SUM(XpEarned) AS total_xp_earned
FROM
  `strange-bay-433318-g0.raw_data.fact`
WHERE   dt = "2024-09-26"
GROUP BY
  ALL

--validation
/*
select dt, count(1)
from
`strange-bay-433318-g0.panels.daily_user_panel`
where dt = "2024-09-26"
group by 1
order by 1 desc
*/