CREATE TABLE [Stage].[Branches] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [hid] [hierarchyid] NULL,
  [Name] [nvarchar](255) NOT NULL,
  [BranchCode] [nvarchar](50) NULL,
  [ParentGID] [uniqueidentifier] NULL,
  [ControlBlanks] [bit] NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [BranchCodeLen] [int] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Branches_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO