SELECT    Replace(Name,'.rdl','') AS Name, Path, UserName
 
FROM Catalog INNER JOIN dbo.Users ON Catalog.CreatedByID = Users.UserID
 
WHERE Type = 2 AND
 
    Catalog.ItemID NOT IN
 
    (
 
        SELECT ExecutionLog.ReportID
 
        FROM ExecutionLog
 
         WHERE ExecutionLog.TimeStart BETWEEN @DateFrom AND @DateTo
 
    ) 

    ORDER BY Name