CREATE TABLE [Stage].[ClaimToParameterValues] (
  [ClaimToParameterValueId] [bigint] NOT NULL,
  [ClaimToParameterValueGID] [uniqueidentifier] NOT NULL,
  [ClaimGID] [uniqueidentifier] NOT NULL,
  [ParameterValue] [nvarchar](max) NOT NULL,
  [ParameterGID] [uniqueidentifier] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  CONSTRAINT [PK_ClaimToParameterValues_ClaimToParameterValueGID] PRIMARY KEY NONCLUSTERED ([ClaimToParameterValueGID]),
  CONSTRAINT [KEY_ClaimToParameterValues_ClaimToParameterValueId] UNIQUE CLUSTERED ([ClaimToParameterValueId])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO