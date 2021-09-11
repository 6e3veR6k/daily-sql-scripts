CREATE TABLE [Stage].[Claims] (
  [ClaimId] [int] NOT NULL,
  [ClaimGid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [ClaimerGID] [uniqueidentifier] NULL,
  [TypeGID] [uniqueidentifier] NOT NULL,
  [DateWriting] [datetime] NULL,
  [Notes] [nvarchar](255) NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [RiskGID] [uniqueidentifier] NULL,
  [InsurerGID] [uniqueidentifier] NULL,
  [InsuranceObjectGID] [uniqueidentifier] NULL,
  [RecipientGID] [uniqueidentifier] NULL,
  [ProgramTypeGID] [uniqueidentifier] NOT NULL,
  [OwnerPostAddressGID] [uniqueidentifier] NULL,
  [IsVipClient] [bit] NOT NULL,
  [InsuranceSum] [decimal](18, 2) NULL,
  CONSTRAINT [PK_Claims_ClaimGid] PRIMARY KEY NONCLUSTERED ([ClaimGid]),
  CONSTRAINT [KEY_Claims_ClaimId] UNIQUE CLUSTERED ([ClaimId])
)
ON [PRIMARY]
GO