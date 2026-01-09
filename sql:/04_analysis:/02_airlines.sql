-- Analysis: average departure and arrival delays by airline (all airlines)
SELECT
 f.airline_code,
 ROUND(AVG(f.dep_delay), 2) AS avg_dep_delay,
 ROUND(AVG(f.arr_delay), 2) AS avg_arr_delay,
 COUNT(*) AS flights_cnt
FROM core.flights f
WHERE f.cancelled = FALSE
GROUP BY f.airline_code
ORDER BY avg_dep_delay DESC, flights_cnt DESC

-- Note: filtering by flight volume reduces the impact of small carriers with unstable averages

-- Analysis: average arrival delays by airline (large carriers only)
SELECT
  f.airline_code,
  COUNT(*) AS flights_cnt,
  ROUND(AVG(f.arr_delay), 2) AS avg_arr_delay
FROM core.flights f
WHERE f.cancelled = FALSE
GROUP BY f.airline_code
HAVING COUNT(*) >= 100000
ORDER BY avg_arr_delay DESC;

-- Analysis: departure delay rate (>15 minutes) by airline
SELECT 
	f.airline_code AS airline,
	COUNT(*) AS total_flights,
	ROUND (COUNT(*) FILTER (WHERE f.dep_delay > 15) * 100.0 / COUNT(*), 2) AS delayed_dep_rate_pct
FROM core.flights f
WHERE f.cancelled = FALSE
GROUP BY f.airline_code
HAVING COUNT(*) >= 100000
ORDER BY delayed_dep_rate_pct DESC;

-- Analysis: arrival delay rate (>15 minutes) by airline
SELECT 
	f.airline_code AS airline,
	COUNT(*) AS total_flights,
	ROUND (COUNT(*) FILTER (WHERE f.arr_delay > 15) * 100.0 / COUNT(*), 2) AS delayed_arr_rate_pct
FROM core.flights f
WHERE f.cancelled = FALSE
GROUP BY f.airline_code
HAVING COUNT(*) >= 100000
ORDER BY delayed_arr_rate_pct DESC;