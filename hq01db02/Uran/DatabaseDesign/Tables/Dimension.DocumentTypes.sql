CREATE TABLE [Dimension].[DocumentTypes] (
  [DocumentTypeId] [int] IDENTITY,
  [DocumentTypeGid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Name] [nvarchar](255) NOT NULL,
  [TemplateName] [nvarchar](50) NULL,
  [ValidationExpression] [nvarchar](255) NULL,
  [InputMessage] [nvarchar](50) NULL,
  [Note] [nvarchar](255) NULL,
  [CanBeAttachedToCase] [bit] NOT NULL,
  [CanBePrinted] [bit] NOT NULL,
  [IsRegulationCost] [bit] NOT NULL,
  [CalculationTypeGID] [uniqueidentifier] NULL,
  [PayableTypeGID] [uniqueidentifier] NULL,
  [IsRegress] [bit] NOT NULL,
  [IsReinsurance] [bit] NOT NULL,
  [IsLetter] [bit] NOT NULL,
  CONSTRAINT [PK_DocumentTypes_DocumentTypeGid] PRIMARY KEY NONCLUSTERED ([DocumentTypeGid]),
  CONSTRAINT [PK_DocumentTypes_] UNIQUE CLUSTERED ([DocumentTypeId])
)
ON [PRIMARY]
GO