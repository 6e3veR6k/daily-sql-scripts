SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [Link].[sp_LoadLinkFactAgentActs] 
	@SourceRecordId int = 1, 
	@LoadDateTime datetime2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @LoadDateTime IS NULL SET @LoadDateTime = CURRENT_TIMESTAMP;


  INSERT INTO [Link].[FactAgentActs]
      ([LinkFactAgentActsId]
      ,[HubAgentActId]
      ,[HubAgentActsCommissionId]
      ,[SourceRecordId]
      ,[LoadDateTime])
	SELECT
		NEXT VALUE FOR [Link].[sq_FactAgentActs] AS LinkFactAgentActsId,
    sh.HubAgentActId,
    fh.HubAgentActsCommissionId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
  FROM Stage.AgentActsCommissions AS src
  LEFT JOIN Hub.AgentActsCommissions AS fh ON fh.HubAgentActsCommissionId = src.id
  LEFT JOIN Hub.AgentActs AS sh on sh.AgentActGID = src.AgentActGID
	WHERE NOT EXISTS 
		(SELECT 1 FROM Link.FactAgentActs AS trg 
		WHERE 
			trg.HubAgentActsCommissionId = fh.HubAgentActsCommissionId AND 
			trg.HubAgentActId = sh.HubAgentActId)
END
GO