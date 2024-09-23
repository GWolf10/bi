# DataBase Monoitoring
## Final project - 1
### Description: 
BigQuery public project contains many datasets,
It is impossible to monitor when each table had been updated
and what is the info on each table.
As a BI developer you have been requested to develop a daily job
which will monitor this data warehouse.
The job will extract the info on all the tables,
you need to define which properties you would like to extract and where to
save it.

### Action Items:
1. Define the KPIs you want to extract
2. Develop the python script which execute this operation
3. Draw a chart flow for the whole process
4. Which features will you add to the process?


## Solution
### KPIs
    - Created
    - Last Modified
    - Number of rows
    - Total logical bytes

## source 
- [list_datasets_and_tables](https://cloud.google.com/bigquery/docs/listing-datasets?_gl=1*psper8*_ga*MjA0NjAwNTk4OC4xNzI2NjUyOTg3*_ga_WH2QY8WWF5*MTcyNzA3OTQyOS4xMi4xLjE3MjcwODEyMzUuNjAuMC4w#python)
- [get_table_info](https://cloud.google.com/bigquery/docs/listing-datasets?_gl=1*psper8*_ga*MjA0NjAwNTk4OC4xNzI2NjUyOTg3*_ga_WH2QY8WWF5*MTcyNzA3OTQyOS4xMi4xLjE3MjcwODEyMzUuNjAuMC4w#get_information_about_datasets)

Process
for given project_id
we need to extract (list) all the datasets
for each dataset we need to extract (list) all the tables
and for each table we need to extract the info.
save all the date into a table in our project

#### my table id: bigquery-public-data.noaa_tsunami.historical_runups
```dtd
create scheme bi_final_project options(
        description = 'This table contains the info on all the tables in the given project'
)
```
[load_dataframe_into_tables](https://cloud.google.com/bigquery/docs/samples/bigquery-load-table-dataframe?_gl=1*1ed13z1*_ga*MjA0NjAwNTk4OC4xNzI2NjUyOTg3*_ga_WH2QY8WWF5*MTcyNzA5MDEwNy4xNC4xLjE3MjcwOTA2MDQuNTguMC4w)