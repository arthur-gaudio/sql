# Exercise 003 — GROUP BY / HAVING / COUNT (Kaggle)

## Goal
Practice aggregation patterns used in analytics:
- `COUNT()`
- grouping with `GROUP BY`
- filtering groups with `HAVING`
- aliasing with `AS`

## Dataset used
- `bigquery-public-data.hacker_news`
- Table: `full`

## Steps practiced
1) Fetch dataset + table with BigQuery Python client  
2) Preview rows and identify useful columns  
3) Write aggregation queries using `COUNT`, `GROUP BY`, and `HAVING`

## Key code (Kaggle style)
### Python setup + table fetch
```python
from google.cloud import bigquery

# Create a "Client" object
client = bigquery.Client()

# Construct a reference to the "hacker_news" dataset
dataset_ref = client.dataset("hacker_news", project="bigquery-public-data")

# API request - fetch the dataset
dataset = client.get_dataset(dataset_ref)

# Construct a reference to the "full" table
table_ref = dataset_ref.table("full")

# API request - fetch the table
table = client.get_table(table_ref)

# Preview the first five rows
client.list_rows(table, max_results=5).to_dataframe()
```

## Exercise queries
### 1) Prolific commenters (> 10,000 posts)
```sql
SELECT `by` AS author, COUNT(1) AS NumPosts
FROM `bigquery-public-data.hacker_news.full`
GROUP BY author
HAVING COUNT(1) > 10000
```

### 2) Deleted comments (count deleted posts)
``` sql
SELECT deleted, COUNT(1) AS NumPosts
FROM `bigquery-public-data.hacker_news.full`
GROUP BY deleted
HAVING deleted = True
```

## Results / answers recorded in the notebook
- Defined prolific_commenters_query and deleted_comments_query.
- Stored answer: num_deleted_posts = 0 (as recorded in notebook).
- Queries were validated in Kaggle using the exercise check system.

## Notes
- WHERE filters rows before grouping; HAVING filters after grouping.
- When using GROUP BY, every column in SELECT must be either grouped or aggregated (COUNT/SUM/AVG/etc.)
- Aliasing (AS) makes result columns readable for stakeholders and dashboards.
