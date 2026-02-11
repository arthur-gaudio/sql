/* Dates + EXTRACT patterns (Hacker News time often stored as unix seconds) */

-- Monthly totals
SELECT
  EXTRACT(YEAR FROM TIMESTAMP_SECONDS(time)) AS year,
  EXTRACT(MONTH FROM TIMESTAMP_SECONDS(time)) AS month,
  COUNT(1) AS total_items
FROM `bigquery-public-data.hacker_news.full`
WHERE time IS NOT NULL
GROUP BY year, month
ORDER BY year, month;

-- Day of week distribution
SELECT
  EXTRACT(DAYOFWEEK FROM TIMESTAMP_SECONDS(time)) AS day_of_week,
  COUNT(1) AS total_items
FROM `bigquery-public-data.hacker_news.full`
WHERE time IS NOT NULL
GROUP BY day_of_week
ORDER BY day_of_week;
