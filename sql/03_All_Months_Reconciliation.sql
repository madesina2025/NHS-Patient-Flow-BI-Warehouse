
USE NHS_Patient_Flow_BI;
GO

WITH Reconciliation AS
(
    -- RAW SOURCE
    SELECT
        Period AS ReportingPeriod,
        'RAW SOURCE' AS DataLayer,
        COUNT_BIG(*) AS TotalRows,
        SUM(TRY_CONVERT(BIGINT, [Total All])) AS TotalPathways
    FROM stg.RTT_Raw
    WHERE [RTT Part Type] = 'PART_2'
    GROUP BY Period

    UNION ALL

    -- CLEAN STAGING
    SELECT
        reporting_period,
        'CLEAN STAGING',
        COUNT_BIG(*),
        SUM(TRY_CONVERT(BIGINT, total_all))
    FROM stg.RTT_Clean
    WHERE rtt_part_type = 'PART_2'
    GROUP BY reporting_period

    UNION ALL

    -- FACT WAREHOUSE
    SELECT
        rp.ReportingPeriodCode,
        'FACT WAREHOUSE',
        COUNT_BIG(*),
        SUM(TRY_CONVERT(BIGINT, f.TotalAll))
    FROM dw.FactRTTWaitingList f
    INNER JOIN dw.DimReportingPeriod rp
        ON f.ReportingPeriodKey = rp.ReportingPeriodKey
    WHERE f.RTTPartType = 'PART_2'
    GROUP BY rp.ReportingPeriodCode
)
SELECT
    ReportingPeriod,
    DataLayer,
    TotalRows,
    TotalPathways
FROM Reconciliation
ORDER BY
    ReportingPeriod,
    CASE DataLayer
        WHEN 'RAW SOURCE' THEN 1
        WHEN 'CLEAN STAGING' THEN 2
        WHEN 'FACT WAREHOUSE' THEN 3
    END;
