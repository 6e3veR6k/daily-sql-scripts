SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

-- =============================================
-- Author:		bezvershuk_do
-- Create date: 29.09.2021
-- Description:	
-- =============================================
CREATE PROCEDURE [Link].[sp_LoadLinkPlanedPaymentPeriods] 
	@SourceRecordId int = 1, 
	@LoadDateTime datetime2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @LoadDateTime IS NULL SET @LoadDateTime = CURRENT_TIMESTAMP;


	INSERT INTO [Link].[PlanedPaymentPeriods]
				([LinkPlanedPaymentPeriodId]
				,[HubPaymentPeriodId]
				,[HubPlanedPaymentId]
				,[SourceRecordId]
				,[LoadDateTime])
	SELECT
		NEXT VALUE FOR [Link].[sq_PlanedPaymentPeriods] AS LinkPlanedPaymentPeriodId,
		sh.HubPaymentPeriodId AS HubPaymentPeriodId,
		fh.HubPlanedPaymentId AS HubPlanedPaymentId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
	FROM Stage.PlanedPayments AS src
	INNER JOIN Hub.PlanedPayments AS fh ON fh.HubPlanedPaymentId = src.id
	INNER JOIN Hub.PaymentPeriods AS sh ON sh.PaymentPeriodGid = src.PaymentPeriodGID
	WHERE NOT EXISTS 
		(SELECT 1 FROM Link.PlanedPaymentPeriods AS trg 
		WHERE 
			trg.HubPlanedPaymentId = fh.HubPlanedPaymentId AND 
			trg.HubPaymentPeriodId = sh.HubPaymentPeriodId)

END
GO