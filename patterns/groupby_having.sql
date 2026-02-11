/* COUNT + GROUP BY + HAVING patterns */

-- Count rows by type
SELECT
  type,
  COUNT(1) AS total
FROM `bigquery-public-data.hacker_news.full`
GROUP BY type
ORDER BY total DESC;

-- Authors with more than 100 items
SELECT
  by,
  COUNT(1) AS total_items
FROM `bigquery-public-data.hacker_news.full`
WHERE by IS NOT NULL
GROUP BY by
HAVING COUNT(1) > 100
ORDER BY total_items DESC;
