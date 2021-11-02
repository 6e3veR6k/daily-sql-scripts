SET QUOTED_IDENTIFIER, ANSI_NULLS ON
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
		fh.HubProductId AS HubProductId,
		sh.HubPaymentPeriodId AS HubPaymentPeriodId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
	FROM Stage.PaymentPeriods AS src
	LEFT JOIN Hub.Products AS fh ON fh.ProductGid = src.ProductGID
	LEFT JOIN Hub.PaymentPeriods AS sh ON sh.PaymentPeriodGid = src.GID
	WHERE NOT EXISTS 
		(SELECT 1 FROM Link.FactPaymentPeriods AS trg 
		WHERE 
			trg.HubProductId = fh.HubProductId AND 
			trg.HubPaymentPeriodId = sh.HubPaymentPeriodId)

END
GO