CREATE SCHEMA IF NOT EXISTS core;

CREATE TABLE IF NOT EXISTS core.dim_airlines (
  airline_code TEXT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS core.dim_airports (
  airport_code TEXT PRIMARY KEY
);