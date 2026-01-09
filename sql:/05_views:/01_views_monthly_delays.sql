-- Analytical views

-- Monthly average departure delays by airline (non-cancelled flights)
CREATE VIEW core.vw_monthly_airline_departure_delays AS
SELECT
  EXTRACT(MONTH FROM fl_date) AS month_num,
  TRIM(TO_CHAR(fl_date, 'Month')) AS flight_month,
  airline_code,
  ROUND(AVG(dep_delay), 2) AS avg_dep_delay
FROM core.flights
WHERE cancelled = FALSE
GROUP BY month_num, flight_month, airline_code;

-- Monthly average arrival delays by airline (non-cancelled flights)
CREATE VIEW core.vw_monthly_airline_arrival_delays AS
SELECT
  EXTRACT(MONTH FROM fl_date) AS month_num,
  TRIM(TO_CHAR(fl_date, 'Month')) AS flight_month,
  airline_code,
  ROUND(AVG(arr_delay), 2) AS avg_arr_delay
FROM core.flights
WHERE cancelled = FALSE
GROUP BY month_num, flight_month, airline_code;