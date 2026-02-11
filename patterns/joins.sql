/* JOIN patterns (GitHub public dataset) */

-- Files per license
SELECT
  l.license,
  COUNT(1) AS number_of_files
FROM `bigquery-public-data.github_repos.sample_files` AS sf
INNER JOIN `bigquery-public-data.github_repos.licenses` AS l
  ON sf.repo_name = l.repo_name
WHERE l.license IS NOT NULL
GROUP BY l.license
ORDER BY number_of_files DESC;

-- Files + distinct repos per license
SELECT
  l.license,
  COUNT(1) AS number_of_files,
  COUNT(DISTINCT sf.repo_name) AS number_of_repos
FROM `bigquery-public-data.github_repos.sample_files` AS sf
INNER JOIN `bigquery-public-data.github_repos.licenses` AS l
  ON sf.repo_name = l.repo_name
WHERE l.license IS NOT NULL
GROUP BY l.license
ORDER BY number_of_files DESC;
