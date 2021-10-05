CREATE TABLE [Stage].[RealPayments] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [PaymentDate] [date] NOT NULL,
  [Value] [decimal](18, 2) NOT NULL,
  [Comment] [nvarchar](500) NULL,
  [IsCommission] [bit] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [IsAutomatic] [bit] NOT NULL,
  [SourceTypeGID] [uniqueidentifier] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [_CreateDateTime] [datetime2] NOT NULL,
  [_ActionDateTime] [datetime2] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_RealPayments_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO