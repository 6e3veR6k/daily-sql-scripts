SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Link].[sp_LoadLinkAgentActsProducts] 
	@SourceRecordId int = 1, 
	@LoadDateTime datetime2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @LoadDateTime IS NULL SET @LoadDateTime = CURRENT_TIMESTAMP;


  INSERT INTO [Link].[AgentActsProducts]
      ([LinkAgentActsProductId]
      ,[HubProductId]
      ,[HubAgentActsCommissionId]
      ,[SourceRecordId]
      ,[LoadDateTime])
	SELECT
		NEXT VALUE FOR [Link].[sq_AgentActsProducts] AS LinkAgentActsProductId,
    sh.HubProductId,
    fh.HubAgentActsCommissionId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
  FROM Stage.AgentActsCommissions AS src
  LEFT JOIN Hub.AgentActsCommissions AS fh ON fh.HubAgentActsCommissionId = src.id
  LEFT JOIN Hub.Products AS sh on sh.ProductGid = src.ProductGid

	WHERE NOT EXISTS 
		(SELECT 1 FROM Link.AgentActsProducts AS trg 
		WHERE 
			trg.HubAgentActsCommissionId = fh.HubAgentActsCommissionId AND 
			trg.HubProductId = sh.HubProductId)
END
GO