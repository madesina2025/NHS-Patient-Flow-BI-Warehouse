# NHS Patient Flow BI Warehouse

## Project Overview
A production-style Business Intelligence portfolio project
analysing NHS Referral to Treatment (RTT) waiting times.

The solution uses SSIS for data integration, PostgreSQL for
staging and dimensional warehousing, and Power BI for
analytics and reporting.

## Business Objectives
- Monitor NHS waiting-list performance.
- Analyse incomplete RTT pathways.
- Compare provider and clinical specialty performance.
- Monitor 18-week RTT performance.
- Analyse admitted and non-admitted pathways.
- Identify long-waiting pathways and trends.

## Data Source
NHS England - Referral to Treatment Waiting Times.

Initial reporting periods:
- November 2025
- December 2025 (revised)
- January 2026

Source format: Monthly CSV extracts.

## Architecture
NHS CSV Files
    |
    v
Landing Zone
    |
    v
SSIS ETL
    |
    v
PostgreSQL Staging
    |
    v
PostgreSQL Data Warehouse
    |
    v
Power BI Dashboards

## Technologies
- SQL Server Integration Services (SSIS)
- PostgreSQL
- SQL
- Power BI
- Git and GitHub

## Data Engineering Controls
- Source file validation
- ETL audit logging
- Data quality checks
- Duplicate prevention
- Error handling
- Monthly snapshot processing
- Historical data retention
- Reprocessing of revised files

## Project Status
Phase 1 - Environment and repository setup.

## Data Privacy
The project uses publicly available aggregated NHS
statistics, not patient-identifiable records.
