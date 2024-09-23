/* This model is a second model that is built from the same source table as the first model.

dbt run --select dbt_second_model_from_bigquery.sql
dbt compile --select dbt_second_model_from_bigquery.sql

*/

{{ config(
  materialized='table',
  schema='dbt_model_01'
) }}

select *

from {{ref('dbt_model_from_bigquery')}}
