CREATE TABLE [Stage].[Reservations] (
  [ReservationId] [bigint] NOT NULL,
  [ReservationGid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Amount] [decimal](18, 2) NOT NULL,
  [PreviousDamageAmount] [decimal](18, 2) NULL,
  [CreateUserGID] [uniqueidentifier] NOT NULL,
  [CreateDate] [datetime] NOT NULL,
  [CalculationTypeGID] [uniqueidentifier] NOT NULL,
  [CurrencyTypeGID] [uniqueidentifier] NOT NULL,
  [AmountHRN] [decimal](18, 2) NULL,
  [AmountEuro] [decimal](18, 2) NULL,
  [CaseGID] [uniqueidentifier] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [ClaimDate] [datetime] NULL,
  [EndingDate] [datetime] NULL,
  [ParentGID] [uniqueidentifier] NULL,
  [DocumentGID] [uniqueidentifier] NULL,
  [ParentDocumentGID] [uniqueidentifier] NULL,
  [LastModifiedDate] [datetime] NULL,
  [LastModifiedAuthorGID] [uniqueidentifier] NULL,
  [ExportDate] [datetime] NULL,
  [DoNotExport] [bit] NOT NULL,
  [Deleted] [bit] NOT NULL,
  CONSTRAINT [PK_Reservations_ReservationGid] PRIMARY KEY NONCLUSTERED ([ReservationGid]),
  CONSTRAINT [KEY_Reservations_ReservationId] UNIQUE CLUSTERED ([ReservationId])
)
ON [PRIMARY]
GO