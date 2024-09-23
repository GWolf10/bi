/*
dbt test --select my_first_test

*/

{{ config(
    error_if = ">70",
    warn_if = ">5",
) }}

select
*
from {{ ref('customers') }}
where first_order_date is not null