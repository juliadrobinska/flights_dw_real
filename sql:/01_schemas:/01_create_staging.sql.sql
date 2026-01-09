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