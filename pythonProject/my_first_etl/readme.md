# my first ETL
planning the ETL in the BI developer course

https://console.cloud.google.com/bigquery

## planing 
white board planing -
#TODO add flow chard schema

## process steps
### explore the data
```dtd
SELECT
  TIMESTAMP_MILLIS(UNIX_MILLIS(CURRENT_TIMESTAMP())) AS creation_time,
  TIMESTAMP_MILLIS(UNIX_MILLIS(CURRENT_TIMESTAMP())) AS last_modified_time,
   IF(
    TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), TIMESTAMP_MILLIS(UNIX_MILLIS(CURRENT_TIMESTAMP())), HOUR) >= 12,
    'True',
    'False'
  ) AS Is_Alarm
FROM
  `bigquery-public-data.google_trends.__TABLES__`
  where table_id = 'top_terms'
;


```
[Scheduled query](https://console.cloud.google.com/bigquery?ws=!1m4!1m3!3m2!1sbi-ppltx2!2slogs)

