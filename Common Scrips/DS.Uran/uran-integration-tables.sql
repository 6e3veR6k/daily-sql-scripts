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

USE [Callisto]

DECLARE @LastExecutionDateTime DATETIME2 = GETDATE() -1;
DECLARE @CurentExecutionDateTime DATETIME2 = GETDATE()
DECLARE @tableName NVARCHAR(255) = '[AgentActs]'

DECLARE @query NVARCHAR(4000) = 'SELECT src.* ,lg.[_CreateDate], lg.[_ActionDate] FROM [dbo].' +
	+ @tableName + ' AS src CROSS APPLY (SELECT MIN(L.ActionDate) AS [_CreateDate], MAX(L.ActionDate) AS [_ActionDate] FROM [log].' +
	+ @tableName + ' AS L WHERE L.LoggedEntityGID = src.gid GROUP BY L.LoggedEntityGID) AS lg WHERE EXISTS (SELECT 1 FROM [log].' +
	+ @tableName + ' AS [log] WHERE [log].LoggedEntityGID = src.gid AND ([log].ActionDate > @LastExecutionDateTime AND [log].ActionDate <= @CurentExecutionDateTime))'
DECLARE @paramDefinition NVARCHAR(500) = '@LastExecutionDateTime DATETIME2, @CurentExecutionDateTime DATETIME2'

EXECUTE sys.sp_executesql @query, @paramDefinition, @LastExecutionDateTime, @CurentExecutionDateTime; 

/******************************************************************************************/
GO
USE [Callisto]

DECLARE @LastExecutionDateTime DATETIME2 = ?
DECLARE @CurentExecutionDateTime DATETIME2 = ?
DECLARE @tableName NVARCHAR(255) = ?

DECLARE @query NVARCHAR(4000) = 'SELECT src.* ,lg.[_CreateDate], lg.[_ActionDate] FROM [dbo].' +
	+ @tableName + ' AS src CROSS APPLY (SELECT MIN(L.ActionDate) AS [_CreateDate], MAX(L.ActionDate) AS [_ActionDate] FROM [log].' +
	+ @tableName + ' AS L WHERE L.LoggedEntityGID = src.gid GROUP BY L.LoggedEntityGID) AS lg WHERE EXISTS (SELECT 1 FROM [log].' +
	+ @tableName + ' AS [log] WHERE [log].LoggedEntityGID = src.gid AND ([log].ActionDate > @LastExecutionDateTime AND [log].ActionDate <= @CurentExecutionDateTime))'
DECLARE @paramDefinition NVARCHAR(500) = '@LastExecutionDateTime DATETIME2, @CurentExecutionDateTime DATETIME2'

EXECUTE sys.sp_executesql @query, @paramDefinition, @LastExecutionDateTime, @CurentExecutionDateTime; 

/******************************************************************************************/

[_CreateDateTime] DATETIME2 NOT NULL,
[_ActionDateTime] DATETIME2 NOT NULL,

USE [Callisto]

DECLARE @LastExecutionDateTime DATETIME2 = ?
DECLARE @CurentExecutionDateTime DATETIME2 = ?


SELECT src.* ,lg.[_CreateDate], lg.[_ActionDate]  
FROM [dbo].[AgentActs] AS src 
CROSS APPLY 
	(SELECT MIN(L.ActionDate) AS [_CreateDate], MAX(L.ActionDate) AS [_ActionDate] 
	FROM [log].[AgentActs] AS L 
	WHERE L.LoggedEntityGID = src.gid 
	GROUP BY L.LoggedEntityGID) AS lg 
WHERE EXISTS 
	(SELECT 1 FROM [log].[AgentActs]  AS [log] 
	WHERE [log].LoggedEntityGID = src.gid 
		AND ([log].ActionDate > @LastExecutionDateTime AND [log].ActionDate <= @CurentExecutionDateTime))


/******************************************************************************************/
/******************************************************************************************/

/******************************************************************************************/

[_CreateDateTime] DATETIME2 NOT NULL,
[_ActionDateTime] DATETIME2 NOT NULL,

USE [Callisto]

DECLARE @LastExecutionDateTime DATETIME2 = ?
DECLARE @CurentExecutionDateTime DATETIME2 = ?


SELECT src.* ,lg.[_CreateDate], lg.[_ActionDate] 
FROM [dbo].[Programs] AS src 
CROSS APPLY 
	(SELECT MIN(L.ActionDate) AS [_CreateDate], MAX(L.ActionDate) AS [_ActionDate] 
	FROM [log].[Programs] AS L 
	WHERE L.LoggedEntityGID = src.gid 
	GROUP BY L.LoggedEntityGID) AS lg 
WHERE EXISTS 
	(SELECT 1 FROM [log].[Programs]  AS [log] 
	WHERE [log].LoggedEntityGID = src.gid 
		AND ([log].ActionDate > @LastExecutionDateTime AND [log].ActionDate <= @CurentExecutionDateTime))


/******************************************************************************************/
/******************************************************************************************/
/******************************************************************************************/


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