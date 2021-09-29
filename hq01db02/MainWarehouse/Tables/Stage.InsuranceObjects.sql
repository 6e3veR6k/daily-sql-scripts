CREATE TABLE [Stage].[InsuranceObjects] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [ObjectCategory] [nvarchar](50) NULL,
  [ProgramGID] [uniqueidentifier] NOT NULL,
  [InsuranceObjectTypeGID] [uniqueidentifier] NOT NULL,
  [Comment] [nvarchar](255) NULL,
  [ObjectTypeGID] [uniqueidentifier] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [InsuranceSum] [decimal](18, 2) NULL,
  [InsurancePayment] [decimal](18, 2) NULL,
  [InsuranceRate] [decimal](18, 10) NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [ObjectGID] [uniqueidentifier] NULL,
  [Name] [nvarchar](900) NULL,
  [CalculatedInsuranceRate] [decimal](18, 10) NULL,
  [CalculatedPayment] [decimal](18, 2) NULL,
  [ParentInsuranceObjectGID] [uniqueidentifier] NULL,
  [TotalInsuranceSum] [decimal](18, 2) NULL,
  [EntityCostValueGID] [uniqueidentifier] NULL,
  [LastModifiedObjectDate] [datetime] NULL,
  [InsurancePaymentInCurrency] [decimal](18, 2) NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_InsuranceObjects_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO