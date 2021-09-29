CREATE TABLE [Hub].[Branches] (
  [HubBranchId] [int] NOT NULL,
  [BranchGid] [uniqueidentifier] NOT NULL,
  [BranchCode] [nvarchar](50) NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Branches_HubBranchId] PRIMARY KEY CLUSTERED ([HubBranchId]),
  CONSTRAINT [KEY_Branches_BranchGid] UNIQUE ([BranchGid])
)
ON [PRIMARY]
GO