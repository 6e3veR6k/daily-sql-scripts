DECLARE @period date = DATEADD(M, -1, getdate())
SET @period = DATEADD(M, DATEDIFF(M, 0, @period), 0)


;WITH IkpData
AS (
    
    SELECT P.gid AS ProductGID,
           Pg.ProgramTypeGID,
           Ikp.IkpPercent AS IkpPercent,
           Ikp.IkpValue AS IkpValue,
           IIF(Agent.Firstname IS NULL OR Agent.Firstname = '', Agent.Name, Agent.Lastname + ' ' + Agent.FirstName + ' ' + Agent.Secondname) AS AgentName,
           Ch.Name AS IkpChanelName,
           Ch.Code AS IkpChanelCode
    FROM OrantaSch.dbo.Products AS P
    INNER JOIN OrantaSch.dbo.Programs AS Pg ON P.gid = Pg.ProductGID AND Pg.Deleted = 0
    INNER JOIN 
        (
        SELECT 
          C.AgentGID, 
          CTP.ProgramGID, 
          IIF(CV.Name = 'Звичайна в процентах', CTP.Value, NULL) AS IkpPercent,
          IIF(CV.Name = 'Звичайна в гривнях', CTP.Value, NULL) AS IkpValue
        FROM OrantaSch.dbo.Commissions AS C
        INNER JOIN OrantaSch.meta.CommissionValueTypes AS CV ON CV.id = C.ValueType
        INNER JOIN OrantaSch.dbo.CommissionToPrograms AS CTP ON CTP.CommissionGID = C.gid AND CTP.Deleted = 0
        WHERE
          C.CommissionTypeGID = CONVERT(UNIQUEIDENTIFIER, 'BEDED8D6-159C-4DEC-869C-25416FCAD1FF')
          AND C.Deleted = 0
        ) AS Ikp
          ON Ikp.ProgramGID = Pg.gid
    INNER JOIN Metis.dbo.Faces AS Agent ON Agent.gid = Ikp.AgentGID
    INNER JOIN Callisto.dbo.AgentInChanel AS AgCh ON AgCh.AgentGID = Ikp.AgentGID AND AgCh.Deleted = 0 AND AgCh.IsPrimary = 1
    INNER JOIN Callisto.meta.AgentChanels AS Ch ON Ch.gid = AgCh.ChanelGID 
    )


SELECT IIF(F.Firstname IS NULL OR F.Firstname = '', F.Name, F.Lastname + ' ' + F.FirstName + ' ' + F.SecondName) AS AgentName,
       F.FaceID AS AgentFaceId,
       AAC.InsuranceTypeCode AS ProgramCode,
       P.PolisNumber AS PolisNumber,
       DATEDIFF(DD, P.BeginingDate, P.EndingDate) AS PolisDurationInDays,
       ROUND(AAC.RealPaymentValue, 2) AS PolisRealPayments,
       AAC.Value AS ComissionValue,
       ROUND(AAC.CommissionValue, 2) AS Comission,
       AAS.Name AS ActStatus,
       Br.BranchCode,
       LEFT(Br.BranchCode, 2) AS DirectionCode,
       P.RegisteredDate AS PolisRegisteredDate,
       PT.Name AS ProgramTypeName,
       AC.Code AS ChannelCode,
       BLTP.businessLineId AS BusinessLineId,
       BZ.BranchZone AS BranchZone,
       IIF(F.PersonTypeID = 2, 'Ю', 'Ф') AS PersonType,
       Insured.[Name] AS InsuredName,
       IkpData.IkpPercent AS IcsValue,
       CONVERT(DECIMAL(18, 2), COALESCE(ROUND((AAC.RealPaymentValue / 100) * IkpData.IkpPercent, 2), IkpData.IkpValue)) AS Ics,
       IkpData.AgentName AS AgentIcsName,
       IkpData.IkpChanelCode AS AgentIcsChanelCode,
       IkpData.IkpChanelName AS AgentIcsChanelName,
       P.gid AS ProductGid,
       P.Id AS ProductId,
       P.CreateDate
INTO #BaseInfo
FROM
  ( SELECT AA.StatusGID,
           AA.AgentGID,
           AA.gid,
           AA.ChanelGID
    FROM Callisto.dbo.AgentActs AS AA
    INNER JOIN
        (SELECT AA.LoggedEntityGID, AA.ActionDate
        FROM Callisto.log.AgentActs AS AA
        INNER JOIN
            (SELECT AA.LoggedEntityGID, MAX(AA.id) AS id
            FROM Callisto.log.AgentActs AS AA
            WHERE 
              AA.ActionDate BETWEEN @period AND GETDATE()
            GROUP BY AA.LoggedEntityGID
            ) AS AF
              ON AF.id = AA.id
        ) AS logFilter
          ON logFilter.LoggedEntityGID = AA.gid
    WHERE 
      AA.Deleted = 0
      AND AA.CommissionTypeGID = '8CC6A11E-9E88-48A3-9C8C-3F3EC92E16AD'
      AND MONTH(AA.StartPeriod) = MONTH(@period)
      AND YEAR(AA.StartPeriod) = YEAR(@period)
  ) AS AA
INNER JOIN Callisto.meta.AgentActStatuses AS AAS ON AA.StatusGID = AAS.gid
INNER JOIN Metis.dbo.Faces AS F ON F.gid = AA.AgentGID
INNER JOIN Callisto.dbo.AgentActsCommissions AS AAC ON AA.gid = AAC.AgentActGID AND AAC.Deleted = 0
INNER JOIN OrantaSch.meta.ProgramTypes AS PT ON AAC.ProgramTypeGID = PT.gid
INNER JOIN OrantaSch.dbo.Products AS P ON AAC.ProductGID = P.gid AND P.Deleted = 0
INNER JOIN OrantaSch.dbo.Branches AS Br ON P.BranchGID = Br.gid AND Br.BranchCode IS NOT NULL
INNER JOIN Metis.dbo.Faces AS Insured ON Insured.gid = P.InsuredGID
LEFT JOIN IkpData ON AAC.ProductGID = IkpData.ProductGID AND AAC.ProgramTypeGID = IkpData.ProgramTypeGID
INNER JOIN Callisto.meta.AgentChanels AS AC ON AC.gid = AA.ChanelGID
LEFT JOIN ServiceBase.dbo.BusinessLinesToPrograms AS BLTP ON BLTP.code = AAC.InsuranceTypeCode
LEFT JOIN ServiceBase.dbo.BranchesZone AS BZ ON P.BranchGID = BZ.gid




SELECT B.AgentName,
       B.AgentFaceId,
       B.ProgramCode,
       B.PolisNumber,
       Tariff.TariffName,
       B.PolisDurationInDays,
       B.PolisRealPayments,
       B.ComissionValue,
       B.Comission,
       B.ActStatus,
       B.BranchCode,
       B.DirectionCode,
       B.PolisRegisteredDate,
       B.ProgramTypeName,
       B.ChannelCode,
       B.BusinessLineId,
       B.BranchZone,
       B.PersonType,
       B.InsuredName,
       B.IcsValue,
       B.Ics,
       B.AgentIcsName,
       B.AgentIcsChanelCode,
       B.AgentIcsChanelName,
       OP.PolisCoefficientK8,
       OP.PolisCoefficientK9,
       OP.PolisTeritoryCode,
       OP.Franchise,
       OP.VehicleType
FROM #BaseInfo AS B
LEFT JOIN
(
    SELECT P.ProductId,
           P.C8Value AS PolisCoefficientK8,
           P.C9Value AS PolisCoefficientK9,
           CAST(Z.Value AS NVARCHAR(1)) AS PolisTeritoryCode,
           P.Franchise AS Franchise,
           T.Value AS VehicleType
    FROM DmartTest.Osago.Products AS P
    INNER JOIN DmartTest.Osago.Zones AS Z
        ON Z.ZoneId = P.ZoneId
    INNER JOIN DmartTest.Osago.VehicleTypes AS T
        ON T.VehicleTypeId = P.VehicleTypeId
    WHERE P.Deleted = 0
) AS OP
    ON B.ProductId = OP.ProductId
LEFT JOIN
(
    SELECT ap.Number AS TariffName,
           ppp.ProductGID,
           ppp.id
    FROM OrantaSch.dbo.ProductToProductPermissions AS ppp
    INNER JOIN OrantaSch.dbo.ProductPermissions AS pp
        ON ppp.ProductPermissionGID = pp.gid
    INNER JOIN Callisto.dbo.AgentPermissions AS ap
        ON pp.AgentPermissionGID = ap.gid
    WHERE ppp.id >=
    (
        SELECT MAX(ptpp.id)
        FROM OrantaSch.dbo.ProductToProductPermissions AS ptpp
        WHERE ppp.ProductGID = ptpp.ProductGID
    )
) AS Tariff
    ON Tariff.ProductGid = B.ProductGid

DROP TABLE #BaseInfo;
