DECLARE @registeredDateFrom DATE = '20210701'
DECLARE @registeredDateTo DATE = '20210701'

DECLARE @MyTableVar table ( InsCode int NOT NULL, GroupId int NULL );
INSERT INTO @MyTableVar
SELECT
    DISTINCT  Code,
    CASE
	    WHEN Code IN ('234', '233', '235', '236') THEN '1'  	-- osago
	    WHEN Code IN ('231', '232') THEN '2' 			-- greencard
	    WHEN Code BETWEEN '211' AND '229' THEN '3'	-- casco
	    WHEN Code IN ('241', '243', '244', '245') THEN '4'	-- dzv		
    END AS  GroupId
FROM OrantaSch.meta.ProgramTypes

SELECT 
	B.BranchCode,
	ISNULL(C.ContractNumber, P.Number) AS Number,
	SAT.Name AS AgreementName,
	P.PolisNumber,
	Sticker.Number AS Sticker,
	P.RegisteredDate,
	P.BeginingDate,
	DATEADD(S, -1, P.EndingDate) AS EndingDate,
	PT.Code AS InsCode,
	
	CASE Insurer.PersonTypeID
	WHEN 2 THEN JPer.FullName
	ELSE Per.Lastname+' '+Per.Firstname+' '+Per.Secondname
	END AS InsurerName,

	Insurer.IdentificationCode AS INN,

	CASE Insurer.PersonTypeID
		WHEN 2 THEN 2
		ELSE 1
	END AS PersonType,

	VMan.Name AS Mark,
	VMod.Name AS Model,
	ISNULL(VS.Name, V.RegistrationPlace) AS RegistrationPlace,
	V.RegistrationNumber,
	V.BodyNumber,
	V.ProducedDate,
	Pg.CostValue,
	Payment.PValue AS PValue,
	Payment.RValue AS RValue,
	BM.b_m AS BonusM,   --бонус-малус Параметри
	TerrValue.Value AS Terr,
	BenefitValue.Value AS BenefitValue,
	P.Comment,
	RTRIM(LEFT(OT.Name, 2)) AS c_type,
	CoverFranchise.Franchise,
	Cm.[Агент 1] AS agent1,
	Cm.[Агент 2] AS agent2,
	Cm.[Агент 3] AS agent3,
	Cm.[Комісійна винагорода 1] AS percent1,
	Cm.[Комісійна винагорода 2] AS percent2,
	Cm.[Комісійна винагорода 3] AS percent3


FROM  OrantaSch.dbo.Products AS P
INNER JOIN OrantaSch.dbo.Programs AS Pg ON Pg.ProductGID = P.gid AND Pg.Deleted = 0
INNER JOIN
  ( SELECT
      PPay.ProgramGID,
      SUM(PPay.Value) AS PValue, 
      ISNULL(PTR.Value, 0) AS RValue
		FROM OrantaSch.dbo.PlanedPayments AS PPay
		LEFT JOIN
		  ( SELECT SUM(PTR.Value) AS Value, PTR.PlanedPaymentGID
				FROM PlanedToRealPayments AS PTR
				WHERE PTR.Deleted = 0
				GROUP BY PTR.PlanedPaymentGID
			) AS PTR 
        ON PTR.PlanedPaymentGID = PPay.gid
		WHERE PPay.Deleted = 0
		GROUP BY PPay.ProgramGID, PTR.Value
  ) AS Payment
    ON Payment.ProgramGID = Pg.gid
INNER JOIN dbo.GetAgentCommissions AS Cm ON Cm.ProgramGID = Pg.gid
LEFT JOIN dbo.Contracts AS C ON C.gid = P.ContractGID AND C.Deleted = 0
LEFT JOIN meta.SupplementaryAgreementTypes AS SAT ON SAT.gid = P.SupplementaryAgreementTypeGID
INNER JOIN OrantaSch.dbo.Branches AS B ON B.gid = P.BranchGID
  AND B.BranchCode IS NOT NULL
	-- AND LEFT(B.BranchCode, @ResultBranchCodeLength) = @ResultBranchCode
INNER JOIN meta.ProgramTypes AS PT ON PT.gid = Pg.ProgramTypeGID
INNER JOIN @MyTableVar  AS PTCode ON PTCode.InsCode = PT.Code
  AND PTCode.GroupId  =  '1'
LEFT JOIN OrantaSch.dbo.GetFirstSticker AS Sticker ON Sticker.ProductGID = P.gid
INNER JOIN Metis.dbo.Objects AS OInsurer ON OInsurer.gid = P.InsuredGID
INNER JOIN InsuranceObjects AS IOb ON IOb.ProgramGID = Pg.gid
  AND IOb.Deleted = 0
INNER JOIN meta.ObjectTypes AS OT ON OT.gid = IOb.ObjectTypeGID

INNER JOIN Metis.dbo.Faces AS Insurer ON Insurer.gid = OInsurer.gid
LEFT JOIN Metis.dbo.JuridicalPersons AS JPer ON JPer.gid = Insurer.gid
LEFT JOIN Metis.dbo.Persons AS Per ON Per.gid = Insurer.gid
LEFT JOIN Metis.dbo.GetAddress AS PostAddress ON PostAddress.gid = Insurer.PostAddressGID
LEFT JOIN Metis.dbo.GetAddress AS ActualAddress ON ActualAddress.gid = Insurer.PostActualAddressGID
INNER JOIN meta.InsuranceObjectTypes AS IOT ON IOT.gid = IOb.InsuranceObjectTypeGID AND IOT.Risked = 1
INNER JOIN Metis.dbo.Vehicles AS V ON V.gid = IOb.ObjectGID
LEFT JOIN Metis.dbo.Settlements AS VS ON VS.gid = V.SettlementGID
INNER JOIN Metis.meta.VehicleManufacturers AS VMan ON VMan.gid = V.ManufacturerGID
INNER JOIN Metis.meta.VehicleModels AS VMod ON VMod.gid = V.ModelGID
INNER JOIN Metis.dbo.Objects AS VO ON VO.gid = V.gid
INNER JOIN Metis.meta.Countries AS VCountry ON VCountry.gid = VO.CountryGID
INNER JOIN
(
		SELECT C.InsuredObjectGID,
			MAX(CASE C.RiskGID
				WHEN 'CAEBC7AB-9DD5-45E6-9ADC-A0FF3BDE6B0E' THEN C.CoverLimit
				ELSE 0
			END) AS EstateCover,
			MAX(CASE C.RiskGID
				WHEN 'C1133FB1-BCE1-4AEC-B544-E00870602AFF' THEN C.CoverLimit
				ELSE 0
			END) AS HealthCover,
			MAX(TRY_CONVERT(int, ISNULL(CONVERT(nvarchar(40), FTV.Value), ISNULL(CONVERT(nvarchar(40), F.FranchiseValue), '0')))) AS Franchise

		FROM Covers AS C
			LEFT JOIN Franchises AS F ON F.CoverGID = C.gid
				AND F.Deleted = 0
			LEFT JOIN meta.FranchiseTypeValues AS FTV ON CONVERT(nvarchar(40), FTV.gid) = CONVERT(nvarchar(40), F.FranchiseValue)
		WHERE C.Deleted = 0
		GROUP BY C.InsuredObjectGID
) AS CoverFranchise ON CoverFranchise.InsuredObjectGID = IOb.gid
LEFT JOIN
  ( SELECT 
      MAX(CASE PTPV.ParameterGID 
      WHEN 'D3CC1D06-C28E-47D3-8180-61921FFCBE84' THEN CONVERT(int, BMValue.Value)
      WHEN '6EEB4159-2613-4EF4-B2BA-F440FAA9D72D' 
        THEN
        CASE PTPV.ParameterValue
          WHEN	CAST('9E9724A9-077E-4FB5-BED8-E20C2410FFBC' AS UNIQUEIDENTIFIER) THEN 13
          WHEN	CAST('A016EF04-4472-4C83-92C5-58823AAADCDB' AS UNIQUEIDENTIFIER) THEN 12
          WHEN	CAST('39A1AA5B-C8C3-4BFB-878D-04B6CA33FEA3' AS UNIQUEIDENTIFIER) THEN 11
          WHEN	CAST('F2C1A5EF-0055-416E-A0B4-93418A49C968' AS UNIQUEIDENTIFIER) THEN 10
          WHEN	CAST('185ED4F8-52E3-4A74-80BE-F3F256E59092' AS UNIQUEIDENTIFIER) THEN 9
          WHEN	CAST('BB60E0FB-7C84-47E5-B36E-93B2D7E9C4AD' AS UNIQUEIDENTIFIER) THEN 8
          WHEN	CAST('908F6EAB-CA21-4EEE-9313-4C7A50A91897' AS UNIQUEIDENTIFIER) THEN 7
          WHEN	CAST('B69A52D5-D215-4249-89D3-9854E2E6CB7D' AS UNIQUEIDENTIFIER) THEN 6
          WHEN	CAST('85BBA309-78BF-4CC7-A51A-7C93925048E7' AS UNIQUEIDENTIFIER) THEN 5
          WHEN	CAST('12F17376-8FBF-4399-9C0A-A45E43A855A5' AS UNIQUEIDENTIFIER) THEN 4
          WHEN	CAST('70119069-B5BC-49B9-B2DB-451BB22FDFB3' AS UNIQUEIDENTIFIER) THEN 3
          WHEN	CAST('6A6EDC4C-0A5D-4704-9428-D065C91B2698' AS UNIQUEIDENTIFIER) THEN 2
          WHEN	CAST('E9CCAF6F-4A9E-4CC3-BD7E-7C9B0971AAB4' AS UNIQUEIDENTIFIER) THEN 1
          WHEN	CAST('69FB0E60-F54F-4DA7-802A-C958AC69CE5E' AS UNIQUEIDENTIFIER) THEN 0
          WHEN	CAST('D0658BB5-375C-46F3-A3FF-91C9DD511703' AS UNIQUEIDENTIFIER) THEN 'M'
        END
      END) AS b_m,
      PTPV.ProgramGID
    FROM dbo.ProgramToParameterValues AS PTPV 
	  INNER JOIN meta.ProgramParameterValues AS BMValue ON BMValue.gid = PTPV.ParameterValueGUIDKey  
		  AND PTPV.Deleted = 0
    GROUP BY PTPV.ProgramGID
  ) AS BM 
    ON BM.ProgramGID = Pg.gid					
LEFT JOIN
  (	dbo.ProgramToParameterValues AS Terr
		INNER JOIN meta.ProgramParameterValues AS TerrValue ON TerrValue.gid = Terr.ParameterValueGUIDKey
	) ON Terr.ProgramGID = Pg.gid 
    AND Terr.ParameterGID = 'AF37DC18-E364-4A84-87B1-2554FE4ACC69' AND Terr.Deleted = 0
LEFT JOIN	
  ( dbo.ProgramToParameterValues AS Benefit
		INNER JOIN meta.ProgramParameterValues AS BenefitValue ON BenefitValue.gid = Benefit.ParameterValueGUIDKey
	) ON Benefit.ProgramGID = Pg.gid 
    AND Benefit.ParameterGID = '5a76c4d5-9951-4584-9d3b-fbb73901c495' 
    AND Terr.Deleted = 0
WHERE
  P.Deleted = 0 
	AND P.RegisteredDate BETWEEN  @registeredDateFrom AND @registeredDateTo