-- delete from agg table the recent N days data


delete from
    `strange-bay-433318-g0.daily_etl.daily_agg`
where
    day >= DATE_SUB(CURRENT_DATE(), INTERVAL 5 day)