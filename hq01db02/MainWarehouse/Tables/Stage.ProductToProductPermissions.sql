CREATE TABLE [Stage].[ProductToProductPermissions] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [ProductGID] [uniqueidentifier] NOT NULL,
  [ProductPermissionGID] [uniqueidentifier] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [_CreateDateTime] [datetime2] NOT NULL,
  [_ActionDateTime] [datetime2] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ProductToProductPermissions_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO