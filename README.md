# sql

SQL practice repo focused on **analytics SQL** (the stuff data analyst interviews and real work use):
- filtering (`WHERE`)
- aggregation (`COUNT`, `SUM`, `AVG`)
- grouping (`GROUP BY`, `HAVING`)
- sorting (`ORDER BY`)
- dates (`DATE`, `DATETIME`, `EXTRACT`, timestamp conversions)
- CTEs (`WITH`)
- joins (`INNER JOIN ... ON ...`)

Main goal:
✅ build a reusable **SQL patterns library** + ✅ an **exercise bank**.

---

## Structure (recommended)
patterns/
select_where.sql
groupby_having.sql
dates_extract.sql
ctes.sql
joins.sql

exercises/
001_...
002_...
...

sql_exercises.md

---

## How I practice
1) Learn a topic  
2) Write 5–10 queries  
3) Save the best query templates to `patterns/`  
4) Save drills to `exercises/`  
5) Log notes in `learning_log`

---

## Datasets I use (BigQuery Public Data)
- OpenAQ: `bigquery-public-data.openaq.global_air_quality`
- Hacker News: `bigquery-public-data.hacker_news.full`
- GitHub repos:
  - `bigquery-public-data.github_repos.sample_files`
  - `bigquery-public-data.github_repos.licenses`

---

## Learning links
- Kaggle Intro SQL: https://www.kaggle.com/learn/intro-to-sql
- Kaggle Advanced SQL: https://www.kaggle.com/learn/advanced-sql
- Mode SQL Tutorial: https://mode.com/sql-tutorial/
