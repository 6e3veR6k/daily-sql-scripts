SELECT
  Main.PolisNumber,
  Main.InsCode,
  Main.BranchCode,
  Main.PersonType,
  Main.CurentPeriodImportKey,
  SUM(Main.CPeriodPaymentSum) AS CPeriodPaymentSum,
  SUM(Main.CPeriodCount) AS CPeriodCount,
  SUM(Main.CPeriodISum) AS CPeriodISum,
  SUM(Main.Payment) AS Payment
FROM (
SELECT
  AE.PolisNumber,
  AE.InsCode,
  AE.PersonType,
  AE.BranchCode,
  AE.CPeriodPaymentSum,
  AE.CPeriodCount,
  AE.CPeriodISum,
  0 AS Payment,
  AE.CurentPeriodImportKey
FROM Accounting.AccrualEntry AS AE
UNION ALL
SELECT
  P.PolisNumber,
  P.InsCode,
  P.PersonType,
  P.BranchCode,
  0 AS CPeriodPaymentSum,
  0 AS CPeriodCount,
  0 AS CPeriodISum,
  P.PaymentSum AS Payment,
  cast(LEFT(convert(nvarchar(10), P.CurentPeriodImportKey), 8) as int) AS CurentPeriodImportKey
FROM Accounting.Payments as P
) AS Main
-- WHERE Main.CurentPeriodImportKey = 20200101
-- WHERE Main.PolisNumber = '0013872'
GROUP BY  Main.PolisNumber,
  Main.InsCode,
  Main.BranchCode,
  Main.PersonType,
  Main.CurentPeriodImportKey
ORDER BY Main.PolisNumber