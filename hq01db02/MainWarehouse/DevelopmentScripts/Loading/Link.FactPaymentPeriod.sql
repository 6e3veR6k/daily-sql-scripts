
DECLARE @SourceRecordId INT = CAST(1 AS INT)
DECLARE @LoadDateTime datetime2(7) = GETDATE()

EXECUTE [Link].[sp_LoadLinkFactPaymentPeriods]  @SourceRecordId, @LoadDateTime

/****** Object:  StoredProcedure [Link].[sp_LoadLinkFactPaymentPeriods]    Script Date: 27.09.2021 16:17:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		bezvershuk_do
-- Create date: 29.09.2021
-- Description:	
-- =============================================
CREATE PROCEDURE [Link].[sp_LoadLinkFactPaymentPeriods] 
	@SourceRecordId int = 1, 
	@LoadDateTime datetime2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @LoadDateTime IS NULL SET @LoadDateTime = CURRENT_TIMESTAMP;


	INSERT INTO [Link].[FactPaymentPeriods]
				([LinkFactPaymentPeriodId]
				,[HubProductId]
				,[HubPaymentPeriodId]
				,[SourceRecordId]
				,[LoadDateTime])
	SELECT
		NEXT VALUE FOR [Link].[sq_FactPaymentPeriods] AS LinkFactPaymentPeriodId,
		HP.HubProductId AS HubProductId,
		HPP.HubPaymentPeriodId AS HubPaymentPeriodId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
	FROM Stage.PaymentPeriods AS PP
	INNER JOIN Hub.Products AS HP
		ON HP.ProductGid = PP.ProductGID
	INNER JOIN Hub.PaymentPeriods AS HPP
		ON HPP.PaymentPeriodGid = PP.GID
	WHERE NOT EXISTS (SELECT 1 FROM Link.FactPaymentPeriods AS F WHERE F.HubProductId = HP.HubProductId AND F.HubPaymentPeriodId = HPP.HubPaymentPeriodId)

END
GO

