SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

-- =============================================
-- Author:		ORANTA\bezvershuk_do
-- Create date: 20.08.2021
-- Description:	
-- =============================================
CREATE PROCEDURE [Integration].[spSetStartExtractionPeriod] 
	-- Add the parameters for the stored procedure here
	@StartPeriod datetime = '20210101'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Integration].[PackageExecutions]
	SET LastSuccessfulExtractionDatetime =  @StartPeriod
END
GO