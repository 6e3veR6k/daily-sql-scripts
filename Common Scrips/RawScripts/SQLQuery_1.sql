create procedure Uran.sp_ReservesOnDate 
	@OnDate date = null,
	@UserGid uniqueidentifier = null
AS
select
	R.CaseId as ClaimId,
	R.CaseNumber as ClaimNumber,
	B.BranchCode + ' ' + B.Name as Branch,
	D.BranchCode + ' ' + D.Name as Dir,
	R.PolisNumber as DogNumber,
	R.ProductRegisteredDate as RegisteredDate,
	R.ProductBeginingDate as BeginingDate,
	R.ProductEndingDate as EndingDate,
	R.InsuranceSum as InsuredSum,
	R.FranchiseValue as Franchise,
	R.ProgramTypeCode as PgTypeCode,
	R.ProgramType as CodeProgramType,
	R.InsuredName as InsuredFace,
	R.PersonType as InsuredFaceType,
	V.VMark as VehicleMark,
	V.VModel as VehicleModel,
	V.ProducedDate as VehicleProducedDate,
	R.Risk as RiskName,
	R.EventDate as VDate,
	R.DemageList as DemageType,
	case 
		when R.DemageType like '%Європротокол%' then 'Так' 
		when R.DemageType like '%За участю поліції%' then 'Ні'
		else 'Ні'
	end as EuroProtocol, -- Ознака врегулювання за європротоколом(не уверен что это оно)`
	R.DateDiffClaimDateWrittingAndClaimDate as T1_countDays,
	R.InsuredClaimDate as InsFirstReportDate,
	R.InsuredVictimClaimDate as VictimFirstReportDate,
	R.ClaimDateFromReservs as ClaimDate,
	R.ClaimDateWriting as AddClaimDate,
	R.HasRegress as RegresIdentity,
	R.HasRegress as OutRegressType, -- Ознака вихідного регресу (не уверен что это оно)
	R.ReservType as TIPType,
	R.ReservValue as ReservValue, 
	NULL as PercentReg,
	NULL as ValueReg,
	R.ClimeProgramReserveLimit as LimitReserv,
	R.ActNumber as ActNumber,
	R.ActSignDate as ActDate,
	NULL as RejectedDate,
	R.ActCalculationDate as CalculateActDate,
    null as n_ord_ic,
    R.ReservDate,
	(select
	U.LastName + ' ' + U.FirstName + ' ' + U.SecondName
	from Thebe.dbo.Users as U
	where U.gid = @UserGid) as UserName
from Dmart.Uran.ReservationOnDate(@OnDate) as R
left join OrantaSch.dbo.Branches as B on B.gid = R.BranchGID
left join OrantaSch.dbo.Branches as D on D.BranchCode = left(B.BranchCode, 2)
left join OrantaSch.dbo.InsuranceObjects o ON r.InsuredObjectId=o.id
left join (select V.gid,V.BodyNumber, V.RegistrationNumber, V.ProducedDate, M.Name as VMark, Mo.Name as VModel
	from Metis.dbo.Vehicles as V
	inner join Metis.meta.VehicleModels as Mo on V.ModelGID=Mo.gid
	inner join Metis.meta.VehicleManufacturers as M on M.gid=V.ManufacturerGID) as V on V.gid = o.ObjectGID
