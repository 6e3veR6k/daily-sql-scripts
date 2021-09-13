CREATE TABLE [Hub].[Reservation] (
  [HubReservationId] [bigint] NOT NULL CONSTRAINT [DF_HubReservation_HubReservationId] DEFAULT (NEXT VALUE FOR [Hub].[SequenceReservationId]),
  [LoadDateTime] [datetime] NOT NULL,
  [SourceReservationId] [bigint] NOT NULL,
  [SourceReservationGid] [uniqueidentifier] NOT NULL,
  [RecordSource] [nvarchar](50) NOT NULL,
  CONSTRAINT [PK_Reservation] PRIMARY KEY CLUSTERED ([HubReservationId]),
  CONSTRAINT [KEY_Reservation] UNIQUE ([SourceReservationId], [SourceReservationGid])
)
ON [PRIMARY]
GO