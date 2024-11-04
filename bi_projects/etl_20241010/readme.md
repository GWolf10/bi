# ETL - Extract Transform Load
## Definition of procedure

## Goal - 
Develop ETL process which extracts data from Google Cloud Storage to Google Cloud BigQuery
`
## Methodology
Create a python script which execute all the steps and can be deployed to Virtual Machine - production

## Steps
1. Get permission to GCS
2. Explore the data in GCS
3. Extract sample data - Examine the schema, Which events. Developer docs
4. Transf`orm - if needed
5. Load - Data to BigQuery
6. Validate the data in DWH
7. Develop script from A2Z in Python
8. Scheduling
9. Documentation
10. Logs & alerts
11. Configuration
12. Validation procedure

## Links
* [Google Cloud Storage - Public](https://console.cloud.google.com/storage/browser/cloud-samples-data/bigquery/us-states)
* [US states csv file](https://storage.googleapis.com/cloud-samples-data/bigquery/us-states/us-states.csv)


## Operations
create temp folder to save the logs and data file
```dtd
mkdir -p temp/data/bidev/jobs/my_etl_01
mkdir -p temp/logs/bidev/jobs/my_etl_01
```

[BigQuery UI](https://console.cloud.google.com/bigquery?)
```dtd
create schema my_etl options (description ="My first ETL dataset") 
        
```

