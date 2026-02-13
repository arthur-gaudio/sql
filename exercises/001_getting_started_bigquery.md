# Exercise 001 — Getting Started with SQL + BigQuery (Kaggle)

## Goal
Get comfortable with the BigQuery Python client workflow:
Project → Dataset → Table → Schema → Preview rows

## Dataset used
- `bigquery-public-data.chicago_crime`
- Table explored: `crime`

## Steps practiced
1) Create BigQuery client
2) Create dataset reference + fetch dataset
3) List tables in dataset
4) Fetch a table
5) Inspect schema
6) Preview rows

## Key code (Kaggle style)
```python
from google.cloud import bigquery

client = bigquery.Client()

dataset_ref = client.dataset("chicago_crime", project="bigquery-public-data")
dataset = client.get_dataset(dataset_ref)

tables_list = list(client.list_tables(dataset))
for t in tables_list:
    print(t.table_id)

table_ref = dataset_ref.table("crime")
table = client.get_table(table_ref)

table.schema
client.list_rows(table, max_results=5).to_dataframe()
```
## Results / answers recorded in the notebook
- Number of tables found: 1
- Number of TIMESTAMP fields in crime table schema: 2

Notes
- Schema includes: column name, datatype, mode (NULLABLE), and description.
- Previewing a few rows before querying helps avoid schema mistakes.
