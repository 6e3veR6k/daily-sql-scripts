CREATE TABLE [Stage].[Covers] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [InsuredObjectGID] [uniqueidentifier] NOT NULL,
  [RiskGID] [uniqueidentifier] NOT NULL,
  [CoverLimit] [decimal](18, 2) NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [Rate] [decimal](18, 10) NULL,
  [Payment] [decimal](18, 2) NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Covers_id] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO