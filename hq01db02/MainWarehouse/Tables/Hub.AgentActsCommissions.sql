CREATE TABLE [Hub].[AgentActsCommissions] (
  [HubAgentActsCommissionId] [bigint] NOT NULL,
  [AgentActCommissionGID] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_AgentActsCommissions_HubAgentActsCommissionId] PRIMARY KEY CLUSTERED ([HubAgentActsCommissionId])
)
ON [PRIMARY]
GO