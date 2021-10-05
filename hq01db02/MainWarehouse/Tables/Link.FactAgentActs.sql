CREATE TABLE [Link].[FactAgentActs] (
  [LinkFactAgentActsId] [bigint] NOT NULL,
  [HubAgentActId] [bigint] NOT NULL,
  [HubAgentActCommissionId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_FactAgentActs_LinkFactAgentActsId] PRIMARY KEY CLUSTERED ([LinkFactAgentActsId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[FactAgentActs]
  ADD CONSTRAINT [FK_FactAgentActs_AgentActs_HubAgentActId] FOREIGN KEY ([HubAgentActId]) REFERENCES [Hub].[AgentActs] ([HubAgentActId])
GO

ALTER TABLE [Link].[FactAgentActs]
  ADD CONSTRAINT [FK_FactAgentActs_AgentActsCommissions_HubAgentActsCommissionId] FOREIGN KEY ([HubAgentActCommissionId]) REFERENCES [Hub].[AgentActsCommissions] ([HubAgentActsCommissionId])
GO