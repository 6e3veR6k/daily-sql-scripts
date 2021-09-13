CREATE TABLE [Warehouse].[HubProducts] (
  [HubProductId] [bigint] NOT NULL,
  [ProductGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime] NOT NULL,
  CONSTRAINT [PK_HubProducts_HubProductId] PRIMARY KEY CLUSTERED ([HubProductId]),
  CONSTRAINT [KEY_HubProducts_ProductGid] UNIQUE ([ProductGid])
)
ON [PRIMARY]
GO