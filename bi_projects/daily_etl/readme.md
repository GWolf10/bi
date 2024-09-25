# Practicing on my ETL process
## Extract Google bigquery data

```dtd
CREATE SCHEMA `strange-bay-433318-g0.daily_etl`
OPTIONS (
  description = "This is the schema for the daily ETL process"
);
```

## steps
1. Extract data from Google Bigquery
2. create increment for recent N days
3. Delete recent 5 days from Agg table
4. Insert new data into Agg table