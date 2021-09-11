CREATE TABLE [Stage].[Cases] (
  [CaseId] [bigint] NOT NULL,
  [CaseGid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Number] [nvarchar](255) NOT NULL,
  [InnerNumber] [nvarchar](50) NOT NULL,
  [ClaimTypeGID] [uniqueidentifier] NOT NULL,
  [StatusGID] [uniqueidentifier] NOT NULL,
  [ResponsibleGID] [uniqueidentifier] NOT NULL,
  [Year] [int] NOT NULL,
  [EventGID] [uniqueidentifier] NOT NULL,
  [BranchGID] [uniqueidentifier] NULL,
  [IsRegressPossible] [bit] NULL,
  [AddDate] [datetime] NOT NULL,
  [AddUserGID] [uniqueidentifier] NOT NULL,
  [PinCode] [nvarchar](7) NULL,
  [Executor] [nvarchar](255) NULL,
  [ForumTopicGID] [uniqueidentifier] NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [WorkflowGID] [uniqueidentifier] NULL,
  [PolisNumber] [nvarchar](max) NULL,
  [InsuredName] [nvarchar](max) NULL,
  [InsuredObjectName] [nvarchar](max) NULL,
  [ParticipantFaceNames] [nvarchar](max) NULL,
  [ParticipantObjectNames] [nvarchar](max) NULL,
  [LastModifiedAuthorGID] [uniqueidentifier] NULL,
  [LastModifiedDate] [datetime] NULL,
  [Deleted] [bit] NOT NULL,
  [CreateDate] [datetime] NOT NULL,
  CONSTRAINT [PK_Cases_gid] PRIMARY KEY NONCLUSTERED ([CaseGid]),
  CONSTRAINT [KEY_Cases_id] UNIQUE CLUSTERED ([CaseId])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO