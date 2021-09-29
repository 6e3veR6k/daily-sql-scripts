CREATE TABLE [Hub].[Contracts] (
  [HubContractId] [bigint] NOT NULL,
  [ContractGid] [uniqueidentifier] NOT NULL,
  [ContractNumber] [nvarchar](50) NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Contracts_HubContractId] PRIMARY KEY CLUSTERED ([HubContractId]),
  CONSTRAINT [KEY_Contracts_ContractGid] UNIQUE ([ContractGid])
)
ON [PRIMARY]
GO