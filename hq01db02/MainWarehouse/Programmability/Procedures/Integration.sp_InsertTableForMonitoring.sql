SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		bezvershuk_do
-- Create date: 19.08.2021
-- Description:	
-- =============================================
CREATE PROCEDURE [Integration].[sp_InsertTableForMonitoring] 
	-- Add the parameters for the stored procedure here
	(
		@tableName NVARCHAR(50) = NULL,
		@userName NVARCHAR(50) = NULL
	)
AS
BEGIN
	SET NOCOUNT ON;


	MERGE [Integration].[PackageExecutions] AS tg
	USING (SELECT COALESCE(@userName, SUSER_SNAME()), CAST('20100101' AS DATETIME2(7)), CAST('20100101' AS DATETIME2(7)), @tableName, 'new') 
		AS src ([UserName], [LastSuccessfulExtractionDatetime], [CurrentExtractionDateTime], [TableName], [Message])
		ON (tg.TableName = src.TableName)
	WHEN MATCHED THEN
		UPDATE SET 
			[UserName] = src.[UserName],
			[LastSuccessfulExtractionDatetime] = src.[LastSuccessfulExtractionDatetime],
			[CurrentExtractionDateTime] = src.[CurrentExtractionDateTime], 
			[Message] = src.[Message]
	WHEN NOT MATCHED THEN
		INSERT ([UserName], [LastSuccessfulExtractionDatetime], [CurrentExtractionDateTime], [TableName], [Message])
		VALUES (src.UserName, src.LastSuccessfulExtractionDatetime, src.CurrentExtractionDateTime, src.TableName, src.[Message]);
END
GO