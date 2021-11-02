CREATE TABLE [Link].[ProductsToBranches] (
  [LinkProductsToBranchId] [bigint] NOT NULL,
  [HubBranchId] [bigint] NOT NULL,
  [HubProductId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ProductsToBranches_LinkProductsToBranchId] PRIMARY KEY CLUSTERED ([LinkProductsToBranchId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[ProductsToBranches]
  ADD CONSTRAINT [FK_ProductsToBranches_Branches_HubBranchId] FOREIGN KEY ([HubBranchId]) REFERENCES [Hub].[Branches] ([HubBranchId])
GO

ALTER TABLE [Link].[ProductsToBranches]
  ADD CONSTRAINT [FK_ProductsToBranches_Products_HubProductId] FOREIGN KEY ([HubProductId]) REFERENCES [Hub].[Products] ([HubProductId])
GO