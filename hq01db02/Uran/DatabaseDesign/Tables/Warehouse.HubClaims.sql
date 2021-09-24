CREATE TABLE [Warehouse].[HubClaims] (
  [HubClaimId] [bigint] NOT NULL,
  [ClaimGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime] NOT NULL,
  CONSTRAINT [PK_HubClaims_HubClaimId] PRIMARY KEY CLUSTERED ([HubClaimId]),
  CONSTRAINT [KEY_HubClaims_ClaimGid] UNIQUE ([ClaimGid])
)
ON [PRIMARY]
GO