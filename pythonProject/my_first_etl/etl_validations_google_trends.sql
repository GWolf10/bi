/*
query name : etl_validations_google_trends
description : extract metadata on tables
destination : table : bi-ppltx2.logs.etl_validations_google_trends
*/
SELECT
      IF(
        TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), TIMESTAMP_MILLIS(UNIX_MILLIS(CURRENT_TIMESTAMP())), HOUR) >= 12,
        'True',
        'False'
      ) AS Is_Alarm
    FROM
      `bigquery-public-data.google_trends.__TABLES__`
    WHERE table_id = 'top_terms';