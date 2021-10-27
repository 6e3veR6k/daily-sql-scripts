USE [MainWarehouse]
GO
TRUNCATE TABLE [Stage].[PlanedPayments]
GO
INSERT INTO [Stage].[PlanedPayments]
           ([Id]
           ,[gid]
           ,[ProgramGID]
           ,[PaymentPeriodGID]
           ,[Value]
           ,[Deleted]
           ,[AuthorGID]
           ,[_CreateDateTime]
           ,[_ActionDateTime]
           ,[SourceRecordId]
           ,[LoadDateTime])
SELECT src.* ,
	COALESCE(lg.[_CreateDate], CAST('20100101' AS date)) AS [_CreateDate], 
	COALESCE(lg.[_ActionDate], CAST('20100101' AS date)) AS [_ActionDate], 
	CAST('1' AS INT) AS [SourceRecordId], 
	GETDATE() AS [LoadDateTime]
FROM OrantaSch.[dbo].[PlanedPayments] AS src 
OUTER APPLY 
	(SELECT MIN(L.ActionDate) AS [_CreateDate], MAX(L.ActionDate) AS [_ActionDate] 
	FROM OrantaSch.[log].[PlanedPayments] AS L 
	WHERE L.LoggedEntityGID = src.gid 
	GROUP BY L.LoggedEntityGID) AS lg 




USE [MainWarehouse]
GO
TRUNCATE TABLE [Stage].[RealPayments]
GO
INSERT INTO [Stage].[RealPayments]
           ([Id]
           ,[GID]
           ,[PaymentDate]
           ,[Value]
           ,[Comment]
           ,[IsCommission]
           ,[Deleted]
           ,[IsAutomatic]
           ,[SourceTypeGID]
           ,[AuthorGID]
           ,[_CreateDateTime]
           ,[_ActionDateTime]
           ,[SourceRecordId]
           ,[LoadDateTime])
SELECT src.*,
	COALESCE(lg.[_CreateDate], CAST('20100101' AS date)) AS [_CreateDate], 
	COALESCE(lg.[_ActionDate], CAST('20100101' AS date)) AS [_ActionDate], 
	CAST('1' AS INT) AS [SourceRecordId], 
	GETDATE() AS [LoadDateTime]
FROM OrantaSch.[dbo].[RealPayments] AS src 
OUTER APPLY 
	(SELECT MIN(L.ActionDate) AS [_CreateDate], MAX(L.ActionDate) AS [_ActionDate] 
	FROM OrantaSch.[log].[RealPayments] AS L 
	WHERE L.LoggedEntityGID = src.gid 
	GROUP BY L.LoggedEntityGID) AS lg 

USE [MainWarehouse]
GO
/****** Object:  StoredProcedure [Integration].[sp_GetExtractionPeriod]    Script Date: 05.10.2021 11:54:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		bezvershuk_do
-- Create date: 19.08.2021
-- Description:	
-- =============================================
ALTER PROCEDURE [Integration].[sp_GetExtractionPeriod]
	-- Add the parameters for the stored procedure here
	@tableName NVARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @sqlCommand NVARCHAR(MAX) = 'TRUNCATE TABLE ' + @tableName

	EXECUTE sp_executesql @sqlCommand

	UPDATE [Integration].[PackageExecutions] 
	--todo: change to curent timestamp  / CURRENT_TIMESTAMP
	SET CurrentExtractionDateTime = '20211004',
		UserName = SUSER_SNAME(),
		Message = 'in progress'
	WHERE  TableName = @tableName

	SELECT LastSuccessfulExtractionDatetime, CurrentExtractionDateTime
	FROM [Integration].[PackageExecutions]
	WHERE TableName = @tableName

END

