CREATE TABLE [Dimension].[Risks] (
  [RiskId] [bigint] NOT NULL,
  [RiskGid] [uniqueidentifier] NOT NULL,
  [RiskName] [nvarchar](500) NOT NULL,
  [RiskCode] [nvarchar](50) NULL,
  CONSTRAINT [PK_Risks_RiskId] PRIMARY KEY CLUSTERED ([RiskId]),
  CONSTRAINT [KEY_Risks_RiskGid] UNIQUE ([RiskGid])
)
ON [PRIMARY]
GO