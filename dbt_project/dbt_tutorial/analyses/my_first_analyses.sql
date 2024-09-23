/*

dbt compile --select my_first_analyses
dbt run --select my_first_analyses
*/


select *
from {{ ref('my_first_seed') }}