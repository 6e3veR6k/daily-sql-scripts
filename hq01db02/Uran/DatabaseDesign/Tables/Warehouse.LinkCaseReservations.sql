CREATE TABLE [Warehouse].[LinkCaseReservations] (
  [LinkCaseReservationId] [bigint] IDENTITY,
  [HubCaseId] [bigint] NOT NULL,
  [HubReservationId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime] NOT NULL,
  CONSTRAINT [PK_LinkCaseReservations_LinkCaseReservationId] PRIMARY KEY CLUSTERED ([LinkCaseReservationId])
)
ON [PRIMARY]
GO

ALTER TABLE [Warehouse].[LinkCaseReservations]
  ADD CONSTRAINT [FK_LinkCaseReservations_HubCases_HubCaseId] FOREIGN KEY ([HubCaseId]) REFERENCES [Warehouse].[HubCases] ([HubCaseId])
GO

ALTER TABLE [Warehouse].[LinkCaseReservations]
  ADD CONSTRAINT [FK_LinkCaseReservations_HubReservations_HubReservationId] FOREIGN KEY ([HubReservationId]) REFERENCES [Warehouse].[HubReservations] ([HubReservationId])
GO