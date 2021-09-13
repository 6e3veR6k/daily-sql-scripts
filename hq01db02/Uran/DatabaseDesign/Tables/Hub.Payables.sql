CREATE TABLE [Hub].[Payables] (
  [HubPayableId] [bigint] NOT NULL CONSTRAINT [DF_HubPayables_HubPayableId] DEFAULT (NEXT VALUE FOR [Hub].[SequencePayableId]),
  [LoadDateTime] [datetime] NOT NULL,
  [SourcePayableId] [bigint] NOT NULL,
  [SourcePayableGid] [uniqueidentifier] NOT NULL,
  [RecordSource] [nvarchar](50) NOT NULL,
  CONSTRAINT [PK_Payables] PRIMARY KEY CLUSTERED ([HubPayableId]),
  CONSTRAINT [KEY_Payables] UNIQUE ([SourcePayableId], [SourcePayableGid])
)
ON [PRIMARY]
GO