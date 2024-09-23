create or replace temp table combined_results
(date date,
 validation_type string,
 is_valid boolean,
 amount_of_users int64);

FOR loop_variable_name IN (

SELECT
    column_name AS a,
    ordinal_position AS position
  FROM
    `ppltx-ba-course.gmstry`.INFORMATION_SCHEMA.COLUMNS
  WHERE
    table_name = 'bb_segment_inc'
    and column_name not in('uid',
    'Dynamic_offer_pass',
    'Completed_Flash',
    'Completed_2ndFlash',
    'install_flag',
    'days_from_calenderoffer'
    )
)

DO
--  sql_expression_list

EXECUTE IMMEDIATE
concat("""
  insert into combined_results
  SELECT
  current_date() AS date,
  ' """,loop_variable_name.a,"""' AS validation_type,
--  days_from_login_is_valid AS is_valid,
  a.""",loop_variable_name.a,""" = b.""",loop_variable_name.a,""" AS is_valid,
  COUNT(*) AS amount_of_users
  FROM `ppltx-ba-course.gmstry.bb_segment_legacy` a
INNER JOIN `ppltx-ba-course.gmstry.bb_segment_inc` b
ON a.uid = b.uid
GROUP BY all""");
END FOR;