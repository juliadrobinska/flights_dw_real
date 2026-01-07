CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.flights_raw (
    fl_date DATE,
    airline_code TEXT,
    fl_number INTEGER,
    origin TEXT,
    dest TEXT,
    dep_delay INTEGER,
    arr_delay INTEGER,
    cancelled BOOLEAN,
    diverted BOOLEAN,
    distance INTEGER
);

SELECT * FROM staging.flights_raw;

SELECT COUNT(*) FROM staging.flights_raw;

SELECT * FROM staging.flights_raw LIMIT 10;

-- ile jest NULLi w kluczowych kolumnach?
SELECT
  COUNT(*) AS total,
  SUM(CASE WHEN fl_date IS NULL THEN 1 ELSE 0 END) AS null_fl_date,
  SUM(CASE WHEN airline_code IS NULL THEN 1 ELSE 0 END) AS null_airline_code,
  SUM(CASE WHEN origin IS NULL THEN 1 ELSE 0 END) AS null_origin,
  SUM(CASE WHEN dest IS NULL THEN 1 ELSE 0 END) AS null_dest
FROM staging.flights_raw;

-- czy booleany wyglądają sensownie? (0/1 vs true/false)
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

CREATE SCHEMA IF NOT EXISTS core;

CREATE TABLE IF NOT EXISTS core.dim_airlines (
  airline_code TEXT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS core.dim_airports (
  airport_code TEXT PRIMARY KEY
);

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

DROP TABLE IF EXISTS core.flights;

CREATE TABLE core.flights AS
SELECT
  fl_date,
  airline_code,
  fl_number,
  origin,
  dest,
  dep_delay,
  arr_delay,
  cancelled,
  diverted,
  distance
FROM staging.flights_raw;

SELECT COUNT(*) FROM core.flights;
SELECT * FROM core.flights LIMIT 5;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'core'
  AND table_name = 'flights'
ORDER BY ordinal_position;


-- Czy są loty z airline_code, którego nie ma w dim_airlines?
SELECT COUNT(*) AS missing_airlines
FROM core.flights f
LEFT JOIN core.dim_airlines d ON d.airline_code = f.airline_code
WHERE f.airline_code IS NOT NULL
  AND d.airline_code IS NULL;

-- Czy są loty z origin, którego nie ma w dim_airports?
SELECT COUNT(*) AS missing_origin_airports
FROM core.flights f
LEFT JOIN core.dim_airports a ON a.airport_code = f.origin
WHERE f.origin IS NOT NULL
  AND a.airport_code IS NULL;

-- Czy są loty z dest, którego nie ma w dim_airports?
SELECT COUNT(*) AS missing_dest_airports
FROM core.flights f
LEFT JOIN core.dim_airports a ON a.airport_code = f.dest
WHERE f.dest IS NOT NULL
  AND a.airport_code IS NULL;

ALTER TABLE core.flights
  ADD CONSTRAINT fk_flights_airline
  FOREIGN KEY (airline_code) REFERENCES core.dim_airlines(airline_code);

ALTER TABLE core.flights
  ADD CONSTRAINT fk_flights_origin
  FOREIGN KEY (origin) REFERENCES core.dim_airports(airport_code);

ALTER TABLE core.flights
  ADD CONSTRAINT fk_flights_dest
  FOREIGN KEY (dest) REFERENCES core.dim_airports(airport_code);

CREATE INDEX IF NOT EXISTS idx_flights_airline_code ON core.flights (airline_code);
CREATE INDEX IF NOT EXISTS idx_flights_origin       ON core.flights (origin);
CREATE INDEX IF NOT EXISTS idx_flights_dest         ON core.flights (dest);
CREATE INDEX IF NOT EXISTS idx_flights_fl_date      ON core.flights (fl_date);

SELECT
  f.origin,
  f.dest,
  COUNT(*) AS flights_cnt
FROM core.flights f
GROUP BY f.origin, f.dest
ORDER BY flights_cnt DESC
LIMIT 20;

SELECT
 f.airline_code,
 ROUND(AVG(f.dep_delay), 2) AS avg_dep_delay,
 ROUND(AVG(f.arr_delay), 2) AS avg_arr_delay,
 COUNT(*) AS flights_cnt
FROM core.flights f
WHERE f.cancelled = FALSE
GROUP BY f.airline_code
ORDER BY avg_dep_delay DESC, flights_cnt DESC

SELECT
  f.airline_code,
  COUNT(*) AS flights_cnt,
  ROUND(AVG(f.arr_delay), 2) AS avg_arr_delay
FROM core.flights f
WHERE f.cancelled = FALSE
GROUP BY f.airline_code
HAVING COUNT(*) >= 100000
ORDER BY avg_arr_delay DESC;
