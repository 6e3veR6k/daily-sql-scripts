﻿CREATE TABLE [Stage].[Faces] (
  [FaceGid] [uniqueidentifier] NOT NULL,
  [Name] [nvarchar](255) NOT NULL,
  [FaceId] [bigint] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [PersonTypeID] [bigint] NOT NULL,
  [FullNameEnglish] [nvarchar](255) NULL,
  [IdentificationCode] [nvarchar](15) NULL,
  [Profession] [nvarchar](255) NULL,
  [Address] [nvarchar](255) NULL,
  [ActualAddress] [nvarchar](255) NULL,
  [PhoneNumber] [nvarchar](30) NULL,
  [Fax] [nvarchar](30) NULL,
  [AdditionalContactInfo] [nvarchar](255) NULL,
  [Email] [nvarchar](130) NULL,
  [PostAddressGID] [uniqueidentifier] NULL,
  [PostActualAddressGID] [uniqueidentifier] NULL,
  [ActivityGID] [uniqueidentifier] NULL,
  [WebAddress] [nvarchar](50) NULL,
  [PhoneNumberAdditional] [nvarchar](30) NULL,
  [MobilePhoneNumber] [nvarchar](30) NULL,
  [HomePhoneNumber] [nvarchar](30) NULL,
  [WorkPhoneNumber] [nvarchar](30) NULL,
  [FullName] [nvarchar](255) NULL,
  [ParentGID] [uniqueidentifier] NULL,
  [EDRPOU] [nvarchar](15) NULL,
  [IsResponsible] [bit] NULL,
  [Firstname] [nvarchar](50) NULL,
  [Secondname] [nvarchar](50) NULL,
  [Lastname] [nvarchar](50) NULL,
  [IsMan] [bit] NULL,
  [Birthdate] [datetime] NULL,
  [DriverFrom] [int] NULL,
  [GenitiveName] [nvarchar](255) NULL,
  [GenitivePost] [nvarchar](255) NULL,
  [Post] [nvarchar](255) NULL,
  [FaceIDN] [nvarchar](15) NULL,
  CONSTRAINT [PK_Faces_FaceGid] PRIMARY KEY NONCLUSTERED ([FaceGid]),
  CONSTRAINT [KEY_Faces_FaceId] UNIQUE CLUSTERED ([FaceId])
)
ON [PRIMARY]
GO