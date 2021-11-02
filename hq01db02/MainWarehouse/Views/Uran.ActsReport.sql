SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [Uran].[ActsReport]
AS
    
select 
	 1 As id
	,NULL as CaseNumber
	,NULL as RecipientName
	,NULL as RecipientIdentificationCode
	,NULL as OwnerName
	,NULL as OwnerPersonTypeID
	,NULL as OwnerIdentificationCode
	,NULL as OwnerEDRPOU
	,NULL as OwnerPasportNumber
	,NULL as OwnerPasportIssuedBy
	,NULL as OwnerPasportIssuedDate
    ,NULL as InsurerPersonTypeID
	,NULL as InsurerFirstName
	,NULL as InsurerLastName
	,NULL as InsurerSecondName
	,NULL as InsurerFullName
	,NULL as ProductPolisNumber
	,NULL as ProductRegisteredDate
	,NULL as ClaimProgramTypeGID
	,NULL as PrimaryDetailBankName
	,NULL as PrimaryDetailBankMFO
	,NULL as PrimaryDetailBankAccount
	,NULL as PrimaryDetailPaymentPurpose
	,NULL as PrimaryDetailPersonalAccount
	,NULL as ActNumber
	,NULL as CalculationDate
	,NULL as ClaimRiskGID
	,NULL as DateTransferToAccounting
	,NULL as Amount
GO