CREATE TABLE [Hub].[PlanedToRealPayments] (
  [HubPlanedToRealPaymentId] [bigint] NOT NULL,
  [PlanedToRealPaymentGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_PlanedToRealPayments_HubPlanedToRealPaymentId] PRIMARY KEY CLUSTERED ([HubPlanedToRealPaymentId])
)
ON [PRIMARY]
GO