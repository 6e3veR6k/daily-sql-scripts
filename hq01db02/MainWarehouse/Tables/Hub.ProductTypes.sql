CREATE TABLE [Hub].[ProductTypes] (
  [HubProductTypeId] [int] NOT NULL,
  [ProductTypeGid] [uniqueidentifier] NOT NULL,
  [SourcerRecordId] [varchar](50) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ProductTypes_HubProductTypeId] PRIMARY KEY CLUSTERED ([HubProductTypeId])
)
ON [PRIMARY]
GO