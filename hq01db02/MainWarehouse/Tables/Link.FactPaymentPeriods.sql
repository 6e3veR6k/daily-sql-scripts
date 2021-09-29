CREATE TABLE [Link].[FactPaymentPeriods] (
  [LinkFactPaymentPeriodId] [bigint] NOT NULL,
  [HubProductId] [bigint] NOT NULL,
  [HubPaymentPeriodId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_FactPaymentPeriods_LinkFactPaymentPeriods] PRIMARY KEY CLUSTERED ([LinkFactPaymentPeriodId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[FactPaymentPeriods]
  ADD CONSTRAINT [FK_FactPaymentPeriods_PaymentPeriods_HubPaymentPeriodId] FOREIGN KEY ([HubPaymentPeriodId]) REFERENCES [Hub].[PaymentPeriods] ([HubPaymentPeriodId])
GO

ALTER TABLE [Link].[FactPaymentPeriods]
  ADD CONSTRAINT [FK_FactPaymentPeriods_Products_HubProductId] FOREIGN KEY ([HubProductId]) REFERENCES [Hub].[Products] ([HubProductId])
GO