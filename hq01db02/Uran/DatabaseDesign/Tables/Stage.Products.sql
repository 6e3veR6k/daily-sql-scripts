CREATE TABLE [Stage].[Products] (
  [ProductId] [bigint] NOT NULL,
  [ProductGid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [ProductTypeGID] [uniqueidentifier] NULL,
  [PolisNumber] [nvarchar](50) NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [IsFromBlackWater] [bit] NOT NULL,
  [BeginingDate] [datetime] NULL,
  [EndingDate] [datetime] NULL,
  [RegisteredDate] [date] NULL,
  [IsReinsured] [bit] NULL,
  [ReinsurancePolisNumber] [nvarchar](50) NULL,
  [BranchGID] [uniqueidentifier] NULL,
  [ExternalGID] [uniqueidentifier] NULL,
  [InsuredGID] [uniqueidentifier] NULL,
  CONSTRAINT [PK_Products_ProductGid] PRIMARY KEY NONCLUSTERED ([ProductGid]),
  CONSTRAINT [KEY_Products_ProductId] UNIQUE CLUSTERED ([ProductId])
)
ON [PRIMARY]
GO