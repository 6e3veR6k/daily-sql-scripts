CREATE TABLE [Link].[FactContracts] (
  [LinkFactContractId] [bigint] NOT NULL,
  [HubContractId] [bigint] NOT NULL,
  [HubProductId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_FactContracts] PRIMARY KEY CLUSTERED ([LinkFactContractId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[FactContracts]
  ADD CONSTRAINT [FK_FactContracts_Contracts_HubContractId] FOREIGN KEY ([HubContractId]) REFERENCES [Hub].[Contracts] ([HubContractId])
GO

ALTER TABLE [Link].[FactContracts]
  ADD CONSTRAINT [FK_FactContracts_Products_HubProductId] FOREIGN KEY ([HubProductId]) REFERENCES [Hub].[Products] ([HubProductId])
GO