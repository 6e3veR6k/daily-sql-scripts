﻿CREATE TABLE [Stage].[AgentActsCommissions] (
  [id] [int] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [AgentActGID] [uniqueidentifier] NOT NULL,
  [ProductGID] [uniqueidentifier] NOT NULL,
  [PolisNumber] [nvarchar](50) NOT NULL,
  [OriginalPolisNumber] [nvarchar](50) NOT NULL,
  [ProductTypeCode] [nvarchar](50) NOT NULL,
  [ProgramTypeGID] [uniqueidentifier] NOT NULL,
  [InsuranceTypeCode] [nvarchar](10) NOT NULL,
  [RealPaymentGID] [uniqueidentifier] NOT NULL,
  [RealPaymentDate] [date] NOT NULL,
  [RealPaymentValue] [decimal](18, 2) NOT NULL,
  [PlanedPaymentDate] [datetime] NOT NULL,
  [Value] [decimal](18, 2) NOT NULL,
  [ValueType] [int] NOT NULL,
  [CommissionValue] [decimal](18, 2) NOT NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [OriginalAgentGID] [uniqueidentifier] NOT NULL,
  [BranchGID] [uniqueidentifier] NULL,
  [AgentPermissionGID] [uniqueidentifier] NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_AgentActsCommissions_id] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO