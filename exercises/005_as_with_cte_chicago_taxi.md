# Exercise 005 — AS + WITH (CTEs) + EXTRACT (Kaggle)

## Goal
Practice “multi-step analysis” queries using:
- `EXTRACT()` for time breakdowns (year/month/hour)
- `WITH` (CTEs) for readable pipelines
- computed metrics (average speed in mph)

## Dataset used
- `bigquery-public-data.chicago_taxi_trips`
- Table: `taxi_trips`

## Steps practiced
1) List dataset tables and identify the correct table name  
2) Preview rows to confirm timestamp + distance + duration fields  
3) Aggregate trips by year and month using `EXTRACT()`  
4) Use a CTE to filter clean trips and calculate average speed by hour

## Key code (Kaggle style)
### Python setup + dataset fetch
```python
from google.cloud import bigquery

# Create a "Client" object
client = bigquery.Client()

# Construct a reference to the dataset
dataset_ref = client.dataset("chicago_taxi_trips", project="bigquery-public-data")
dataset = client.get_dataset(dataset_ref)

# List tables
tables = list(client.list_tables(dataset))
for t in tables:
    print(t.table_id)

# Table name recorded in notebook
table_name = 'taxi_trips'
```
## Exercise queries
### 1) Trips per year
``` sql
SELECT EXTRACT(YEAR from trip_start_timestamp) as year, COUNT(1) AS num_trips
FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
GROUP BY year
ORDER BY year ASC
```

### 2) Trips per month in 2016
``` sql
SELECT EXTRACT(MONTH from trip_start_timestamp) as month, COUNT(1) AS num_trips
FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE EXTRACT(YEAR from trip_start_timestamp) = 2016
GROUP BY month
ORDER BY month ASC
```

### 3) Avg speed (mph) by hour of day (Jan–Mar 2016) using a CTE
``` sql
WITH RelevantRides AS
(
    SELECT 
    trip_seconds, trip_miles,
    EXTRACT(HOUR from trip_start_timestamp) AS hour_of_day
    FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
    WHERE trip_start_timestamp > '2016-01-01' AND 
          trip_start_timestamp < '2016-04-01' AND 
          trip_seconds > 0 AND 
          trip_miles > 0
)
SELECT hour_of_day, COUNT(1) AS num_trips, 3600 * SUM(trip_miles) / SUM(trip_seconds) AS avg_mph
FROM RelevantRides
GROUP BY hour_of_day
ORDER BY hour_of_day ASC
```

## Results / answers recorded in the notebook
- Confirmed the table name: table_name = 'taxi_trips'.
- Defined rides_per_year_query, rides_per_month_query, and speeds_query.
- Queries were validated in Kaggle using the exercise check system.

## Notes
- WITH (CTEs) makes multi-step queries readable and reusable.
- Filtering out trip_seconds <= 0 and trip_miles <= 0 prevents invalid speeds.
- EXTRACT(HOUR...) is useful for time-of-day behavior analysis.
