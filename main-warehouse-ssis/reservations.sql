-- Oberon.dbo.Cases
-- Oberon.dbo.Events
-- Oberon.dbo.EventToParameterValues
-- Oberon.dbo.CasesDocuments
-- Oberon.dbo.Documents
-- Oberon.dbo.Claims
-- Oberon.dbo.ClaimToParameterValues
-- Oberon.dbo.Products
-- Oberon.dbo.Payables
-- Oberon.dbo.PayableToParameterValues       
-- Oberon.dbo.Regresses
-- Oberon.dbo.Calculations
-- Oberon.dbo.CalculationToParameterValues
-- Oberon.dbo.Reservations

-- Oberon.meta.ProgramTypeToClaimTypes
-- Oberon.meta.DocumentParameters
-- Oberon.meta.ReservationCalculationTypes
-- Oberon.meta.DocumentParameterValues

-- OrantaSch.dbo.Programs
-- OrantaSch.dbo.Branches
-- OrantaSch.dbo.InsuranceObjects

-- OrantaSch.meta.Risks
-- OrantaSch.meta.ProgramTypes
-- OrantaSch.meta.InsuranceTypes

-- Metis.dbo.Vehicles
-- Metis.dbo.Faces



/* ================================================================================================================================================================================= */
/* ================================================================================================================================================================================= */
SELECT C.id as CaseId
      ,C.Number as CaseNumber
      ,Payables.id as ActId
      ,Payables.ActNumberDoc as ActNumber
      ,Payables.CalculationDate as ActCalculationDate
      ,Payables.ActSignDate as ActSignDate
      ,Products.ProductId as OrantaSchProductId
      ,Products.ProgramId as ProgramId
      ,Products.InsuredObjectId as InsuredObjectId
      ,Products.BranchCode as [BranchCode]
      ,Products.ProgramTypeCode as ProgramTypeCode
      ,Products.ProgramType as ProgramType
      ,CAST(Claims.DemageType as NVARCHAR) as DemageType
      ,Products.PolisNumber as PolisNumber
      ,Products.PolisNumber_Seria as PolisNumber_Seria
      ,Products.PolisNumber_Number as PolisNumber_Number
      ,Products.RegisteredDate as ProductRegisteredDate
      ,Products.BeginingDate as ProductBeginingDate
      ,Products.EndingDate as ProductEndingDate
      ,COALESCE(Claims.InsuranceSum, Products.InsuranceSum) as InsuranceSum
      ,CAST(Claims.FranchiseValue as decimal) as FranchiseValue
      ,Products.InsuredName as InsuredName
      ,Products.InsuredFaceIDN as InsuredFaceIDN
      ,Products.PersonType as PersonType
      ,Products.InsuredObjectName as InsuredObjectName
      ,Products.RegistrationNumber as VehicleRegistrationNumber
      ,Products.ProducedDate as VehicleProducedDate
      ,Products.BodyNumber as VehicleBodyNumber
      ,Claims.RiskName as Risk
      ,Claims.DateWriting as ClaimDateWriting
      ,Claims.InsuredClaimDate as InsuredClaimDate
      ,Claims.InsuredVictimClaimDate as InsuredVictimClaimDate
      ,E.Date as EventDate
      ,DATEDIFF(DD, E.Date, COALESCE(Claims.DateWriting, Claims.InsuredVictimClaimDate, Claims.InsuredClaimDate)) as DateDiffClaimDateWrittingAndClaimDate
      ,R.ClaimDate as ClaimDateFromReservs
      ,EventParams.List as DemageList
      ,NULL as [T1_SumZbytka]
      ,Calculation.DemageValue as CalculationDemageValue
      ,CAST(Payables.ActDemageValue as decimal) as ActDemageValue
      ,Limits.Reserve as ClimeProgramReserveLimit
      ,NULL as [T1_SumVregul]
      ,R.Amount as ReservValue
      ,Regresses.HasRegress as HasRegress
      ,R.CreateDate as [ReservDate] -- дата формування
      ,Products.VehicleTypeGid as [VehicleTypeGid]
      ,Products.BranchGid as [BranchGID]
      ,Products.BeginingDate as [BeginingDate]
      ,R.id as ReservId
      ,RT.Name as ReservType
      ,R.LastModifiedDate as ReservLastModifiedDate
      ,R.DocumentGID as ReservDocumentGid
      ,CAST(R.CreateDate as date) as ReservCreateDate
      ,CAST(COALESCE(R.EndingDate, '99991231') as date) as ReservEndingDate
      ,R.ParentDocumentGID as ReservParentDocumentGID
  from Oberon.dbo.Reservations as R
  inner join Oberon.meta.ReservationCalculationTypes as RT on RT.gid = R.CalculationTypeGID
  inner join Oberon.dbo.Cases as C on C.gid = R.CaseGID  and C.Deleted = 0
  left join Oberon.dbo.Events as E on E.gid = C.EventGID
  outer apply (
    select
    STRING_AGG(cast(DV.[Value] as nvarchar(50)), ', ') as List
    from Oberon.dbo.EventToParameterValues as PV
    inner join Oberon.meta.DocumentParameters as P on P.gid = PV.ParameterGID and P.Name like '%Перелік пошкоджень%'
    inner join Oberon.meta.DocumentParameterValues as DV on DV.gid = PV.ParameterValue
    where PV.Deleted = 0
    and PV.EventGID = E.gid
  ) as EventParams
  inner join (
    select 
    CD.CaseGID,
    D.Number,
    Cl.id,
    Cl.DateWriting,
    Cl.InsuranceSum,
    Cl.TypeGID,
    R.Name as RiskName,
    PV.Value as DemageType,
    V.[Франшиза] as FranchiseValue,
    CAST(V.[Дата повідомлення потерпілого] as date) as InsuredVictimClaimDate,
    CAST(V.[Дата повідомлення Страхувальника ОРАНТА] as date) as InsuredClaimDate
    from Oberon.dbo.CasesDocuments as CD
    inner join Oberon.dbo.Documents as D on D.gid = CD.DocumentGID and D.Deleted = 0 
    inner join Oberon.dbo.Claims as Cl on Cl.gid = D.gid
    left join OrantaSch.meta.Risks as R on R.gid = Cl.RiskGID
    inner join (
    select
      pvt.ClaimGID, pvt.[Франшиза], pvt.[Дата повідомлення Страхувальника ОРАНТА], pvt.[Дата повідомлення потерпілого], pvt.[Тип пошкоджень]
    from
      (select
        PV.ClaimGID,
        PV.ParameterValue,
        (SELECT P.Name FROM Oberon.meta.DocumentParameters AS P WHERE P.gid = PV.ParameterGID) AS ParameterName
      from Oberon.dbo.ClaimToParameterValues as PV
      where PV.Deleted = 0
      ) as Query
    pivot 
      (max(ParameterValue)
      for ParameterName
      in ([Дата повідомлення Страхувальника ОРАНТА], [Дата повідомлення потерпілого], [Франшиза], [Тип пошкоджень])
      ) pvt
    ) as V
    on V.ClaimGID = Cl.gid
    left join Oberon.meta.DocumentParameterValues as PV on PV.gid = V.[Тип пошкоджень]
  ) as Claims on C.gid = Claims.CaseGid
  left join (
    select CD.CaseGID,
    PO.id as ProductId,
    Pg.id as ProgramId,
    IObj.id as InsuredObjectId,
    B.BranchCode,
    B.gid as BranchGid,
    IT.Code as ProgramTypeCode,
    Pt.gid as ProgramTypeGid,
    Pt.Name as ProgramType,
    PO.PolisNumber,
    IIF(ISNUMERIC(PO.PolisNumber)=1, NULL, LEFT(PO.PolisNumber, CHARINDEX('-', PO.PolisNumber) - 1)) AS PolisNumber_Seria,
    IIF(ISNUMERIC(PO.PolisNumber)=1, PO.PolisNumber, SUBSTRING(PO.PolisNumber, CHARINDEX('-', PO.PolisNumber) + 1, LEN(PO.PolisNumber))) AS PolisNumber_Number,
    CAST(PO.BeginingDate as date) as BeginingDate,
    CAST(dateadd(ss, -1, PO.EndingDate) as date) as EndingDate,
    CAST(PO.RegisteredDate as date) as RegisteredDate,
    IObj.InsuranceSum,
    coalesce(NULLIF(TRIM(F.FullName), ''), COALESCE(F.Lastname, '') + ' ' + COALESCE(F.Firstname, '') + ' ' + Coalesce(F.Secondname, '')) as InsuredName,
    F.FaceID as InsuredFaceIDN,
    IIF(F.PersonTypeID = 2, 'Ю', 'Ф') as PersonType,
    Iobj.Name as InsuredObjectName,
    V.RegistrationNumber,
    V.ProducedDate,
    V.TypeGID as VehicleTypeGid,
    V.BodyNumber
    from Oberon.dbo.CasesDocuments as CD
    inner join Oberon.dbo.Documents as D on D.gid = CD.DocumentGID and D.Deleted = 0
    inner join Oberon.dbo.Products as P on P.gid = D.gid
    inner join OrantaSch.dbo.Products as PO on PO.gid = P.gid and PO.Deleted = 0
    inner join OrantaSch.dbo.Programs as Pg on Pg.ProductGID = PO.gid and Pg.Deleted = 0
    inner join OrantaSch.meta.ProgramTypes as Pt on Pt.gid = Pg.ProgramTypeGID
    inner join OrantaSch.meta.InsuranceTypes as IT on IT.gid = Pt.InsuranceTypeGID
    inner join OrantaSch.dbo.Branches as B on B.gid = PO.BranchGID
    inner join OrantaSch.dbo.InsuranceObjects as IObj on IObj.ProgramGID = Pg.gid
      AND IObj.InsuranceObjectTypeGID = '20D876F3-F4F0-4A00-BF7B-9B3730496D15'
      AND IObj.Deleted = 0
    left join Metis.dbo.Vehicles as V on V.gid = IObj.ObjectGID
    inner join Metis.dbo.Faces as F on F.gid = PO.InsurerFaceGID
    where CD.Deleted = 0
  ) as Products on C.gid = Products.CaseGid
  left join (
    select P.*, ActDemage.ActDemageValue, D.Number as ActNumberDoc
    from Oberon.dbo.CasesDocuments as CD 
    inner join Oberon.dbo.Documents as D on D.gid = CD.DocumentGID and D.Deleted = 0
    inner join Oberon.dbo.Payables as P on P.gid = D.gid and P.Deleted = 0
    left join (
    select PV.PayableGID, PV.ParameterValue as ActDemageValue
    from Oberon.dbo.PayableToParameterValues as PV
    where PV.Deleted = 0
      and PV.ParameterGID = 'cd7b220c-4af2-430a-a2a6-b0226cfbb334'
    ) as ActDemage
    on ActDemage.PayableGID = P.gid
    where CD.Deleted = 0
  ) as Payables on R.DocumentGID = Payables.gid
  outer apply (select 1 as HasRegress from Oberon.dbo.Regresses where Regresses.PayableGID = Payables.gid) as Regresses
  outer apply (select PT.Reserve from Oberon.meta.ProgramTypeToClaimTypes as PT where PT.ClaimTypeGID = Claims.TypeGid and PT.ProgramTypeGID = Products.ProgramTypeGid) as Limits
  left join (
    SELECT
    CD.CaseGID,
    CP.ParameterValue as DemageValue
    FROM Oberon.dbo.Calculations as C
    inner join Oberon.dbo.Documents as D on D.gid = C.gid
    inner join Oberon.dbo.CasesDocuments as CD on CD.DocumentGID = C.gid
    inner join [Oberon].[dbo].[CalculationToParameterValues] as CP on CP.CalculationGID = c.gid
    INNER join Oberon.meta.DocumentParameters as P on P.gid = CP.ParameterGID
    where CP.Deleted = 0 and 
    CP.[ParameterGID] = 'a4c6c209-462a-462e-9f83-396c93e2d4c4'
  ) as Calculation on Calculation.CaseGID = C.gid
  where R.Deleted = 0
    and R.id = (select max(l.id) from Oberon.dbo.Reservations as l where l.DocumentGID = R.DocumentGID and CAST(l.CreateDate as date) <= @OnDate and @OnDate < CAST(COALESCE(l.EndingDate, '99991231') AS DATE))
