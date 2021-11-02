SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

-- =============================================
-- Author:		bezvershuk_do
-- Create date: 29.09.2021
-- Description:	
-- =============================================
CREATE PROCEDURE [Link].[sp_LoadLinkProgramPlanedPayments] 
	@SourceRecordId int = 1, 
	@LoadDateTime datetime2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @LoadDateTime IS NULL SET @LoadDateTime = CURRENT_TIMESTAMP;


	INSERT INTO [Link].[ProgramPlanedPayments]
				([LinkProgramPlanedPaymentId]
				,[HubProgramId]
				,[HubPlanedPaymentId]
				,[SourceRecordId]
				,[LoadDateTime])
	SELECT
		NEXT VALUE FOR [Link].[sq_ProgramPlanedPayments] AS LinkProgramPlanedPaymentId,
		fh.HubProgramId AS HubProgramId,
		sh.HubPlanedPaymentId AS HubPlanedPaymentId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
	FROM Stage.PlanedPayments AS src
	INNER JOIN Hub.Programs AS fh ON fh.ProgramGid = src.ProgramGID
	INNER JOIN Hub.PlanedPayments AS sh ON sh.HubPlanedPaymentId = src.id
	WHERE NOT EXISTS 
		(SELECT 1 FROM Link.ProgramPlanedPayments AS trg 
		WHERE 
			trg.HubPlanedPaymentId = sh.HubPlanedPaymentId AND 
			trg.HubProgramId = fh.HubProgramId)

END
GO