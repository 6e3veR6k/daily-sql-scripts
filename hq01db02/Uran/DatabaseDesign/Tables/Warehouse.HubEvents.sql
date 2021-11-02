CREATE TABLE [Warehouse].[HubEvents] (
  [HubEventId] [bigint] NOT NULL,
  [EventGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime] NOT NULL,
  CONSTRAINT [PK_HubEvents_HubEventId] PRIMARY KEY CLUSTERED ([HubEventId]),
  CONSTRAINT [KEY_HubEvents_EventGid] UNIQUE ([EventGid])
)
ON [PRIMARY]
GO