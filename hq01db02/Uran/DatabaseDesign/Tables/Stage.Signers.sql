CREATE TABLE [Stage].[Signers] (
  [SignerId] [bigint] NOT NULL,
  [SignerGid] [uniqueidentifier] NOT NULL,
  [FaceGID] [uniqueidentifier] NOT NULL,
  [RepresentativeGID] [uniqueidentifier] NULL,
  [AccountGID] [uniqueidentifier] NULL,
  [DocumentGID] [uniqueidentifier] NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NOT NULL,
  CONSTRAINT [PK_Signers_SignerGid] PRIMARY KEY NONCLUSTERED ([SignerGid]),
  CONSTRAINT [KEY_Signers_SignerId] UNIQUE CLUSTERED ([SignerId])
)
ON [PRIMARY]
GO