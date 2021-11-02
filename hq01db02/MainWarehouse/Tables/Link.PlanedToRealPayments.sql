CREATE TABLE [Link].[PlanedToRealPayments] (
  [LinkPlanedToRealPaymentId] [bigint] NOT NULL,
  [HubPlanedPaymentId] [bigint] NOT NULL,
  [HubRealPaymentId] [bigint] NOT NULL,
  [HubPlanedToRealPaymentId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_PlanedToRealPayments_LinkPlanedToRealPaymentId] PRIMARY KEY CLUSTERED ([LinkPlanedToRealPaymentId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[PlanedToRealPayments]
  ADD CONSTRAINT [FK_PlanedToRealPayments_PlanedPayments_HubPlanedPaymentId] FOREIGN KEY ([HubPlanedPaymentId]) REFERENCES [Hub].[PlanedPayments] ([HubPlanedPaymentId])
GO

ALTER TABLE [Link].[PlanedToRealPayments]
  ADD CONSTRAINT [FK_PlanedToRealPayments_PlanedToRealPayments_HubPlanedToRealPaymentId] FOREIGN KEY ([HubPlanedToRealPaymentId]) REFERENCES [Hub].[PlanedToRealPayments] ([HubPlanedToRealPaymentId])
GO

ALTER TABLE [Link].[PlanedToRealPayments]
  ADD CONSTRAINT [FK_PlanedToRealPayments_RealPayments_HubRealPaymentId] FOREIGN KEY ([HubRealPaymentId]) REFERENCES [Hub].[RealPayments] ([HubRealPaymentId])
GO