CREATE TABLE [Warehouse].[HubCases] (
  [HubCaseId] [bigint] NOT NULL,
  [CaseGid] [uniqueidentifier] NOT NULL,
  [CaseNumber] [nvarchar](255) NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime] NOT NULL,
  CONSTRAINT [PK_HubCases_HubCaseId] PRIMARY KEY CLUSTERED ([HubCaseId]),
  CONSTRAINT [KEY_HubCases_CaseGid] UNIQUE ([CaseGid])
)
ON [PRIMARY]
GO