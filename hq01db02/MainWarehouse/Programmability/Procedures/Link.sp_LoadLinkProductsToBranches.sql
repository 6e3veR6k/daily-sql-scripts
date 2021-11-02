SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


-- =============================================
-- Author:		bezvershuk_do
-- Create date: 29.09.2021
-- Description:	
-- =============================================
CREATE PROCEDURE [Link].[sp_LoadLinkProductsToBranches] 
	@SourceRecordId int = 1, 
	@LoadDateTime datetime2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @LoadDateTime IS NULL SET @LoadDateTime = CURRENT_TIMESTAMP;


	INSERT INTO [Link].[ProductsToBranches]
			   ([LinkProductsToBranchId]
			   ,[HubBranchId]
			   ,[HubProductId]
			   ,[SourceRecordId]
			   ,[LoadDateTime])
	SELECT
		NEXT VALUE FOR [Link].[sq_ProductsToBranches] AS [LinkProductsToBranchId],
		fh.HubBranchId AS HubBranchId,
		sh.HubProductId	AS HubProductId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
	FROM Stage.Products AS src
	LEFT JOIN Hub.Branches AS fh ON fh.BranchGid = src.BranchGID
	LEFT JOIN Hub.Products AS sh ON sh.HubProductId = src.id

	WHERE NOT EXISTS 
		(SELECT 1 FROM [Link].[ProductsToBranches] AS trg 
		WHERE 
			trg.HubProductId = sh.HubProductId AND 
			trg.HubBranchId = fh.HubBranchId)

END
GO