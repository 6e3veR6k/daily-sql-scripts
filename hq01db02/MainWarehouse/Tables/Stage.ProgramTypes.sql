CREATE TABLE [Stage].[ProgramTypes] (
  [Id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [Name] [nvarchar](180) NOT NULL,
  [Description] [nvarchar](200) NULL,
  [InsuranceTypeGID] [uniqueidentifier] NOT NULL,
  [CoefficientCount] [int] NOT NULL,
  [IsOld] [bit] NOT NULL,
  [InitDate] [date] NOT NULL,
  [IssueDate] [date] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ProgramTypes_HubProgramTypeId] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO