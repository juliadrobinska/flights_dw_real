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