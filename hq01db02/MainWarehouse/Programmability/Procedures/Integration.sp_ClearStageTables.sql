SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Integration].[sp_ClearStageTables]
AS
BEGIN

	DECLARE @sqlCommand NVARCHAR(4000) = (SELECT 'TRUNCATE TABLE ' + P.TableName + ';' AS 'data()'
	FROM Integration.PackageExecutions AS P
	FOR XML PATH('')
	)

	EXECUTE sp_executesql @sqlCommand

END
GO