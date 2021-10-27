CREATE TABLE [Hub].[Cases] (
  [HubCaseId] [bigint] NOT NULL,
  [CaseGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Cases_HubCasetId] PRIMARY KEY CLUSTERED ([HubCaseId]),
  CONSTRAINT [KEY_Cases_CaseGid] UNIQUE ([CaseGid])
)
ON [PRIMARY]
GO