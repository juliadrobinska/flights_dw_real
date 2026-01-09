-- Referential integrity check: flights with airline_code missing in dim_airlines
SELECT COUNT(*) AS missing_airlines
FROM core.flights f
LEFT JOIN core.dim_airlines d ON d.airline_code = f.airline_code
WHERE f.airline_code IS NOT NULL
  AND d.airline_code IS NULL;

-- Referential integrity check: flights with origin airport missing in dim_airports
SELECT COUNT(*) AS missing_origin_airports
FROM core.flights f
LEFT JOIN core.dim_airports a ON a.airport_code = f.origin
WHERE f.origin IS NOT NULL
  AND a.airport_code IS NULL;

-- Referential integrity check: flights with destination airport missing in dim_airports
SELECT COUNT(*) AS missing_dest_airports
FROM core.flights f
LEFT JOIN core.dim_airports a ON a.airport_code = f.dest
WHERE f.dest IS NOT NULL
  AND a.airport_code IS NULL;