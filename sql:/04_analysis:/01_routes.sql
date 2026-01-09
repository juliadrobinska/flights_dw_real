-- Analysis: most popular routes by number of flights
SELECT
  f.origin,
  f.dest,
  COUNT(*) AS flights_cnt
FROM core.flights f
GROUP BY f.origin, f.dest
ORDER BY flights_cnt DESC
LIMIT 20;