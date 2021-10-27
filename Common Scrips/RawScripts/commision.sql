/********************************************************
  server: hq01db02
  db: MainWarehouse
  task: GetLastSuccesfulLoadDate
**********************************************************/
DECLARE @tableName NVARCHAR(250) = N'Stage.AgentActsCommissions'
DECLARE @userName NVARCHAR(250) = N'ORANTA\bezvershuk_do'

-- add table to monitoring table
EXEC [Integration].[sp_InsertTableForMonitoring] @tableName, @userName

-- select 
--    LastSuccessfulExtractionDatetime 
--    CurrentExtractionDateTime
-- procedure return two dates that mast be mapped to the variables:
--    1. dtLSE_[@tableName]
--    2. dtCE_[@tableName]
-- =================================================================
--    1. dtLSE_Cases
--    2. dtCE_Cases
GO
DECLARE @tableName NVARCHAR(250) = N'Stage.AgentActsCommissions'
EXEC [Integration].[sp_GetExtractionPeriod] @tableName


/********************************************************
  server: hq01db01
  db: Callisto
  task: LoadStage[@tableName]
  oledb source: Get[@tableName]
  derived cloumn: DefaultValues
  oledb descination: LoadStage[@tableName]
- ==================================================================
  task: LoadStageAgentActsCommissions
  oledb source: GetAgentActsCommissions
  derived cloumn: DefaultValues
  oledb descination: LoadStageAgentActsCommissions
**********************************************************/

-- Data Flow Script for GetAgentActsCommissions 
GO

USE [Callisto]

DECLARE @LastExecutionDateTime DATETIME2 = ?
DECLARE @CurentExecutionDateTime DATETIME2 = ?


SELECT src.* ,lg.[_CreateDate], lg.[_ActionDate] 
FROM [dbo].[AgentActsCommissions] AS src 
CROSS APPLY 
	(SELECT MIN(L.ActionDate) AS [_CreateDate], MAX(L.ActionDate) AS [_ActionDate] 
	FROM [log].[AgentActsCommissions] AS L 
	WHERE L.LoggedEntityGID = src.gid 
	GROUP BY L.LoggedEntityGID) AS lg 
WHERE EXISTS 
	(SELECT 1 FROM [log].[AgentActsCommissions]  AS [log] 
	WHERE [log].LoggedEntityGID = src.gid 
		AND ([log].ActionDate > @LastExecutionDateTime AND [log].ActionDate <= @CurentExecutionDateTime))

-- =========================================================================================================
-- Load from hq01db02 localy
-- we mast update integration table 
-- =========================================================================================================
GO

USE [Callisto]

DECLARE @LastExecutionDateTime DATETIME2 = '2010-01-01 00:00:00'
DECLARE @CurentExecutionDateTime DATETIME2 = '2021-10-04 00:00:00'
DECLARE @tableName NVARCHAR(250) = N'Stage.AgentActsCommissions'


INSERT INTO [MainWarehouse].[Stage].[AgentActsCommissions]
SELECT *
FROM 
  (SELECT
    src.*,
    COALESCE(lg.[_CreateDate], CAST('20100101' AS date)) AS [_CreateDate], 
    COALESCE(lg.[_ActionDate], CAST('20100101' AS date)) AS [_ActionDate], 
    CAST('1' AS INT) AS [SourceRecordId], 
    GETDATE() AS [LoadDateTime] 
  FROM [dbo].[AgentActsCommissions] AS src 
  OUTER APPLY 
    (SELECT MIN(L.ActionDate) AS [_CreateDate], MAX(L.ActionDate) AS [_ActionDate] 
    FROM [log].[AgentActsCommissions] AS L 
    WHERE L.LoggedEntityGID = src.gid 
    GROUP BY L.LoggedEntityGID) AS lg
  ) AS MainData
WHERE MainData.[_ActionDate] <= @CurentExecutionDateTime



UPDATE MainWarehouse.Integration.PackageExecutions
SET 
  CurrentExtractionDateTime = @CurentExecutionDateTime,
  LastSuccessfulExtractionDatetime = @CurentExecutionDateTime,
  Message = 'success'
WHERE
  TableName = @tableName
GO

-- Names for default values 
-- SourceRecordId int
-- LoadDateTime datetime2


/********************************************************
  server: hq01db02
  db: MainWarehouse
  task: SetUpLastSuccessfullExtraction_period
**********************************************************/
GO
USE MainWarehouse

DECLARE @tableName NVARCHAR(250) = N'Stage.AgentActsCommissions'

UPDATE Integration.PackageExecutions
SET 
  LastSuccessfulExtractionDatetime = CurrentExtractionDateTime,
  Message = 'success'
WHERE
  TableName = @tableName


-- ==============================================================================================================
/****************************************************************************************************************
/****************************************************************************************************************
  load links
  server: hq01db02
  db: MainWarehouse
-- ==============================================================================================================
****************************************************************************************************************/

/***************************************************************************************************************
    -- Link -> FactAgentActs
  ***************************************************************************************************************/


USE MainWarehouse
GO
CREATE SEQUENCE [Link].[sq_FactAgentActs] AS [bigint]
 START WITH 1 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO

-- Link procedure create

CREATE PROCEDURE [Link].[sp_LoadLinkFactAgentActs] 
	@SourceRecordId int = 1, 
	@LoadDateTime datetime2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @LoadDateTime IS NULL SET @LoadDateTime = CURRENT_TIMESTAMP;


  INSERT INTO [Link].[FactAgentActs]
      ([LinkFactAgentActsId]
      ,[HubAgentActId]
      ,[HubAgentActsCommissionId]
      ,[SourceRecordId]
      ,[LoadDateTime])
	SELECT
		NEXT VALUE FOR [Link].[sq_FactAgentActs] AS LinkFactAgentActsId,
    sh.HubAgentActId,
    fh.HubAgentActsCommissionId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
  FROM Stage.AgentActsCommissions AS src
  LEFT JOIN Hub.AgentActsCommissions AS fh ON fh.HubAgentActsCommissionId = src.id
  LEFT JOIN Hub.AgentActs AS sh on sh.AgentActGID = src.AgentActGID
	WHERE NOT EXISTS 
		(SELECT 1 FROM Link.FactAgentActs AS trg 
		WHERE 
			trg.HubAgentActsCommissionId = fh.HubAgentActsCommissionId AND 
			trg.HubAgentActId = sh.HubAgentActId)
END
GO

EXEC [Link].[sp_LoadLinkFactAgentActs] @SourceRecordId = 1


/***************************************************************************************************************
    -- Link -> AgentActsProducts
  ***************************************************************************************************************/


USE MainWarehouse
GO
CREATE SEQUENCE [Link].[sq_AgentActsProducts] AS [bigint]
 START WITH 1 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO

-- Link procedure create

CREATE PROCEDURE [Link].[sp_LoadLinkAgentActsProducts] 
	@SourceRecordId int = 1, 
	@LoadDateTime datetime2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @LoadDateTime IS NULL SET @LoadDateTime = CURRENT_TIMESTAMP;


  INSERT INTO [Link].[AgentActsProducts]
      ([LinkAgentActsProductId]
      ,[HubProductId]
      ,[HubAgentActsCommissionId]
      ,[SourceRecordId]
      ,[LoadDateTime])
	SELECT
		NEXT VALUE FOR [Link].[sq_AgentActsProducts] AS LinkAgentActsProductId,
    sh.HubProductId,
    fh.HubAgentActsCommissionId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
  FROM Stage.AgentActsCommissions AS src
  LEFT JOIN Hub.AgentActsCommissions AS fh ON fh.HubAgentActsCommissionId = src.id
  LEFT JOIN Hub.Products AS sh on sh.ProductGid = src.ProductGid

	WHERE NOT EXISTS 
		(SELECT 1 FROM Link.AgentActsProducts AS trg 
		WHERE 
			trg.HubAgentActsCommissionId = fh.HubAgentActsCommissionId AND 
			trg.HubProductId = sh.HubProductId)
END
GO

EXEC [Link].[sp_LoadLinkAgentActsProducts] @SourceRecordId = 1


/***************************************************************************************************************
    -- Link -> AgentActsRealPayments
  ***************************************************************************************************************/


USE MainWarehouse
GO
CREATE SEQUENCE [Link].[sq_AgentActsRealPayments] AS [bigint]
 START WITH 1 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO

-- Link procedure create

ALTER PROCEDURE [Link].[sp_LoadLinkAgentActsRealPayments] 
	@SourceRecordId int = 1, 
	@LoadDateTime datetime2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @LoadDateTime IS NULL SET @LoadDateTime = CURRENT_TIMESTAMP;


  INSERT INTO [Link].[AgentActsRealPayments]
      ([LinkAgentActsRealPaymentId]
      ,[HubRealPaymentId]
      ,[HubAgentActsCommissionId]
      ,[SourceRecordId]
      ,[LoadDateTime])
	SELECT
		NEXT VALUE FOR [Link].[sq_AgentActsRealPayments] AS LinkAgentActsRealPaymentId,
    sh.HubRealPaymentId,
    fh.HubAgentActsCommissionId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
  FROM Stage.AgentActsCommissions AS src
  INNER JOIN Hub.AgentActsCommissions AS fh ON fh.HubAgentActsCommissionId = src.id
  INNER JOIN Hub.RealPayments AS sh on sh.RealPaymentGid = src.RealPaymentGid

	WHERE NOT EXISTS 
		(SELECT 1 FROM Link.AgentActsRealPayments AS trg 
		WHERE 
			trg.HubAgentActsCommissionId = fh.HubAgentActsCommissionId AND 
			trg.HubRealPaymentId = sh.HubRealPaymentId)
END
GO

EXEC [Link].[sp_LoadLinkAgentActsRealPayments] @SourceRecordId = 1


DECLARE @SourceRecordId INT = ?
DECLARE @LoadDateTime datetime2(7) = ?

EXEC [Link].[sp_LoadLinkAgentActsRealPayments] @SourceRecordId, @LoadDateTime
-- EXEC [Link].[sp_LoadLinkFactAgentActs] @SourceRecordId, @LoadDateTime
-- EXEC [Link].[sp_LoadLinkAgentActsProducts] @SourceRecordId, @LoadDateTime