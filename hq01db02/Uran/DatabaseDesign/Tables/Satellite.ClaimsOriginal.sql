CREATE TABLE [Satellite].[ClaimsOriginal] (
  [ClaimsOriginalId] [int] NOT NULL DEFAULT (NEXT VALUE FOR [Satellite].[SequenceClaimsOriginalId]),
  [HubClaimId] [int] NOT NULL,
  [LoadDateTime] [datetime] NOT NULL,
  [ClaimerGID] [uniqueidentifier] NULL,
  [TypeGID] [uniqueidentifier] NOT NULL,
  [RiskGID] [uniqueidentifier] NULL,
  [DateWriting] [datetime] NULL,
  [InsurerGID] [uniqueidentifier] NULL,
  [InsuranceObjectGID] [uniqueidentifier] NULL,
  [RecipientGID] [uniqueidentifier] NULL,
  [ProgramTypeGID] [uniqueidentifier] NOT NULL,
  [OwnerPostAddressGID] [uniqueidentifier] NULL,
  [IsVipClient] [bit] NOT NULL,
  [InsuranceSum] [decimal](18, 2) NULL,
  [Notes] [nvarchar](255) NULL,
  [AuthorGID] [uniqueidentifier] NOT NULL,
  [RecordSource] [nvarchar](50) NOT NULL,
  CONSTRAINT [PK_ClaimsOriginal] PRIMARY KEY CLUSTERED ([ClaimsOriginalId])
)
ON [PRIMARY]
GO