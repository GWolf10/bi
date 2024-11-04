-- Delete data from table by date
/*
Description
Delete the daily data before insert new one, in order to avoid duplications

Run Time
2024-10-14 13:46:28
*/

--DELETE the data of the date
delete from `strange-bay-433318-g0.raw_data.fact2`
WHERE DATE(pickup_datetime) =  date('2024-10-13')
