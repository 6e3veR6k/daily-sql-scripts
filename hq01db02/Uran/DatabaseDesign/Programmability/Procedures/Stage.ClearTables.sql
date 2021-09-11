﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Stage].[ClearTables]
AS
BEGIN
	TRUNCATE TABLE Stage.Cases
	TRUNCATE TABLE Stage.CasesDocuments
	TRUNCATE TABLE Stage.Claims
	TRUNCATE TABLE Stage.CommissarExaminations
	TRUNCATE TABLE Stage.Documents
	TRUNCATE TABLE Stage.Payables
	TRUNCATE TABLE Stage.Products
	TRUNCATE TABLE Stage.Reservations
END
GO