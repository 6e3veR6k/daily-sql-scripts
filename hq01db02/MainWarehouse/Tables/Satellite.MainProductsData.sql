CREATE TABLE [Satellite].[MainProductsData] (
  [HubProductId] [bigint] NOT NULL,
  [PolisNumber] [nvarchar](50) NOT NULL,
  [RegisteredDate] [date] NOT NULL,
  [BeginingDate] [datetime] NOT NULL,
  [EndingDate] [datetime] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_MainProductsData] PRIMARY KEY CLUSTERED ([HubProductId], [LoadDateTime])
)
ON [PRIMARY]
GO

ALTER TABLE [Satellite].[MainProductsData]
  ADD CONSTRAINT [FK_MainProductsData_Products_HubProductId] FOREIGN KEY ([HubProductId]) REFERENCES [Hub].[Products] ([HubProductId])
GO