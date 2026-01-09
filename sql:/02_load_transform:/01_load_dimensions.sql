INSERT INTO core.dim_airlines (airline_code)
SELECT DISTINCT airline_code
FROM staging.flights_raw
WHERE airline_code IS NOT NULL
ON CONFLICT (airline_code) DO NOTHING;

INSERT INTO core.dim_airports (airport_code)
SELECT DISTINCT origin
FROM staging.flights_raw
WHERE origin IS NOT NULL
ON CONFLICT (airport_code) DO NOTHING;

INSERT INTO core.dim_airports (airport_code)
SELECT DISTINCT dest
FROM staging.flights_raw
WHERE dest IS NOT NULL
ON CONFLICT (airport_code) DO NOTHING;

SELECT COUNT(*) FROM core.dim_airlines;
SELECT COUNT(*) FROM core.dim_airports;