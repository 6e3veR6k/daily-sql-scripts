CREATE TABLE [Stage].[Documents] (
  [DocumentId] [int] NOT NULL,
  [DocumentGid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Name] [nvarchar](255) NOT NULL,
  [Serial] [nvarchar](50) NULL,
  [Number] [nvarchar](255) NOT NULL,
  [StartDate] [datetime] NULL,
  [EndDate] [datetime] NULL,
  [IssuedDate] [date] NULL,
  [IssuedBy] [nvarchar](200) NULL,
  [ObjectGID] [uniqueidentifier] NULL,
  [TypeGID] [uniqueidentifier] NULL,
  [Type] [nvarchar](255) NULL,
  [IsLockedOut] [bit] NOT NULL,
  [AddDate] [datetime] NOT NULL,
  [AddUserGID] [uniqueidentifier] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [AutoGeneratNumbere] [bigint] NULL,
  [WorkflowGID] [uniqueidentifier] NULL,
  CONSTRAINT [PK_Documents_gid] PRIMARY KEY NONCLUSTERED ([DocumentGid]),
  CONSTRAINT [KEY_Documents_id] UNIQUE CLUSTERED ([DocumentId])
)
ON [PRIMARY]
GO