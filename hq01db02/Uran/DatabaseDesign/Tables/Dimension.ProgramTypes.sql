CREATE TABLE [Dimension].[ProgramTypes] (
  [ProgramTypeId] [bigint] NOT NULL,
  [ProgramTypeGid] [uniqueidentifier] NOT NULL,
  [ProgramTypeName] [nvarchar](180) NOT NULL,
  [InsuranceCode] [nvarchar](10) NOT NULL,
  [InsuranceScopeName] [nvarchar](500) NOT NULL,
  CONSTRAINT [PK_ProgramTypes_ProgramTypeId] PRIMARY KEY CLUSTERED ([ProgramTypeId]),
  CONSTRAINT [KEY_ProgramTypes_ProgramTypeGid] UNIQUE ([ProgramTypeGid])
)
ON [PRIMARY]
GO