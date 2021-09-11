CREATE TABLE [Dimension].[DocumentParameterValues] (
  [DocumentParameterValueId] [bigint] NOT NULL,
  [DocumentParameterValueGID] [uniqueidentifier] NOT NULL,
  [DocumentParameterGID] [uniqueidentifier] NULL,
  [Value] [nvarchar](4000) NULL,
  CONSTRAINT [PK_DocumentParameterValues_DocumentParameterValueGID] PRIMARY KEY NONCLUSTERED ([DocumentParameterValueGID]),
  CONSTRAINT [KEY_DocumentParameterValues_DocumentParameterValueId] UNIQUE CLUSTERED ([DocumentParameterValueId])
)
ON [PRIMARY]
GO