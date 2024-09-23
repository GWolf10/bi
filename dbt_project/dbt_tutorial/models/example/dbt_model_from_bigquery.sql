/*
this model is a copy of the `top_terms` table from the `google_trends` dataset in BigQuery

dbt run --select dbt_model_from_bigquery.sql
dbt compile --select dbt_model_from_bigquery.sql
*/

{{ config(
  materialized='table',
  schema='dbt_model_01'
) }}

-- This query shows a list of the daily top Google Search terms.
SELECT
   refresh_date AS Day,
   term AS Top_Term,
       -- These search terms are in the top 25 in the US each day.
   rank,
FROM `bigquery-public-data.google_trends.top_terms`
WHERE
   rank = 1
       -- Choose only the top term each day.
   AND refresh_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 2 WEEK)
       -- Filter to the last 2 weeks.
GROUP BY Day, Top_Term, rank
ORDER BY Day DESC
   -- Show the days in reverse chronological order.
