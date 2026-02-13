# Exercise 004 — ORDER BY (Kaggle)

## Goal
Practice sorting results with `ORDER BY` in real analysis-style queries:
- ranking countries by an average metric
- finding the “largest groups” after aggregation

## Dataset used
- `bigquery-public-data.world_bank_intl_education`
- Table: `international_education`

## Steps practiced
1) Fetch dataset + preview table rows  
2) Filter by indicator + time range  
3) Aggregate with `AVG()` and sort with `ORDER BY`  
4) Aggregate with `COUNT()` and find top indicator codes

## Key code (Kaggle style)
### Python setup + table fetch
```python
from google.cloud import bigquery

# Create a "Client" object
client = bigquery.Client()

# Construct a reference to the dataset
dataset_ref = client.dataset("world_bank_intl_education", project="bigquery-public-data")
dataset = client.get_dataset(dataset_ref)

# Construct a reference to the table
table_ref = dataset_ref.table("international_education")
table = client.get_table(table_ref)

# Preview the first five rows
client.list_rows(table, max_results=5).to_dataframe()
```

## Exercise queries
### 1) Avg education spending (% GDP), 2010–2017, sorted highest → lowest

```sql
SELECT country_name, AVG(value) AS avg_ed_spending_pct
FROM `bigquery-public-data.world_bank_intl_education.international_education`
WHERE indicator_code = 'SE.XPD.TOTL.GD.ZS' AND year <= 2017 AND year >= 2010
GROUP BY country_name
ORDER BY avg_ed_spending_pct DESC
```

### 2) In 2016, indicator codes with at least 175 rows
``` sql
SELECT indicator_code, indicator_name, COUNT(1) AS num_rows
FROM `bigquery-public-data.world_bank_intl_education.international_education`
WHERE year = 2016
GROUP BY indicator_code, indicator_name
HAVING num_rows >= 175
ORDER BY num_rows DESC
```

## Results / answers recorded in the notebook
- Defined country_spend_pct_query and code_count_query.
- Queries were validated in Kaggle using the exercise check system.

## Notes
- ORDER BY ... DESC is a common “Top N” pattern.
- Sorting aggregated results is usually the last step after GROUP BY.
- Filtering by time range keeps results relevant and improves performance.
