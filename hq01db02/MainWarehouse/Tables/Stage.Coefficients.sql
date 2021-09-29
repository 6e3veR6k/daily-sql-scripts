CREATE TABLE [Stage].[Coefficients] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [ProgramGID] [uniqueidentifier] NULL,
  [Value] [decimal](18, 4) NOT NULL,
  [Deleted] [bit] NOT NULL,
  [ProgramCoefficientGID] [uniqueidentifier] NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [CalculatedValue] [decimal](18, 4) NULL,
  [InsuranceObjectGID] [uniqueidentifier] NULL,
  [IsFixed] [bit] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Coefficients_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO