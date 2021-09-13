CREATE TABLE [Link].[PayableReservations] (
  [LinkPayableReservation] [varchar](50) NOT NULL CONSTRAINT [DF_PayableReservations_PayableReservationId] DEFAULT (NEXT VALUE FOR [Link].[SequencePayableReservationId]),
  [LoadDateTime] [datetime] NOT NULL,
  [RecordSource] [nvarchar](50) NOT NULL,
  [HubReservationId] [bigint] NOT NULL,
  [HubPayableId] [bigint] NOT NULL,
  CONSTRAINT [PK_PayableReservations_LinkPayableReservation] PRIMARY KEY CLUSTERED ([LinkPayableReservation])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[PayableReservations]
  ADD CONSTRAINT [FK_PayableReservations_Payables_HubPayableId] FOREIGN KEY ([HubPayableId]) REFERENCES [Hub].[Payables] ([HubPayableId])
GO

ALTER TABLE [Link].[PayableReservations]
  ADD CONSTRAINT [FK_PayableReservations_Reservation_HubReservationId] FOREIGN KEY ([HubReservationId]) REFERENCES [Hub].[Reservation] ([HubReservationId])
GO