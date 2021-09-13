CREATE TABLE [Hub].[Claims] (
  [HubClaimId] [bigint] NOT NULL CONSTRAINT [DF_Claims_HubClaim_ClaimIdValue] DEFAULT (NEXT VALUE FOR [Hub].[SequenceClaimId]),
  [LoadDateTime] [datetime] NOT NULL,
  [SourceClaimId] [bigint] NOT NULL,
  [SourceClaimGid] [uniqueidentifier] NOT NULL,
  [RecordSource] [nvarchar](50) NOT NULL,
  CONSTRAINT [PK_Claims] PRIMARY KEY CLUSTERED ([HubClaimId]),
  CONSTRAINT [KEY_Claims] UNIQUE ([SourceClaimId], [SourceClaimGid])
)
ON [PRIMARY]
GO