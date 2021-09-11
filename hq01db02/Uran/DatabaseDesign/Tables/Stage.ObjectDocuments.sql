CREATE TABLE [Stage].[ObjectDocuments] (
  [ObjectDocumentId] [bigint] NOT NULL,
  [ObjectDocumentGid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Name] [nvarchar](50) NOT NULL,
  [Number] [nvarchar](50) NOT NULL,
  [StartDate] [datetime] NULL,
  [EndDate] [datetime] NULL,
  [IssuedDate] [date] NULL,
  [IssuedBy] [nvarchar](200) NULL,
  [ObjectGID] [uniqueidentifier] NOT NULL,
  [DocumentTypeGID] [uniqueidentifier] NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [IsActive] [bit] NOT NULL,
  CONSTRAINT [PK_ObjectDocuments_gid] PRIMARY KEY NONCLUSTERED ([ObjectDocumentGid]),
  CONSTRAINT [KEY_ObjectDocuments_ObjectDocumentId] UNIQUE CLUSTERED ([ObjectDocumentId])
)
ON [PRIMARY]
GO