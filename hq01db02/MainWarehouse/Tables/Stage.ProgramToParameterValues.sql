CREATE TABLE [Stage].[ProgramToParameterValues] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [ProgramGID] [uniqueidentifier] NOT NULL,
  [ParameterValue] [sql_variant] NOT NULL,
  [ParameterGID] [uniqueidentifier] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [ParameterValueGUIDKey] [uniqueidentifier] NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ProgramToParameterValues_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO