CREATE TABLE [Hub].[PlanedPayments] (
  [HubPlanedPaymentId] [bigint] NOT NULL,
  [PlanedPaymentGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_PlannedPayments_HubPlannedPaymentId] PRIMARY KEY CLUSTERED ([HubPlanedPaymentId])
)
ON [PRIMARY]
GO