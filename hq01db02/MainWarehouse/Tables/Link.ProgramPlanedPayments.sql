CREATE TABLE [Link].[ProgramPlanedPayments] (
  [LinkProgramPlanedPaymentId] [bigint] NOT NULL,
  [HubProgramId] [bigint] NOT NULL,
  [HubPlanedPaymentId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ProgramPlanedPayments_ProgramPlanedPayments] PRIMARY KEY CLUSTERED ([LinkProgramPlanedPaymentId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[ProgramPlanedPayments]
  ADD CONSTRAINT [FK_ProgramPlanedPayments_PlanedPayments_HubPlanedPaymentId] FOREIGN KEY ([HubPlanedPaymentId]) REFERENCES [Hub].[PlanedPayments] ([HubPlanedPaymentId])
GO

ALTER TABLE [Link].[ProgramPlanedPayments]
  ADD CONSTRAINT [FK_ProgramPlanedPayments_Programs_HubProgramId] FOREIGN KEY ([HubProgramId]) REFERENCES [Hub].[Programs] ([HubProgramId])
GO