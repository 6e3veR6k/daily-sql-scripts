CREATE TABLE [Integration].[PackageExecutionsHistory] (
  [PackageExecutionId] [int] NOT NULL,
  [UserName] [nvarchar](100) NOT NULL,
  [LastSuccessfulExtractionDatetime] [datetime2] NOT NULL,
  [CurrentExtractionDateTime] [datetime2] NOT NULL,
  [TableName] [nvarchar](255) NOT NULL,
  [Message] [nvarchar](255) NOT NULL,
  [ValidFrom] [datetime2] NOT NULL,
  [ValidTo] [datetime2] NOT NULL
)
ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [ix_PackageExecutionsHistory]
  ON [Integration].[PackageExecutionsHistory] ([ValidTo], [ValidFrom])
  ON [PRIMARY]
GO