SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

-- =============================================
-- Author:		bezvershuk_do
-- Create date: 19.08.2021
-- Description:	
-- =============================================
CREATE PROCEDURE [Integration].[sp_GetExtractionPeriod]
	-- Add the parameters for the stored procedure here
	@tableName NVARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @sqlCommand NVARCHAR(MAX) = 'TRUNCATE TABLE ' + @tableName

	EXECUTE sp_executesql @sqlCommand

	UPDATE [Integration].[PackageExecutions] 
	--todo: change to curent timestamp  / CURRENT_TIMESTAMP
	SET CurrentExtractionDateTime = '20211004',
		UserName = SUSER_SNAME(),
		Message = 'in progress'
	WHERE  TableName = @tableName

	SELECT LastSuccessfulExtractionDatetime, CurrentExtractionDateTime
	FROM [Integration].[PackageExecutions]
	WHERE TableName = @tableName

END

GO