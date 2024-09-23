/*
This model is a combination of the previous two models. It selects all columns from the third model and filters out rows where the id column is null.

dbt run --select my_fourth_dbt_model.sql
dbt compile --select my_fourth_dbt_model.sql
*/



select *

from {{ref('my_third_dbt_model')}}

where id is not null