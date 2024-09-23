/*
this is for loop
https://cloud.google.com/bigquery/docs/reference/standard-sql/procedural-language#loop

https://cloud.google.com/bigquery/docs/reference/standard-sql/procedural-language#execute_immediate
*/

DECLARE x INT64 DEFAULT 0;
LOOP
  SET x = x + 1;
  IF x >= 10 THEN
    LEAVE;
  END IF;
END LOOP;
SELECT x;


FOR loop_variable_name IN (table_expression)
DO
  sql_expression_list
END FOR;


EXECUTE IMMEDIATE
  "CREATE TEMP TABLE Books (title STRING, publish_date INT64)";



  FOR loop_variable_name IN (select *
from unnest(['days_from_last_login','days_from_install']) as list)
DO
EXECUTE IMMEDIATE concat("""SELECT  current_date() AS date,
  '""",loop_variable_name.list,"""' as asas""");
END FOR;


  SELECT
    * EXCEPT(is_generated, generation_expression, is_stored, is_updatable)
  FROM
    `bigquery-public-data`.census_bureau_usa.INFORMATION_SCHEMA.COLUMNS
  WHERE
    table_name = 'population_by_zip_2010';



  with a as (SELECT
  table_name,
  column_name,
  COUNT(1) AS cnt,
  -- ordinal_position AS position
FROM
  ppltx-ba-course.gmstry.INFORMATION_SCHEMA.COLUMNS
WHERE
  (table_name = 'bb_segment_inc'
    OR table_name = 'bb_segment_legacy' )
GROUP BY
  ALL)

SELECT
  column_name,
  table_name,
  cnt,
  round(cnt / sum(cnt) over (partition by column_name), 2) as Prop
FROM a