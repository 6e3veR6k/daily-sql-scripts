CREATE TABLE [Integration].[PackageExecutions] (
  [PackageExecutionId] [int] IDENTITY,
  [UserName] [nvarchar](100) NOT NULL,
  [LastSuccessfulExtractionDatetime] [datetime2] NOT NULL,
  [CurrentExtractionDateTime] [datetime2] NOT NULL,
  [TableName] [nvarchar](255) NOT NULL,
  [Message] [nvarchar](255) NOT NULL,
  [ValidFrom] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL,
  [ValidTo] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL,
  PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo),
  CONSTRAINT [PK_PackageExecutions_PackageExecutionId] PRIMARY KEY CLUSTERED ([PackageExecutionId] DESC)
)
ON [PRIMARY]
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = [Integration].[PackageExecutionsHistory], DATA_CONSISTENCY_CHECK = ON))
GO