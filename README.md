
# NHS Patient Flow & Waiting List BI Warehouse

## Project Overview

An end-to-end healthcare Business Intelligence portfolio project using NHS England Referral to Treatment (RTT) data.

The solution integrates monthly NHS RTT CSV extracts using SQL Server Integration Services (SSIS), stores transformed data in a SQL Server 2019 data warehouse, and delivers interactive Power BI reports.

**Technologies:** SSIS | SQL Server 2019 | T-SQL | Power BI | DAX

## Business Objectives

- Analyse incomplete RTT pathways and waiting-list trends.
- Monitor performance against the 18-week waiting-time threshold.
- Identify pathways waiting longer than 52 weeks.
- Compare NHS providers and treatment specialties.
- Analyse month-on-month changes in waiting-list volumes.

## Solution Architecture

![NHS Patient Flow Architecture](screenshots/01-architecture/nhs-patient-flow-architecture.png)

**Data Flow:**

NHS RTT CSV Extracts → SSIS ETL → SQL Server 2019 Data Warehouse → SQL Reporting Views → Power BI

## Data Integration and Warehousing

The SSIS solution contains four packages:

1. '00_Master_NHS_RTT_ETL' – ETL orchestration.
2. '01_Load_RTT_Staging' – CSV ingestion into raw staging.
3. '02_Transform_RTT_Staging' – Data cleansing, validation and standardisation.
4. '03_DFT_Load_FactRTTWaitingList' – Data warehouse fact loading.

The SQL Server data warehouse uses a star schema containing:

- Fact: 'dw.FactRTTWaitingList'
- Dimension: 'dw.DimReportingPeriod'
- Dimension: 'dw.DimProvider'
- Dimension: 'dw.DimCommissioner'
- Dimension: 'dw.DimTreatmentFunction'

SQL reporting views support the Power BI analytical layer.

## Data Quality and Validation

- Data cleansing and standardisation.
- Raw-to-clean-to-fact reconciliation.
- Monthly record-count and pathway-total comparisons.
- Reconciliation checks passed for all 12 reporting months.
- ETL audit logging and SQL validation scripts.

## SSIS ETL Implementation

The ETL solution was developed using SQL Server Integration Services (SSIS) in Visual Studio 2019.

The solution contains four packages responsible for orchestrating monthly NHS RTT data ingestion, cleansing, transformation and loading into the SQL Server data warehouse.

### Master ETL Package

The master package coordinates the execution of the ETL workflow.

![Master ETL Package](screenshots/02-ssis/master-etl-package.png)

### Package 01 — Load RTT Staging

This package processes NHS RTT monthly CSV extracts and loads source records into SQL Server staging tables.

**Control Flow**

![Load RTT Staging](screenshots/02-ssis/01-Load_RTT_Staging.png)

![Load RTT Staging Control Flow](screenshots/02-ssis/01-Load_RTT_Staging2.png)

**Data Flow**

![Load RTT Staging Data Flow](screenshots/02-ssis/01-Load_RTT_StagingDataFlow.png)

**Package Parameters and Variables**

![Staging Parameters](screenshots/02-ssis/01-Load_RTT_StagingParameters.png)

![Staging Variables](screenshots/02-ssis/01-Load_RTT_StagingVariables.png)

**C# Script Implementation**

![CSharp Script Task](screenshots/02-ssis/01-Load_RTT_Staging-CSharp.png)

![CSharp Script Code](screenshots/02-ssis/01-Load_RTT_Staging-CSharpScript.png)

### Package 02 — Transform RTT Staging

This package performs data cleansing, standardisation and transformation to prepare the NHS RTT records for warehouse loading.

**Control Flow**

![Transform RTT Staging](screenshots/02-ssis/02-Transform_RTT_Staging.png)

**Data Flow**

![Transformation Data Flow](screenshots/02-ssis/02-Transform_RTT_StagingDataFlow.png)

**Parameters and Variables**

![Transformation Parameter](screenshots/02-ssis/02-Transform_RTT_Staging-Parameter.png)

![Transformation Variable](screenshots/02-ssis/02-Transform_RTT_Staging-Variable.png)

### Package 03 — Load Fact RTT Waiting List

This package prepares and loads transformed RTT records into the data warehouse fact table.

**Control Flow**

![Fact Loading Package](screenshots/02-ssis/03-DFT_Load_FactRTTWaitingList.png)

**Data Flow**

![Fact Loading Data Flow](screenshots/02-ssis/03_DFT_Load_FactRTTWaitingListDataFlow.png)

**Foreach Loop Container**

![Fact Loading Foreach Loop](screenshots/02-ssis/03-DFT_Load_FactRTTWaitingList-ForeachLoop.png)

**Package Variables**

![Fact Loading Variable](screenshots/02-ssis/03-DFT_Load_FactRTTWaitingList-Variable.png)

---

## SQL Server Data Warehouse

The SQL Server 2019 data warehouse stores cleansed NHS RTT waiting-list records for analytical reporting.

The solution uses a dimensional model containing one fact table and four dimensions:

- 'dw.FactRTTWaitingList'
- 'dw.DimReportingPeriod'
- 'dw.DimProvider'
- 'dw.DimCommissioner'
- 'dw.DimTreatmentFunction'

### SQL Server Database Objects

The database includes staging tables, dimension tables, fact tables, reporting views and ETL audit objects.

![SQL Server Database Objects](screenshots/03-sql-server/sql-server-database-objects.png)

### Star Schema

The star schema supports reporting by month, provider, commissioner and treatment specialty.

![NHS RTT Data Warehouse Star Schema](screenshots/03-sql-server/nhs-rtt-data-warehouse-star-schema.png)

---

## SQL Data Quality and Reconciliation

SQL-based validation was performed to verify data consistency between the raw source, cleansed staging and fact warehouse layers.

Validation includes:

- Raw-to-clean-to-fact row-count reconciliation.
- Monthly pathway-total comparisons.
- Verification of warehouse loading completeness.
- Identification of missing or inconsistent records.

### Raw-to-Fact Reconciliation

![SQL Data Reconciliation](screenshots/03-sql-server/sql-data-reconciliation.png)

### All-Months Reconciliation

![SQL All Months Reconciliation](screenshots/03-sql-server/sql-all-months-reconciliation.png)

### Monthly Reconciliation Status

All 12 reporting months from April 2025 to March 2026 passed the recorded row-count reconciliation checks.

![SQL Monthly Reconciliation Status](screenshots/03-sql-server/sql-monthly-reconciliation-status.png)



## Power BI Dashboards

Four interactive report pages provide healthcare performance analysis.

### Executive Overview

Waiting-list KPIs, 18-week performance, provider comparisons and trends.

![Executive Overview](screenshots/04-powerbi/powerbi-executive-overview.png)

### Provider Performance

Comparison of NHS providers by waiting-list volumes and breaches.

![Provider Performance](screenshots/04-powerbi/powerbi-provider-performance.png)

### Specialty Analysis

Treatment-specialty comparisons and 18-week breach rates.

![Specialty Analysis](screenshots/04-powerbi/powerbi-specialty-analysis.png)

### Monthly Trends

Month-on-month changes in waiting-list volumes and waiting-time performance.

![Monthly Trends](screenshots/04-powerbi/powerbi-monthly-trends.png)

## Project Files

- 'ssis/' – SSIS packages and Visual Studio solution.
- 'database/' – SQL Server database schema scripts.
- 'sql/' – SQL queries and reconciliation scripts.
- 'powerbi/' – Power BI report files.
- 'screenshots/' – Architecture, ETL, SQL and dashboard evidence.



## Data Source

NHS England – Referral to Treatment (RTT) Waiting Times.

Reporting period: April 2025 to March 2026.

The dataset contains aggregated RTT pathway statistics, not individual patient records.

## Skills Demonstrated

**BI Development:** SSIS ETL, SQL Server data warehousing, dimensional modelling, SQL reporting views, Power BI and DAX.

**Data Analytics:** Data quality validation, KPI development, healthcare performance analysis, provider benchmarking and trend analysis.


---

## Implementation Summary

| Component | Technology | Purpose |
|-----------|------------|---------|
| Data Source | NHS England RTT CSV | Monthly waiting-list extracts |
| Data Integration | SSIS | Data ingestion and ETL processing |
| Data Warehouse | SQL Server 2019 | Staging, dimensional modelling and fact storage |
| Data Validation | T-SQL | Reconciliation and quality checks |
| Analytical Reporting | Power BI | Waiting-list KPIs, provider performance and monthly trends |

The project demonstrates practical BI development skills across ETL integration, SQL Server data warehousing, data validation, dimensional modelling and Power BI analytics.

