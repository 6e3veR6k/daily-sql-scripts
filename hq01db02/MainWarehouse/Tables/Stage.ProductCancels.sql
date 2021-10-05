CREATE TABLE [Stage].[ProductCancels] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [ProductCancelActGID] [uniqueidentifier] NULL,
  [CancelDate] [date] NOT NULL,
  [OnDealSum] [decimal](18, 2) NOT NULL,
  [ReturnSum] [decimal](18, 2) NOT NULL,
  [PlanedPaymentRest] [decimal](18, 2) NOT NULL,
  [ProductCancelTypeGID] [uniqueidentifier] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [LastModifiedAuthorGID] [uniqueidentifier] NULL,
  [LastModifiedDate] [datetime] NULL,
  [CalculatedReturnSum] [decimal](18, 2) NOT NULL,
  [CreatorUserGID] [uniqueidentifier] NOT NULL,
  [CreateDate] [datetime] NOT NULL,
  [StatusGID] [uniqueidentifier] NOT NULL,
  [RepresentativeGID] [uniqueidentifier] NULL,
  [WorkflowGID] [uniqueidentifier] NULL,
  [RepresentativeName] [nvarchar](255) NULL,
  [RepresentativePersonTypeID] [bigint] NULL,
  [_CreateDateTime] [datetime2] NOT NULL,
  [_ActionDateTime] [datetime2] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ProductCancels_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO