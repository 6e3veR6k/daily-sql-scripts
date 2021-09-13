CREATE TABLE [Link].[ClaimCases] (
  [LinkClaimCaseId] [bigint] NOT NULL CONSTRAINT [DF_LinkClaimCases_ClaimCaseId] DEFAULT (NEXT VALUE FOR [Link].[SequenceClaimCaseId]),
  [LoadDateTime] [datetime] NOT NULL,
  [RecordSource] [nvarchar](50) NOT NULL,
  [HubCaseId] [bigint] NOT NULL,
  [HubClaimId] [bigint] NOT NULL,
  [HubProductId] [bigint] NOT NULL,
  CONSTRAINT [PK_ClaimCases] PRIMARY KEY CLUSTERED ([LinkClaimCaseId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[ClaimCases]
  ADD CONSTRAINT [FK_ClaimCases_Cases_HubCaseId] FOREIGN KEY ([HubCaseId]) REFERENCES [Hub].[Cases] ([HubCaseId])
GO

ALTER TABLE [Link].[ClaimCases]
  ADD CONSTRAINT [FK_ClaimCases_Claims_HubClaimId] FOREIGN KEY ([HubClaimId]) REFERENCES [Hub].[Claims] ([HubClaimId])
GO

ALTER TABLE [Link].[ClaimCases]
  ADD CONSTRAINT [FK_ClaimCases_Products_HubProductId] FOREIGN KEY ([HubProductId]) REFERENCES [Hub].[Products] ([HubProductId])
GO