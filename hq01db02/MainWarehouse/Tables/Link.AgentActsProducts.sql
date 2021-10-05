CREATE TABLE [Link].[AgentActsProducts] (
  [LinkAgentActsProductId] [bigint] NOT NULL,
  [HubProductId] [bigint] NOT NULL,
  [HubAgentActsCommissionId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_AgentActsProducts_LinkAgentActsProductId] PRIMARY KEY CLUSTERED ([LinkAgentActsProductId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[AgentActsProducts]
  ADD CONSTRAINT [FK_AgentActsProducts_AgentActsCommissions_HubAgentActsCommissionId] FOREIGN KEY ([HubAgentActsCommissionId]) REFERENCES [Hub].[AgentActsCommissions] ([HubAgentActsCommissionId])
GO

ALTER TABLE [Link].[AgentActsProducts]
  ADD CONSTRAINT [FK_AgentActsProducts_Products_HubProductId] FOREIGN KEY ([HubProductId]) REFERENCES [Hub].[Products] ([HubProductId])
GO