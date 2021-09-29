﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
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
		HP.HubProductId AS HubProductId,
		HF.HubFaceId AS HubFacesId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
	FROM Stage.Products AS P 
	INNER JOIN Hub.Products AS HP
		ON HP.HubProductId = P.Id
	INNER JOIN Hub.Faces AS HF
		ON HF.FaceGid = P.InsurerFaceGID
	WHERE NOT EXISTS (SELECT 1 FROM Link.Insurers AS I WHERE I.HubProductId = HP.HubProductId AND I.HubFaceId = HF.HubFaceId)

END
GO