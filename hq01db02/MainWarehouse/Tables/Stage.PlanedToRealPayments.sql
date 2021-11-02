CREATE TABLE [Stage].[PlanedToRealPayments] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [PlanedPaymentGID] [uniqueidentifier] NOT NULL,
  [RealPaymentGID] [uniqueidentifier] NOT NULL,
  [Value] [decimal](18, 2) NOT NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [_CreateDateTime] [datetime2] NOT NULL,
  [_ActionDateTime] [datetime2] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_PlanedToRealPayments_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO