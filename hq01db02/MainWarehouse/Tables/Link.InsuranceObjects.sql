CREATE TABLE [Link].[InsuranceObjects] (
  [LinkInsuranceObjectId] [bigint] IDENTITY,
  [HubObjectId] [bigint] NOT NULL,
  [HubProgramId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_InsuredObjects_LinkInsuredObjectId] PRIMARY KEY CLUSTERED ([LinkInsuranceObjectId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[InsuranceObjects]
  ADD CONSTRAINT [FK_InsuredObjects_Objects_HubObjectId] FOREIGN KEY ([HubObjectId]) REFERENCES [Hub].[Objects] ([HubObjectId])
GO

ALTER TABLE [Link].[InsuranceObjects]
  ADD CONSTRAINT [FK_InsuredObjects_Programs_HubProgramId] FOREIGN KEY ([HubProgramId]) REFERENCES [Hub].[Programs] ([HubProgramId])
GO