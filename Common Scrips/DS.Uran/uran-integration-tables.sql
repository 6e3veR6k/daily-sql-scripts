/* *************************************************************************************

TRUNCATE TABLE Integration.PackageExecutions;
WITH table_cte
AS (SELECT SCHEMA_NAME(t.schema_id) AS schema_name,
           t.name AS table_name,
           t.create_date,
           t.modify_date
    FROM sys.tables t
    WHERE SCHEMA_NAME(t.schema_id) = 'Stage' -- put schema name here
)
INSERT INTO [Integration].[PackageExecutions]
(
    [UserName],
    [LastSuccessfulExtractionDatetime],
    [CurrentExtractionDateTime],
    [TableName],
    [Message]
)
SELECT N'ORANTA\bezvershuk_do',
       '20210401',
       GETDATE(),
       T.schema_name + '.' + T.table_name,
       'success'
FROM table_cte AS T
  
  
******************************************************************************************/


/******************************************************************************************

SELECT LastSuccessfulExtractionDatetime, CurrentExtractionDateTime
FROM [Integration].[PackageExecutions]
WHERE TableName = 'Stage.Cases'

UPDATE [Integration].[PackageExecutions] SET CurrentExtractionDateTime = CURRENT_TIMESTAMP WHERE  TableName = 'Stage.Cases'
UPDATE [Integration].[PackageExecutions] SET LastSuccessfulExtractionDatetime = CurrentExtractionDateTime WHERE  TableName = 'Stage.Cases'



SELECT *
FROM [Integration].[PackageExecutions]


UPDATE Integration.PackageExecutions
SET 
    LastSuccessfulExtractionDatetime = CurrentExtractionDateTime,
    Message = 'success'
WHERE
    TableName = 'Stage.Cases'

******************************************************************************************/

Get[Products]Period

EXEC [Integration].[spGetExtractionPeriod] @tableName = N'Stage.[Products]'


v1 => LastSuccessfulExtractionDatetime  => dtLSE_[Products]
v2 => CurrentExtractionDateTime         => dtCE_[Products]

/* *************************************************************************************** */
Oberon[Products]
    Get[Products]

WHERE 
	EXISTS (
		SELECT 1 
		FROM [log].[Products] AS L 
		WHERE
			L.LoggedEntityGID = P.gid 
			AND
			(L.ActionDate > ? AND L.ActionDate <= ?)
		)

WHERE 
	(LastModifiedDate > ? AND LastModifiedDate <= ?)
	OR
	(CreateDate > ? AND CreateDate <= ?)


    LoadWarehouseStg[Products]


/* *************************************************************************************** */
SetLastSuccessfulExtraction[Products]

UPDATE
  Integration.PackageExecutions
SET
  LastSuccessfulExtractionDatetime = CurrentExtractionDateTime,
  Message = 'success'
WHERE
  TableName = 'Stage.[Products]'