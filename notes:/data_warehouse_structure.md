# Data Warehouse Structure

## Project Context

This project uses flight-level data to analyze delays and cancellations
and their relationship with airlines and airports.

It aims to answer questions such as:
- which airlines experience the largest delays,
- which airports are most affected by delays and cancellations.


## Overall Architecture

The project follows a simple data warehouse flow.
Raw flight data is first loaded into a staging layer, then transformed into
cleaned core tables, which are later used for analysis and analytical views.

## Staging Layer

The staging layer contains raw flight data and serves as an intermediate stage
between the source data and the core tables.

At this stage, basic data quality checks are performed, such as validating
NULL values in key columns and verifying boolean fields.
No business logic or transformations are applied here.

## Core Layer

The core layer contains cleaned, structured, and analysis-ready data.
It represents the main analytical layer of the project and is used directly
for querying, reporting, and creating analytical views.

### Fact Table: flights

The flights table stores flight-level data, where each row represents a single flight.
It contains key metrics such as departure and arrival delays, distance, and cancellation status,
as well as foreign keys linking flights to airlines and airports.

### Dimension Tables

## Data Quality & Integrity

## Why This Design
