CREATE TABLE [Hub].[RealPayments] (
  [HubRealPaymentId] [bigint] NOT NULL,
  [RealPaymentGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_RealPayments_HubRealPaymentId] PRIMARY KEY CLUSTERED ([HubRealPaymentId])
)
ON [PRIMARY]
GO