USE NHS_Patient_Flow_BI;
GO

WITH RawData AS
(
    SELECT
        UPPER(Period) AS ReportingPeriod,
        COUNT_BIG(*) AS RawRows
    FROM stg.RTT_Raw
    GROUP BY UPPER(Period)
),
CleanData AS
(
    SELECT
        UPPER(reporting_period) AS ReportingPeriod,
        COUNT_BIG(*) AS CleanRows
    FROM stg.RTT_Clean
    GROUP BY UPPER(reporting_period)
),
FactData AS
(
    SELECT
        UPPER(d.ReportingPeriodCode) AS ReportingPeriod,
        COUNT_BIG(*) AS FactRows
    FROM dw.FactRTTWaitingList f
    INNER JOIN dw.DimReportingPeriod d
        ON f.ReportingPeriodKey = d.ReportingPeriodKey
    GROUP BY UPPER(d.ReportingPeriodCode)
)
SELECT
    r.ReportingPeriod,
    r.RawRows,
    c.CleanRows,
    f.FactRows,
    CASE
        WHEN r.RawRows = c.CleanRows
         AND c.CleanRows = f.FactRows
        THEN 'PASS'
        ELSE 'FAIL'
    END AS ReconciliationStatus
FROM RawData r
LEFT JOIN CleanData c
    ON r.ReportingPeriod = c.ReportingPeriod
LEFT JOIN FactData f
    ON r.ReportingPeriod = f.ReportingPeriod
ORDER BY r.ReportingPeriod;