CREATE TABLE [Warehouse].[HubPayables] (
  [HubPayableId] [bigint] NOT NULL,
  [PayableGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime] NOT NULL,
  CONSTRAINT [PK_HubPayables_HubPayableId] PRIMARY KEY CLUSTERED ([HubPayableId]),
  CONSTRAINT [KEY_HubPayables_PayableGid] UNIQUE ([PayableGid])
)
ON [PRIMARY]
GO