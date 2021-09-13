CREATE TABLE [Hub].[Cases] (
  [HubCaseId] [bigint] NOT NULL CONSTRAINT [DF_HubCases_HubCaseId] DEFAULT (NEXT VALUE FOR [Hub].[SequenceCasesId]),
  [LoadDateTime] [datetime] NOT NULL,
  [SourceCaseId] [bigint] NOT NULL,
  [SourceCaseGid] [uniqueidentifier] NOT NULL,
  [RecordSource] [nvarchar](50) NOT NULL,
  CONSTRAINT [PK_Cases] PRIMARY KEY CLUSTERED ([HubCaseId]),
  CONSTRAINT [KEY_Cases] UNIQUE ([SourceCaseId], [SourceCaseGid])
)
ON [PRIMARY]
GO