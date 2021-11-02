CREATE TABLE [Satellite].[ProductHistory] (
  [HubProductId] [bigint] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  [CreateDateTime] [datetime2] NOT NULL,
  [LastModifiedDateTime] [datetime2] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  CONSTRAINT [PK_ProductHistory] PRIMARY KEY CLUSTERED ([HubProductId], [LoadDateTime])
)
ON [PRIMARY]
GO

ALTER TABLE [Satellite].[ProductHistory]
  ADD CONSTRAINT [FK_ProductHistory_Products_HubProductId] FOREIGN KEY ([HubProductId]) REFERENCES [Hub].[Products] ([HubProductId])
GO