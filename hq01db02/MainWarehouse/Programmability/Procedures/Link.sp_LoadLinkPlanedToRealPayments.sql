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
		fh.HubPlanedPaymentId AS [HubPlanedPaymentId],
		sh.HubRealPaymentId AS [HubRealPaymentId],
		src.Id AS [HubPlanedToRealPaymentId],
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
	FROM Stage.PlanedToRealPayments AS src
	LEFT JOIN Hub.PlanedPayments AS fh ON fh.PlanedPaymentGid = src.PlanedPaymentGID
	LEFT JOIN Hub.RealPayments AS sh ON sh.RealPaymentGid = src.RealPaymentGID
	WHERE NOT EXISTS (
		SELECT 1
		FROM Link.PlanedToRealPayments AS trg
		WHERE 
			trg.HubPlanedPaymentId = fh.HubPlanedPaymentId AND 
			trg.HubRealPaymentId = sh.HubRealPaymentId AND 
			trg.HubPlanedToRealPaymentId = src.Id
	)
END
GO