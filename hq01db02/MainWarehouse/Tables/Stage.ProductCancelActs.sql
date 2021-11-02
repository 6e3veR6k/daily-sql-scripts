CREATE TABLE [Stage].[ProductCancelActs] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [ActNum] [nvarchar](50) NOT NULL,
  [BranchGID] [uniqueidentifier] NOT NULL,
  [SignDate] [date] NOT NULL,
  [ProductCancelTypeGID] [uniqueidentifier] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [_CreateDateTime] [datetime2] NOT NULL,
  [_ActionDateTime] [datetime2] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ProductCancelActs_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO