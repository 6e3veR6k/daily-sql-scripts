SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [Link].[sp_LoadLinkAgentActsRealPayments] 
	@SourceRecordId int = 1, 
	@LoadDateTime datetime2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @LoadDateTime IS NULL SET @LoadDateTime = CURRENT_TIMESTAMP;


  INSERT INTO [Link].[AgentActsRealPayments]
      ([LinkAgentActsRealPaymentId]
      ,[HubRealPaymentId]
      ,[HubAgentActsCommissionId]
      ,[SourceRecordId]
      ,[LoadDateTime])
	SELECT
		NEXT VALUE FOR [Link].[sq_AgentActsRealPayments] AS LinkAgentActsRealPaymentId,
    sh.HubRealPaymentId,
    fh.HubAgentActsCommissionId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
  FROM Stage.AgentActsCommissions AS src
  INNER JOIN Hub.AgentActsCommissions AS fh ON fh.HubAgentActsCommissionId = src.id
  INNER JOIN Hub.RealPayments AS sh on sh.RealPaymentGid = src.RealPaymentGid

	WHERE NOT EXISTS 
		(SELECT 1 FROM Link.AgentActsRealPayments AS trg 
		WHERE 
			trg.HubAgentActsCommissionId = fh.HubAgentActsCommissionId AND 
			trg.HubRealPaymentId = sh.HubRealPaymentId)
END
GO