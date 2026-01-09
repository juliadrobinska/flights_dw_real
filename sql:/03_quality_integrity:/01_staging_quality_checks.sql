SELECT COUNT(*) FROM staging.flights_raw;

SELECT * FROM staging.flights_raw LIMIT 10;

-- Data quality check: NULL counts in key columns
SELECT
  COUNT(*) AS total,
  SUM(CASE WHEN fl_date IS NULL THEN 1 ELSE 0 END) AS null_fl_date,
  SUM(CASE WHEN airline_code IS NULL THEN 1 ELSE 0 END) AS null_airline_code,
  SUM(CASE WHEN origin IS NULL THEN 1 ELSE 0 END) AS null_origin,
  SUM(CASE WHEN dest IS NULL THEN 1 ELSE 0 END) AS null_dest
FROM staging.flights_raw;

-- Validate boolean fields encoding (0/1 vs TRUE/FALSE)
SELECT
  cancelled,
  diverted,
  COUNT(*) AS cnt
FROM staging.flights_raw
GROUP BY cancelled, diverted
ORDER BY cnt DESC;

SELECT
  COUNT(*) AS total,
  SUM(CASE WHEN cancelled IS NULL THEN 1 ELSE 0 END) AS null_cancelled,
  SUM(CASE WHEN diverted  IS NULL THEN 1 ELSE 0 END) AS null_diverted
FROM staging.flights_raw;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'staging'
  AND table_name = 'flights_raw'
ORDER BY ordinal_position;