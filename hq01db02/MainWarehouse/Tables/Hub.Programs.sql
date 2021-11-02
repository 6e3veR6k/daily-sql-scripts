CREATE TABLE [Hub].[Programs] (
  [HubProgramId] [bigint] NOT NULL,
  [ProgramGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Programs_HubProgramId] PRIMARY KEY CLUSTERED ([HubProgramId]),
  CONSTRAINT [KEY_Programs_ProgramGid] UNIQUE ([ProgramGid])
)
ON [PRIMARY]
GO