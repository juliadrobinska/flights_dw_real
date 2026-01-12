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

## Core Layer

### Fact Table: flights

### Dimension Tables

## Data Quality & Integrity

## Why This Design
