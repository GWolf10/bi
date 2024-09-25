-- insert into  agg table the recent N days data


insert into
    `strange-bay-433318-g0.daily_etl.daily_agg`
select * from
    `strange-bay-433318-g0.daily_etl.daily_inc`;