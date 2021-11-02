CREATE TABLE [Warehouse].[LinkEventsToCases] (
  [LinkEventsToCaseId] [bigint] NOT NULL,
  [HubEventId] [bigint] NOT NULL,
  [HubCaseId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime] NOT NULL,
  CONSTRAINT [PK_LinkEventsToCases_LinkEventsToCaseId] PRIMARY KEY CLUSTERED ([LinkEventsToCaseId])
)
ON [PRIMARY]
GO

ALTER TABLE [Warehouse].[LinkEventsToCases]
  ADD CONSTRAINT [FK_LinkEventsToCases_HubCases_HubCaseId] FOREIGN KEY ([HubCaseId]) REFERENCES [Warehouse].[HubCases] ([HubCaseId])
GO

ALTER TABLE [Warehouse].[LinkEventsToCases]
  ADD CONSTRAINT [FK_LinkEventsToCases_HubEvents_HubEventId] FOREIGN KEY ([HubEventId]) REFERENCES [Warehouse].[HubEvents] ([HubEventId])
GO