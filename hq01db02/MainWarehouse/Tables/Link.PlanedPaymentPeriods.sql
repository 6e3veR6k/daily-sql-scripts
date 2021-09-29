CREATE TABLE [Link].[PlanedPaymentPeriods] (
  [LinkPlanedPaymentPeriodId] [bigint] NOT NULL,
  [HubPaymentPeriodId] [bigint] NOT NULL,
  [HubPlanedPaymentId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_PlanedPaymentPeriods_LinkPlanedPaymentPeriodId] PRIMARY KEY CLUSTERED ([LinkPlanedPaymentPeriodId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[PlanedPaymentPeriods]
  ADD CONSTRAINT [FK_PlanedPaymentPeriods_PaymentPeriods_HubPaymentPeriodId] FOREIGN KEY ([HubPaymentPeriodId]) REFERENCES [Hub].[PaymentPeriods] ([HubPaymentPeriodId])
GO

ALTER TABLE [Link].[PlanedPaymentPeriods]
  ADD CONSTRAINT [FK_PlanedPaymentPeriods_PlanedPayments_HubPlanedPaymentId] FOREIGN KEY ([HubPlanedPaymentId]) REFERENCES [Hub].[PlanedPayments] ([HubPlanedPaymentId])
GO