/*
Description
init table by parameters

2024-09-25 18:57:50 - run time
*/


CREATE OR REPLACE TABLE
  `strange-bay-433318-g0.raw_data.fact`
PARTITION BY
  --dt
  dt
  OPTIONS( description="raw data of users in the game. Contains all the events")
  AS
SELECT
  *
FROM
  `ppltx-ba-course.project_game.fact`
WHERE
   dt <= "2024-09-24"