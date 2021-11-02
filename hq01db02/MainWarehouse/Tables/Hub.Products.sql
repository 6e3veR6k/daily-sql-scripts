CREATE TABLE [Hub].[Products] (
  [HubProductId] [bigint] NOT NULL,
  [ProductGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Products_HubProductId] PRIMARY KEY CLUSTERED ([HubProductId]),
  CONSTRAINT [KEY_Products_ProductGid] UNIQUE ([ProductGid])
)
ON [PRIMARY]
GO