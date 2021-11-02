USE [MainWarehouse]
GO

--TRUNCATE TABLE [Stage].[Products]

INSERT INTO [Stage].[Products]
           ([Id]
           ,[GID]
           ,[ProductTypeGID]
           ,[PolisNumber]
           ,[BranchGID]
           ,[ResponsibleGID]
           ,[Number]
           ,[IsProlonged]
           ,[IsAction]
           ,[BeginingDate]
           ,[EndingDate]
           ,[RegisteredDate]
           ,[DurationUnitGID]
           ,[AgentReportDate]
           ,[AgentReportNumber]
           ,[InsurerGID]
           ,[InsuranceSumUkr]
           ,[Comment]
           ,[Deleted]
           ,[SupplementaryAgreementTypeGID]
           ,[BaseProductGID]
           ,[ContractGID]
           ,[SourceTypeGID]
           ,[StatusGID]
           ,[IsEditable]
           ,[IsFull]
           ,[LastModifiedAuthorGID]
           ,[ProductActionGID]
           ,[ProductPartnerActionGID]
           ,[CreatorUserGID]
           ,[AuthorGID]
           ,[CreateDate]
           ,[LastModifiedDate]
           ,[SalesChannelGID]
           ,[EntranceIntoForceGID]
           ,[IsInwardsReinsurance]
           ,[BasePayment]
           ,[IsReinsured]
           ,[ReinsurancePolisNumber]
           ,[SelectDate]
           ,[OnSaveDate]
           ,[WorkflowGID]
           ,[OwnerGID]
           ,[DealGID]
           ,[SubSalesChannelGID]
           ,[BasedOnProductGID]
           ,[InsurerFaceGID]
           ,[InsurerFacePersonTypeID]
           ,[InsurerFaceName]
           ,[SourceRecordId]
           ,[LoadDateTime])
SELECT [id]
      ,[gid]
      ,[ProductTypeGID]
      ,[PolisNumber]
      ,[BranchGID]
      ,[ResponsibleGID]
      ,[Number]
      ,[IsProlonged]
      ,[IsAction]
      ,[BeginingDate]
      ,[EndingDate]
      ,[RegisteredDate]
      ,[DurationUnitGID]
      ,[AgentReportDate]
      ,[AgentReportNumber]
      ,[InsurerGID]
      ,[InsuranceSumUkr]
      ,[Comment]
      ,[Deleted]
      ,[SupplementaryAgreementTypeGID]
      ,[BaseProductGID]
      ,[ContractGID]
      ,[SourceTypeGID]
      ,[StatusGID]
      ,[IsEditable]
      ,[IsFull]
      ,[LastModifiedAuthorGID]
      ,[ProductActionGID]
      ,[ProductPartnerActionGID]
      ,[CreatorUserGID]
      ,[AuthorGID]
      ,[CreateDate]
      ,[LastModifiedDate]
      ,[SalesChannelGID]
      ,[EntranceIntoForceGID]
      ,[IsInwardsReinsurance]
      ,[BasePayment]
      ,[IsReinsured]
      ,[ReinsurancePolisNumber]
      ,[SelectDate]
      ,[OnSaveDate]
      ,[WorkflowGID]
      ,[OwnerGID]
      ,[DealGID]
      ,[SubSalesChannelGID]
      ,[BasedOnProductGID]
      ,[InsurerFaceGID]
      ,[InsurerFacePersonTypeID]
      ,[InsurerFaceName]
	  ,CAST(1 AS INT)SourceRecordId
	  ,CURRENT_TIMESTAMP LoadDateTime
FROM OrantaSch.[dbo].[Products] AS P


INSERT INTO [Hub].[Products] (HubProductId, ProductGid, SourceRecordId, LoadDateTime)
SELECT P.id, P.GID, CAST(1 AS INT) AS SourceRecordId, CURRENT_TIMESTAMP AS LoadDateTime
FROM [Stage].[Products] AS P
WHERE NOT EXISTS (SELECT 1 FROM [Hub].[Products] AS H WHERE H.HubProductId = P.id)


USE [MainWarehouse]
GO

INSERT INTO [Link].[FactProducts]
           ([LinkFactProductId]
           ,[HubProductId]
           ,[HubProgramId]
           ,[SourceRecordId]
           ,[LoadDateTime])
SELECT
	NEXT VALUE FOR Link.sq_FactProducts AS LinkFactProductId,
	HP.HubProductId,
	HPg.HubProgramId,
	CAST('1' AS INT) AS SourceRecordId,
	CURRENT_TIMESTAMP
FROM Stage.Programs AS Pg
LEFT JOIN Hub.Programs AS HPg ON HPg.HubProgramId = Pg.Id
LEFT JOIN Hub.Products AS HP ON HP.ProductGid = Pg.ProductGID
WHERE NOT EXISTS (
	SELECT 1
	FROM Link.FactProducts AS FP
	WHERE FP.HubProductId = HP.HubProductId
		AND FP.HubProgramId = HPg.HubProgramId
)
