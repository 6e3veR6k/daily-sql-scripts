/*
;WITH ReservCTE AS (
SELECT
	R.id,
	R.Amount,
	R.CreateDate,
	CT.Name,
	R.CaseGID,
	R.ClaimDate,
	R.EndingDate,
	R.ParentGID,
	R.DocumentGID,
	R.ParentDocumentGID,
	R.LastModifiedDate,
	R.ExportDate
FROM Oberon.dbo.Reservations AS R
INNER JOIN Oberon.meta.ReservationCalculationTypes AS CT ON CT.gid = R.CalculationTypeGID
WHERE R.Deleted = 0
)







SELECT
	--C.id AS CaseId,
	--C.Number AS CaseNumber, 
	--D.Number AS ActNumber,
	--D.id AS ActId,
	--R.ClaimDate AS ActCalcDate,
	--D.AddDate AS ActDate, -- clarify date
	--P.gid AS ProductGid,
	--P.BranchGID AS PolisBranch, -- or caseBranch?
	----дата відмови?
	CDD.*,
	DT.*
FROM dbo.Cases AS C
INNER JOIN dbo.CasesDocuments AS CD ON CD.CaseGID = C.gid 
INNER JOIN dbo.Documents AS CDD ON CDD.gid = CD.DocumentGID 
INNER JOIN meta.DocumentTypes AS DT ON DT.gid = CDD.TypeGID
--INNER JOIN dbo.Products AS P ON P.gid = CDD.gid


--INNER JOIN ReservCTE AS R ON R.CaseGID = C.gid
--INNER JOIN dbo.Documents AS D ON D.gid = R.DocumentGID
--INNER JOIN meta.DocumentTypes AS DT ON DT.gid = D.TypeGID
--INNER JOIN meta.PayableTypes AS PT ON PT.gid = DT.PayableTypeGID

WHERE C.Number = '21-23-312'
--ORDER BY R.LastModifiedDate


--select *
--from dbo.Products AS P
--where P.PolisNumber = '200101513'

*/
;WITH ClaimParametersCTE AS (
	SELECT
		C.ClaimGID,
		MAX(CONVERT(DATE, IIF(P.Name = 'Дата повідомлення потерпілого', C.ParameterValue, NULL))) AS VictimNotificationDate,
		MAX(CONVERT(DATE, IIF(P.Name = 'Дата повідомлення Страхувальника ОРАНТА', C.ParameterValue, NULL))) AS InsuredNotificationDate
	FROM dbo.ClaimToParameterValues AS C
	INNER JOIN meta.DocumentParameters AS P ON C.ParameterGID = P.gid
	WHERE ClaimGID = '6367b291-069f-4989-aef1-4395f2efe2db'
		AND Deleted = 0
	GROUP BY C.ClaimGID
), ProductsCte AS (
	SELECT
		C.id AS CaseId,
		P.gid AS ProductGid
	FROM dbo.Cases AS C
	INNER JOIN dbo.CasesDocuments AS CD ON CD.CaseGID = C.gid AND CD.Deleted = 0
	INNER JOIN dbo.Documents AS D ON D.gid = CD.DocumentGID AND D.Deleted = 0
	INNER JOIN dbo.Products AS P ON P.gid = D.gid
	WHERE C.Deleted = 0
)

SELECT
	C.id AS CaseId,
	C.gid AS CaseGid,
	C.Number AS CaseNumber,
	C.InnerNumber AS CaseInnerNumber,
	S.Name AS CaseStatus,
	C.ResponsibleGID,
	C.Year,
	C.EventGID,
	C.BranchGID,
	C.IsRegressPossible,
	C.AddDate,
	C.AddUserGID,
	C.PinCode,
	C.Executor,
	P.ProductGid,
	C.ParticipantFaceNames,
	C.ParticipantObjectNames,
	ISNULL(C.LastModifiedAuthorGID, '575CBF8C-A4A1-4A5D-A372-EE624F11973B') AS LastModifiedAuthorGID,
	ISNULL(C.LastModifiedDate, C.CreateDate) AS LastModifiedDate,
	C.CreateDate,
	D.id AS DocumentId,
	D.Number AS DocumentNumber,
	Cl.gid AS ClaimGid,
	Cl.id AS ClaimId,
	Cl.ClaimerGID,
	CT.Name AS ClaimType,
	Cl.DateWriting AS ClaimDateWriting,
	Cl.Notes AS ClaimNotes,
	Cl.AuthorGID,
	Cl.RiskGID AS ClaimRiskGid,
	Cl.RecipientGID AS ClaimRecipientGID,
	Cl.ProgramTypeGID AS ClaimProgramTypeGID,
	Cl.IsVipClient AS ClaimIsVipClient,
	CP.InsuredNotificationDate,
	CP.VictimNotificationDate
FROM dbo.Cases AS C
INNER JOIN meta.Statuses AS S ON S.gid = C.StatusGID
INNER JOIN dbo.CasesDocuments AS CD ON CD.CaseGID = C.gid AND CD.Deleted = 0
INNER JOIN dbo.Documents AS D ON D.gid = CD.DocumentGID AND D.Deleted = 0
INNER JOIN dbo.Claims AS Cl ON Cl.gid = D.gid
INNER JOIN meta.ClaimTypes AS CT ON CT.gid = C.ClaimTypeGID
LEFT JOIN ClaimParametersCTE AS CP ON CP.ClaimGID = Cl.gid
INNER JOIN ProductsCte AS P ON P.CaseId = C.id
WHERE C.Deleted = 0


/*
'21-23-312' - 'это моё'
'21-23-324' - 'евро-протокол'
		СК другої сторони
		Серія полісу (сторона 2)	
		Номер полісу (сторона 2)
		Початок дії полісу (сторона 2)	01.08.2021
		Кінець дії полісу (сторона 2)	 01.08.2021
		Франшиза (сторона 2)
*/

-- SELECT *
-- FROM dbo.Cases AS C
-- INNER JOIN meta.Statuses AS S ON S.gid = C.StatusGID
-- WHERE C.Deleted = 0
-- AND C.Number = '21-23-324'