CREATE TABLE [Stage].[CasesDocuments] (
  [CaseDocumentId] [bigint] NOT NULL,
  [CaseDocumentGid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [CaseGID] [uniqueidentifier] NOT NULL,
  [DocumentGID] [uniqueidentifier] NOT NULL,
  [AddDate] [datetime] NOT NULL,
  [AddUserGID] [uniqueidentifier] NOT NULL,
  [ProcessingStatusGID] [uniqueidentifier] NULL,
  [StatusGID] [uniqueidentifier] NOT NULL,
  [IsAccepted] [bit] NOT NULL,
  [ParentGID] [uniqueidentifier] NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [Deleted] [bit] NOT NULL,
  CONSTRAINT [PK_CasesDocuments_CaseDocumentGid] PRIMARY KEY NONCLUSTERED ([CaseDocumentGid]),
  CONSTRAINT [KEY_CasesDocuments_CaseDocumentId] UNIQUE CLUSTERED ([CaseDocumentId])
)
ON [PRIMARY]
GO