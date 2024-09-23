
{{
  config(
    materialized='table',
    schema='model_04_dbt_tutorial'
  )
}}


select
    id as customer_id,
    first_name,
    last_name

from {{source('jaffle_shop', 'customers')}}