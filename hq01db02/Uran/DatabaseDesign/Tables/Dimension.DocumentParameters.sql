CREATE TABLE [Dimension].[DocumentParameters] (
  [DocumentParameterId] [bigint] NOT NULL,
  [DocumentParameterGID] [uniqueidentifier] NOT NULL,
  [Name] [nvarchar](255) NOT NULL,
  [ValueTypeGID] [uniqueidentifier] NOT NULL,
  CONSTRAINT [PK_DocumentParameters_DocumentParameterGID] PRIMARY KEY NONCLUSTERED ([DocumentParameterGID]),
  CONSTRAINT [KEY_DocumentParameters_DocumentParameterId] UNIQUE CLUSTERED ([DocumentParameterId])
)
ON [PRIMARY]
GO