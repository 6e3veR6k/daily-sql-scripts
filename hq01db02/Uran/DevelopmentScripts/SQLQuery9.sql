
SELECT [gid]
      ,[LoggedEntityGID]
      ,[ActionDate]
      ,[Amount]
      ,[PreviousDamageAmount]
      ,[CreateUserGID]
      ,[CreateDate]
      ,[CalculationTypeGID]
      ,[CurrencyTypeGID]
      ,[AmountHRN]
      ,[AmountEuro]
      ,[CaseGID]
      ,[AuthorGID]
      ,[ClaimDate]
      ,[EndingDate]
      ,[ParentGID]
      ,[DocumentGID]
      ,[ParentDocumentGID]
      ,[LastModifiedDate]
      ,[LastModifiedAuthorGID]
      ,[ExportDate]
      ,[DoNotExport]
      ,[Deleted]
  FROM [Oberon].[log].[Reservations]
  where LoggedEntityGID IN (
	select LoggedEntityGID
	from [Oberon].[log].[Reservations]
	group by LoggedEntityGID
	having count(gid) > 1
	--order by LoggedEntityGID offset 1 rows fetch next 1 rows only
  )
  order by LoggedEntityGID