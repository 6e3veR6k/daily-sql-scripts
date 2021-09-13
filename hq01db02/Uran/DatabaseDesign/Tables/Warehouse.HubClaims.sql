CREATE TABLE [Warehouse].[HubClaims] (
  [HubClaimId] [bigint] IDENTITY,
  [ClaimGid] [uniqueidentifier] NOT NULL,
  [ClaimDateWriting] [date] NOT NULL,
  [ClaimDateAdd] [date] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime] NOT NULL,
  CONSTRAINT [PK_HubClaims_HubClaimId] PRIMARY KEY CLUSTERED ([HubClaimId]),
  CONSTRAINT [KEY_HubClaims_ClaimGid] UNIQUE ([ClaimGid])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', 'Дата заяви (вимоги)', 'SCHEMA', N'Warehouse', 'TABLE', N'HubClaims', 'COLUMN', N'ClaimDateWriting'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', 'Дата реєстрації заяви', 'SCHEMA', N'Warehouse', 'TABLE', N'HubClaims', 'COLUMN', N'ClaimDateAdd'
GO