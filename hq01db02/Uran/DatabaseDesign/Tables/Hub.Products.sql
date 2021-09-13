CREATE TABLE [Hub].[Products] (
  [HubProductId] [bigint] NOT NULL CONSTRAINT [DF_HubProducts_HubProductId] DEFAULT (NEXT VALUE FOR [Hub].[SequenceProductId]),
  [LoadDateTime] [datetime] NOT NULL,
  [SourceProductId] [bigint] NOT NULL,
  [SourceProductGid] [uniqueidentifier] NOT NULL,
  [RecordSource] [nvarchar](50) NOT NULL,
  CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([HubProductId]),
  CONSTRAINT [KEY_Products] UNIQUE ([SourceProductId], [SourceProductGid])
)
ON [PRIMARY]
GO