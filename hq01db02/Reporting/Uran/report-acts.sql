USE Oberon;

SELECT ROW_NUMBER() OVER (ORDER BY payable.id DESC) AS id,
       payableCase.Number AS CaseNumber,
       payableDetail.RecipientName AS RecipientName,
       payableDetail.RecipientIdentificationCode AS RecipientIdentificationCode,
       payableDetail.OwnerName AS OwnerName,
       owner.PersonTypeID AS OwnerPersonTypeID,
       owner.IdentificationCode AS OwnerIdentificationCode,
       owner.EDRPOU AS OwnerEDRPOU,
       ownerPasport.Number AS OwnerPasportNumber,
       ownerPasport.IssuedBy AS OwnerPasportIssuedBy,
       ownerPasport.IssuedDate AS OwnerPasportIssuedDate,
       insurer.PersonTypeID AS InsurerPersonTypeID,
       insurer.Firstname AS InsurerFirstName,
       insurer.Lastname AS InsurerLastName,
       insurer.Secondname AS InsurerSecondName,
       insurer.FullName AS InsurerFullName,
       product.PolisNumber AS ProductPolisNumber,
       product.RegisteredDate AS ProductRegisteredDate,
       claim.ProgramTypeGID AS ClaimProgramTypeGID,
       payableDetail.BankName AS PrimaryDetailBankName,
       payableDetail.BankMFO AS PrimaryDetailBankMFO,
       payableDetail.BankAccount AS PrimaryDetailBankAccount,
       payableDetail.PaymentPurpose AS PrimaryDetailPaymentPurpose,
       payableDetail.PersonalAccount AS PrimaryDetailPersonalAccount,
       document.Number AS ActNumber,
       payable.CalculationDate AS CalculationDate,
       claim.RiskGID AS ClaimRiskGID,
       payable.DateTransferToAccounting AS DateTransferToAccounting,
       payable.Amount AS Amount
FROM dbo.Payables payable
INNER JOIN dbo.Documents document
    ON payable.gid = document.gid
INNER JOIN
(
    SELECT CasesDocuments.*
    FROM dbo.CasesDocuments
    WHERE gid IN
          (
              SELECT MIN(gid)
              FROM dbo.CasesDocuments
              WHERE Deleted = cast(0 AS BIT)
              GROUP BY DocumentGID
          )
) casesDocument
    ON casesDocument.DocumentGID = document.gid

INNER JOIN dbo.Cases payableCase
    ON payableCase.gid = casesDocument.CaseGID

LEFT JOIN
(
    SELECT PayableDetails.*
    FROM dbo.PayableDetails
    WHERE id IN
          (
              SELECT MIN(ID)
              FROM dbo.PayableDetails
              WHERE ParentGID IS NULL
                    AND AdjustmentTypeGID IS NULL
              GROUP BY PayableGID
          )
) payableDetail
    ON payableDetail.PayableGID = payable.gid

LEFT JOIN dbo.Faces owner
    ON payableDetail.OwnerGID = owner.gid
LEFT JOIN
(
    SELECT *
    FROM dbo.ObjectDocuments
    WHERE gid IN
          (
              SELECT MIN(gid)
              FROM dbo.ObjectDocuments
              WHERE (
                        DocumentTypeGID = '357BED28-00FC-479A-B3AB-A8FC8B2DE094'
                        OR DocumentTypeGID = 'A6139EB6-6AFE-4B32-93AF-E300ED28680B'
                        OR DocumentTypeGID = '7BC04105-8BB0-4C80-9FC3-1308E2F19EDC'
                    )
                    AND Deleted = cast(0 AS BIT)
              GROUP BY ObjectGID
          )
) ownerPasport
    ON ownerPasport.ObjectGID = owner.gid
LEFT JOIN
(
    SELECT MIN(claim.gid) AS ClaimGID,
           claimCaseDocument.CaseGID
    FROM dbo.Claims claim
    INNER JOIN dbo.Documents claimDocument
        ON claim.gid = claimDocument.gid
    INNER JOIN
    (
        SELECT *
        FROM dbo.CasesDocuments
        WHERE gid IN
              (
                  SELECT MIN(gid)
                  FROM dbo.CasesDocuments
                  WHERE Deleted = cast(0 AS BIT)
                  GROUP BY DocumentGID
              )
    ) claimCaseDocument
        ON claimCaseDocument.DocumentGID = claimDocument.gid
    WHERE claimDocument.Deleted = cast(0 AS BIT)
    GROUP BY claimCaseDocument.CaseGID
) claimStructure
    ON claimStructure.CaseGID = payableCase.gid
LEFT JOIN dbo.Claims claim
    ON claim.gid = claimStructure.ClaimGID
LEFT JOIN dbo.Signers insurerSigner
    ON claim.InsurerGID = insurerSigner.gid
LEFT JOIN dbo.Faces insurer
    ON insurer.gid = insurerSigner.FaceGID
LEFT JOIN
(
    SELECT MIN(product.gid) AS ProductGID,
           productCaseDocument.CaseGID
    FROM dbo.Products product
    INNER JOIN dbo.Documents productDocument
        ON product.gid = productDocument.gid
    INNER JOIN
    (
        SELECT *
        FROM dbo.CasesDocuments
        WHERE gid IN
              (
                  SELECT MIN(gid)
                  FROM dbo.CasesDocuments
                  WHERE Deleted = cast(0 AS BIT)
                  GROUP BY DocumentGID
              )
    ) productCaseDocument
        ON productCaseDocument.DocumentGID = productDocument.gid
    WHERE productDocument.Deleted = cast(0 AS BIT)
    GROUP BY productCaseDocument.CaseGID
) productStructure
    ON productStructure.CaseGID = payableCase.gid
LEFT JOIN dbo.Products product
    ON product.gid = productStructure.ProductGID
    
WHERE payable.Deleted = cast(0 AS BIT)
      AND document.Deleted = cast(0 AS BIT)
      AND payableCase.Deleted = cast(0 AS BIT)

-- AND payable.ActSignDate between @DateFrom and @DateTo
-- AND (payableCase.ClaimTypeGID = @ClaimTypeGID or @ClaimTypeGID = '00000000-0000-0000-0000-000000000000')
ORDER BY payable.id DESC