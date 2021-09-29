CREATE TABLE [Link].[ProgramInfo] (
  [LinkProgramInfoId] [bigint] IDENTITY,
  [HubProgramId] [bigint] NOT NULL,
  [HubProgramTypeId] [int] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ProgramInfo_LinkProgramInfoId] PRIMARY KEY CLUSTERED ([LinkProgramInfoId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[ProgramInfo]
  ADD CONSTRAINT [FK_ProgramInfo_Programs_HubProgramId] FOREIGN KEY ([HubProgramId]) REFERENCES [Hub].[Programs] ([HubProgramId])
GO

ALTER TABLE [Link].[ProgramInfo]
  ADD CONSTRAINT [FK_ProgramInfo_ProgramTypes_HubProgramTypeId] FOREIGN KEY ([HubProgramTypeId]) REFERENCES [Hub].[ProgramTypes] ([HubProgramTypeId])
GO