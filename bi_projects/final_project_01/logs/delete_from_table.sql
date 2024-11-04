-- Delete data from table by date
/*
Description
Delete the daily data before insert new one, in order to avoid duplications

Run Time
2024-10-14 12:02:01
*/

--DELETE the data of the date
delete from `strange-bay-433318-g0.panels.daily_user_panel`
WHERE dt =  date('2024-10-13')
