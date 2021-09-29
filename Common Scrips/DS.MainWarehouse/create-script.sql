/**********************************************************************************
* This is a concatenation of all the selected files, including files in subfolders.
* The start and end of each file contains a comment with its name, as well as a
* print statement.
* Generated at: Tue Sep 21 2021 14:21:18 GMT+0300 (Восточная Европа, летнее время) 
***********************************************************************************
* These are the line numbers for the included files:
* 28		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[BRANCHES].SQL
* 56		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[COEFFICIENTS].SQL
* 84		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[CONTRACTS].SQL
* 128		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[COVERS].SQL
* 155		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FACES].SQL
* 180		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FRANCHISEPARAMETERS].SQL
* 205		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FRANCHISES].SQL
* 231		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[INSURANCEOBJECTS].SQL
* 269		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PAYMENTPERIODS].SQL
* 300		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PLANEDPAYMENTS].SQL
* 325		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PLANEDTOREALPAYMENTS].SQL
* 349		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTCANCELACTS].SQL
* 375		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTCANCELS].SQL
* 412		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTS].SQL
* 479		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTTOPRODUCTPERMISSIONS].SQL
* 502		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PROGRAMS].SQL
* 533		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PROGRAMTOPARAMETERVALUES].SQL
* 559		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[REALPAYMENTS].SQL
* 587		C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[SIGNERS].SQL
***********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[BRANCHES].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[BRANCHES].SQL'
GO
CREATE TABLE [Stage].[Branches]
(
    [Id] [bigint] NOT NULL,
    [GID] [uniqueidentifier] NOT NULL,
    [hid] [hierarchyid] NULL,
    [Name] [nvarchar](255) NOT NULL,
    [BranchCode] [nvarchar](50) NULL,
    [ParentGID] [uniqueidentifier] NULL,
    [ControlBlanks] [bit] NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [BranchCodeLen] INT NOT NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
) ON [PRIMARY]
GO

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[BRANCHES].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[BRANCHES].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[COEFFICIENTS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[COEFFICIENTS].SQL'
GO
CREATE TABLE [Stage].[Coefficients]
(
    [Id] [bigint] NOT NULL,
    [GID] [uniqueidentifier] NOT NULL,
    [ProgramGID] [uniqueidentifier] NULL,
    [Value] [decimal](18, 4) NOT NULL,
    [Deleted] [bit] NOT NULL,
    [ProgramCoefficientGID] [uniqueidentifier] NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [CalculatedValue] [decimal](18, 4) NULL,
    [InsuranceObjectGID] [uniqueidentifier] NULL,
    [IsFixed] [bit] NOT NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[COEFFICIENTS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[COEFFICIENTS].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[CONTRACTS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[CONTRACTS].SQL'
GO
CREATE TABLE [Stage].[Contracts]
(
    [Id] [bigint] NOT NULL,
    [GID] [uniqueidentifier] NOT NULL,
    [ContragentGID] [uniqueidentifier] NOT NULL,
    [ContractNumber] [nvarchar](50) NOT NULL,
    [BranchGID] [uniqueidentifier] NOT NULL,
    [ContractTypeGID] [uniqueidentifier] NULL,
    [BeginDate] [date] NULL,
    [EndDate] [date] NULL,
    [Sum] [decimal](18, 2) NULL,
    [ResponsibleGID] [uniqueidentifier] NULL,
    [Deleted] [bit] NOT NULL,
    [Comment] [nvarchar](255) NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [CreateDate] [datetime] NULL,
    [CreatorUserGID] [uniqueidentifier] NULL,
    [LastModifiedDate] [datetime] NULL,
    [LastModifiedAuthorGID] [uniqueidentifier] NULL,
    [WorkflowGID] [uniqueidentifier] NULL,
    [StatusGID] [uniqueidentifier] NOT NULL,
    [ObjectsCount] [int] NULL,
    [ParentGID] [uniqueidentifier] NULL,
    [OwnerGID] [uniqueidentifier] NULL,
    [SalesChannelGID] [uniqueidentifier] NULL,
    [SubSalesChannelGID] [uniqueidentifier] NULL,
    [AgentPermissionGID] [uniqueidentifier] NULL,
    [RegisteredDate] [date] NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[CONTRACTS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[CONTRACTS].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[COVERS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[COVERS].SQL'
GO
CREATE TABLE [Stage].[Covers]
(
    [id] [bigint] NOT NULL,
    [gid] [uniqueidentifier] NOT NULL,
    [InsuredObjectGID] [uniqueidentifier] NOT NULL,
    [RiskGID] [uniqueidentifier] NOT NULL,
    [CoverLimit] [decimal](18, 2) NULL,
    [Deleted] [bit] NOT NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [Rate] [decimal](18, 10) NULL,
    [Payment] [decimal](18, 2) NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[COVERS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[COVERS].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FACES].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FACES].SQL'
GO
CREATE TABLE [Stage].[Faces]
(
    [Id] [bigint] NOT NULL,
    [GID] [uniqueidentifier] NOT NULL,
    [PersonTypeID] [bigint] NOT NULL,
    [Name] [nvarchar](255) NOT NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

GO

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FACES].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FACES].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FRANCHISEPARAMETERS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FRANCHISEPARAMETERS].SQL'
GO
CREATE TABLE [Stage].[FranchiseParameters]
(
    [Id] [bigint] NOT NULL,
    [GID] [uniqueidentifier] NOT NULL,
    [FranchiseGID] [uniqueidentifier] NOT NULL,
    [FranchiseTypeParameterGID] [uniqueidentifier] NOT NULL,
    [Value] [sql_variant] NOT NULL,
    [Deleted] [bit] NOT NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FRANCHISEPARAMETERS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FRANCHISEPARAMETERS].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FRANCHISES].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FRANCHISES].SQL'
GO
CREATE TABLE [Stage].[Franchises]
(
    [id] [bigint] NOT NULL,
    [gid] [uniqueidentifier] NOT NULL,
    [FranchiseTypeGID] [uniqueidentifier] NOT NULL,
    [FranchiseValue] [sql_variant] NOT NULL,
    [CoverGID] [uniqueidentifier] NOT NULL,
    [Conditional] [int] NOT NULL,
    [Deleted] [bit] NOT NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FRANCHISES].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[FRANCHISES].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[INSURANCEOBJECTS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[INSURANCEOBJECTS].SQL'
GO
CREATE TABLE [Stage].[InsuranceObjects]
(
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
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)
GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[INSURANCEOBJECTS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[INSURANCEOBJECTS].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PAYMENTPERIODS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PAYMENTPERIODS].SQL'
GO
CREATE TABLE [Stage].[PaymentPeriods]
(
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
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PAYMENTPERIODS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PAYMENTPERIODS].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PLANEDPAYMENTS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PLANEDPAYMENTS].SQL'
GO
CREATE TABLE [Stage].[PlanedPayments]
(
    [Id] [bigint] NOT NULL,
    [gid] [uniqueidentifier] NOT NULL,
    [ProgramGID] [uniqueidentifier] NOT NULL,
    [PaymentPeriodGID] [uniqueidentifier] NOT NULL,
    [Value] [decimal](18, 2) NOT NULL,
    [Deleted] [bit] NOT NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PLANEDPAYMENTS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PLANEDPAYMENTS].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PLANEDTOREALPAYMENTS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PLANEDTOREALPAYMENTS].SQL'
GO
CREATE TABLE [Stage].[PlanedToRealPayments]
(
    [Id] [bigint] NOT NULL,
    [GID] [uniqueidentifier] NOT NULL,
    [PlanedPaymentGID] [uniqueidentifier] NOT NULL,
    [RealPaymentGID] [uniqueidentifier] NOT NULL,
    [Value] [decimal](18, 2) NOT NULL,
    [Deleted] [bit] NOT NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)
GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PLANEDTOREALPAYMENTS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PLANEDTOREALPAYMENTS].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTCANCELACTS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTCANCELACTS].SQL'
GO
CREATE TABLE [Stage].[ProductCancelActs]
(
    [Id] [bigint] NOT NULL,
    [GID] [uniqueidentifier] NOT NULL,
    [ActNum] [nvarchar](50) NOT NULL,
    [BranchGID] [uniqueidentifier] NOT NULL,
    [SignDate] [date] NOT NULL,
    [ProductCancelTypeGID] [uniqueidentifier] NOT NULL,
    [Deleted] [bit] NOT NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTCANCELACTS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTCANCELACTS].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTCANCELS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTCANCELS].SQL'
GO
CREATE TABLE [Stage].[ProductCancels]
(
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
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)
GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTCANCELS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTCANCELS].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTS].SQL'
GO
CREATE TABLE [Stage].[Products]
(
    [Id] [bigint] NOT NULL,
    [GID] [uniqueidentifier] NOT NULL,
    [ProductTypeGID] [uniqueidentifier] NOT NULL,
    [PolisNumber] [nvarchar](50) NOT NULL,
    [BranchGID] [uniqueidentifier] NOT NULL,
    [ResponsibleGID] [uniqueidentifier] NOT NULL,
    [Number] [nvarchar](50) NULL,
    [IsProlonged] [bit] NULL,
    [IsAction] [bit] NULL,
    [BeginingDate] [datetime] NOT NULL,
    [EndingDate] [datetime] NOT NULL,
    [RegisteredDate] [date] NOT NULL,
    [DurationUnitGID] [uniqueidentifier] NULL,
    [AgentReportDate] [datetime] NULL,
    [AgentReportNumber] [nvarchar](50) NULL,
    [InsurerGID] [uniqueidentifier] NOT NULL,
    [InsuranceSumUkr] [decimal](18, 2) NULL,
    [Comment] [nvarchar](255) NULL,
    [Deleted] [bit] NOT NULL,
    [SupplementaryAgreementTypeGID] [uniqueidentifier] NULL,
    [BaseProductGID] [uniqueidentifier] NULL,
    [ContractGID] [uniqueidentifier] NULL,
    [SourceTypeGID] [uniqueidentifier] NOT NULL,
    [StatusGID] [uniqueidentifier] NOT NULL,
    [IsEditable] [bit] NULL,
    [IsFull] [bit] NOT NULL,
    [LastModifiedAuthorGID] [uniqueidentifier] NULL,
    [ProductActionGID] [uniqueidentifier] NULL,
    [ProductPartnerActionGID] [uniqueidentifier] NULL,
    [CreatorUserGID] [uniqueidentifier] NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [CreateDate] [datetime] NULL,
    [LastModifiedDate] [datetime] NULL,
    [SalesChannelGID] [uniqueidentifier] NULL,
    [EntranceIntoForceGID] [uniqueidentifier] NULL,
    [IsInwardsReinsurance] [bit] NOT NULL,
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
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTS].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTTOPRODUCTPERMISSIONS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTTOPRODUCTPERMISSIONS].SQL'
GO
CREATE TABLE [Stage].[ProductToProductPermissions]
(
    [Id] [bigint] NOT NULL,
    [GID] [uniqueidentifier] NOT NULL,
    [ProductGID] [uniqueidentifier] NOT NULL,
    [ProductPermissionGID] [uniqueidentifier] NOT NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTTOPRODUCTPERMISSIONS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PRODUCTTOPRODUCTPERMISSIONS].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PROGRAMS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PROGRAMS].SQL'
GO
CREATE TABLE [Stage].[Programs]
(
    [Id] [bigint] NOT NULL,
    [GID] [uniqueidentifier] NOT NULL,
    [ProductGID] [uniqueidentifier] NOT NULL,
    [ProgramTypeGID] [uniqueidentifier] NOT NULL,
    [CostValue] [decimal](18, 2) NOT NULL,
    [InsuranceRate] [decimal](18, 10) NULL,
    [Deleted] [bit] NOT NULL,
    [CalculatedPayment] [decimal](18, 2) NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [CalculatedInsuranceRate] [decimal](18, 10) NULL,
    [CurrencyGID] [uniqueidentifier] NULL,
    [CurrencyExchangeCost] [decimal](10, 7) NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)


GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PROGRAMS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PROGRAMS].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PROGRAMTOPARAMETERVALUES].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PROGRAMTOPARAMETERVALUES].SQL'
GO
CREATE TABLE [Stage].[ProgramToParameterValues]
(
    [Id] [bigint] NOT NULL,
    [GID] [uniqueidentifier] NOT NULL,
    [ProgramGID] [uniqueidentifier] NOT NULL,
    [ParameterValue] [sql_variant] NOT NULL,
    [ParameterGID] [uniqueidentifier] NOT NULL,
    [Deleted] [bit] NOT NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [ParameterValueGUIDKey] [uniqueidentifier] NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PROGRAMTOPARAMETERVALUES].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[PROGRAMTOPARAMETERVALUES].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[REALPAYMENTS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[REALPAYMENTS].SQL'
GO
CREATE TABLE [Stage].[RealPayments]
(
    [Id] [bigint] NOT NULL,
    [GID] [uniqueidentifier] NOT NULL,
    [PaymentDate] [date] NOT NULL,
    [Value] [decimal](18, 2) NOT NULL,
    [Comment] [nvarchar](500) NULL,
    [IsCommission] [bit] NOT NULL,
    [Deleted] [bit] NOT NULL,
    [IsAutomatic] [bit] NOT NULL,
    [SourceTypeGID] [uniqueidentifier] NOT NULL,
    [AuthorGID] [uniqueidentifier] NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[REALPAYMENTS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[REALPAYMENTS].SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[SIGNERS].SQL
**********************************************************************************/
print 'Start: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[SIGNERS].SQL'
GO
CREATE TABLE [Stage].[Signers]
(
    [Id] [bigint] NOT NULL,
    [gid] [uniqueidentifier] NOT NULL,
    [FaceGID] [uniqueidentifier] NOT NULL,
    [RepresentativeGID] [uniqueidentifier] NULL,
    [AccountGID] [uniqueidentifier] NULL,
    [DocumentGID] [uniqueidentifier] NULL,
    [Deleted] [bit] NOT NULL,
    [AuthorGID] [uniqueidentifier] NOT NULL,
    [FaceDocumentGID] [uniqueidentifier] NULL,
    [LastModifiedFaceDate] [datetime] NULL,
    [LastModifiedRepresentativeDate] [datetime] NULL,
    [FaceName] [nvarchar](255) NOT NULL,
    [RepresentativeName] [nvarchar](255) NULL,
    [FacePersonTypeID] [bigint] NOT NULL,
    [RepresentativePersonTypeID] [bigint] NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

GO
/*********************************************************************************
* End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[SIGNERS].SQL
**********************************************************************************/
print 'End: C:\USERS\BEZVERSHUK_DO.ORANTA\DOCUMENTS\GITHUB\DAILY-SQL-SCRIPTS\HQ01DB02\MAINWAREHOUSE\DEVELOPMENTSCRIPTS\[STAGE].[SIGNERS].SQL'
GO
/*********************************************************************************/