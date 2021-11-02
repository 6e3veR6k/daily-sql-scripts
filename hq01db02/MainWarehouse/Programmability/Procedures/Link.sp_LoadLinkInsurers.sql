SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

-- =============================================
-- Author:		bezvershuk_do
-- Create date: 27.09.2021
-- Description:	
-- =============================================
CREATE PROCEDURE [Link].[sp_LoadLinkInsurers] 
	@SourceRecordId int = 1, 
	@LoadDateTime datetime2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @LoadDateTime IS NULL SET @LoadDateTime = CURRENT_TIMESTAMP;


	INSERT INTO [Link].[Insurers]
				([LinkInsurerId]
				,[HubProductId]
				,[HubFaceId]
				,[SourceRecordId]
				,[LoadDateTime])
	SELECT
		NEXT VALUE FOR [Link].[sq_Insurers] AS LinkInsurerId,
		fh.HubProductId AS HubProductId,
		sh.HubFaceId AS HubFacesId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
	FROM Stage.Products AS src
	LEFT JOIN Hub.Products AS fh ON fh.HubProductId = src.Id
	LEFT JOIN Hub.Faces AS sh ON sh.FaceGid = src.InsurerFaceGID
	WHERE NOT EXISTS 
		(SELECT 1 FROM Link.Insurers AS trg 
		WHERE 
			trg.HubProductId = fh.HubProductId AND 
			trg.HubFaceId = sh.HubFaceId)

END
GO