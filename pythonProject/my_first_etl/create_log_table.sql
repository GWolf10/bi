CREATE or replace TABLE
  `strange-bay-433318-g0.logs.bi_jobs` ( run_time timestamp OPTIONS (description = 'The runtime UTC'),
    job_name STRING OPTIONS (description = 'Job name'),
    run_id string options (description = 'run ID'),
    step STRING OPTIONS (description = 'Step name'),
    msg STRING OPTIONS (description = 'Message for the client'),
    )
PARTITION BY
  date(run_time );

#explore logs
SELECT *
FROM
    `strange-bay-433318-g0.logs.bi_jobs`
where
    date(run_time) = 'current_date()'
order by
    1 desc
LIMIT
    1000