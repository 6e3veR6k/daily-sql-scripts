USE [MainWarehouse]
GO

/****** Object:  Table [Satellite].[MainProductsData]    Script Date: 22.09.2021 12:54:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Satellite].[MainProductsData]') AND type in (N'U'))
DROP TABLE [Satellite].[MainProductsData]
GO


CREATE TABLE [Satellite].[MainProductsData](
	[MainProductsDataId] [bigint] NOT NULL,
	[HubProductId] [bigint] NOT NULL,

  [PolisNumber] [nvarchar](50) NOT NULL,
  [RegisteredDate] [date] NOT NULL,
  [BeginingDate] [datetime] NOT NULL,
  [EndingDate] [datetime] NOT NULL,
  [AgentReportDate] [datetime] NULL,
  [AgentReportNumber] [nvarchar](50) NULL,
  [Deleted] [bit] NOT NULL,

	[SourceRecordId] [int] NOT NULL,
	[LoadDateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_MainProductsData_MainProductsDataId] PRIMARY KEY CLUSTERED 
(
	[MainProductsDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[Products] (

  [ProductTypeGID] [uniqueidentifier] NOT NULL,


  [BranchGID] [uniqueidentifier] NOT NULL,

  [ResponsibleGID] [uniqueidentifier] NOT NULL,

  [Number] [nvarchar](50) NULL,

  [IsProlonged] [bit] NULL,
  [IsAction] [bit] NULL,


  [DurationUnitGID] [uniqueidentifier] NULL,


  [InsurerGID] [uniqueidentifier] NOT NULL,
  [InsuranceSumUkr] [decimal](18, 2) NULL,
  [Comment] [nvarchar](255) NULL,
   CONSTRAINT [DF_Products_Deleted] DEFAULT (0),
  [SupplementaryAgreementTypeGID] [uniqueidentifier] NULL,

  [BaseProductGID] [uniqueidentifier] NULL,
  [ContractGID] [uniqueidentifier] NULL,

  [SourceTypeGID] [uniqueidentifier] NOT NULL,
  [StatusGID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Products_StatusGID] DEFAULT (N'805C973D-FE3F-44A3-8229-8CF3A29CCD23'),

  [IsEditable] [bit] NULL,
  [IsFull] [bit] NOT NULL CONSTRAINT [DF_Products_IsFull] DEFAULT (0),

  [LastModifiedAuthorGID] [uniqueidentifier] NULL,

  [ProductActionGID] [uniqueidentifier] NULL,
  [ProductPartnerActionGID] [uniqueidentifier] NULL,

  [CreatorUserGID] [uniqueidentifier] NULL,

  [AuthorGID] [uniqueidentifier] NULL CONSTRAINT [DF_Products_Author] DEFAULT ([dbo].[GetAuthor]()),

  [CreateDate] [datetime] NULL,
  [LastModifiedDate] [datetime] NULL,

  [SalesChannelGID] [uniqueidentifier] NULL,

  [EntranceIntoForceGID] [uniqueidentifier] NULL,
  [IsInwardsReinsurance] [bit] NOT NULL CONSTRAINT [DF_Products_IsReinsurance] DEFAULT (0),
  [BasePayment] [decimal](18, 2) NULL,
  [IsReinsured] [bit] NULL,
  [ReinsurancePolisNumber] [nvarchar](50) NULL,
  [SelectDate] [datetime] NULL,
  [OnSaveDate] [datetime] NULL,
  [WorkflowGID] [uniqueidentifier] NULL,
  [OwnerGID] [uniqueidentifier] NULL,
  [DealGID] [uniqueidentifier] NULL,
  [SubSalesChannelGID] [uniqueidentifier] NULL,
  [BasedOnProductGID] [uniqueidentifier] NULL,
  [InsurerFaceGID] [uniqueidentifier] NOT NULL,
  [InsurerFacePersonTypeID] [bigint] NOT NULL,
  [InsurerFaceName] [nvarchar](255) NOT NULL,
  CONSTRAINT [PK_Products] PRIMARY KEY NONCLUSTERED ([gid]) WITH (PAD_INDEX = ON)
)
