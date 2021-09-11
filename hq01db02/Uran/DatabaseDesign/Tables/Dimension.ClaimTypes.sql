CREATE TABLE [Dimension].[ClaimTypes] (
  [ClaimTypeId] [int] NOT NULL,
  [ClaimTypeGid] [uniqueidentifier] NOT NULL,
  [Name] [nvarchar](255) NOT NULL,
  CONSTRAINT [PK_ApplicationViewTypes] PRIMARY KEY CLUSTERED ([ClaimTypeId] DESC),
  CONSTRAINT [KEY_ClaimTypes_ClaimTypeGid] UNIQUE ([ClaimTypeGid])
)
ON [PRIMARY]
GO