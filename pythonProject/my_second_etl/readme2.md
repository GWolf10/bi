# my second ETL
improving my etl development skills

[BigQuery direct link](https://console.cloud.google.com/bigquery)

```dtd
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
```
[Daily Scheduled query](https://console.cloud.google.com/bigquery/scheduled-queries/locations/us/configs/66d91c8c-0000-2d15-80f5-d4f547e62188/runs?project=strange-bay-433318-g0)
