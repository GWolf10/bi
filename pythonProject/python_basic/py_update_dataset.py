
from google.cloud import bigquery

# Construct a BigQuery client object.
client = bigquery.Client()

# TODO(developer): Set dataset_id to the ID of the dataset to fetch.
#dataset_id = 'your-project.your_dataset'
dataset_id = "{}.py_dataset_tutorial".format(client.project)

dataset = client.get_dataset(dataset_id)  # Make an API request.
dataset.description = "Updated description tutorial"
dataset = client.update_dataset(dataset, ["description"])  # Make an API request.

full_dataset_id = "{}.{}".format(dataset.project, dataset.dataset_id)
print(
    "Updated dataset '{}' with description '{}'.".format(
        full_dataset_id, dataset.description
    )
)