
DECLARE @SourceRecordId INT = CAST(1 AS INT)
DECLARE @LoadDateTime datetime2(7) = GETDATE()

EXECUTE [Link].[sp_LoadLinkPlanedPaymentPeriods]  @SourceRecordId, @LoadDateTime

/****** Object:  StoredProcedure [Link].[sp_LoadLinkPlanedPaymentPeriods]    Script Date: 27.09.2021 16:17:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
		HPP.HubPaymentPeriodId AS HubPaymentPeriodId,
		HP.HubPlanedPaymentId AS HubPlanedPaymentId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
	FROM Stage.PlanedPayments AS PP
	INNER JOIN Hub.PlanedPayments AS HP
		ON HP.HubPlanedPaymentId = PP.id
	INNER JOIN Hub.PaymentPeriods AS HPP
		ON HPP.PaymentPeriodGid = PP.PaymentPeriodGID
	WHERE NOT EXISTS (SELECT 1 FROM Link.PlanedPaymentPeriods AS F WHERE F.HubPlanedPaymentId = HP.HubPlanedPaymentId AND F.HubPaymentPeriodId = HPP.HubPaymentPeriodId)

END
GO

