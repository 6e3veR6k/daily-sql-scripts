-- 2021080101
DECLARE @CJP AS bigint = 2021080101
DECLARE @PJP AS bigint
SELECT @PJP=PP.ImportKey
FROM tWH.dbo.JupiterPeriods AS CP
	INNER JOIN tWH.dbo.JupiterPeriods AS PP ON PP.ImportPeriod=DATEADD(MM, -1, CP.ImportPeriod)
WHERE CP.ImportKey=@CJP

declare @Temp as table (gid uniqueidentifier)
insert into @Temp
SELECT
	P.gid
FROM (
SELECT DISTINCT P.PolisNumber, P.BranchCode
FROM tWH.dbo.PG7 AS P
	INNER JOIN tWH.dbo.JupiterPeriods AS JP ON JP.ImportKey=P.ImportKey
		AND JP.ImportKey=@CJP
WHERE P.CancelPeriod<=JP.ImportPeriod
	-- AND LEFT(P.BranchCode, @ResultBranchCodeLength)=@ResultBranchCode
	AND P.InsType IN ('233', '234', '236')
EXCEPT
SELECT DISTINCT P.PolisNumber, P.BranchCode
FROM tWH.dbo.PG7 AS P
	INNER JOIN tWH.dbo.JupiterPeriods AS JP ON JP.ImportKey=P.ImportKey
		AND JP.ImportKey=@PJP
WHERE P.CancelPeriod<=JP.ImportPeriod
	-- AND LEFT(P.BranchCode, @ResultBranchCodeLength)=@ResultBranchCode
	AND P.InsType IN ('233', '234', '236')
) AS C
INNER JOIN OrantaSch.dbo.Products as P ON P.PolisNumber = C.PolisNumber
and P.Deleted = 0


SELECT DISTINCT 
	CAST(PolisData.PolisNumber AS nvarchar(150)) AS PolisNumber,
	CAST(PolisData.BranchCode AS nchar(10)) AS BranchCode,
	CAST(PolisData.sagr AS nvarchar(2)) AS sagr,
	CAST(PolisData.nagr AS int) AS nagr,
	PolisData.compl,
	PolisData.d_beg,
	PolisData.d_end,
	PolisData.c_term,
	PolisData.d_distr,
	NULL AS is_active1,
	NULL AS is_active2,
	NULL AS is_active3,
	NULL AS is_active4,
	NULL AS is_active5,
	NULL AS is_active6,
	NULL AS is_active7,
	NULL AS is_active8,
	NULL AS is_active9,
	NULL AS is_active10,
	NULL AS is_active11,
	NULL AS is_active12,
	PolisData.c_privileg,
	(PolisData.c_discount/5) AS c_discount,
	CAST(PolisData.zone AS nvarchar(10)) AS zone,
	CASE PolisData.b_m
		WHEN 99 THEN CONVERT(int, 14)
		ELSE PolisData.b_m
	END AS b_m,
	PolisData.K1,
	PolisData.K2,
	PolisData.K3,
	PolisData.K4,
	PolisData.K5,
	PolisData.K6,
	PolisData.K7,
	PolisData.limit_life,
	PolisData.limit_prop,
	PolisData.franchise,
	CAST(PolisData.t_agr AS nchar(1)) AS t_agr,
	PolisData.payment,
	PolisData.paym_bal,
	'' AS note,
	PolisData.d_abort,
	PolisData.retpayment,
	CONVERT(nvarchar(2), NULL) AS chng_sagr,
	CONVERT(int, NULL) AS chng_nagr,
	CASE PolisData.resident
		WHEN 1 THEN 'True'
		ELSE 'False'
	END AS resident,
	CASE PolisData.status_prs
		WHEN 1 THEN 'Ф'
		ELSE 'Ю'
	END AS status_prs,
	CAST(PolisData.numb_ins AS nchar(12)) AS numb_ins,
	PolisData.f_name,
	PolisData.s_name,
	PolisData.p_name,
	PolisData.birth_date,
	CAST(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(PolisData.phone, '-', ''), ')', ''), '(', ''), ' ', ''), '+', '') AS nvarchar(30)) AS phone,
	'' AS doc_name,
	LEFT(PolisData.InsPassNumber, 2) AS doc_series,
	SUBSTRING(PolisData.InsPassNumber, 4, 10) AS doc_no,
	CASE PolisData.person_s
		WHEN 0 THEN 'Ж'
		WHEN 1 THEN 'М'
	END AS person_s,
	PolisData.c_city,
	PolisData.ser_ins AS ser_ins,
	PolisData.num_ins,
	PolisData.exprn_ins,
	PolisData.drv_cnt,
	CASE PolisData.person_s1
		WHEN 0 THEN 'Ж'
		WHEN 1 THEN 'М'
	END AS person_s1,
	PolisData.f_name1,
	PolisData.s_name1,
	PolisData.p_name1,
	PolisData.ins1,
	PolisData.exprn_ins1,
	CASE PolisData.person_s2
		WHEN 0 THEN 'Ж'
		WHEN 1 THEN 'М'
	END AS person_s2,
	PolisData.f_name2,
	PolisData.s_name2,
	PolisData.p_name2,
	PolisData.ins2,
	PolisData.exprn_ins2,
	CASE PolisData.person_s3
		WHEN 0 THEN 'Ж'
		WHEN 1 THEN 'М'
	END AS person_s3,
	PolisData.f_name3,
	PolisData.s_name3,
	PolisData.p_name3,
	PolisData.ins3,
	PolisData.exprn_ins3,
	CASE PolisData.person_s4
		WHEN 0 THEN 'Ж'
		WHEN 1 THEN 'М'
	END AS person_s4,
	PolisData.f_name4,
	PolisData.s_name4,
	PolisData.p_name4,
	PolisData.ins4,
	PolisData.exprn_ins4,
	PolisData.[auto],
	PolisData.reg_no,
	PolisData.vin,
	CASE PolisData.c_type
		WHEN 'B1' THEN 1
		WHEN 'B2' THEN 2
		WHEN 'B3' THEN 3
		WHEN 'B4' THEN 4
		WHEN 'A1' THEN 5
		WHEN 'A2' THEN 6
		WHEN 'C1' THEN 7
		WHEN 'C2' THEN 8
		WHEN 'D1' THEN 9
		WHEN 'D2' THEN 10
		WHEN 'F' THEN 11
		WHEN 'E' THEN 12
		WHEN 'B' THEN 13
		WHEN 'A' THEN 14
		WHEN 'C' THEN 15
		WHEN 'D' THEN 16
		WHEN 'B5' THEN 17
	END AS c_type,
	PolisData.c_mark,
	PolisData.mark_txt,
	PolisData.model_txt,
	PolisData.prod_year,
	CASE PolisData.sphere_use
		WHEN 'Таксі' THEN 2
		ELSE 1
	END AS sphere_use,
	CASE PolisData.need_to
		WHEN 'Так' THEN 'True'
		ELSE 'False'
	END AS need_to,
	PolisData.date_next_to,
	CASE
		WHEN PolisData.c_exp<=3 THEN 2
		ELSE 1
	END AS c_exp,
	PolisData.ErrorFlag
FROM(
	SELECT PolisData.PolisNumber,
		PolisData.BranchCode,
		IIF(SUBSTRING(PolisData.PolisNumber, 1, 1) = '1', NULL, LEFT(PolisData.PolisNumber, 2)) AS sagr,
		IIF(SUBSTRING(PolisData.PolisNumber, 1, 1) = '1', PolisData.PolisNumber, SUBSTRING(PolisData.PolisNumber, 4, 7)) AS nagr,
		--SUBSTRING(PolisData.PolisNumber, 4, 7) AS nagr,
		PolisData.compl,
		PolisData.d_beg,
		PolisData.d_end,
		CASE
			WHEN DATEDIFF(D, PolisData.d_beg, PolisData.d_end)<20 THEN 0
			ELSE DATEDIFF(MM, PolisData.d_beg, PolisData.d_end)+1
		END AS c_term,
		PolisData.d_distr,
		PolisData.c_privileg,
		PolisData.c_discount,
		PolisData.zone,
		PolisData.b_m,
		PolisData.K1,
		PolisData.K2,
		PolisData.K3,
		PolisData.K4,
		PolisData.K5,
		PolisData.K6,
		PolisData.K7,
		PolisData.limit_life,
		PolisData.limit_prop,
		PolisData.franchise,
		PolisData.t_agr,
		PolisData.payment,
		PolisData.paym_bal,
		PolisData.d_abort,
		PolisData.retpayment,
		PolisData.resident,
		PolisData.status_prs,
		PolisData.numb_ins,
		PolisData.f_name,
		PolisData.s_name,
		PolisData.p_name,
		PolisData.birth_date,
		PolisData.phone,
		'' AS doc_name,
		PolisData.InsPassNumber,
		PolisData.person_s,
		PolisData.c_city,
		PolisData.ser_ins,
		PolisData.num_ins,
		PolisData.exprn_ins,
		PolisData.drv_cnt,
		PolisData.person_s1,
		PolisData.f_name1,
		PolisData.s_name1,
		PolisData.p_name1,
		PolisData.ins1,
		PolisData.exprn_ins1,
		PolisData.person_s2,
		PolisData.f_name2,
		PolisData.s_name2,
		PolisData.p_name2,
		PolisData.ins2,
		PolisData.exprn_ins2,
		PolisData.person_s3,
		PolisData.f_name3,
		PolisData.s_name3,
		PolisData.p_name3,
		PolisData.ins3,
		PolisData.exprn_ins3,
		PolisData.person_s4,
		PolisData.f_name4,
		PolisData.s_name4,
		PolisData.p_name4,
		PolisData.ins4,
		PolisData.exprn_ins4,
		PolisData.mark_txt+' '+PolisData.model_txt AS [auto],
		PolisData.reg_no,
		PolisData.vin,
		PolisData.c_type,
		PolisData.c_mark,
		PolisData.mark_txt,
		PolisData.model_txt,
		PolisData.prod_year,
		PolisData.sphere_use,
		PolisData.need_to,
		PolisData.date_next_to,
		PolisData.c_exp,
		COUNT(PolisData.gid) OVER (PARTITION BY PolisData.[PolisNumber]) AS ErrorFlag,
		PolisData.gid
	FROM @Temp AS PeriodData
		LEFT JOIN(
			SELECT P.PolisNumber, P.gid,
				B.BranchCode,
				CONVERT(int, 2) AS compl,
				CONVERT(date, P.BeginingDate) AS d_beg,
				CONVERT(date, DATEADD(MI, -1, P.EndingDate)) AS d_end,
				CONVERT(date, P.RegisteredDate) AS d_distr,
				Params.c_privileg,
				Params.c_discount,
				CASE Params.zone
					WHEN '1' THEN '1'
					WHEN '2' THEN '6'
					WHEN '3' THEN '2'
					WHEN '4' THEN '3'
					WHEN '5' THEN '4'
					WHEN '6' THEN '5'
					WHEN '7' THEN '7'
					ELSE ''
				END AS zone,
				ISNULL(Params.b_m, 3) AS b_m,
				Params.K1,
				Params.K2,
				Params.K3,
				Params.K4,
				Params.K5,
				Params.K6,
				Params.K7,
				CoverFranchise.HealthCover AS limit_life,
				CoverFranchise.EstateCover AS limit_prop,
				CoverFranchise.Franchise AS franchise,
				Params.t_agr,
				PPay.PValue AS payment,
				PPay.RValue AS paym_bal,
				PC.CancelDate AS d_abort,
				(CAST(ISNULL(RetPayment.Value, 0) AS decimal(18, 2)) + PPay.PValue - PPay.BValue) AS retpayment,
				CASE O.CountryGID
					WHEN '0F52ADF4-F544-42D6-BEA6-AD656AB683DF' THEN CONVERT(bit, 1)
					ELSE CONVERT(bit, 0)
				END AS resident,
				CASE F.PersonTypeID
					WHEN 2 THEN 2
					ELSE 1
				END AS status_prs,
				F.FaceID AS numb_ins,
				CASE F.PersonTypeID
					WHEN 2 THEN F.FullName
					ELSE F.Lastname
				END AS f_name,
				ISNULL(F.Firstname, '') AS s_name,
				ISNULL(F.Secondname, '') AS p_name,
				F.Birthdate AS birth_date,
				F.PhoneNumber AS phone,
				'' AS doc_name,
				DPers.InsPass AS InsPassNumber,
				F.IsMan AS person_s,
				CASE Params.zone
				WHEN '7' THEN 3345
				ELSE ISNULL(V.MTSBUID, 0)
				END AS c_city,
				LEFT(DPers.DLic, 3) AS ser_ins,
				SUBSTRING(REPLACE(DPers.DLic, '-',''), 4, 10) AS num_ins,
				F.DriverFrom AS exprn_ins,
				CONVERT(int, NULL) AS drv_cnt,
				CONVERT(int, NULL) AS person_s1,
				CONVERT(nvarchar(100), '') AS f_name1,
				CONVERT(nvarchar(100), '') AS s_name1,
				CONVERT(nvarchar(100), '') AS p_name1,
				CONVERT(nvarchar(100), NULL) AS ins1,
				CONVERT(int, NULL) AS exprn_ins1,
				CONVERT(int, NULL) AS person_s2,
				CONVERT(nvarchar(100), '') AS f_name2,
				CONVERT(nvarchar(100), '') AS s_name2,
				CONVERT(nvarchar(100), '') AS p_name2,
				CONVERT(nvarchar(100), '') AS ins2,
				CONVERT(int, NULL) AS exprn_ins2,
				CONVERT(int, NULL) AS person_s3,
				CONVERT(nvarchar(100), '') AS f_name3,
				CONVERT(nvarchar(100), '') AS s_name3,
				CONVERT(nvarchar(100), '') AS p_name3,
				CONVERT(nvarchar(100), '') AS ins3,
				CONVERT(int, NULL) AS exprn_ins3,
				CONVERT(int, NULL) AS person_s4,
				CONVERT(nvarchar(100), '') AS f_name4,
				CONVERT(nvarchar(100), '') AS s_name4,
				CONVERT(nvarchar(100), '') AS p_name4,
				CONVERT(nvarchar(100), NULL) AS ins4,
				CONVERT(int, NULL) AS exprn_ins4,
				V.[auto],
				V.reg_no,
				V.vin,
				V.OTc_type AS c_type,
				V.c_mark,
				V.mark_txt,
				V.model_txt,
				V.ProducedDate AS prod_year,
				Params.sphere_use,
				Params.need_to,
				Params.date_next_to,
				CASE F.PersonTypeID
					WHEN 2 THEN CONVERT(int, NULL)
					ELSE Params.c_exp
				END AS c_exp
			FROM Products AS P
				INNER JOIN ProductCancels AS PC ON PC.gid=P.gid
					AND PC.Deleted=0
					AND PC.ProductCancelTypeGID!='BBB24EEE-E2F0-457F-BFA3-6F11F44D1930'
				INNER JOIN Branches AS B ON B.gid=P.BranchGID
					AND B.BranchCode IS NOT NULL
					-- AND LEFT(B.BranchCode, @ResultBranchCodeLength)=@ResultBranchCode
				INNER JOIN Programs AS Pg ON Pg.ProductGID=P.gid
					AND Pg.Deleted=0
				INNER JOIN meta.ProgramTypes AS PT ON PT.gid=Pg.ProgramTypeGID
					AND PT.Code IN ('233', '234', '236')
				INNER JOIN ServiceBase.dbo.OSAGOParametersSB as Params
					ON Params.ProgramGID=Pg.gid
			--Автомобиль
				INNER JOIN ServiceBase.dbo.OSAGOVehicleSB as V
					ON V.ProgramGID = Pg.gid
			--Разбираем платежи
				INNER JOIN(
					SELECT PPay.ProgramGID, SUM(PPay.Value) AS PValue,
						SUM(ISNULL(PTR.Value, 0)) AS RValue, SUM(PTR.BValue) AS BValue
					FROM PlanedPayments AS PPay
						LEFT JOIN(
							SELECT PTR.PlanedPaymentGID, SUM(PTR.Value) AS BValue,
								SUM(CASE ISNULL(M.Value, 0)
									WHEN 0 THEN 0
									ELSE PTR.Value
								END) AS Value
							FROM PlanedToRealPayments AS PTR
								LEFT JOIN(Ganimed.dbo.Moneys AS M
									INNER JOIN Ganimed.dbo.BankPayments AS BP ON BP.gid=M.FromGID
										AND BP.Deleted=0
								) ON M.ToGID=PTR.RealPaymentGID
									AND M.Deleted=0
							WHERE PTR.Deleted=0
							GROUP BY PTR.PlanedPaymentGID
						) AS PTR ON PTR.PlanedPaymentGID=PPay.gid
					WHERE PPay.Deleted=0
						AND PPay.Value>0
					GROUP BY PPay.ProgramGID
				) AS PPay ON PPay.ProgramGID=Pg.gid
				LEFT JOIN(
					SELECT SUM(S.Value) AS Value, JP.JupiterEntityGID
					FROM Ganimed.dbo.JupiterPayments AS JP
						INNER JOIN Ganimed.dbo.Sources AS S ON S.gid=JP.gid
							AND S.Deleted=0
					WHERE JP.Deleted=0
					GROUP BY JP.JupiterEntityGID
				) AS RetPayment ON RetPayment.JupiterEntityGID=P.gid
			--Покрытие
				INNER JOIN ServiceBase.dbo.OSAGOFranchiseValuesSB AS CoverFranchise
					   ON CoverFranchise.InsuredObjectGID = V.ObjectGID

				INNER JOIN Signers AS Ins ON Ins.gid=P.InsurerGID
					AND Ins.Deleted=0
				INNER JOIN Metis.dbo.Objects AS O ON O.gid=Ins.FaceGID
				INNER JOIN Metis.dbo.Faces AS F ON F.gid=O.gid
				LEFT JOIN(
					SELECT D.ObjectGID,
						MAX(CASE D.DocumentTypeGID
							WHEN '357BED28-00FC-479A-B3AB-A8FC8B2DE094' THEN D.Number
							ELSE ''
						END) AS InsPass,
						MAX(CASE D.DocumentTypeGID
							WHEN '7ACAE121-776B-467C-8FDC-C47F09C184EE' THEN D.Number
							ELSE ''
						END) AS DLic
					FROM Metis.dbo.Documents AS D
					WHERE D.Deleted=0
						AND D.DocumentTypeGID IN (
							'7ACAE121-776B-467C-8FDC-C47F09C184EE',
							'357BED28-00FC-479A-B3AB-A8FC8B2DE094'
						)
					GROUP BY D.ObjectGID
				) AS DPers ON DPers.ObjectGID=O.gid
			WHERE P.Deleted=0
		) AS PolisData ON PolisData.gid=PeriodData.gid
) AS PolisData


/***********************************************************************************************************************************/
/*
SELECT P.PolisNumber, C.*
FROM [DmartTest].[Osago].[Products] AS P
INNER JOIN DmartTest.Osago.ProductCancels AS C ON C.ProductId = P.ProductId
WHERE P.PolisNumber IN ('205008363', '205115122')
*/