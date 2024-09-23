--CREATE schema IF NOT EXISTS gmstry;
CREATE OR REPLACE TABLE
`gmstry.combined_results`(
  date DATE,
  validation_type STRING,
  is_valid BOOLEAN,
  amount_of_users INT64,
  uid1 string,
  uid2 string
);

FOR loop_variable_name IN (
  SELECT
    column_name AS a,
    ordinal_position AS position
  FROM
    `ppltx-ba-course.gmstry.INFORMATION_SCHEMA.COLUMNS`
  WHERE
    table_name = 'bb_segment_inc'
    --AND column_name IN ('users_from_campaign')
    AND column_name NOT IN (
      'PlayerId',
      'Dynamic_offer_pass',
      'Completed_Flash',
      'Completed_2ndFlash',
      'install_flag',
      'days_from_calenderoffer'
    )
)
DO
  EXECUTE IMMEDIATE
  CONCAT("""
    INSERT INTO `gmstry.combined_results`
    SELECT
      CURRENT_DATE() AS date,
      '""", loop_variable_name.a, """' AS validation_type,
      COALESCE(a.""", loop_variable_name.a, """ = b.""", loop_variable_name.a, """, FALSE) AS is_valid,
      COUNT(*) AS amount_of_users,
      max(a.PlayerId) as uid1,
      min(a.PlayerId) as uid2,
    FROM `ppltx-ba-course.gmstry.bb_segment_legacy` a
    INNER JOIN `ppltx-ba-course.gmstry.bb_segment_inc` b
    ON a.PlayerId = b.PlayerId
    GROUP BY is_valid
  """);
END FOR;

--checking propotion of valid users
select * from (select
    date,
    validation_type,
    is_valid,
    amount_of_users,
--      round(cnt / sum(cnt) over (partition by column_name), 2) as Prop
    round(amount_of_users / sum(amount_of_users) over (partition by validation_type), 2) as Prop,
    uid1,
    uid2
from `gmstry.combined_results`
) where is_valid
order by Prop;


--extracting samples of users between the two tables
/*
select * except(cnt_ad)  from `ppltx-ba-course.gmstry.bb_segment_legacy` a
union all
select * except( Dynamic_offer_pass,Completed_Flash,
      Completed_2ndFlash,
      install_flag,
      days_from_calenderoffer) from `ppltx-ba-course.gmstry.bb_segment_inc` b
--where uid in (select uid from `ppltx-ba-course.gmstry.bb_segment_inc`)
where PlayerId in ("281538507249846001")
*/

/*
SELECT
    -- column_name AS a,
    -- -- ordinal_position AS position,
    -- data_type,
    format( "ifnull( %s, %s ) as %s,", column_name, case when data_type = "STRING" THEN "'xxx'"
    when data_type = "INT64" THEN "-999"
    when data_type = "FLOAT64" THEN "-999.9"
     end, column_name)
    -- *

  FROM
    bingo-bling-develop.s3_segments.INFORMATION_SCHEMA.COLUMNS
--    ppltx-ba-course.gmstry.INFORMATION_SCHEMA.COLUMNS
  WHERE
    table_name = 'sos_s3_segment_validation_inc'

*/