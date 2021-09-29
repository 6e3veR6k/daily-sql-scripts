SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		bezvershuk_do
-- Create date: 27.09.2021
-- Description:	
-- =============================================
CREATE PROCEDURE [Link].[sp_LoadLinkFactProducts] 
	-- Add the parameters for the stored procedure here
	@SourceRecordId int = 1, 
	@LoadDateTime datetime2 = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @LoadDateTime IS NULL SET @LoadDateTime = CURRENT_TIMESTAMP;
	
    -- Insert statements for procedure here
	INSERT INTO [Link].[FactProducts]
           ([LinkFactProductId]
           ,[HubProductId]
           ,[HubProgramId]
           ,[SourceRecordId]
           ,[LoadDateTime])
	SELECT
		NEXT VALUE FOR Link.sq_FactProducts AS LinkFactProductId,
		HP.HubProductId,
		HPg.HubProgramId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
	FROM Stage.Programs AS Pg
	LEFT JOIN Hub.Programs AS HPg ON HPg.HubProgramId = Pg.Id
	LEFT JOIN Hub.Products AS HP ON HP.ProductGid = Pg.ProductGID
	WHERE NOT EXISTS (
		SELECT 1
		FROM Link.FactProducts AS FP
		WHERE FP.HubProductId = HP.HubProductId
			AND FP.HubProgramId = HPg.HubProgramId
	)
END
GO