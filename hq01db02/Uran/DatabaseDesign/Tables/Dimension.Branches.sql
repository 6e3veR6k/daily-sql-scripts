CREATE TABLE [Dimension].[Branches] (
  [BranchWhId] [int] NOT NULL,
  [BranchGID] [uniqueidentifier] NOT NULL,
  [BranchCode] [varchar](10) NOT NULL,
  [BranchName] [nvarchar](255) NOT NULL,
  [FullCodeBranchName] [nvarchar](300) NOT NULL,
  [ParentBranchWhId] [int] NULL,
  [ParentBranchName] [nvarchar](300) NULL,
  [ParentBranchCode] [varchar](4) NULL,
  [FullCodeParentBranchName] [nvarchar](300) NULL,
  [DirectionCode] [varchar](2) NULL,
  [DirectionName] [nvarchar](300) NULL,
  [ShortCodeDirectionName] [nvarchar](300) NULL,
  [ShortDirectionName] [nvarchar](300) NULL,
  CONSTRAINT [PK_Branches_BranchWhId_BranchGID] PRIMARY KEY CLUSTERED ([BranchWhId], [BranchGID]),
  CONSTRAINT [KEY_Branches_BranchWhId] UNIQUE ([BranchWhId])
)
ON [PRIMARY]
GO

ALTER TABLE [Dimension].[Branches]
  ADD CONSTRAINT [FK_Branches_ParentBranchWhId] FOREIGN KEY ([ParentBranchWhId]) REFERENCES [Dimension].[Branches] ([BranchWhId])
GO