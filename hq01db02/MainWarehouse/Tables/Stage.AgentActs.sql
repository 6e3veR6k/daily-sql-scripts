CREATE TABLE [Stage].[AgentActs] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [AgentGID] [uniqueidentifier] NOT NULL,
  [StatusGID] [uniqueidentifier] NOT NULL,
  [ChanelGID] [uniqueidentifier] NOT NULL,
  [StartPeriod] [date] NOT NULL,
  [CommissionTypeGID] [uniqueidentifier] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [EndPeriod] [date] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [WorkflowGID] [uniqueidentifier] NULL,
  [_CreateDateTime] [datetime2] NOT NULL,
  [_ActionDateTime] [datetime2] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_AgentActs_Id] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO