SELECT TOP 10   

      COUNT(Name) AS ExecutionCount
 
    , Replace(Name,'.rdl','') AS Name
    ,ReportID	

    , MIN(TimeDataRetrieval) AS TimeDataRetrievalMIN
 
    , MIN(TimeProcessing) AS TimeProcessingMIN
 
    , MIN(TimeRendering) AS TimeRenderingMIN
    , MAX(TimeDataRetrieval) AS TimeDataRetrievalMAX
 
    , MAX(TimeProcessing) AS TimeProcessingMAX
 
    , MAX(TimeRendering) AS TimeRenderingMAX
 
    , AVG(TimeDataRetrieval) AS TimeDataRetrievalAVG
 
    , AVG(TimeProcessing) AS TimeProcessingAVG
 
    , AVG(TimeRendering) AS TimeRenderingAVG
   , SUM(TimeDataRetrieval) AS TimeDataRetrievalSum
 
    , SUM(TimeProcessing) AS TimeProcessingSum
 
    , SUM(TimeRendering) AS TimeRenderingSum
 
    , SUM(ByteCount) AS ByteCountSum
 
    , SUM([RowCount]) AS RowCountSum
 
FROM
 
(
 
    SELECT TimeStart, Catalog.Type, Catalog.Name, ReportID,
 
      TimeDataRetrieval, TimeProcessing, TimeRendering, ByteCount, [RowCount]
 
    FROM
 
    Catalog INNER JOIN ExecutionLog ON Catalog.ItemID = ExecutionLog.ReportID
 
     WHERE ExecutionLog.TimeStart BETWEEN @DateFrom AND @DateTo AND Type = 2
 
) AS RE
 
GROUP BY
 
        Name
	,ReportID
 
ORDER BY 

        COUNT(Name) DESC
 
      , Name