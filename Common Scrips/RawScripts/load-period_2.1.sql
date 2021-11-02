
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

		DROP TABLE IF EXISTS #temp

		SELECT JP.[id]
				,JP.[gid]
				,JP.[BranchCode]
				,JP.[PolisNumber]
				,JP.[InsType]
				,JP.[PersonType]
				,JP.[PolisPeriod]
				,JP.[RegisterdDate]
				,JP.[BeginingDate]
				,JP.[EndDate]
				,JP.[InsuredName]
				,JP.[PaymentDate]
				,JP.[PaymentSum]
				,JP.[PaymentKey]
				,JP.[PaymentComment]
				,JP.[PaymentPeriod]
				,JP.[CancelDate]
				,JP.[ImportKey]
				,@CurentPeriodImportKey AS [CurentPeriodImportKey]
		INTO #temp
		FROM [dbo].[JupiterPayments] AS JP
		WHERE JP.PolisPeriod<=JP.PaymentPeriod
      AND JP.ImportKey=@CurentPeriodImportKey
			AND JP.PaymentPeriod=@CurentPeriodDate

		INSERT INTO [Dmart].[Accounting].[Payments]
							([PaymentId]
							,[GID]
							,[BranchCode]
							,[PolisNumber]
							,[InsCode]
							,[PersonType]
							,[PolisPeriod]
							,[RegisterdDate]
							,[BeginingDate]
							,[EndDate]
							,[InsuredName]
							,[PaymentDate]
							,[PaymentSum]
							,[PaymentKey]
							,[PaymentComment]
							,[PaymentPeriod]
							,[CancelDate]
							,[ImportKey]
							,[CurentPeriodImportKey])
		SELECT * FROM #temp WHERE id =  '1351722966'
	END
GO



