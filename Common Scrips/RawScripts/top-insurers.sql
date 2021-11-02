select
  Top 50 F.gid, 
  coalesce(NULLIF(TRIM(F.FullName), ''), COALESCE(F.Lastname, '') + ' ' + COALESCE(F.Firstname, '') + ' ' + Coalesce(F.Secondname, '')) as F_name,
  A.PostAdress,
  T.Code,
  T.[Value],
  SUM(T.[Value]) over (partition by F.gid) as Avg_Sum,
  ROW_NUMBER() over (partition by F.gid order by T.code desc) as count
from Metis.dbo.Faces as F
inner join Metis.dbo.GetAddress as A on A.gid = f.PostAddressGID
cross apply (
  select
    Pt.Code,
    sum(pp.[Value]) as Value
  from OrantaSch.dbo.Products as P
  inner join OrantaSch.dbo.Programs as Pg on Pg.ProductGID = P.gid and Pg.Deleted = 0 
  inner join OrantaSch.meta.ProgramTypes as Pt on Pt.gid = Pg.ProgramTypeGID
  inner join OrantaSch.dbo.PaymentPeriods as Per on Per.ProductGID = P.gid and Per.Deleted = 0
  inner join OrantaSch.dbo.PlanedPayments as PP on PP.PaymentPeriodGID = Per.gid and PP.Deleted = 0
  where DATEPART(Quarter, P.BeginingDate ) IN (1, 2)
    and YEAR(P.BeginingDate) = 2021
    and P.Deleted = 0 
    and  P.InsurerFaceGID = F.gid
  group by Pt.Code
) as T
order by Avg_Sum desc, F.gid, count asc


