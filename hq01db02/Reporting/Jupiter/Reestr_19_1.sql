USE OrantaSch;

DECLARE @ProgramCode AS TABLE ( Code NVARCHAR(3) )
INSERT INTO @ProgramCode
SELECT PT.code FROM meta.ProgramTypes as PT 

DECLARE @payDateFrom AS DATE = '20210501' 
DECLARE @payDateTo AS DATE = '20210801'

DECLARE @regDateFrom AS DATE = '20210501' 
DECLARE @regDateTo AS DATE = '20210801'

DECLARE @ResultBranchCodeLength AS DATE = '20210501'
DECLARE @ResultBranchCode AS DATE = '20210501'

SELECT B.Name AS [Branch],
       LEFT(B.BranchCode, 2) AS [DirCode],
       P.AgentReportNumber,
       P.AgentReportDate,
       CASE ISNULL(comm.[Комісійна винагорода 1], 0)
           WHEN 0 THEN
               comm.[Агент 2]
           ELSE
               comm.[Агент 1]
       END AS Agent1,
       CASE ISNULL(comm.[Комісійна винагорода 1], 0)
           WHEN 0 THEN
               comm.[Агент 1]
           ELSE
               comm.[Агент 2]
       END AS Agent2,
       CASE ISNULL(comm.[Комісійна винагорода 1], 0)
           WHEN 0 THEN
               comm.[Комісійна винагорода 2]
           ELSE
               comm.[Комісійна винагорода 1]
       END AS percent1,
       CASE ISNULL(comm.[Комісійна винагорода 1], 0)
           WHEN 0 THEN
               comm.[Комісійна винагорода 1]
           ELSE
               comm.[Комісійна винагорода 2]
       END AS percent2,
       CASE ISNULL(comm.[Комісійна винагорода 1], 0)
           WHEN 0 THEN
               comm.[Комісійна винагорода 2] * Payment.Value / 100
           ELSE
               comm.[Комісійна винагорода 1] * Payment.Value / 100
       END AS comm1,
       CASE ISNULL(comm.[Комісійна винагорода 1], 0)
           WHEN 0 THEN
               comm.[Комісійна винагорода 1] * Payment.Value / 100
           ELSE
               comm.[Комісійна винагорода 2] * Payment.Value / 100
       END AS comm2,
       ISNULL(pers.Lastname + ' ' + pers.Firstname + ' ' + pers.Secondname, F.Name) AS [InsurerName],
       CASE F.PersonTypeID
           WHEN 1 THEN
               'Ф'
           WHEN 2 THEN
               'Ю'
           ELSE
               ''
       END AS PersonType,
       P.PolisNumber AS [Polis],
       P.RegisteredDate,
       comm.ProgramType AS ProgramCode,
       TotalPayment.Value AS TotalPayment,
       Payment.Value AS PartPayment,
       Pd.PlanDate AS PaymentDate,
       RealPay.Value AS RealPay,
       RealPay.RealDate,
       Pd.TicketDate AS TicketDate,
       P.BeginingDate,
       DATEADD(MINUTE, -1, P.EndingDate) AS EndingDate,
       Prg.CostValue AS InsSum,
       CASE P.IsProlonged
           WHEN 1 THEN
               'пролонгація'
       END AS IsProlonged,
       ptp.ParameterValue AS PersonCount,
       CASE P.IsAction
           WHEN 1 THEN
               'акція'
       END AS IsAction,
       P.Comment
FROM Products AS P
INNER JOIN Metis.dbo.Faces AS F
    ON F.gid = P.InsuredGID
LEFT JOIN Metis.dbo.Persons AS pers
    ON pers.gid = f.gid
INNER JOIN Programs AS Prg
    ON Prg.ProductGID = P.gid
INNER JOIN meta.ProgramTypes pt
    ON pt.gid = Prg.ProgramTypeGID
       AND pt.Code IN (
                          SELECT Code FROM @ProgramCode
                      )
LEFT JOIN dbo.ProgramToParameterValues AS ptp
    ON ptp.ProgramGID = prg.gid
       AND ptp.Deleted = 0
       AND ptp.ParameterGID = '1388B04C-97B0-4E1D-B697-E363D009293E'
INNER JOIN dbo.GetAgentCommissions AS comm
    ON comm.ProgramGID = Prg.gid
INNER JOIN
(
    SELECT SUM(PlanPay.Value) AS Value,
           PlanPay.ProgramGID AS ProgramGID
    FROM PlanedPayments AS PlanPay
    WHERE PlanPay.Deleted = 0
    GROUP BY PlanPay.ProgramGID
) AS TotalPayment
    ON TotalPayment.ProgramGID = comm.ProgramGID
INNER JOIN
(
    SELECT SUM(PlanPay.Value) AS Value,
           PlanPay.ProgramGID AS ProgramGID
    FROM PlanedPayments AS PlanPay
    INNER JOIN PaymentPeriods AS Per
        ON Per.gid = PlanPay.PaymentPeriodGID
           AND Per.Deleted = 0
           AND Per.PlanDate
           BETWEEN @payDateFrom AND @payDateTo
    WHERE PlanPay.Deleted = 0
    GROUP BY PlanPay.ProgramGID
) AS Payment
    ON Payment.ProgramGID = comm.ProgramGID
LEFT JOIN
(
    SELECT Per.ProductGID,
           MAX(Per.PlanDate) AS PlanDate,
           MAX(Per.[Date]) AS TicketDate
    FROM PaymentPeriods AS Per
    WHERE Per.PlanDate
    BETWEEN @payDateFrom AND @payDateTo
    GROUP BY ProductGID
) AS Pd
    ON Pd.ProductGID = P.gid
LEFT JOIN
(
    SELECT SUM(ISNULL(ptr.Value, 0)) AS Value,
           MAX(rp.PaymentDate) AS RealDate,
           pp.ProgramGID
    FROM PlanedPayments AS pp
    INNER JOIN PlanedToRealPayments AS ptr
        ON ptr.PlanedPaymentGID = pp.gid
           AND ptr.Deleted = 0
           AND pp.Deleted = 0
    INNER JOIN RealPayments AS rp
        ON rp.gid = ptr.RealPaymentGID
           AND rp.Deleted = 0
           AND rp.PaymentDate
           BETWEEN @payDateFrom AND @payDateTo
    GROUP BY pp.ProgramGID
) AS RealPay
    ON RealPay.ProgramGID = Prg.gid
INNER JOIN Branches AS B
    ON B.gid = P.BranchGID
WHERE (P.Deleted = 0)
      AND (P.gid NOT IN
           (
               SELECT CP.BaseProductGID
               FROM Products AS CP
               WHERE CP.BaseProductGID IS NOT NULL
                     AND CP.id > P.id
                     AND CP.Deleted = 0
           )
          )
      -- AND (LEFT(B.BranchCode, @ResultBranchCodeLength) = @ResultBranchCode)
      AND (P.RegisteredDate
      BETWEEN @regDateFrom AND @regDateTo
          )
ORDER BY P.AgentReportNumber,
         P.PolisNumber

