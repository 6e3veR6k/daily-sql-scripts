CREATE TABLE [Link].[FactProducts] (
  [LinkFactProductId] [bigint] NOT NULL,
  [HubProductId] [bigint] NOT NULL,
  [HubProgramId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ProductPrograms_LinkProductProgramId] PRIMARY KEY CLUSTERED ([LinkFactProductId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[FactProducts]
  ADD CONSTRAINT [FK_ProductPrograms_Products_HubProductId] FOREIGN KEY ([HubProductId]) REFERENCES [Hub].[Products] ([HubProductId])
GO

ALTER TABLE [Link].[FactProducts]
  ADD CONSTRAINT [FK_ProductPrograms_Programs_HubProgramId] FOREIGN KEY ([HubProgramId]) REFERENCES [Hub].[Programs] ([HubProgramId])
GO