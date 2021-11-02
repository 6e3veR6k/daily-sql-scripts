CREATE TABLE [Warehouse].[LinkCasePayables] (
  [LinkCasePayableId] [bigint] NOT NULL,
  [HubCaseId] [bigint] NOT NULL,
  [HubPayableId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime] NOT NULL,
  CONSTRAINT [PK_LinkCasePayables_LinkCasePayable] PRIMARY KEY CLUSTERED ([LinkCasePayableId])
)
ON [PRIMARY]
GO

ALTER TABLE [Warehouse].[LinkCasePayables]
  ADD CONSTRAINT [FK_LinkCasePayables_HubCases_HubCaseId] FOREIGN KEY ([HubCaseId]) REFERENCES [Warehouse].[HubCases] ([HubCaseId])
GO

ALTER TABLE [Warehouse].[LinkCasePayables]
  ADD CONSTRAINT [FK_LinkCasePayables_HubPayables_HubPayableId] FOREIGN KEY ([HubPayableId]) REFERENCES [Warehouse].[HubPayables] ([HubPayableId])
GO