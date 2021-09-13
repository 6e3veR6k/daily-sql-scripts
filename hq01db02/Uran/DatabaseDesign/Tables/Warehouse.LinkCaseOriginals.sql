CREATE TABLE [Warehouse].[LinkCaseOriginals] (
  [LinkCaseOriginalId] [bigint] IDENTITY,
  [HubCaseId] [bigint] NOT NULL,
  [HubClaimId] [bigint] NOT NULL,
  [HubProductId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime] NOT NULL,
  CONSTRAINT [PK_LinkCaseOriginals_LinkCaseOriginalId] PRIMARY KEY CLUSTERED ([LinkCaseOriginalId])
)
ON [PRIMARY]
GO

ALTER TABLE [Warehouse].[LinkCaseOriginals]
  ADD CONSTRAINT [FK_LinkCaseOriginals_HubCases_HubCaseId] FOREIGN KEY ([HubCaseId]) REFERENCES [Warehouse].[HubCases] ([HubCaseId])
GO

ALTER TABLE [Warehouse].[LinkCaseOriginals]
  ADD CONSTRAINT [FK_LinkCaseOriginals_HubClaims_HubClaimId] FOREIGN KEY ([HubClaimId]) REFERENCES [Warehouse].[HubClaims] ([HubClaimId])
GO

ALTER TABLE [Warehouse].[LinkCaseOriginals]
  ADD CONSTRAINT [FK_LinkCaseOriginals_HubProducts_HubProductId] FOREIGN KEY ([HubProductId]) REFERENCES [Warehouse].[HubProducts] ([HubProductId])
GO