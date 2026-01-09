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