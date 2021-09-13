CREATE TABLE [Warehouse].[HubReservations] (
  [HubReservationId] [bigint] NOT NULL,
  [ReservationGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime] NOT NULL,
  CONSTRAINT [PK_HubReservation_HubReservationId] PRIMARY KEY CLUSTERED ([HubReservationId]),
  CONSTRAINT [KEY_HubReservation_ReservationGid] UNIQUE ([ReservationGid])
)
ON [PRIMARY]
GO