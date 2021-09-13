CREATE TABLE [Link].[CasePayables] (
  [LinkCasePayableId] [bigint] IDENTITY,
  [LoadDateTime] [datetime] NOT NULL,
  [RecordSource] [nvarchar](50) NOT NULL,
  [HubCaseId] [bigint] NOT NULL,
  [HubPayableId] [bigint] NOT NULL,
  CONSTRAINT [PK_CasePayables_LinkCasePayableId] PRIMARY KEY CLUSTERED ([LinkCasePayableId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[CasePayables]
  ADD CONSTRAINT [FK_CasePayables_Cases_HubCaseId] FOREIGN KEY ([HubCaseId]) REFERENCES [Hub].[Cases] ([HubCaseId])
GO

ALTER TABLE [Link].[CasePayables]
  ADD CONSTRAINT [FK_CasePayables_Payables_HubPayableId] FOREIGN KEY ([HubPayableId]) REFERENCES [Hub].[Payables] ([HubPayableId])
GO