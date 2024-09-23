from google.cloud import bigquery

# Construct a BigQuery client object.
client = bigquery.Client()

# TODO(developer): Set table_id to the ID of the destination table.
table_id = "bi-ppltx2.py_dataset_tutorial.run_query_and_save_results"

job_config = bigquery.QueryJobConfig(destination=table_id)

sql = """
    SELECT corpus
    FROM `bigquery-public-data.samples.shakespeare`
    GROUP BY corpus;
"""

# Start the query, passing in the extra configuration.
client.query_and_wait(
    sql, job_config=job_config
)  # Make an API request and wait for the query to finish.

print("Query results loaded to the table {}".format(table_id))