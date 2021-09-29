CREATE TABLE [Hub].[PaymentPeriods] (
  [HubPaymentPeriodId] [bigint] NOT NULL,
  [PaymentPeriodGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_PaymentPeriods_HubPaymentPeriodId] PRIMARY KEY CLUSTERED ([HubPaymentPeriodId])
)
ON [PRIMARY]
GO