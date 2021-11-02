CREATE TABLE [Link].[AgentActsRealPayments] (
  [LinkAgentActsRealPaymentId] [bigint] NOT NULL,
  [HubAgentActsCommissionId] [bigint] NOT NULL,
  [HubRealPaymentId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_AgentActsRealPayments_LinkAgentActsRealPaymentId] PRIMARY KEY CLUSTERED ([LinkAgentActsRealPaymentId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[AgentActsRealPayments]
  ADD CONSTRAINT [FK_AgentActsRealPayments_AgentActsCommissions_HubAgentActsCommissionId] FOREIGN KEY ([HubAgentActsCommissionId]) REFERENCES [Hub].[AgentActsCommissions] ([HubAgentActsCommissionId])
GO

ALTER TABLE [Link].[AgentActsRealPayments]
  ADD CONSTRAINT [FK_AgentActsRealPayments_RealPayments_HubRealPaymentId] FOREIGN KEY ([HubRealPaymentId]) REFERENCES [Hub].[RealPayments] ([HubRealPaymentId])
GO