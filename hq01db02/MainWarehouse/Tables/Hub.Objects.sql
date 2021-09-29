CREATE TABLE [Hub].[Objects] (
  [HubObjectId] [bigint] IDENTITY,
  [ObjectGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Objects_HubObjectId] PRIMARY KEY CLUSTERED ([HubObjectId])
)
ON [PRIMARY]
GO