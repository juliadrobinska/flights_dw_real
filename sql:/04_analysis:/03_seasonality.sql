-- Analysis: seasonal patterns in average departure and arrival delays (by month)
SELECT 
  	EXTRACT(MONTH FROM f.fl_date) AS month_num,
	TRIM(TO_CHAR(f.fl_date, 'Month')) AS flight_month,
	ROUND(AVG(f.dep_delay), 2) AS avg_dep_delay,
 	ROUND(AVG(f.arr_delay), 2) AS avg_arr_delay,
 	COUNT(*) AS flights_cnt
 FROM core.flights f
 WHERE f.cancelled = FALSE
 GROUP BY TRIM(TO_CHAR(f.fl_date, 'Month')), EXTRACT(MONTH FROM f.fl_date)
 ORDER BY MONTH_num;