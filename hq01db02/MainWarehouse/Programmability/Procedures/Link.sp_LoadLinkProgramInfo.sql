SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


-- =============================================
-- Author:		bezvershuk_do
-- Create date: 27.09.2021
-- Description:	
-- =============================================
CREATE PROCEDURE [Link].[sp_LoadLinkProgramInfo] 
	@SourceRecordId int = 1, 
	@LoadDateTime datetime2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF @LoadDateTime IS NULL SET @LoadDateTime = CURRENT_TIMESTAMP;

	INSERT INTO [Link].[ProgramInfo]
			   ([LinkProgramInfoId]
			   ,[HubProgramId]
			   ,[HubProgramTypeId]
			   ,[SourceRecordId]
			   ,[LoadDateTime])
	SELECT
		NEXT VALUE FOR [Link].[sq_ProgramInfo] AS LinkProgramInfoId,
		fh.HubProgramId AS HubProgramId,
		sh.HubProgramTypeId AS HubProgramTypeId,
		@SourceRecordId AS SourceRecordId,
		@LoadDateTime
	FROM Stage.Programs AS src
	LEFT JOIN Hub.Programs AS fh ON fh.HubProgramId = src.Id
	LEFT JOIN Hub.ProgramTypes AS sh ON sh.ProgramTypeGid = src.ProgramTypeGID 
	WHERE NOT EXISTS 
		(SELECT 1 FROM [Link].[ProgramInfo] AS trg 
		WHERE 
			trg.HubProgramId = fh.HubProgramId AND 
			trg.HubProgramTypeId = sh.HubProgramTypeId)

END
GO