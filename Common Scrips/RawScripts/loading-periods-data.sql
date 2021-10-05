
DECLARE @RowId INT = 0;
DECLARE @HasValue INT = 1;




WHILE (@HasValue = 1)
	BEGIN


		DECLARE @PreviousPeriodImportKey AS BIGINT;
		DECLARE @CurentPeriodDate AS DATE ;
		DECLARE @PreviousPeriodDate AS DATE;
		DECLARE @CurentPeriodImportKey INT;

		SELECT 
			@PreviousPeriodImportKey = PP.ImportKey,
			@PreviousPeriodDate = DATEADD(MONTH, 1, PP.ImportPeriod),
			@CurentPeriodImportKey = P.ImportKey,
			@CurentPeriodDate = P.ImportPeriod
		FROM tWH.dbo.JupiterPeriods AS P
		INNER JOIN tWH.dbo.JupiterPeriods AS PP
			ON P.id - 1 = PP.id
		WHERE YEAR(DATEADD(MONTH, 1, PP.ImportPeriod)) >= 2020
		ORDER BY P.id desc
		OFFSET @RowId ROWS FETCH NEXT 1 ROWS ONLY

		SET @HasValue = @@ROWCOUNT
		SET @RowId = @RowId + @HasValue		

		
		INSERT INTO [Accounting].[AccrualEntry]
           ([ProductGid]
           ,[PolisNumber]
           ,[InsCode]
           ,[PersonType]
           ,[PolisPeriod]
           ,[BranchCode]
           ,[IsNew]
           ,[PaymentSum]
           ,[InsuranceSum]
           ,[CPeriodCount]
           ,[PPeriodCount]
           ,[CPeriodPaymentSum]
           ,[PPeriodPaymentSum]
           ,[CPeriodISum]
           ,[PPeriodISum]
           ,[CurentPeriodImportKey])
		SELECT
			SData.ProductGid,
			SData.PolisNumber,
			SData.InsCode,
			SData.PersonType, 
			SData.PolisPeriod, 
			SData.BranchCode, 
			SData.IsNew, 
			SData.PaymentSum, 
			SData.InsuranceSum,
			
			CASE SData.PolisPeriod WHEN @CurentPeriodDate THEN SData.IsNew ELSE 0 END AS CPeriodCount,
			CASE SData.PolisPeriod WHEN @CurentPeriodDate THEN 0 ELSE SData.IsNew END AS PPeriodCount,
			CASE SData.PolisPeriod WHEN @CurentPeriodDate THEN SData.PaymentSum ELSE 0 END AS CPeriodPaymentSum,
			CASE SData.PolisPeriod WHEN @CurentPeriodDate THEN 0 ELSE SData.PaymentSum END AS PPeriodPaymentSum,
			CASE SData.PolisPeriod WHEN @CurentPeriodDate THEN SData.InsuranceSum ELSE 0 END AS CPeriodISum,
			CASE SData.PolisPeriod WHEN @CurentPeriodDate THEN 0 ELSE SData.InsuranceSum END AS PPeriodISum,

			cast(LEFT(convert(nvarchar(10), @CurentPeriodImportKey), 8) as int) AS CurentPeriodImportKey
		FROM(
			SELECT 
				ISNULL(NData.gid, OData.gid) AS ProductGid,
				ISNULL(NData.PolisNumber, OData.PolisNumber) AS PolisNumber, 
				ISNULL(NData.InsType, OData.InsType) AS InsCode,
				ISNULL(NData.PersonType, OData.PersonType) AS PersonType, 
				ISNULL(NData.PolisPeriod, OData.PolisPeriod) AS PolisPeriod,
				ISNULL(NData.BranchCode, OData.BranchCode) AS BranchCode, 
				CONVERT(int, ISNULL(NData.IsNew, 0))-CONVERT(int, ISNULL(OData.IsNew, 0)) AS IsNew,
				ISNULL(NData.PaymentSum, 0)-ISNULL(OData.PaymentSum, 0) AS PaymentSum,
				ISNULL(NData.InsuranceSum, 0)-ISNULL(OData.InsuranceSum, 0) AS InsuranceSum
			FROM(
				SELECT P.gid, P.PolisNumber, P.InsType, P.PersonType, P.PolisPeriod, P.BranchCode, P.IsNew, SUM(P.PaymentSum) AS PaymentSum, SUM(P.InsuranceSum) AS InsuranceSum
				FROM tWH.dbo.PG1 AS P
				WHERE P.ImportKey=@CurentPeriodImportKey
					AND P.PolisPeriod<=@CurentPeriodDate
					AND P.BeginingDate>='2011-01-01'	
				GROUP BY P.gid, P.PolisNumber, P.InsType, P.PersonType, P.PolisPeriod, P.BranchCode, P.IsNew, P.JupiterPeriod
			) AS NData
				FULL OUTER JOIN(
					SELECT P.gid, P.PolisNumber, P.InsType, P.PersonType, P.PolisPeriod, P.BranchCode, P.IsNew, SUM(P.PaymentSum) AS PaymentSum, SUM(P.InsuranceSum) AS InsuranceSum
					FROM tWH.dbo.PG1 AS P
					WHERE P.ImportKey=@PreviousPeriodImportKey
						AND P.PolisPeriod<@PreviousPeriodDate
						AND P.BeginingDate>='2011-01-01'
					GROUP BY P.gid,P.PolisNumber, P.InsType, P.PersonType, P.PolisPeriod, P.BranchCode, P.IsNew, P.JupiterPeriod
				) AS OData ON OData.PolisNumber=NData.PolisNumber
					AND OData.InsType=NData.InsType
					AND OData.PersonType=NData.PersonType
					AND OData.PolisPeriod=NData.PolisPeriod
					AND OData.IsNew=NData.IsNew
		
			WHERE ISNULL(NData.PaymentSum, 0)-ISNULL(OData.PaymentSum, 0)!=0
				OR ISNULL(NData.InsuranceSum, 0)-ISNULL(OData.InsuranceSum, 0)!=0
			) AS SData

	END



