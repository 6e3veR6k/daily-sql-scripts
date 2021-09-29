CREATE TABLE [Stage].[FranchiseParameters] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [FranchiseGID] [uniqueidentifier] NOT NULL,
  [FranchiseTypeParameterGID] [uniqueidentifier] NOT NULL,
  [Value] [sql_variant] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_FranchiseParameters_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO