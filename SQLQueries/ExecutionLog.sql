SELECT     
      DATEPART(Year, TimeStart) AS ReportYear
     ,DATEPART(Month, TimeStart) AS ReportMonth
 
    , DATEPART(Day, TimeStart) AS ReportDay
 
    , DATEPART(Hour, TimeStart) AS ReportHour
   ,  CONVERT(DATE, TimeStart) AS ReportDate
 
    , Type
 
    , COUNT(Name) AS ExecutionCount
 
    , SUM(TimeDataRetrieval)/1000 AS TimeDataRetrievalSum
 
    , SUM(TimeProcessing)/1000 AS TimeProcessingSum
 
    , SUM(TimeRendering)/1000 AS TimeRenderingSum
 
    , SUM(ByteCount) AS ByteCountSum
 
    , SUM([RowCount]) AS RowCountSum
 
FROM
 
(
 
    SELECT TimeStart, Catalog.Type, Catalog.Name, TimeDataRetrieval,
 
  TimeProcessing, TimeRendering, ByteCount, [RowCount]
 
    FROM
 
    Catalog INNER JOIN ExecutionLog ON Catalog.ItemID =
 
       ExecutionLog.ReportID LEFT OUTER JOIN
 
    Users ON Catalog.CreatedByID = Users.UserID
 
    WHERE ExecutionLog.TimeStart BETWEEN @DateFrom AND @DateTo
    AND Type = 2  	
 
) AS RE
 
GROUP BY
 
     DATEPART(Year, TimeStart)
    , DATEPART(Month, TimeStart)
 
    , DATEPART(Day, TimeStart)
 
    , DATEPART(Hour, TimeStart)
      ,  CONVERT(DATE, TimeStart)
 
    , Type
 
ORDER BY 

    ReportYear	 
    , ReportMonth
 
    , ReportDay
 
    , ReportHour
 
    , Type