# Flights Data Warehouse & Analysis

## Overview

This project demonstrates the design and analysis of a relational data warehouse built on flight operations data. 
The goal was to model flight data using a clean staging → core architecture, validate data quality and integrity, and perform analytical queries focused on delays, cancellations, and seasonality.

The project emphasizes data modeling, SQL organization, and analytical reasoning, rather than raw data ingestion automation.

## Data Model
### Schemas
- staging – raw, minimally processed flight data loaded from source files
- core – curated analytical layer with fact and dimension tables

### Tables
- staging.flights_raw
Raw flight-level data used as the ingestion layer.
- core.flights (fact table) Contains operational metrics such as flight date, airline, origin, destination, delays, cancellations, and distance.
- core.dim_airlines (dimension) Unique airline codes.
- core.dim_airports (dimension) Unique airport codes used for both origin and destination.

The model follows a star-schema-like structure, where the fact table references dimension tables via foreign keys.

## Design Decisions & Scope
The core fact table (core.flights) contains a curated subset of available columns focused on:
- schedule performance
- delays
- cancellations
- traffic volume

Detailed delay attribution columns (e.g. weather, carrier, NAS, security) are present in the raw dataset but were intentionally excluded from the core model to keep it lightweight and focused on high-level performance analysis.

The data model is designed to be easily extensible in future iterations.

## Data Quality & Integrity
The project includes explicit validation steps:
- NULL checks for key columns
- Boolean encoding verification
- Referential integrity checks between fact and dimension tables
- Foreign key constraints
- Indexes on commonly filtered and joined columns

These steps ensure consistency between staging and core layers and improve query performance.

## Analysis Highlights
The analytical queries focus on:
- Most frequently operated routes
- Average departure and arrival delays by airline
- Delay rates using an industry-standard threshold (>15 minutes)
- Cancellation rates by origin airport
- Seasonal patterns in delays across calendar months

To ensure statistical stability, selected analyses apply minimum flight volume thresholds.

## Analytical Views
Two analytical views were created to simplify downstream analysis:
- vw_monthly_airline_departure_delays
- vw_monthly_airline_arrival_delays

These views expose monthly delay patterns by airline without requiring repeated aggregation logic.

## Project Structure

```text
sql/
├── 01_schemas/
├── 02_load_transform/
├── 03_quality_integrity/
├── 04_analysis/
└── 05_views/
```

SQL scripts are organized in logical execution order, from schema creation to analysis and views.

## Technologies
- PostgreSQL
- SQL
- DBeaver (development & exploration)

## Key Takeaways
- Clean separation between raw and analytical layers improves clarity and extensibility
- Data quality checks are a critical part of analytical workflows
- Using rates and thresholds provides more meaningful insights than raw counts
- Organizing SQL scripts as a pipeline improves readability and maintainability

## Future Improvements
- Enrich airport and airline dimensions with descriptive metadata
- Extend the fact table with delay attribution columns
- Add automation for data ingestion
- Create additional analytical views or dashboards