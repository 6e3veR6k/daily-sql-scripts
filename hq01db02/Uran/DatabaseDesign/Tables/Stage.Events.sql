CREATE TABLE [Stage].[Events] (
  [EventId] [int] NOT NULL,
  [EventGID] [uniqueidentifier] NOT NULL,
  [Date] [datetime] NULL,
  [CountryGID] [uniqueidentifier] NOT NULL,
  [PostAddressGID] [uniqueidentifier] NULL,
  [Address] [nvarchar](255) NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [Comment] [nvarchar](255) NULL,
  CONSTRAINT [PK_Events_EventGID] PRIMARY KEY NONCLUSTERED ([EventGID]),
  CONSTRAINT [KEY_Events_EventId] UNIQUE CLUSTERED ([EventId])
)
ON [PRIMARY]
GO