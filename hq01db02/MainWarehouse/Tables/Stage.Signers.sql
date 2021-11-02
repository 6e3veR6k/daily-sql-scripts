CREATE TABLE [Stage].[Signers] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [FaceGID] [uniqueidentifier] NOT NULL,
  [RepresentativeGID] [uniqueidentifier] NULL,
  [AccountGID] [uniqueidentifier] NULL,
  [DocumentGID] [uniqueidentifier] NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NOT NULL,
  [FaceDocumentGID] [uniqueidentifier] NULL,
  [LastModifiedFaceDate] [datetime] NULL,
  [LastModifiedRepresentativeDate] [datetime] NULL,
  [FaceName] [nvarchar](255) NOT NULL,
  [RepresentativeName] [nvarchar](255) NULL,
  [FacePersonTypeID] [bigint] NOT NULL,
  [RepresentativePersonTypeID] [bigint] NULL,
  [_CreateDateTime] [datetime2] NOT NULL,
  [_ActionDateTime] [datetime2] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Signers_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO