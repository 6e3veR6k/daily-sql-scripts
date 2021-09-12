;WITH EntityCTE
AS 
(
  SELECT EA.EntityGID,
           EA.[Value],
           A.Name,
           A.Caption
  FROM dbo.EntityAttributes AS EA
  INNER JOIN Metis.meta.Attributes AS A
      ON A.gid = EA.AttributeGID
  WHERE A.Caption LIKE '%[Оо]плачено%'
        AND EA.Deleted = 0
)



SELECT P.PolisNumber,
       B.BranchCode,
       IT.Code,
       CONVERT(DATE, P.RegisteredDate) AS RegisteredDate,
       CONVERT(DATE, P.BeginingDate) AS BeginingDate,
       CONVERT(DATE, P.EndingDate) AS EndingDate,
       IIF(P.InsurerFacePersonTypeID = 2, 'Ю', 'Ф') AS PersonType,
       PPay.PValue,
       PPay.RValue,
       E.Caption,
       E.[Value]
FROM dbo.Products AS P
INNER JOIN dbo.Programs AS Pg
    ON Pg.ProductGID = P.gid
INNER JOIN dbo.Branches AS B
    ON B.gid = P.BranchGID
INNER JOIN meta.ProgramTypes AS PT
    ON PT.gid = Pg.ProgramTypeGID
INNER JOIN meta.InsuranceTypes AS IT
    ON IT.gid = PT.InsuranceTypeGID
INNER JOIN
(
    SELECT PPay.ProgramGID,
           SUM(ISNULL(PPay.Value, 0)) AS PValue,
           SUM(ISNULL(PTR.Value, 0)) AS RValue,
           SUM(PTR.BValue) AS BValue,
           MAX(PTR.PaymentDate) AS RealPaymentDate
    FROM dbo.PlanedPayments AS PPay
    LEFT JOIN
    (
        SELECT PTR.PlanedPaymentGID,
               SUM(PTR.[Value]) AS BValue,
               SUM(   CASE ISNULL(M.[Value], 0)
                          WHEN 0 THEN
                              0
                          ELSE
                              PTR.[Value]
                      END
                  ) AS [Value],
               MAX(BP.PaymentDate) AS PaymentDate
        FROM dbo.PlanedToRealPayments AS PTR
        LEFT JOIN Ganimed.dbo.Moneys AS M
            ON M.ToGID = PTR.RealPaymentGID
               AND M.Deleted = 0
        INNER JOIN Ganimed.dbo.BankPayments AS BP
            ON BP.gid = M.FromGID
               AND BP.Deleted = 0
        WHERE PTR.Deleted = 0
        GROUP BY PTR.PlanedPaymentGID
    ) AS PTR
        ON PTR.PlanedPaymentGID = PPay.gid
    WHERE PPay.Deleted = 0
    GROUP BY PPay.ProgramGID,
             PPay.Deleted
) AS PPay
    ON PPay.ProgramGID = Pg.gid
INNER JOIN EntityCTE AS E ON E.EntityGID = P.gid
WHERE (P.RegisteredDate BETWEEN '20210101' AND '20210731')
      AND 
      P.Deleted = 0
      AND
      PPay.RValue != 0
ORDER BY P.RegisteredDate DESC