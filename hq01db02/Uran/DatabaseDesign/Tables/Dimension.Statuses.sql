CREATE TABLE [Dimension].[Statuses] (
  [StatusId] [int] NOT NULL,
  [StatusGid] [uniqueidentifier] NOT NULL,
  [StatusName] [nvarchar](255) NOT NULL,
  CONSTRAINT [PK_Statuses_StatusGid] PRIMARY KEY NONCLUSTERED ([StatusGid]),
  CONSTRAINT [KEY_Statuses_StatusId] UNIQUE CLUSTERED ([StatusId])
)
ON [PRIMARY]
GO