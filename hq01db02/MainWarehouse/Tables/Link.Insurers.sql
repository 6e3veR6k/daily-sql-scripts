CREATE TABLE [Link].[Insurers] (
  [LinkInsurerId] [bigint] NOT NULL,
  [HubProductId] [bigint] NOT NULL,
  [HubFaceId] [bigint] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Insurers_LinkInsurerId] PRIMARY KEY CLUSTERED ([LinkInsurerId])
)
ON [PRIMARY]
GO

ALTER TABLE [Link].[Insurers]
  ADD CONSTRAINT [FK_Insurers_Faces_HubFaceId] FOREIGN KEY ([HubFaceId]) REFERENCES [Hub].[Faces] ([HubFaceId])
GO

ALTER TABLE [Link].[Insurers]
  ADD CONSTRAINT [FK_Insurers_Products_HubProductId] FOREIGN KEY ([HubProductId]) REFERENCES [Hub].[Products] ([HubProductId])
GO