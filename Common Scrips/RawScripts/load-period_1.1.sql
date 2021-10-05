DECLARE @PrevPeriod AS bigint, @CDate AS date, @PDate AS date
SELECT @CDate=CP.ImportPeriod, @PrevPeriod=PP.ImportKey, @PDate=PP.ImportDate
FROM tWH.dbo.JupiterPeriods AS CP
	INNER JOIN tWH.dbo.JupiterPeriods AS PP ON PP.ImportPeriod=DATEADD(MONTH, -1, CP.ImportPeriod)
WHERE CP.ImportKey=@ImportPeriod

SELECT 
  SData.BranchCode, 
  SData.InsCode, 
  SData.PolisPeriod, 
  SData.PersonType, 
  SData.PolisNumber,
	CASE SData.PolisPeriod WHEN @CDate THEN SData.IsNew ELSE 0 END AS CPeriodCount,
	CASE SData.PolisPeriod WHEN @CDate THEN 0 ELSE SData.IsNew END AS PPeriodCount,
	CASE SData.PolisPeriod WHEN @CDate THEN SData.PaymentSum ELSE 0 END AS CPeriodPaymentSum,
	CASE SData.PolisPeriod WHEN @CDate THEN 0 ELSE SData.PaymentSum END AS PPeriodPaymentSum,
	CASE SData.PolisPeriod WHEN @CDate THEN SData.InsuranceSum ELSE 0 END AS CPeriodISum,
	CASE SData.PolisPeriod WHEN @CDate THEN 0 ELSE SData.InsuranceSum END AS PPeriodISum
FROM(
	SELECT ISNULL(NData.PolisNumber, OData.PolisNumber) AS PolisNumber, ISNULL(NData.InsType, OData.InsType) AS InsCode,
		ISNULL(NData.PersonType, OData.PersonType) AS PersonType, ISNULL(NData.PolisPeriod, OData.PolisPeriod) AS PolisPeriod,
		ISNULL(NData.BranchCode, OData.BranchCode) AS BranchCode, CONVERT(int, ISNULL(NData.IsNew, 0))-CONVERT(int, ISNULL(OData.IsNew, 0)) AS IsNew,
		ISNULL(NData.PaymentSum, 0)-ISNULL(OData.PaymentSum, 0) AS PaymentSum,
		ISNULL(NData.InsuranceSum, 0)-ISNULL(OData.InsuranceSum, 0) AS InsuranceSum
	FROM(
		SELECT P.PolisNumber, P.InsType, P.PersonType, P.PolisPeriod, P.BranchCode, P.IsNew, SUM(P.PaymentSum) AS PaymentSum, SUM(P.InsuranceSum) AS InsuranceSum
		FROM tWH.dbo.PG1 AS P
		WHERE P.ImportKey=@ImportPeriod
			AND P.PolisPeriod<=@CDate
			AND P.InsType IN (@InsCode)
			AND P.BeginingDate>='2011-01-01'
			AND LEFT(P.BranchCode, @ResultBranchCodeLength)=@ResultBranchCode
		GROUP BY P.PolisNumber, P.InsType, P.PersonType, P.PolisPeriod, P.BranchCode, P.IsNew, P.JupiterPeriod
	) AS NData
		FULL OUTER JOIN(
			SELECT P.PolisNumber, P.InsType, P.PersonType, P.PolisPeriod, P.BranchCode, P.IsNew, SUM(P.PaymentSum) AS PaymentSum, SUM(P.InsuranceSum) AS InsuranceSum
			FROM tWH.dbo.PG1 AS P
			WHERE P.ImportKey=@PrevPeriod
				AND P.PolisPeriod<@CDate
				AND P.InsType IN (@InsCode)
				AND P.BeginingDate>='2011-01-01'
				AND LEFT(P.BranchCode, @ResultBranchCodeLength)=@ResultBranchCode
			GROUP BY P.PolisNumber, P.InsType, P.PersonType, P.PolisPeriod, P.BranchCode, P.IsNew, P.JupiterPeriod
		) AS OData ON OData.PolisNumber=NData.PolisNumber
			AND OData.InsType=NData.InsType
			AND OData.PersonType=NData.PersonType
			AND OData.PolisPeriod=NData.PolisPeriod
			AND OData.IsNew=NData.IsNew
		
	WHERE ISNULL(NData.PaymentSum, 0)-ISNULL(OData.PaymentSum, 0)!=0
		OR ISNULL(NData.InsuranceSum, 0)-ISNULL(OData.InsuranceSum, 0)!=0
) AS SData