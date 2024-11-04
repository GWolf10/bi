from google.cloud import bigquery
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError

# Function to check for missing dates in the BigQuery table
def check_date_gaps(project_id, dataset_id, table_id):
    # Initialize a BigQuery client
    client = bigquery.Client(project=project_id)

    # The query to check for missing dates
    query = f"""
    WITH date_bounds AS (
        SELECT 
            MIN(event_date) AS min_date,
            MAX(event_date) AS max_date
        FROM `{project_id}.{dataset_id}.{table_id}`
    ),
    all_dates AS (
        SELECT 
            DATE_ADD(min_date, INTERVAL n DAY) AS generated_date
        FROM date_bounds,
        UNNEST(GENERATE_ARRAY(0, DATE_DIFF(max_date, min_date, DAY))) AS n
    ),
    missing_dates AS (
        SELECT generated_date
        FROM all_dates
        WHERE generated_date NOT IN (SELECT event_date FROM `{project_id}.{dataset_id}.{table_id}`)
    )
    SELECT generated_date
    FROM missing_dates;
    """

    # Run the query
    query_job = client.query(query)
    results = query_job.result()

    # Check if there are any missing dates
    missing_dates = [row.generated_date for row in results]
    return missing_dates


# Function to send an alert to Slack if there are any missing dates
def send_slack_alert(missing_dates, slack_token, slack_channel):
    # Initialize Slack client
    client = WebClient(token=slack_token)

    # Prepare the alert message
    if missing_dates:
        message = f"Alert! Missing dates found: {missing_dates}"
    else:
        message = "All dates are in sequence. No gaps found."

    try:
        # Send the message to the specified Slack channel
        response = client.chat_postMessage(channel=slack_channel, text=message)
        print(f"Slack message sent successfully: {response['message']['text']}")
    except SlackApiError as e:
        print(f"Error sending Slack message: {e.response['error']}")


if __name__ == "__main__":
    # Replace with your GCP project, dataset, and table details
    project_id = "strange-bay-433318-g0"
    dataset_id = "test_by_gal_from_liad"
    table_id = "dates_table"

    # Slack details
    slack_token = "xoxb-your-slack-token-here"  # Replace with your Slack bot token
    slack_channel = "#your-channel"  # Replace with your Slack channel name

    # Step 1: Check for date gaps in BigQuery
    missing_dates = check_date_gaps(project_id, dataset_id, table_id)

    # Step 2: Send alert to Slack
    send_slack_alert(missing_dates, slack_token, slack_channel)
