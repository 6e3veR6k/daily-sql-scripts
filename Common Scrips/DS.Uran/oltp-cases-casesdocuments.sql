DECLARE @p0 UNIQUEIDENTIFIER,
        @p1 UNIQUEIDENTIFIER,
        @p2 UNIQUEIDENTIFIER,
        @p3 UNIQUEIDENTIFIER,
        @p4 DATETIME,
        @p5 NVARCHAR(4000)
SET @p0 = 'FFCC9910-2753-4CA4-B072-A8BA357C7E12'
SET @p1 = 'F0A112FB-73DA-4857-909D-2343525C29D6'
SET @p2 = 'E872E603-D0F8-4899-8244-1959E780F009'
SET @p3 = '58331F72-38EF-4A38-9412-EEC8C3A252CF'
SET @p4 = '1900-01-01 00:00:00'
SET @p5 = N'%21-23-312%'



SELECT TOP (11)
       [t17].[id],
       [t17].[gid],
       [t17].[Number],
       [t17].[InnerNumber],
       [t17].[ClaimTypeGID],
       [t17].[StatusGID],
       [t17].[ResponsibleGID],
       [t17].[Year],
       [t17].[EventGID],
       [t17].[BranchGID],
       [t17].[IsRegressPossible],
       [t17].[AddDate],
       [t17].[AddUserGID],
       [t17].[PinCode],
       [t17].[Executor],
       [t17].[ForumTopicGID],
       [t17].[AuthorGID],
       [t17].[WorkflowGID],
       [t17].[PolisNumber],
       [t17].[InsuredName],
       [t17].[InsuredObjectName],
       [t17].[ParticipantFaceNames],
       [t17].[ParticipantObjectNames],
       [t17].[LastModifiedAuthorGID],
       [t17].[LastModifiedDate],
       [t17].[Deleted],
       [t17].[CreateDate],
       [t17].[id2],
       [t17].[gid2],
       [t17].[Date],
       [t17].[CountryGID],
       [t17].[PostAddressGID],
       [t17].[Address],
       [t17].[AuthorGID2],
       [t17].[Comment],
       [t17].[Name] AS [StatusName],
       [t17].[id3] AS [ClaimTypeID],
       [t17].[gid3] AS [ClaimTypeGID2],
       [t17].[value],
       [t17].[test],
       [t17].[id4] AS [id3],
       [t17].[gid4] AS [gid3],
       [t17].[Name2] AS [Name],
       [t17].[test2],
       [t17].[id5] AS [id4],
       [t17].[gid5] AS [gid4],
       [t17].[LastName],
       [t17].[FirstName],
       [t17].[SecondName],
       [t17].[UserName],
       [t17].[BranchGID2],
       [t17].[Deleted2],
       [t17].[AuthorGID3],
       [t17].[test3],
       [t17].[id6] AS [id5],
       [t17].[gid6] AS [gid5],
       [t17].[CaseGID],
       [t17].[StepGID],
       [t17].[RoleGID],
       [t17].[UserGID],
       [t17].[DocumentStatusGID],
       [t17].[StatusGID2],
       [t17].[Comment2],
       [t17].[AuthorGID4],
       [t17].[AddDate2],
       [t17].[AddUserGID2],
       [t17].[BranchGID3],
       [t17].[Date2],
       [t17].[Deleted3],
       [t17].[value2] AS [EventDate]
FROM
(
    SELECT [t0].[id],
           [t0].[gid],
           [t0].[Number],
           [t0].[InnerNumber],
           [t0].[ClaimTypeGID],
           [t0].[StatusGID],
           [t0].[ResponsibleGID],
           [t0].[Year],
           [t0].[EventGID],
           [t0].[BranchGID],
           [t0].[IsRegressPossible],
           [t0].[AddDate],
           [t0].[AddUserGID],
           [t0].[PinCode],
           [t0].[Executor],
           [t0].[ForumTopicGID],
           [t0].[AuthorGID],
           [t0].[WorkflowGID],
           [t0].[PolisNumber],
           [t0].[InsuredName],
           [t0].[InsuredObjectName],
           [t0].[ParticipantFaceNames],
           [t0].[ParticipantObjectNames],
           [t0].[LastModifiedAuthorGID],
           [t0].[LastModifiedDate],
           [t0].[Deleted],
           [t0].[CreateDate],
           [t10].[id] AS [id2],
           [t10].[gid] AS [gid2],
           [t10].[Date],
           [t10].[CountryGID],
           [t10].[PostAddressGID],
           [t10].[Address],
           [t10].[AuthorGID] AS [AuthorGID2],
           [t10].[Comment],
           [t11].[Name],
           [t9].[id] AS [id3],
           [t9].[gid] AS [gid3],
           (CASE
                WHEN [t12].[gid] = @p3 THEN
                    1
                WHEN NOT ([t12].[gid] = @p3) THEN
                    0
                ELSE
                    NULL
            END
           ) AS [value],
           [t14].[test],
           [t14].[id] AS [id4],
           [t14].[gid] AS [gid4],
           [t14].[Name] AS [Name2],
           [t16].[test] AS [test2],
           [t16].[id] AS [id5],
           [t16].[gid] AS [gid5],
           [t16].[LastName],
           [t16].[FirstName],
           [t16].[SecondName],
           [t16].[UserName],
           [t16].[BranchGID] AS [BranchGID2],
           [t16].[Deleted] AS [Deleted2],
           [t16].[AuthorGID] AS [AuthorGID3],
           [t8].[test] AS [test3],
           [t8].[id] AS [id6],
           [t8].[gid] AS [gid6],
           [t8].[CaseGID],
           [t8].[StepGID],
           [t8].[RoleGID],
           [t8].[UserGID],
           [t8].[DocumentStatusGID],
           [t8].[StatusGID] AS [StatusGID2],
           [t8].[Comment] AS [Comment2],
           [t8].[AuthorGID] AS [AuthorGID4],
           [t8].[AddDate] AS [AddDate2],
           [t8].[AddUserGID] AS [AddUserGID2],
           [t8].[BranchGID] AS [BranchGID3],
           [t8].[Date] AS [Date2],
           [t8].[Deleted] AS [Deleted3],
           COALESCE([t10].[Date], @p4) AS [value2],
           [t4].[id] AS [id7]
    FROM [dbo].[Cases] AS [t0]
    INNER JOIN(
    (
        SELECT [t1].[CaseGID]
        FROM [dbo].[CaseHistorySteps] AS [t1]
        WHERE NOT ([t1].[Deleted] = 1)
        GROUP BY [t1].[CaseGID]
    ) AS [t2]
    OUTER APPLY
    (
        SELECT TOP (1)
               [t3].[id],
               [t3].[CaseGID]
        FROM [dbo].[CaseHistorySteps] AS [t3]
        WHERE (
                  ([t3].[StatusGID] = @p0)
                  OR ([t3].[StatusGID] = @p1)
              )
              AND ([t2].[CaseGID] = [t3].[CaseGID])
              AND (NOT ([t3].[Deleted] = 1))
        ORDER BY [t3].[id] DESC
    ) AS [t4] )
        ON [t0].[gid] = [t4].[CaseGID]
    INNER JOIN(
    (
        SELECT [t5].[CaseGID]
        FROM [dbo].[CaseHistorySteps] AS [t5]
        WHERE NOT ([t5].[Deleted] = 1)
        GROUP BY [t5].[CaseGID]
    ) AS [t6]
    OUTER APPLY
    (
        SELECT TOP (1)
               1 AS [test],
               [t7].[id],
               [t7].[gid],
               [t7].[CaseGID],
               [t7].[StepGID],
               [t7].[RoleGID],
               [t7].[UserGID],
               [t7].[DocumentStatusGID],
               [t7].[StatusGID],
               [t7].[Comment],
               [t7].[AuthorGID],
               [t7].[AddDate],
               [t7].[AddUserGID],
               [t7].[BranchGID],
               [t7].[Date],
               [t7].[Deleted]
        FROM [dbo].[CaseHistorySteps] AS [t7]
        WHERE ([t7].[StatusGID] <> @p2)
              AND ([t6].[CaseGID] = [t7].[CaseGID])
              AND (NOT ([t7].[Deleted] = 1))
        ORDER BY [t7].[id] DESC
    ) AS [t8] )
        ON [t0].[gid] = [t8].[CaseGID]
    INNER JOIN [meta].[ClaimTypes] AS [t9]
        ON [t0].[ClaimTypeGID] = [t9].[gid]
    INNER JOIN [dbo].[Events] AS [t10]
        ON [t0].[EventGID] = [t10].[gid]
    INNER JOIN [meta].[Statuses] AS [t11]
        ON [t11].[gid] = [t0].[StatusGID]
    LEFT OUTER JOIN [meta].[CaseHistoryStepStatuses] AS [t12]
        ON [t12].[gid] = [t8].[StatusGID]
    LEFT OUTER JOIN
    (
        SELECT 1 AS [test],
               [t13].[id],
               [t13].[gid],
               [t13].[Name]
        FROM [meta].[Roles] AS [t13]
    ) AS [t14]
        ON [t14].[gid] = [t8].[RoleGID]
    LEFT OUTER JOIN
    (
        SELECT 1 AS [test],
               [t15].[id],
               [t15].[gid],
               [t15].[LastName],
               [t15].[FirstName],
               [t15].[SecondName],
               [t15].[UserName],
               [t15].[BranchGID],
               [t15].[Deleted],
               [t15].[AuthorGID]
        FROM [dbo].[Users] AS [t15]
    ) AS [t16]
        ON [t16].[gid] = [t8].[UserGID]
) AS [t17]
WHERE ([t17].[Number] LIKE @p5)
      AND (NOT ([t17].[Deleted] = 1))
ORDER BY [t17].[id] DESC,
         [t17].[id7] DESC,
         [t17].[id6] DESC




-------------------------------------------------------------------------
DECLARE @p0 UNIQUEIDENTIFIER
SET @p0 = 'A17A915C-CD94-40EC-BD29-DDED26C1A581'

SELECT [t0].[CaseGID],
       [t2].[id],
       [t2].[gid],
       [t2].[ClaimerGID],
       [t2].[TypeGID],
       [t2].[DateWriting],
       [t2].[Notes],
       [t2].[AuthorGID],
       [t2].[RiskGID],
       [t2].[InsurerGID],
       [t2].[InsuranceObjectGID],
       [t2].[RecipientGID],
       [t2].[ProgramTypeGID],
       [t2].[OwnerPostAddressGID],
       [t2].[IsVipClient],
       [t2].[InsuranceSum]
FROM [dbo].[CasesDocuments] AS [t0]
INNER JOIN [dbo].[Documents] AS [t1]
    ON [t0].[DocumentGID] = [t1].[gid]
INNER JOIN [dbo].[Claims] AS [t2]
    ON [t1].[gid] = [t2].[gid]
WHERE [t0].[CaseGID] IN (
                            @p0
                        )



-------------------------------------------------------------------------
                       
exec GetCaseByGID @GID='A17A915C-CD94-40EC-BD29-DDED26C1A581'

-------------------------------------------------------------------------

DECLARE @p0 UNIQUEIDENTIFIER,
        @p1 UNIQUEIDENTIFIER,
        @p2 UNIQUEIDENTIFIER,
        @p3 UNIQUEIDENTIFIER,
        @p4 UNIQUEIDENTIFIER
SET @p0 = '48CFC35B-622B-4A8E-A12F-A9EE6C9ECCE0'
SET @p1 = '28892BDB-1642-4293-B37D-660511A936EA'
SET @p2 = '805C973D-FE3F-44A3-8229-8CF3A29CCD23'
SET @p3 = 'C7A338C5-7892-4CCD-8B9A-B1A2817CCB73'
SET @p4 = '6219F747-7A24-47E8-AEDC-E2CA63472E31'

SELECT [t0].[gid]
FROM [dbo].[Products] AS [t0]
WHERE ([t0].[gid] = @p0)
      AND (NOT ([t0].[Deleted] = 1))
      AND ([t0].[StatusGID] IN (
                                   @p1,
                                   @p2,
                                   @p3,
                                   @p4
                               )
          )


exec GetProductByGID @GID='48CFC35B-622B-4A8E-A12F-A9EE6C9ECCE0'