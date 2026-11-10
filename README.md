
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


## Key Features & Deliverables

This project demonstrates an end-to-end healthcare Business Intelligence solution, integrating NHS England Referral to Treatment (RTT) data into a SQL Server data warehouse for analytical reporting.


### Key Features

- **Automated SSIS ETL Integration:** Automatically discovers and processes monthly NHS RTT CSV extracts using SQL Server Integration Services, with a master package coordinating ingestion, transformation, warehouse loading and file archiving.

- **Data Cleansing and Standardisation:** Cleans and transforms source records, standardises reporting periods, provider and commissioner information, treatment functions and waiting-time bands, and handles missing values consistently.

- **SQL Server Dimensional Data Warehouse:** Implements a star schema consisting of one fact table and four dimensions, supporting historical waiting-list analysis across reporting periods, providers, commissioners and treatment specialties.

- **Incremental and Duplicate-Safe Data Loading:** Supports monthly incremental processing, preserves historical warehouse records and applies duplicate-prevention logic to avoid repeated loading of previously processed data.

- **Dynamic Reporting Period and Dimension Management:** Uses SSIS parameters, variables and SQL-based dimension loading to manage new reporting periods and maintain dimension-key relationships.

- **ETL Audit Logging and Error Handling:** Records ETL execution activities, tracks processing outcomes and supports the identification and investigation of failed or rejected records.

- **Data Quality Validation and Reconciliation:** Uses T-SQL validation scripts to compare raw, cleansed and fact-table record counts, verify dimension mappings and reconcile monthly NHS RTT waiting-list totals.

- **Power BI Reporting and Analytics:** Delivers four interactive dashboards—Executive Overview, Provider Performance, Specialty Analysis and Monthly Trends—for monitoring waiting-list volumes, 18-week breaches, long waits and NHS provider performance.


### Project Deliverables

1. SSIS ETL packages and master orchestration workflow.
2. SQL Server 2019 dimensional data warehouse.
3. SQL scripts for data validation and reconciliation.
4. Power BI semantic model and analytical dashboards.
5. Technical documentation, architecture diagrams and
   implementation screenshots.

---


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


### Detailed Power BI Analytical Insights

A comprehensive analytical review of the four Power BI
dashboards is available in the dedicated report.

The analysis covers:

- **Executive Overview:** National waiting-list volumes, 18-week performance, provider pressures and backlog trends.

- **Provider Performance:** Provider comparisons, overdue pathway volumes, breach rates and performance benchmarking.

- **Specialty Analysis:** Treatment-specialty waiting times, backlog contributions and 18-week breach comparisons.

- **Monthly Trends:** Month-on-month waiting-list movements, overdue pathway trends and long-wait performance.

Each dashboard analysis includes key findings, business insights, management recommendations and analytical conclusions.

**[Read the Complete Power BI Analytical Insights Report](docs/powerbi-analytical-insights.md)**


## Solution Architecture

![NHS Patient Flow Architecture](screenshots/01-architecture/nhs-patient-flow-architecture.png)

**Data Flow:**

NHS RTT CSV Extracts → SSIS ETL → SQL Server 2019 Data Warehouse → SQL Reporting Views → Power BI


## Data Source

NHS England – Referral to Treatment (RTT) Waiting Times.

Reporting period: April 2025 to March 2026.

The dataset contains aggregated RTT pathway statistics, not individual patient records.



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


### Raw-to-Fact Reconciliation

![SQL Data Reconciliation](screenshots/03-sql-server/sql-data-reconciliation.png)

### All-Months Reconciliation

![SQL All Months Reconciliation](screenshots/03-sql-server/sql-all-months-reconciliation.png)

### Monthly Reconciliation Status

All 12 reporting months from April 2025 to March 2026 passed the recorded row-count reconciliation checks.

![SQL Monthly Reconciliation Status](screenshots/03-sql-server/sql-monthly-reconciliation-status.png)


## Data Quality and Validation

- Data cleansing and standardisation.
- Raw-to-clean-to-fact reconciliation.
- Monthly record-count and pathway-total comparisons.
- Reconciliation checks passed for all 12 reporting months.
- ETL audit logging and SQL validation scripts.



## How to Run the Project

### Prerequisites

The following software is required:


- Microsoft SQL Server 2019
- SQL Server Management Studio (SSMS)
- Visual Studio 2019 with SSIS extension
- SQL Server Integration Services (SSIS)
- Microsoft Power BI Desktop
- Git

### Step 1: Clone the Repository

```bash
git clone https://github.com/madesina2025/NHS-Patient-Flow-BI-Warehouse.git

cd NHS-Patient-Flow-BI-Warehouse
```

### Step 2: Obtain NHS RTT Data

Download monthly Referral to Treatment (RTT)
full-extract CSV files from NHS England.

Place the required source files in:

'data/landing/incoming/'

Raw datasets are excluded from Git version control.

### Step 3: Configure SQL Server

1. Open SQL Server Management Studio.
2. Connect to your local SQL Server 2019 instance.
3. Create the NHS Patient Flow BI database using
   the database schema scripts in this repository.
4. Verify that staging, warehouse and audit
   objects are available.

### Step 4: Configure SSIS

Open the SSIS solution:

'ssis/NHS_Patient_Flow_ETL/NHS_Patient_Flow_ETL.sln'

Configure:

- SQL Server connection managers.
- Source CSV file paths.
- Reporting-period package parameters.
- Landing and archive folder paths.

### Step 5: Execute the ETL Workflow

Open the master package:

'00_Master_NHS_RTT_ETL.dtsx'

The ETL workflow follows this sequence:

1. Load RTT CSV data into raw staging.
2. Clean and standardise source records.
3. Validate and update warehouse dimensions.
4. Load the RTT waiting-list fact table.
5. Perform reconciliation and audit checks.

Run the packages in the required sequence,
using the configured reporting period and source file.

### Step 6: Validate the Data Warehouse

Execute the SQL reconciliation scripts in:

'sql/'

Verify:

- Source and destination record counts.
- Monthly reporting-period coverage.
- Dimension-key mappings.
- Waiting-list measure reconciliation.
- Successful ETL execution status.

### Step 7: Open Power BI

Open:

'powerbi/NHS RTT Waiting List & Performance Analytics.pbix'

Update the SQL Server connection settings to match
your local environment.

Refresh the semantic model and explore the dashboards:

- Executive Overview
- Provider Performance
- Specialty Analysis
- Monthly Trends

### Execution Notes

The solution requires local configuration of SQL Server
connections and source-file paths.

Monthly incremental processing, automated scheduling,
file archiving and rerun behaviour should be verified
in the target environment before production use.

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

## Project Files

- 'ssis/' – SSIS packages and Visual Studio solution.
- 'database/' – SQL Server database schema scripts.
- 'sql/' – SQL queries and reconciliation scripts.
- 'powerbi/' – Power BI report files.
- 'screenshots/' – Architecture, ETL, SQL and dashboard evidence.


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


## Challenges & Solutions

During the development of the NHS Patient Flow & Waiting List BI Warehouse, several technical challenges were encountered across data ingestion, transformation, dimensional modelling, data validation and reporting.

### 1. Handling Large NHS RTT CSV Extracts

**Challenge:**

The NHS RTT monthly full-extract datasets contain a large
number of columns, including detailed waiting-time bands.
Processing these files required consistent data types,
column mappings and source-file configurations.

**Solution:**

- Implemented SSIS Data Flow Tasks for CSV ingestion.
- Configured Flat File Connection Managers.
- Standardised source column mappings.
- Used SQL Server staging tables to separate raw ingestion
  from downstream transformations.
- Introduced package parameters and variables to support
  different monthly reporting periods.

**Outcome:**

Established a structured ingestion process for loading monthly NHS RTT extracts into SQL Server staging.

### 2. Data Cleansing and Standardisation

**Challenge:**

Source data required consistent formatting, data types and handling of missing values before it could be used
for warehouse reporting.

**Solution:**

- Implemented SQL-based cleansing and transformation.
- Standardised reporting-period identifiers.
- Applied trimming and text-cleaning rules.
- Converted numeric fields into appropriate SQL data types.
- Used consistent handling of unavailable dimension values.
- Separated raw and cleansed records into staging tables.

**Outcome:**

Produced standardised staging data suitable for dimensional modelling and analytical reporting.

### 3. Dimensional Modelling and Key Mapping

**Challenge:**

The warehouse needed to support analysis across reporting periods, NHS providers, commissioners and treatment
functions while maintaining reliable relationships.

**Solution:**

Designed a star schema containing:

- 'dw.DimReportingPeriod'
- 'dw.DimProvider'
- 'dw.DimCommissioner'
- 'dw.DimTreatmentFunction'
- 'dw.FactRTTWaitingList'

Implemented dimension-key lookups and SQL validation queries to identify missing business-key mappings.

**Outcome:**

Created a dimensional warehouse structure supporting provider, commissioner, specialty and monthly analysis.

### 4. Monthly Incremental Loading and Duplicate Prevention

**Challenge:**

Loading additional reporting months required preserving previously processed data and preventing duplicate
warehouse records during repeated executions.

**Solution:**

- Introduced reporting-period parameters in SSIS.
- Applied reporting-period filtering during transformation.
- Used SQL validation queries to compare monthly records.
- Developed the ETL workflow around staged processing and controlled warehouse loading.

**Outcome:**

Established the foundation for monthly incremental processing. Fully automated idempotent loading and
restart recovery remain areas for further validation.

### 5. Data Reconciliation and Quality Assurance

**Challenge:**

The warehouse needed to preserve the integrity of NHS RTT pathway counts throughout the ETL process.

**Solution:**

Developed T-SQL validation and reconciliation queries
to compare:

- Raw staging record counts.
- Cleansed staging record counts.
- Warehouse fact-table record counts.
- Monthly reporting-period coverage.
- Waiting-time band totals.
- Missing dimension-key mappings.

Reconciliation scripts and execution screenshots are included in the repository.

**Outcome:**

Established a repeatable approach for validating data completeness and consistency between ETL stages.

### 6. Building Meaningful Power BI Dashboards

**Challenge:**

The transformed RTT dataset needed to support clear and actionable healthcare performance reporting
without confusing pathway volumes with patient-level data.

**Solution:**

Developed four Power BI analytical pages:

1. Executive Overview
2. Provider Performance
3. Specialty Analysis
4. Monthly Trends

Implemented analytical measures and visualisations covering waiting-list volumes, 18-week performance,
long waits, provider comparisons and monthly trends.

**Outcome:**

Delivered an interactive BI reporting solution for analysing NHS RTT waiting-list performance.

---






## Author

**Mukaila Adesina**

Data Engineer | BI Developer | Data Analyst

MSc Data Science & Analytics  
University of Hertfordshire, United Kingdom

### Technical Expertise

SQL Server | T-SQL | SSIS | SSAS | Power BI | DAX |
Python | Azure Data Factory | Data Warehousing |
ETL/ELT | Dimensional Modelling | Data Quality

### GitHub

[madesina2025](https://github.com/madesina2025)

### Project Repository

[NHS Patient Flow & Waiting List BI Warehouse](https://github.com/madesina2025/NHS-Patient-Flow-BI-Warehouse)

---

