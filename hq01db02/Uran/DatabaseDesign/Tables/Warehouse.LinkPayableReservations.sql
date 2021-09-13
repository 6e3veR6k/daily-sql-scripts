CREATE TABLE [Warehouse].[LinkPayableReservations] (
  [LinkPayableReservationId] [bigint] NOT NULL,
  [HubPayableId] [bigint] NOT NULL,
  [HubReservationId] [bigint] NOT NULL,
  [SourceRecordId] [bigint] NOT NULL,
  [LoadDateTime] [datetime] NOT NULL,
  CONSTRAINT [PK_LinkPayableReservations_LinkPayableReservationId] PRIMARY KEY CLUSTERED ([LinkPayableReservationId])
)
ON [PRIMARY]
GO

ALTER TABLE [Warehouse].[LinkPayableReservations]
  ADD CONSTRAINT [FK_LinkPayableReservations_HubPayables_HubPayableId] FOREIGN KEY ([HubPayableId]) REFERENCES [Warehouse].[HubPayables] ([HubPayableId])
GO

ALTER TABLE [Warehouse].[LinkPayableReservations]
  ADD CONSTRAINT [FK_LinkPayableReservations_HubReservations_HubReservationId] FOREIGN KEY ([HubReservationId]) REFERENCES [Warehouse].[HubReservations] ([HubReservationId])
GO