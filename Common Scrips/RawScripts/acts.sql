
select 
	 ROW_NUMBER() OVER(Order by payable.id desc) As id
	, payableCase.Number as CaseNumber
	,payableDetail.RecipientName as RecipientName
	,payableDetail.RecipientIdentificationCode as RecipientIdentificationCode
	,payableDetail.OwnerName as OwnerName
	,owner.PersonTypeID as OwnerPersonTypeID
	,owner.IdentificationCode as OwnerIdentificationCode
	,owner.EDRPOU as OwnerEDRPOU
	,ownerPasport.Number as OwnerPasportNumber
	,ownerPasport.IssuedBy as OwnerPasportIssuedBy
	,ownerPasport.IssuedDate as OwnerPasportIssuedDate
,insurer.PersonTypeID as InsurerPersonTypeID
	,insurer.Firstname as InsurerFirstName
	,insurer.Lastname as InsurerLastName
	,insurer.Secondname as InsurerSecondName
	,insurer.FullName as InsurerFullName
	,product.PolisNumber as ProductPolisNumber
	,product.RegisteredDate as ProductRegisteredDate
	,claim.ProgramTypeGID as ClaimProgramTypeGID
	,payableDetail.BankName as PrimaryDetailBankName
	,payableDetail.BankMFO as PrimaryDetailBankMFO
	,payableDetail.BankAccount as PrimaryDetailBankAccount
	,payableDetail.PaymentPurpose as PrimaryDetailPaymentPurpose
	,payableDetail.PersonalAccount as PrimaryDetailPersonalAccount
	,document.Number as ActNumber
	,payable.CalculationDate as CalculationDate
	,claim.RiskGID as ClaimRiskGID
	,payable.DateTransferToAccounting as DateTransferToAccounting
	,payable.Amount as Amount
  ,Br.BranchCode
  ,Br.Name
from dbo.Payables payable
inner join dbo.Documents document on payable.gid = document.gid
inner join 
(
	select * from dbo.CasesDocuments 
	where gid in 
	(
		select MIN(gid) from dbo.CasesDocuments
		where Deleted = cast (0 as bit) 
		group by DocumentGID
	)
) casesDocument on casesDocument.DocumentGID = document.gid
inner join dbo.Cases payableCase on payableCase.gid = casesDocument.CaseGID
inner join dbo.Branches as Br on Br.gid = payableCase.BranchGID
left join 
(
	select * from dbo.PayableDetails
	where id in 
	(
		select MIN(ID) from dbo.PayableDetails
		where ParentGID is null and AdjustmentTypeGID is null
		group by PayableGID
	)
) payableDetail On payableDetail.PayableGID = payable.gid
left join dbo.Faces owner on payableDetail.OwnerGID = owner.gid
left join 
(
	select * from dbo.ObjectDocuments
	where gid in
	(
		select Min(gid) from dbo.ObjectDocuments
		where 
		(	DocumentTypeGID = '357BED28-00FC-479A-B3AB-A8FC8B2DE094' 
		or
			DocumentTypeGID = 'A6139EB6-6AFE-4B32-93AF-E300ED28680B' 
		or
			DocumentTypeGID = '7BC04105-8BB0-4C80-9FC3-1308E2F19EDC' 
		)
		and
			Deleted = cast(0 as bit)
		group by ObjectGID
	)
) ownerPasport on ownerPasport.ObjectGID = owner.gid

left join 
(
		select Min(claim.gid) as ClaimGID, claimCaseDocument.CaseGID from dbo.Claims claim 
		inner join dbo.Documents claimDocument on claim.gid = claimDocument.gid
		inner join 
		(	
			select * from dbo.CasesDocuments 
			where gid in 
			(
				select MIN(gid) from dbo.CasesDocuments
				where Deleted = cast (0 as bit) 
				group by DocumentGID
			)
		) claimCaseDocument on claimCaseDocument.DocumentGID = claimDocument.gid
		where claimDocument.Deleted = cast(0 as bit)
		group by claimCaseDocument.CaseGID
) claimStructure on claimStructure.CaseGID = payableCase.gid
left join dbo.Claims claim on claim.gid = claimStructure.ClaimGID
left join dbo.Signers insurerSigner on claim.InsurerGID = insurerSigner.gid
left join dbo.Faces insurer on insurer.gid = insurerSigner.FaceGID


left join 
(
		select Min(product.gid) as ProductGID, productCaseDocument.CaseGID from dbo.Products product 
		inner join dbo.Documents productDocument on product.gid = productDocument.gid
		inner join 
		(	
			select * from dbo.CasesDocuments 
			where gid in 
			(
				select MIN(gid) from dbo.CasesDocuments
				where Deleted = cast (0 as bit) 
				group by DocumentGID
			)
		) productCaseDocument on productCaseDocument.DocumentGID = productDocument.gid
		where productDocument.Deleted = cast(0 as bit)
		group by productCaseDocument.CaseGID
) productStructure on productStructure.CaseGID = payableCase.gid
left join dbo.Products product on product.gid = productStructure.ProductGID


where
		payable.Deleted = cast (0 as bit)
	and	document.Deleted = cast (0 as bit)
	and payableCase.Deleted = cast (0 as bit)

	AND payable.ActSignDate between @DateFrom and @DateTo
	AND (payableCase.ClaimTypeGID = @ClaimTypeGID or @ClaimTypeGID = '00000000-0000-0000-0000-000000000000')
Order by payable.id desc