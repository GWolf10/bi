-- Delete data from table by date
/*
Description
{description}

Run Time
{run_time}
*/

--DELETE the data of the date
delete from `{project_id}.{dataset_src}.{table_src}`
WHERE {partition_att} =  date('{date}')
