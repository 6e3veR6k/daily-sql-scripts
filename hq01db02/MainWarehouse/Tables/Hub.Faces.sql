CREATE TABLE [Hub].[Faces] (
  [HubFaceId] [bigint] NOT NULL,
  [FaceGid] [uniqueidentifier] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Faces_HubFaceId] PRIMARY KEY CLUSTERED ([HubFaceId]),
  CONSTRAINT [KEY_Faces_FaceGid] UNIQUE ([FaceGid])
)
ON [PRIMARY]
GO