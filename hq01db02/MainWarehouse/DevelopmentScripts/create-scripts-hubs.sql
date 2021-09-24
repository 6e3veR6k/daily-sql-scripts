GO
CREATE TABLE [Hub].[Branches]
(
    [HubBranchId] [bigint] NOT NULL,
    [BranchGid] [uniqueidentifier] NOT NULL,
    [BranchCode] [nvarchar](50) NOT NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL,
    CONSTRAINT [PK_Branches_HubBranchId] PRIMARY KEY CLUSTERED 
    ([HubBranchId] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
    CONSTRAINT [KEY_Branches_BranchGid] UNIQUE NONCLUSTERED 
    ([BranchGid] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [Hub].[Contracts]
(
    [HubContractId] [bigint] NOT NULL,
    [ContractGid] [uniqueidentifier] NOT NULL,
    [ContractNumber] [nvarchar](50) NOT NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL,
    CONSTRAINT [PK_Contracts_HubContractId] PRIMARY KEY CLUSTERED 
    ([HubContractId] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
    CONSTRAINT [KEY_Contracts_ContractGid] UNIQUE NONCLUSTERED 
    ([ContractGid] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)

CREATE TABLE [Hub].[Faces](
	[HubFaceId] [bigint] NOT NULL,
	[FaceGid] [uniqueidentifier] NOT NULL,
	[FaceID] [nvarchar](15) NOT NULL,
	[SourceRecordId] INT NOT NULL,
  [LoadDateTime] DATETIME2 NOT NULL
) 


CREATE TABLE [Hub].[Programs]
(
    [HubProgramId] [bigint] NOT NULL,
    [ProgramGid] [uniqueidentifier] NOT NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)

CREATE TABLE [Hub].[RealPayments]
(
    [HubRealPaymentId] [bigint] NOT NULL,
    [RealPaymentGid] [uniqueidentifier] NOT NULL,
    [PaymentDate] [date] NOT NULL,
    [Value] [decimal](18, 2) NOT NULL,
    [SourceRecordId] INT NOT NULL,
    [LoadDateTime] DATETIME2 NOT NULL
)


