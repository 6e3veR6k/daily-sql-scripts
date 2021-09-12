/*************************************************************************************
CASES
*************************************************************************************/

SELECT
  C.CaseId,
  C.CaseGid, --todo: remove
  C.Number AS CaseNumber,
  C.InnerNumber,
  CT.ClaimTypeId,
  S.StatusId,
  C.ResponsibleGID, -- todo: change to Id
  C.[Year],
  E.EventId,
  B.BranchWhId,  -- todo: change to Id
  C.IsRegressPossible,
  C.AddDate,
  C.AddUserGID, -- todo: change to Id
  C.PinCode,
  C.Executor,
  C.AuthorGID,
  C.LastModifiedAuthorGID,
  C.LastModifiedDate,
  C.CreateDate,
  C.Deleted
INTO #StageCases
FROM Stage.Cases AS C
INNER JOIN Dimension.ClaimTypes AS CT ON CT.ClaimTypeGid = C.ClaimTypeGID
INNER JOIN Dimension.Statuses AS S ON S.StatusGid = C.StatusGID
INNER JOIN Stage.Events AS E ON E.EventGID = C.EventGID
LEFT JOIN Dimension.Branches AS B ON B.BranchGID = C.BranchGID


/*************************************************************************************
CLAIMS
*************************************************************************************/

SELECT
  Cl.ClaimId,
  Cl.ClaimGid, --todo: remove
  Cl.ClaimerGID, -- todo: change to Id
  ClT.ClaimTypeId,
  Cl.DateWriting,
  Cl.Notes,
  Cl.AuthorGID, -- todo: change to Id
  R.RiskId,
  F.FaceId AS InsuredFaceId,
  Cl.InsuranceObjectGID, -- todo: change to Id
  Cl.RecipientGID, -- todo: change to Id
  PT.ProgramTypeId,
  Cl.OwnerPostAddressGID, -- todo: change to Id
  Cl.IsVipClient,
  Cl.InsuranceSum
INTO #StageClaimsT
FROM Stage.Claims AS Cl
INNER JOIN Dimension.ClaimTypes AS ClT ON ClT.ClaimTypeGid = Cl.TypeGID
INNER JOIN Dimension.Risks AS R ON R.RiskGid = Cl.RiskGID
INNER JOIN Stage.Signers AS S ON S.SignerGid = Cl.InsurerGID
INNER JOIN Stage.Faces AS F ON F.FaceGid = S.FaceGID
INNER JOIN Dimension.ProgramTypes AS PT ON PT.ProgramTypeGid = Cl.ProgramTypeGID


/* CLAIMS PARAMETERS */

SELECT
  Cl.ClaimId,
  Cl.ClaimGid, --todo: remove
  Cl.ClaimerGID, -- todo: change to Id
  Cl.ClaimTypeId,
  Cl.DateWriting,
  Cl.Notes,
  Cl.AuthorGID, -- todo: change to Id
  Cl.RiskId,
  Cl.InsuredFaceId,
  Cl.InsuranceObjectGID, -- todo: change to Id
  Cl.RecipientGID, -- todo: change to Id
  Cl.ProgramTypeId,
  Cl.OwnerPostAddressGID, -- todo: change to Id
  Cl.IsVipClient,
  Cl.InsuranceSum,
  P.ApprovalOfInsuranceIndemnity,
  P.Franchise,
  P.InsuredDamageCompensated,
  P.ListOfErrorsORANTAContract,
  P.IsViolationDeadline,
  P.DemageType,
  P.HasORANTAContractErrors,
  P.VictimNotificationDate,
  P.ClaimDateFilledAutomatically,
  P.HasOppositeSideContractErrors,
  P.IsInsuredAMinor,
  P.Calls,
  P.VictimsRepresentative,
  P.CustomerStatus,
  P.OppositeSidePolisNumber,
  P.OppositeSideFranchise,
  P.ListOfErrorsOppositeSideContract,
  P.DemageTypeValue,
  P.AttorneyIssueDate,
  P.OppositeSidePolisSer,
  P.OppositeSideInsuranceCompany,
  P.VictimsRepresentativeCall,
  P.InsuredNotificationDate,
  P.OrantaInsuredCivilLiability,
  P.OppositeSidePolisBeginingDate,
  P.OppositeSidePolisEndingDate,
  P.AttorneyNumber
INTO #StageClaims
FROM #StageClaimsT AS Cl
LEFT JOIN (
  SELECT
    P.ClaimGID,
    MAX(IIF(DP.Name = 'Погодження страхового відшкодування', V.Value, NULL)) AS ApprovalOfInsuranceIndemnity,
    MAX(IIF(DP.Name = 'Франшиза', CAST(P.ParameterValue AS decimal(18,2)), NULL)) AS Franchise,
    MAX(IIF(DP.Name = 'Страхувальником шкоду відшкодовано (проведено взаєморозрахунки)', P.ParameterValue, NULL)) AS InsuredDamageCompensated,
    STRING_AGG(IIF(DP.Name = 'Перелік помилок договору ОРАНТА', V.Value, NULL), ',') AS ListOfErrorsORANTAContract,
    MAX(IIF(DP.Name = 'Внести Заяву з порушенням термінів', P.ParameterValue, NULL)) AS IsViolationDeadline,
    MAX(IIF(DP.Name = 'Тип шкоди', V.Value, NULL)) AS DemageType,
    MAX(IIF(DP.Name = 'Наявність помилок в договорі ОРАНТИ', P.ParameterValue, NULL)) AS HasORANTAContractErrors,
    MAX(IIF(DP.Name = 'Дата повідомлення потерпілого', CONVERT(DATETIME, P.ParameterValue), NULL)) AS VictimNotificationDate,
    MAX(IIF(DP.Name = 'Даты заяви (вимоги) заповнена автоматично', P.ParameterValue, NULL)) AS ClaimDateFilledAutomatically,
    MAX(IIF(DP.Name = 'Наявність помилок в полісі 2-ї сторони', P.ParameterValue, NULL)) AS HasOppositeSideContractErrors,
    MAX(IIF(DP.Name = 'Застраховано особа - неповнолітня', P.ParameterValue, NULL)) AS IsInsuredAMinor,
    MAX(IIF(DP.Name = 'Хто звертається', V.Value, NULL)) AS Calls,
    MAX(IIF(DP.Name = 'Звертається представник потерпілого', P.ParameterValue, NULL)) AS VictimsRepresentative,
    MAX(IIF(DP.Name = 'Статус клієнта', V.Value, NULL)) AS CustomerStatus,
    MAX(IIF(DP.Name = 'Номер полісу  (сторона 2)', P.ParameterValue, NULL)) AS OppositeSidePolisNumber,
    MAX(IIF(DP.Name = 'Франшиза  (сторона 2)', CAST(P.ParameterValue AS decimal(18,2)), NULL)) AS OppositeSideFranchise,
    STRING_AGG(IIF(DP.Name = 'Помилки полісу 2-ї сторони/ невідповідність ЦБД МТСБУ', V.Value, NULL), ',') AS ListOfErrorsOppositeSideContract,
    MAX(IIF(DP.Name = 'Тип пошкоджень', V.Value, NULL)) AS DemageTypeValue,
    MAX(IIF(DP.Name = 'Дата довіреності представника', CONVERT(DATETIME, P.ParameterValue), NULL)) AS AttorneyIssueDate,
    MAX(IIF(DP.Name = 'Серія полісу  (сторона 2)', P.ParameterValue, NULL)) AS OppositeSidePolisSer,
    MAX(IIF(DP.Name = 'СК другої сторони', V.Value, NULL)) AS OppositeSideInsuranceCompany,
    MAX(IIF(DP.Name = 'Звертається представник', P.ParameterValue, NULL)) AS VictimsRepresentativeCall,
    MAX(IIF(DP.Name = 'Дата повідомлення Страхувальника ОРАНТА', CONVERT(DATETIME, P.ParameterValue), NULL)) AS InsuredNotificationDate,
    MAX(IIF(DP.Name = 'Ознаки ЦВ відповід. Страх. ОРАНТИ', V.Value, NULL)) AS OrantaInsuredCivilLiability,
    MAX(IIF(DP.Name = 'Початок дії полісу  (сторона 2)', CONVERT(DATETIME, P.ParameterValue), NULL)) AS OppositeSidePolisBeginingDate,
    MAX(IIF(DP.Name = 'Кінець дії полісу  (сторона 2)', CONVERT(DATETIME, P.ParameterValue), NULL)) AS OppositeSidePolisEndingDate,
    MAX(IIF(DP.Name = 'Серія та номер довіреності представника', P.ParameterValue, NULL)) AS AttorneyNumber
  FROM Stage.ClaimToParameterValues AS P
  INNER JOIN Dimension.DocumentParameters AS DP ON DP.DocumentParameterGID = P.ParameterGID
  LEFT JOIN Dimension.DocumentParameterValues AS V ON V.DocumentParameterValueGID = TRY_CONVERT(uniqueidentifier, P.ParameterValue)
  WHERE P.Deleted = 0
  GROUP BY P.ClaimGid
) AS P
  ON P.ClaimGid = Cl.ClaimGid

DROP TABLE #StageClaimsT



/*************************************************************************************
CASE DOCUMENTS
*************************************************************************************/

SELECT
  CD.CaseDocumentId,
  CD.CaseDocumentGid, --todo: remove
  C.CaseId,
  D.DocumentId,
  D.DocumentGid,
  CD.AddDate AS CaseDocumentAddDate,
  CD.AddUserGID AS CaseDocumentAddUserGID,
  IIF(CD.StatusGID = 'B55ECBEC-5E16-42C0-8649-16EAF45F2D96', 'Прикреплен', CAST(CD.StatusGID AS NVARCHAR(80))) AS DocumentStatus,
  CD.IsAccepted,
  D.Name AS DocumentName,
  D.Serial,
  D.Number,
  D.StartDate,
  D.EndDate,
  D.IssuedDate,
  D.IssuedBy,
  D.ObjectGID,
  DT.DocumentTypeId,
  D.IsLockedOut,
  D.AddDate AS DocumentAddDate,
  D.AddUserGID AS DocumentAddUserGID,
  D.Deleted,
  D.AuthorGID,
  D.AutoGeneratNumbere
INTO #CasesDocuments
FROM Stage.CasesDocuments AS CD
INNER JOIN Stage.Cases AS C ON C.CaseGid = CD.CaseGID
INNER JOIN Stage.Documents AS D ON D.DocumentGid = CD.DocumentGID
INNER JOIN Dimension.DocumentTypes AS DT ON DT.DocumentTypeGid = D.[TypeGID]

/*************************************************************************************
CASE + CLAIMS
*************************************************************************************/

SELECT
  Cl.ClaimId,
  Cl.ClaimerGID,
  Cl.ClaimTypeId,
  Cl.DateWriting,
  Cl.Notes,
  Cl.AuthorGID,
  Cl.RiskId,
  Cl.InsuredFaceId,
  Cl.InsuranceObjectGID,
  Cl.RecipientGID,
  Cl.ProgramTypeId,
  Cl.OwnerPostAddressGID,
  Cl.IsVipClient,
  Cl.InsuranceSum,
  CD.CaseDocumentAddDate,
  CD.CaseDocumentAddUserGID,
  CD.DocumentTypeId,
  C.BranchWhId,
  C.CaseId,
  C.CaseNumber,
  C.CreateDate,
  C.Deleted,
  C.EventId,
  C.Executor,
  C.InnerNumber,
  C.IsRegressPossible,
  C.LastModifiedAuthorGID,
  C.LastModifiedDate,
  C.PinCode,
  C.ResponsibleGID,
  C.StatusId,
  C.[Year],
  P.ProductGid,
  Cl.ApprovalOfInsuranceIndemnity,
  Cl.Franchise,
  Cl.InsuredDamageCompensated,
  Cl.ListOfErrorsORANTAContract,
  Cl.IsViolationDeadline,
  Cl.DemageType,
  Cl.HasORANTAContractErrors,
  Cl.VictimNotificationDate,
  Cl.ClaimDateFilledAutomatically,
  Cl.HasOppositeSideContractErrors,
  Cl.IsInsuredAMinor,
  Cl.Calls,
  Cl.VictimsRepresentative,
  Cl.CustomerStatus,
  Cl.OppositeSidePolisNumber,
  Cl.OppositeSideFranchise,
  Cl.ListOfErrorsOppositeSideContract,
  Cl.DemageTypeValue,
  Cl.AttorneyIssueDate,
  Cl.OppositeSidePolisSer,
  Cl.OppositeSideInsuranceCompany,
  Cl.VictimsRepresentativeCall,
  Cl.InsuredNotificationDate,
  Cl.OrantaInsuredCivilLiability,
  Cl.OppositeSidePolisBeginingDate,
  Cl.OppositeSidePolisEndingDate,
  Cl.AttorneyNumber
INTO #WarehouseClaimsCases
FROM #StageClaims AS Cl
INNER JOIN #CasesDocuments  AS CD ON CD.DocumentGid = Cl.ClaimGid
INNER JOIN #StageCases AS C ON C.CaseId = CD.CaseId
INNER JOIN (
  SELECT
    PD.CaseId,
    P.ProductGid
  FROM #CasesDocuments AS PD
  INNER JOIN Stage.Products AS P ON PD.DocumentGid = P.ProductGid
) AS P
  ON P.CaseId = C.CaseId

-- SELECT * FROM #WarehouseClaimsCases where CaseNumber = '21--325'

/*************************************************************************************
ACTS
*************************************************************************************/
SELECT
  C.CaseId,
  C.CaseGid,
  CD.CaseDocumentId,
  CD.CaseDocumentGid,

  -- must be the same
  D.DocumentId,
  D.DocumentGid,
  P.PayableGid,
  P.PayableId,
  -- must be the same
  
  PD.PayableDetailGid,
  PD.PayableDetailId,
  
  CD.DocumentGID,
  P.PayableGid,
  PD.PayableDetailGid, --> D.DocumentGid = CD.DocumentGID,  D.DocumentGid = P.PayableGid, PD.PayableGID = P.PayableGid
  P.PayableId,
  PD.PayableDetailId,
  D.Number AS ActNumber
  -- P.*,
  -- PD.*,
  -- P.CalculationDate as CalculationDate,
  -- P.PayableId,
	-- P.DateTransferToAccounting as DateTransferToAccounting,
	-- P.Amount as Amount,
  -- PD.RecipientName as RecipientName,
  -- PD.RecipientIdentificationCode as RecipientIdentificationCode,
  -- PD.OwnerName as OwnerName,
  -- PD.BankName as PrimaryDetailBankName,
  -- PD.BankMFO as PrimaryDetailBankMFO,
  -- PD.BankAccount as PrimaryDetailBankAccount,
  -- PD.PaymentPurpose as PrimaryDetailPaymentPurpose,
  -- PD.PersonalAccount as PrimaryDetailPersonalAccount
FROM Stage.Cases AS C
INNER JOIN Stage.CasesDocuments AS CD ON CD.CaseGID = C.CaseGid
INNER JOIN Stage.Documents AS D ON D.DocumentGid = CD.DocumentGID
INNER JOIN Stage.Payables AS P ON P.PayableGid = D.DocumentGid
INNER JOIN Stage.PayableDetails AS PD ON PD.PayableGID = P.PayableGid
WHERE 
  CD.Deleted = 0
  AND D.Deleted = 0
  AND P.Deleted = 0




-- DROP TABLE #CasesDocuments
-- DROP TABLE #StageCases
-- DROP TABLE #StageClaims
-- DROP TABLE #WarehouseClaimsCases


SELECT DATEADD(MI, -5, MAX(LastModifiedDate)) AS FromPeriod FROM [DmartTest].[Osago].[Products] AS P
SELECT CAST(DATEADD(DD, -2, MAX(LastModifiedDate)) AS DATE) AS FromPeriod FROM [DmartTest].[Osago].[Products] AS P