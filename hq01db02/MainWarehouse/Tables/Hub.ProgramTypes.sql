CREATE TABLE [Hub].[ProgramTypes] (
  [HubProgramTypeId] [int] IDENTITY,
  [ProgramTypeGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ProgramTypes_HubProgramTypeId] PRIMARY KEY CLUSTERED ([HubProgramTypeId])
)
ON [PRIMARY]
GO