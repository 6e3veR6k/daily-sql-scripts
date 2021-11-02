CREATE TABLE [Link].[ProductInfo] (
  [LinkProductInfoId] [int] NOT NULL,
  [HubProductId] [bigint] NOT NULL,
  [HubProductTypeId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  [SourceRecordId] [varchar](50) NOT NULL,
  CONSTRAINT [PK_ProductInfo_LinkProductInfoId] PRIMARY KEY CLUSTERED ([LinkProductInfoId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[ProductInfo]
  ADD CONSTRAINT [FK_ProductInfo_Products_HubProductId] FOREIGN KEY ([HubProductId]) REFERENCES [Hub].[Products] ([HubProductId])
GO

ALTER TABLE [Link].[ProductInfo]
  ADD CONSTRAINT [FK_ProductInfo_ProductTypes_HubProductTypeId] FOREIGN KEY ([HubProductTypeId]) REFERENCES [Hub].[ProductTypes] ([HubProductTypeId])
GO