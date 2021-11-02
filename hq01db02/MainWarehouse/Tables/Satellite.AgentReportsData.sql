CREATE TABLE [Satellite].[AgentReportsData] (
  [HubProductId] [bigint] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  [AgentReportDate] [date] NULL,
  [AgentReportNumber] [nvarchar](50) NULL,
  [SourceRecordId] [int] NOT NULL,
  CONSTRAINT [PK_AgentReportsData] PRIMARY KEY CLUSTERED ([HubProductId], [LoadDateTime])
)
ON [PRIMARY]
GO

ALTER TABLE [Satellite].[AgentReportsData]
  ADD CONSTRAINT [FK_AgentReportsData_Products_HubProductId] FOREIGN KEY ([HubProductId]) REFERENCES [Hub].[Products] ([HubProductId])
GO