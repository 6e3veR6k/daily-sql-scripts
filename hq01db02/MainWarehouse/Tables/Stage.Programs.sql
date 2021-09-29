CREATE TABLE [Stage].[Programs] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [ProductGID] [uniqueidentifier] NOT NULL,
  [ProgramTypeGID] [uniqueidentifier] NOT NULL,
  [CostValue] [decimal](18, 2) NOT NULL,
  [InsuranceRate] [decimal](18, 10) NULL,
  [Deleted] [bit] NOT NULL,
  [CalculatedPayment] [decimal](18, 2) NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [CalculatedInsuranceRate] [decimal](18, 10) NULL,
  [CurrencyGID] [uniqueidentifier] NULL,
  [CurrencyExchangeCost] [decimal](10, 7) NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Programs_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO