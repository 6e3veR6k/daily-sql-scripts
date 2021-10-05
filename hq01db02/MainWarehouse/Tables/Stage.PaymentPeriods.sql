CREATE TABLE [Stage].[PaymentPeriods] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [ProductGID] [uniqueidentifier] NOT NULL,
  [PlanDate] [datetime] NOT NULL,
  [DueDate] [datetime] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [MFO] [nvarchar](6) NULL,
  [TicketNumber] [nvarchar](50) NULL,
  [Date] [datetime] NULL,
  [Sum] [decimal](18, 2) NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [StartDate] [datetime] NULL,
  [IsAdditional] [bit] NOT NULL,
  [_CreateDateTime] [datetime2] NOT NULL,
  [_ActionDateTime] [datetime2] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_PaymentPeriods_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO