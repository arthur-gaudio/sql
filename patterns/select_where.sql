/* SELECT / FROM / WHERE patterns */

-- Basic filter + column selection
SELECT
  city,
  location,
  parameter,
  value
FROM `bigquery-public-data.openaq.global_air_quality`
WHERE country = 'US'
LIMIT 20;

-- Multiple conditions
SELECT
  city,
  parameter,
  value
FROM `bigquery-public-data.openaq.global_air_quality`
WHERE country = 'US'
  AND value > 50
LIMIT 20;

-- IN filter
SELECT
  country,
  COUNT(1) AS rows_count
FROM `bigquery-public-data.openaq.global_air_quality`
WHERE country IN ('US','CA','GB')
GROUP BY country
ORDER BY rows_count DESC;
