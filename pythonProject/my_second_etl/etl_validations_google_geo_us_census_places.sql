/*
query name : etl_validations_google_geo_us_census_places
description : extract metadata on tables
destination : table : strange-bay-433318-g0.logs2.etl_validations_google_geo_us_census_places
*/

SELECT
  TIMESTAMP_MILLIS(creation_time) AS creation_time,
  TIMESTAMP_MILLIS(last_modified_time) AS last_modified_time,
  IF(
    TIMESTAMP_DIFF(TIMESTAMP_MILLIS(last_modified_time), TIMESTAMP_MILLIS(creation_time), HOUR) < 12,
    'True',
    'False'
  ) AS Is_Alarm
FROM
  `bigquery-public-data.geo_us_census_places.__TABLES__`
WHERE
  table_id = 'places_alabama';