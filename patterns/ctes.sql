/* CTE (WITH) patterns */

WITH base AS (
  SELECT
    by,
    type,
    TIMESTAMP_SECONDS(time) AS ts
  FROM `bigquery-public-data.hacker_news.full`
  WHERE time IS NOT NULL
),
monthly AS (
  SELECT
    EXTRACT(YEAR FROM ts) AS year,
    EXTRACT(MONTH FROM ts) AS month,
    COUNT(1) AS total_items
  FROM base
  GROUP BY year, month
)
SELECT
  year,
  month,
  total_items
FROM monthly
WHERE total_items > 10000
ORDER BY year, month;
