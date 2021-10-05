CREATE TABLE [Hub].[AgentActs] (
  [HubAgentActId] [bigint] NOT NULL,
  [AgentActGID] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_AgentActs_HubAgentActId] PRIMARY KEY CLUSTERED ([HubAgentActId])
)
ON [PRIMARY]
GO