
SELECT Claims.id as [claim_id]
      ,Claims.Number as [claim_no]
      ,Payables.id as [act_id]
      ,Payables.ActNumber as [act_no]
      ,Payables.CalculationDate as [oa_dataaktaraschet]
      ,Payables.ActSignDate as [oa_dataakta]
      ,NULL as [ext_pkd]
      ,Products.ProductId as [polis_id]
      ,Products.ProgramId as [prg_id]
      ,Products.InsuredObjectId as [obj_id]
      ,Products.BranchCode as [BranchCode]
      ,Products.ProgramTypeCode as [CodeProgramType]
      ,Products.ProgramType as [T1_VIDN]
      ,NULL as [T1_komplektidN]
      ,Products.PolisNumber_Seria as [T1_SerDog]
      ,Products.PolisNumber_Number as [T1_NomerDog]
      ,Products.RegisteredDate as [T1_dataDog]
      ,Products.BeginingDate as [T1_dataDogBeg]
      ,Products.EndingDate as [T1_dataDogEnd]
      ,COALESCE(Claims.InsuranceSum, Products.InsuranceSum) as [T1_SumStrah]
      ,Claims.FranchiseValue as [T1_FRANSH]
      ,Products.InsuredName as [T1_StrahName]
      ,Products.InsuredFaceIDN as [T1_StrahINN]
      ,Products.PersonType as [T1_StrahTip]
      ,Products.InsuredObjectName as [T1_objname]
      ,Products.RegistrationNumber as [T1_objcomm]
      ,Products.ProducedDate as [T1_objGod]
      ,Products.BodyNumber as [T1_objVIN]
      ,Claims.RiskName as [T1_RISK]
      ,NULL as [T1_dataVidmovy]
      ,Claims.DateWriting as [T1_dataZayavy]
      ,Claims.InsuredClaimDate as [T1_dataPovidStrah]
      ,Claims.InsuredVictimClaimDate as [T1_dataPovidPoterp] 
      ,E.Date as [T1_dataVypadka]
      ,DATEDIFF(DD, E.Date, COALESCE(Claims.DateWriting, Claims.InsuredVictimClaimDate, Claims.InsuredClaimDate)) as [T1_countDays]
      ,Claims.DateWriting as [oa_dataVymogy]
      ,NULL as [T1_dataZayavyPoterp]
      ,NULL as [T1_firstZayava]
      ,EventParams.List as [T1_Perelik]

      ,NULL as [T1_SumZbytka]
      ,Calculation.DemageValue as [T1_SumZbytkaFull]
      ,Payables.ActDemageValue as [Sum_Zbytka_akt]

      ,NULL as [reserv_limit]
      ,NULL as [T1_SumVregul]
      ,NULL as [T1_SumReservAll]
      ,NULL as [TIP]
      ,NULL as [flag_PV]
      ,NULL as [SDTIP]
      ,NULL as [T1_Can_OutRegres]
      ,NULL as [osnova]
      ,R.CreateDate as [ReservDate] -- дата формування
      ,Products.VehicleTypeGid as [VehicleTypeGid]
      ,NULL as [zonegid]
      ,NULL as [Franchise]
      ,NULL as [b_m]
      ,Products.BranchGid as [BranchGID]
      ,Products.BeginingDate as [BeginingDate]
      ,NULL as [T1_ProcVregul]
      ,NULL as [n_ord_ic]
      ,R.id as ReservId
      ,RT.Name as ReservType
      ,R.LastModifiedDate as ReservLastModifiedDate
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
inner join Oberon.dbo.CommissarExaminations as CE on CE.CaseGID	 = C.gid and CE.Deleted = 0
inner join (
	select 
    CD.CaseGID,
    D.Number,
		Cl.id,
    Cl.DateWriting,
    Cl.InsuranceSum,
    R.Name as RiskName,

    V.[Франшиза] as FranchiseValue,
    CAST(V.[Дата повідомлення потерпілого] as date) as InsuredVictimClaimDate,
    CAST(V.[Дата повідомлення Страхувальника ОРАНТА] as date) as InsuredClaimDate
	from Oberon.dbo.CasesDocuments as CD
	inner join Oberon.dbo.Documents as D on D.gid = CD.DocumentGID and D.Deleted = 0 
	inner join Oberon.dbo.Claims as Cl on Cl.gid = D.gid
  left join OrantaSch.meta.Risks as R on R.gid = Cl.RiskGID
  inner join (
	select
		pvt.ClaimGID, pvt.[Франшиза], pvt.[Дата повідомлення Страхувальника ОРАНТА], pvt.[Дата повідомлення потерпілого]
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
		in ([Дата повідомлення Страхувальника ОРАНТА], [Дата повідомлення потерпілого], [Франшиза])
		) pvt
	) as V
	on V.ClaimGID = Cl.gid
) as Claims on C.gid = Claims.CaseGid
left join (
	select CD.CaseGID,
		PO.id as ProductId,
    Pg.id as ProgramId,
    IObj.id as InsuredObjectId,
    B.BranchCode,
    B.gid as BranchGid,
    Pt.Code as ProgramTypeCode,
    Pt.Name as ProgramType,
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
  inner join OrantaSch.dbo.Branches as B on B.gid = PO.BranchGID
  inner join OrantaSch.dbo.InsuranceObjects as IObj on IObj.ProgramGID = Pg.gid
        AND IObj.InsuranceObjectTypeGID = '20D876F3-F4F0-4A00-BF7B-9B3730496D15'
        AND IObj.Deleted = 0
  left join Metis.dbo.Vehicles as V on V.gid = IObj.ObjectGID
  inner join Metis.dbo.Faces as F on F.gid = PO.InsuredGID
  where CD.Deleted = 0
) as Products on C.gid = Products.CaseGid
left join (
	select P.*, ActDemage.ActDemageValue
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
-- and Payables.id= 4789


