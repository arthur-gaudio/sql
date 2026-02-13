# Exercise 006 — JOINing Data (Kaggle)

## Goal
Practice joining two related tables to answer real questions:
- explore available tables
- preview schemas
- join answers to questions
- find “experts” by counting answers

## Dataset used
- `bigquery-public-data.stackoverflow`
- Tables:
  - `posts_questions`
  - `posts_answers`

## Steps practiced
1) Fetch dataset and list available tables  
2) Preview the two relevant tables (`posts_questions`, `posts_answers`)  
3) Write a query to find BigQuery-tagged questions  
4) Write an INNER JOIN to connect answers to those questions  
5) Aggregate and count answers per user to identify BigQuery experts

## Key code (Kaggle style)
### Python setup + dataset fetch
```python
from google.cloud import bigquery

# Create a "Client" object
client = bigquery.Client()

# Construct a reference to the "stackoverflow" dataset
dataset_ref = client.dataset("stackoverflow", project="bigquery-public-data")

# API request - fetch the dataset
dataset = client.get_dataset(dataset_ref)
```

### List available tables
``` python
tables = list(client.list_tables(dataset))
list_of_tables = [table.table_id for table in tables]
print(list_of_tables)
```

### Preview relevant tables
``` python
# posts_answers
answers_table_ref = dataset_ref.table("posts_answers")
answers_table = client.get_table(answers_table_ref)
client.list_rows(answers_table, max_results=5).to_dataframe()

# posts_questions
questions_table_ref = dataset_ref.table("posts_questions")
questions_table = client.get_table(questions_table_ref)
client.list_rows(questions_table, max_results=5).to_dataframe()
```

## Exercise queries
### 1) Questions tagged with "bigquery"
``` sql
SELECT id, title, owner_user_id
FROM `bigquery-public-data.stackoverflow.posts_questions`
WHERE tags LIKE '%bigquery%'
```

### 2) Answers to BigQuery-tagged questions (first join)
``` sql
SELECT a.id, a.body, a.owner_user_id
FROM `bigquery-public-data.stackoverflow.posts_answers` AS a
INNER JOIN `bigquery-public-data.stackoverflow.posts_questions` as q 
  ON a.parent_id = q.id
WHERE q.tags LIKE '%bigquery%'
```

### 3) BigQuery experts (users with most answers to BigQuery-tagged questions)
```sql
SELECT a.owner_user_id AS user_id, COUNT(1) AS number_of_answers
FROM `bigquery-public-data.stackoverflow.posts_answers` AS a
INNER JOIN `bigquery-public-data.stackoverflow.posts_questions` as q 
  ON a.parent_id = q.id
WHERE q.tags LIKE '%bigquery%'
GROUP BY user_id
```

## Results / answers recorded in the notebook
- Identified relevant tables by listing dataset tables (list_of_tables).
- Defined questions_query, answers_query, and bigquery_experts_query.
- Queries were validated in Kaggle using the exercise check system.

Notes
- Always use table aliases in joins (a, q) to keep queries readable.
- The join key here is: answers.parent_id = questions.id.
- This is a common analytics pattern: filter a “dimension” subset (questions), join the “fact” table (answers), then aggregate.
