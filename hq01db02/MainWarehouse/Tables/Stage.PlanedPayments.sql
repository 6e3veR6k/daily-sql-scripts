CREATE TABLE [Stage].[PlanedPayments] (
  [Id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [ProgramGID] [uniqueidentifier] NOT NULL,
  [PaymentPeriodGID] [uniqueidentifier] NOT NULL,
  [Value] [decimal](18, 2) NOT NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [_CreateDateTime] [datetime2] NOT NULL,
  [_ActionDateTime] [datetime2] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_PlanedPayments_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO