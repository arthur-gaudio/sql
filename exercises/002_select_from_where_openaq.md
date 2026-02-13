# Exercise 002 — SELECT / FROM / WHERE (Kaggle)

## Goal
Practice writing basic SQL queries in BigQuery:
- selecting specific columns
- filtering rows with `WHERE`
- using `DISTINCT` to get unique values

## Dataset used
- `bigquery-public-data.openaq`
- Table: `global_air_quality`

## Steps practiced
1) Fetch dataset + table with BigQuery Python client  
2) Preview rows to understand columns  
3) Write and run SQL queries with `SELECT`, `FROM`, `WHERE`, `DISTINCT`

## Key code (Kaggle style)
### Python setup + table fetch
```python
from google.cloud import bigquery

# Create a "Client" object
client = bigquery.Client()

# Construct a reference to the "openaq" dataset
dataset_ref = client.dataset("openaq", project="bigquery-public-data")

# API request - fetch the dataset
dataset = client.get_dataset(dataset_ref)

# Construct a reference to the "global_air_quality" table
table_ref = dataset_ref.table("global_air_quality")

# API request - fetch the table
table = client.get_table(table_ref)

# Preview the first five rows
client.list_rows(table, max_results=5).to_dataframe()
```
## Exercise queries
### 1) Units of measurement (countries reporting in ppm)
``` sql
SELECT DISTINCT country
FROM `bigquery-public-data.openaq.global_air_quality`
WHERE unit = 'ppm'
```

### 2) High air quality (pollution value = 0)
``` sql
SELECT *
FROM `bigquery-public-data.openaq.global_air_quality`
WHERE value = 0
```

## Results / answers recorded in the notebook
- Created first_query to return distinct countries where unit = 'ppm'.
- Created zero_pollution_query to return rows where value = 0.
- Queries were validated in Kaggle using the exercise check system.

## Notes
- BigQuery tables can be huge → filter early with WHERE.
- SELECT * is useful for quick exploration, but in real work it’s better to select only needed columns.
- DISTINCT is a fast way to see what unique values exist in a column.
