CREATE TABLE [Stage].[Franchises] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [FranchiseTypeGID] [uniqueidentifier] NOT NULL,
  [FranchiseValue] [sql_variant] NOT NULL,
  [CoverGID] [uniqueidentifier] NOT NULL,
  [Conditional] [int] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Franchises_id] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO