 -- Analysis: airports with the highest number of cancelled departures (absolute counts)
 SELECT
 	f.origin AS origin_airport,
 	COUNT(*) FILTER (WHERE f.cancelled = TRUE) AS cancelled_flights,
  	COUNT(*) AS total_flights
 FROM core.flights f
 GROUP BY f.origin
 ORDER BY cancelled_flights DESC;
 
 -- Analysis: cancellation rate by origin airport (filtered by minimum flight volume)
 SELECT
  	f.origin AS origin_airport,
	COUNT(*) AS total_flights,
	ROUND(COUNT(*) FILTER (WHERE f.cancelled = TRUE) * 100.0 / COUNT(*), 2) AS cancellation_rate_pct
FROM core.flights f
GROUP BY f.origin
HAVING COUNT(*) >= 10000
ORDER BY cancellation_rate_pct DESC;