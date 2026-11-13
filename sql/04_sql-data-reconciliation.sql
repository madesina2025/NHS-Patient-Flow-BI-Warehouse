
USE NHS_Patient_Flow_BI;
GO

SELECT
    d.ReportingMonth,
    SUM(f.TotalWaiting) AS TotalWaiting,
    SUM(f.WaitsUnder18Weeks) AS Under18Weeks,
    SUM(f.WaitsOver18Weeks) AS Over18Weeks,
    SUM(f.WaitsOver52Weeks) AS Over52Weeks
FROM dw.FactRTTWaitingList AS f
INNER JOIN dw.DimReportingPeriod AS d
    ON f.ReportingPeriodKey = d.ReportingPeriodKey
WHERE f.RTTPartType = 'PART_2'
GROUP BY d.ReportingMonth
ORDER BY d.ReportingMonth;
