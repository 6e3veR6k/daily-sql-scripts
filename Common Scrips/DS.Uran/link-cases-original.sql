IF OBJECT_ID('Warehouse.LoadLinks') IS NOT NULL
	SET NOEXEC ON
GO
CREATE PROCEDURE Warehouse.LoadLinks
AS RETURN;
GO
SET NOEXEC OFF
GO
ALTER PROCEDURE Warehouse.LoadLinks 
	@SourceRecordId INT, @LoadDateTime DATETIME

AS BEGIN
	SET NOCOUNT ON;

  DECLARE @SourceRecordId INT = '1' as SourceRecordId,
    '2021-09-14 12:39:10.000' AS LoadDateTime

	INSERT INTO [Warehouse].[LinkCaseOriginals]
			   ([HubCaseId]
			   ,[HubClaimId]
			   ,[HubProductId]
			   ,[SourceRecordId]
			   ,[LoadDateTime])
	SELECT
	  C.CaseId AS HubCaseId,
	  Cl.ClaimId AS HubClaimId,
	  P.HimaliaProductId AS HubProductId,
	  @SourceRecordId,
	  @LoadDateTime
	FROM Stage.Cases AS C
	INNER JOIN (
		SELECT
			C.ClaimGid,
			C.ClaimId,
			CD.CaseGID
		FROM Stage.Claims AS C
		INNER JOIN Stage.Documents AS D ON D.DocumentGid = C.ClaimGid
		INNER JOIN Stage.CasesDocuments AS CD ON CD.DocumentGID = D.DocumentGid
	) AS Cl ON Cl.CaseGID = C.CaseGid
	INNER JOIN (
		SELECT
			P.ProductGid,
			P.HimaliaProductId,
			CD.CaseGID
		FROM Stage.Products AS P
		INNER JOIN Stage.Documents AS D ON D.DocumentGid = P.ProductGid
		INNER JOIN Stage.CasesDocuments AS CD ON CD.DocumentGID = D.DocumentGid
	) AS P ON P.CaseGID = C.CaseGid	

	RETURN 0;
END
GO