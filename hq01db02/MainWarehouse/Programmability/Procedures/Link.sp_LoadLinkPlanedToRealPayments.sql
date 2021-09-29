SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

-- =============================================
-- Author:		bezvershuk_do
-- Create date: 29.09.2021
-- Description:	
-- =============================================
CREATE PROCEDURE [Link].[sp_LoadLinkPlanedToRealPayments]
	@SourceRecordId int = 1, 
	@LoadDateTime datetime2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @LoadDateTime IS NULL SET @LoadDateTime = CURRENT_TIMESTAMP;
	   
	INSERT INTO [Link].[PlanedToRealPayments]
			   ([LinkPlanedToRealPaymentId]
			   ,[HubPlanedPaymentId]
			   ,[HubRealPaymentId]
			   ,[HubPlanedToRealPaymentId]
			   ,[SourceRecordId]
			   ,[LoadDateTime])
	SELECT
		NEXT VALUE FOR [Link].[sq_PlanedToRealPayments] AS LinkPlanedToRealPaymentId,
		PP.HubPlanedPaymentId AS [HubPlanedPaymentId],
		RP.HubRealPaymentId AS [HubRealPaymentId],
		PRP.Id AS [HubPlanedToRealPaymentId],
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
	FROM Stage.PlanedToRealPayments AS PRP
	INNER JOIN Hub.PlanedPayments AS PP ON PP.PlanedPaymentGid = PRP.PlanedPaymentGID
	INNER JOIN Hub.RealPayments AS RP ON RP.RealPaymentGid = PRP.RealPaymentGID
	WHERE NOT EXISTS (
		SELECT 1
		FROM Link.PlanedToRealPayments AS L
		WHERE L.HubPlanedPaymentId = PP.HubPlanedPaymentId
			AND L.HubRealPaymentId = RP.HubRealPaymentId
			AND L.HubPlanedToRealPaymentId = PRP.Id
	)
END
GO