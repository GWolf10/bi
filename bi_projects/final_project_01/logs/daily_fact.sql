-- This query insert data raw data into FACT table
/*
Description
add data from source to fact table

Run Time
2024-09-26 13:30:06

*/

--insert the data of the date
insert into `strange-bay-433318-g0.raw_data.fact`

SELECT
    *,
FROM  `ppltx-ba-course.project_game.fact`
WHERE dt >= date('2024-09-25')
AND time < current_timestamp()